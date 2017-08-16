function UpdateViewControls()
%% Update view controls, i.e. visibility (depending on parameter relevancy), position, size
%  and color (depending parameter validness).
%  Also, initialize global variables containing parameters values
%  and invalid parameters names.

    global hf panIdx params customVars
    global yPos yPos0 layout
    global invalidParams
    
    % Add all variables from customVars structure to the current workspace
    fields = fieldnames(customVars);
    for varIdx = 1 : length(fields)
        cmd = sprintf('%s = customVars.%s;', fields{varIdx}, fields{varIdx});
        % The next command must be executed in the same function as other commands marked with (*)
        eval(cmd);  % (*)
    end
    
    pos = get(hf, 'Position');
    winWidth = pos(3);
    
    % Loop by panels
    for panIdx_ = 1 : length(params)
        % Loop by all parameters of this panel
        for parIdx = 1 : length(params{panIdx_})
            value = params{panIdx_}{parIdx}.value;
            
            handlers = params{panIdx_}{parIdx}.handlers;
            h2 = handlers(2);
            style = GetUIControlStyle(h2);
            if strcmp(style, 'edit') || strcmp(style, 'mledit')
                min = get(h2, 'Min');
                max = get(h2, 'Max');
            else
                max = 0;
                min = 0;
            end
            if max - min > 1
                % Text area is evaluated elsewhere
            elseif ischar(value)
                try
                    % The next command must be executed in the same function as other commands marked with (*)
                    value = eval(value);    % (*)
                catch
                    value = nan;
                end
            end
            % The next command must be executed in the same function as other commands marked with (*)
            Assign(params{panIdx_}{parIdx}.name, value);    % (*)
        end
    end
    
    yPos = yPos0;
    
    invalidParams = {};
    
    % Loop by panels
    for panIdx_ = 1 : length(params)
        
        % Loop by all parameters of this panel
        for parIdx = 1 : length(params{panIdx_})
            
            relPred = params{panIdx_}{parIdx}.relPred;
            if ~islogical(relPred)
                % The next command must be executed in the same function as other commands marked with (*)
                rel = eval(relPred);    % (*)
            else
                rel = relPred;
            end
                
            if panIdx_ == panIdx
                % This is the active panel
                vis = rel;
            else
                % This is a hidden panel
                vis = false;
            end
            
            % Get handlers of this control
            handlers = params{panIdx_}{parIdx}.handlers;
            h2 = handlers(2);
            
            style = GetUIControlStyle(h2);
                   
            for j = 1 : length(handlers)
                handler = handlers(j);

                % Update y coordinate for Name and Unit labels
                UpdateYForNameAndUnitLabels(handler, style, j, panIdx_);
                
                % Update color for editboxes and tables according to the validation predicate value
                if j == 2 && (strcmp(style, 'edit') || strcmp(style, 'mledit') || strcmp(style, 'uitable'))

                    % Evaluate the validation predicate
                    valPred = params{panIdx_}{parIdx}.valPred;
                    try
                        % The next command must be executed in the same function as other commands marked with (*)
                        val = eval(valPred);    % (*)
                    catch
                        val = false;
                    end

                    % Set color for visible controls.
                    % For relevant invalid controls, add the name to "invalidParams".
                    name = params{panIdx_}{parIdx}.name;
                    SetColorUpdateInvalidParams(handler, name, style, rel, vis, val);
                end
            end
  
            % Update visibility
            SetVisibility(handlers, vis);

            if vis
                % Update position and size of the control
                UpdatePosAndSize(h2, style, panIdx_, winWidth);
                
                % Do one step by y for positioning the next control
                pos = get(h2, 'Position');
                h = pos(4);
                switch style
                    case 'mledit'
                        yPos = yPos - h + layout.mlebYMargin2;
                    case 'uitable'
                        yPos = yPos - h + layout.tYMargin;
                end
                yPos = yPos - layout.yStep;
            end
        end
    end
end

function Assign(name, value)
%% Assign given value to the global variable of the given name in the caller function workspace

    assignin('caller', name, value);
    
    cmd1 = ['global ', name];
    cmd2 = [name, ' = value;'];
    eval(cmd1);
    eval(cmd2);
    
end

function UpdateYForNameAndUnitLabels(handler, style, j, panIdx)
%% Update y coordinate for Name and Unit labels

    global yPos layout
    
    dy = 0;
    
    if j == 1 || j == 3
        switch style
            case 'edit'
                dy = layout.ebNameUnitYMargin;
            case 'mledit'
                if panIdx == 1
                    dy = layout.mlebNameYMargin1;
                else
                    dy = layout.mlebNameYMargin2;
                end
            case 'checkbox'
                dy = layout.cbNameYMargin;
            case 'popupmenu'
                dy = layout.pmNameYMargin;
            case 'uitable'
                dy = layout.tNameYMargin;
        end
    end
    
    pos = get(handler, 'Position');
    pos(2) = yPos - dy;
    set(handler, 'Position', pos);
    
end
                
function SetColorUpdateInvalidParams(handler, name, style, rel, vis, val)
%% Set color for visible controls.
%  For relevant invalid controls, add the name to "invalidParams".

    global palette invalidParams
    
    % Set color for visible controls
    if vis
        if ~strcmp(style, 'uitable')
            if val
                color = palette.validColor;
            else
                color = palette.invalidColor;
            end
        else
            if val
                color = palette.tableValidColor;
            else
                color = palette.tableInvalidColor;
            end
        end
        set(handler, 'BackgroundColor', color);
    end

    % For relevant invalid editboxes and tables,
    % save the parameter name to the global cell array
    if rel && ~val
        invalidParams{end + 1} = name;
    end
    
end

function UpdatePosAndSize(h2, style, panIdx, winWidth)
%% Update position and size of the control

    switch style
        case 'mledit'
            AdjustMultilineEditBoxPosAndSize(h2, panIdx, winWidth);
        case 'uitable'
            AdjustTablePosAndSize(h2, winWidth);
    end
    
end
                
function AdjustMultilineEditBoxPosAndSize(h2, panIdx, winWidth)
%% Adjust position and size of the multiline editbox to fill all available space by x.
%  Also, we'll fill all availale space by y for the editbox on 1st panel.

    global layout yPos

    pos = get(h2, 'Position');    % [x, y, w, h]
    
    if panIdx == 1
        % Adjust vertical position and height to fill all available space on the panel
        pos(2) = layout.bsHeight + layout.pbHeight + 5 * layout.yMargin0;
        pos(4) = yPos - pos(2) + layout.ebHeight - layout.mlebYMargin1;
    else
        % Adjust vertical position
        pos(2) = yPos - pos(4) + layout.ebHeight;
    end
    
    % Adjust width
    pos(3) = winWidth - pos(1) - layout.sWidth - 2 * layout.xMargin0;
    
    set(h2, 'Position', pos);
    
end

function AdjustTablePosAndSize(h2, winWidth)
%% Adjust position and size of the table to fit the panel size

    global layout yPos

    pos = get(h2, 'Position');
    x = pos(1);

    % Compute height of the table
    data = get(h2, 'Data');
    [numDataRows, numDataCols] = size(data);
    h = layout.trHdrHeight + numDataRows * layout.trHeight;
    
    % Update the table width according to the available horizontal space
    w = winWidth - layout.sWidth - 3 * layout.xMargin0 - x;
    columnWidth = GetTableColumnWidth(numDataRows, numDataCols, w);
    if columnWidth < layout.tcMinWidth 
        % The table is too short for the figure.
        % The column width is set to minimal.           
        columnWidth = layout.tcMinWidth;     
        % The horizontal slider will be created making the table height bigger.
        h = h + layout.tHorSliderHeight;
    elseif w > layout.tMaxWidth
        % The table is too wide.
        % Its width is set to maximal.
        w = layout.tMaxWidth;
        columnWidth = GetTableColumnWidth(numDataRows, numDataCols, w);
    end
    
    if columnWidth > layout.tcMaxWidth
        % Column width is too big.
        columnWidth = layout.tcMaxWidth;
        w = GetTableWidth(numDataRows, numDataCols, columnWidth);
    end

    % Compute the table bottom coordinate
    y = yPos - h + layout.tYMargin;

    % Update the table height according to the available vertical space
    minY = layout.bsHeight + layout.pbHeight + 3 * layout.yMargin0;
    if (y < minY) && (y + h > minY)
        % The table is too high for the figure.
        % The vertical slider will be created, but it will not make the table width bigger.
        y = minY;
        h = yPos + layout.ebHeight - y;  
        % Column width will is lowered instead.
        columnWidth = GetTableColumnWidth(numDataRows, numDataCols, w - layout.tVertSliderWidth);
    end
    
    pos = [x, y, w, h];
    set(h2, 'Position', pos);
    
    columnWidthInt = floor(columnWidth);
    cloumnWidths(1:numDataCols) = {columnWidthInt};
    % Width of the first collumn is increased to fill all remaining table space.
    cloumnWidths{1} = columnWidthInt + numDataCols * (columnWidth - columnWidthInt);
    set(h2, 'ColumnWidth', cloumnWidths);
    
end

function w = GetTableColumnWidth(numDataRows, numDataCols, spaceWidth)
%% Get table collumn width raltive to avaliable space

    w = (spaceWidth - GetTcHdrWidth(numDataRows)) / numDataCols;

end

function w = GetTableWidth(numDataRows, numDataCols, columnWidth)
%% Get table width

    w = GetTcHdrWidth(numDataRows) + columnWidth * numDataCols;

end

function tcHdrWidth = GetTcHdrWidth(numDataRows)
%% Get table header column width

    global layout
    
    if numDataRows < 10
        tcHdrWidth = layout.tcHdrWidth0to9;
    else
        tcHdrWidth = layout.tcHdrWidth10to99;
    end
    
end