function AddResizableMatrix(name, values, defaultValues, colNames, desc,   relPred, valPred)

    global layout
    global panIdx params
    
    %% The table itself
    
    if nargin < 6
        relPred = 'true';
    end

    if nargin < 7
        valPred = 'true';
    end
    
    % The name
    [handlers, xPos] = CreateParamNameText(name);
    
    % Prepare tooltip
    desc = DescToHtmlString(desc);
    
    % The control itself
    xPos = xPos + layout.xMargin2;
    parIdx = length(params{panIdx}) + 1;
    [numDataRows, numDataCols] = size(values);
    w = layout.tcHdrWidth0to9 + numDataCols * layout.tcMinWidth;
    h = layout.trHdrHeight + numDataRows * layout.trHeight;
    handlers(end + 1) = uitable('Units', 'pixels', ...
                                'Position', [xPos, 0, w, h], ...
                                'ColumnName', colNames, ...
                                'Data', values, ...
                                'ColumnEditable', true(1, numDataCols), ...
                                'UserData', [panIdx, parIdx], ...
                                'CellEditCallback', @generic_Callback, ...
                                'TooltipString', desc);
                                
    CommitParam(name, values, relPred, valPred, handlers, '');
    
    %% The buttons for addition and removal of rows
    nextParIdx = length(params{panIdx}) + 1;
    w = (layout.ebWidth - layout.pbAddRemMargin) / 2;
    
    xPos = xPos - 1;
    userData = struct('panIdx', panIdx, 'parIdx', nextParIdx, 'defaultValues', {defaultValues});
    h1 = CreateButton('Add Row', 'Add one row to the table from below', xPos, w, @pb_addRow_Callback, userData);
    
    xPos = xPos + w + layout.pbAddRemMargin + 2;
    userData = [panIdx, nextParIdx];
    h2 = CreateButton('Remove Row', 'Remove the last row from the table', xPos, w, @pb_removeRow_Callback, userData);
        
    handlers = [h1, h2];
    
    btnName = [name, '_addRemoveRow'];
    value = '';
    relPred = 'true';
    valPred = 'true'; % !!
    unit = '';
    CommitParam(btnName, value, relPred, valPred, handlers, unit);
    
end

function handler = CreateButton(text, desc, xPos, w, callback, userData)
%% Create one button

    global layout palette
    
    % The control itself
    handler = uicontrol('Style', 'pushbutton', ...
                        'Units', 'pixels', ...
                        'BackgroundColor', palette.backgroundColor, ...
                        'Position', [xPos, 0, w, layout.pbHeight], ...
                        'String', text, ...
                        'UserData', userData, ...
                        'Callback', callback, ...
                        'TooltipString', desc);
    
end
