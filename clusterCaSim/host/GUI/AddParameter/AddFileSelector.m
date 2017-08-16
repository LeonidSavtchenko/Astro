function AddFileSelector(name, string, desc,   relPred, valPred, ext, title)
%% Add a file selector with reset to default button

    global layout params panIdx
    
    string = strcat('''', string, '''');
    
    if nargin < 4
        % The parameter is always relevant
        relPred = 'true';
    end
    
    % The validation predicate
    if nargin < 5
        valPred = 'true';
    end
    
    % The extension
    if nargin < 6
        ext = '';
    end    
    
    % Select file dialog title
    if nargin < 7
        title = 'Select file';
    end
    
    % The name
    [handlers, xPos] = CreateParamNameText(name);
    
    % The edit box to display selected file
    % NOTE Desctiption isn't shown when pointing at inactive control. Should it be active?
    [handlers(end + 1), xPos] = CreateParamEditBox(string, xPos, desc, 'inactive');
    
    % The extension
    if ~isempty(ext)
        handlers(end + 1) = CreateParamUnitText(ext, xPos);
    end
    
    CommitParam(name, string, relPred, valPred, handlers, ext);
    
    % Buttons
    nextParIdx = length(params{panIdx}) + 1;
    w = (layout.ebWidth - layout.pbAddRemMargin) / 2;
    
    % Button for selecting a file
    xPos = xPos - layout.ebWidth - 1;    
    userData = struct('panIdx', panIdx, 'parIdx', nextParIdx, 'extension', ext, 'title', title);
    h1 = CreateButton('Select File', 'Select file to use', xPos, w, @pb_fileSelector_Callback, userData);
    
    % Button for resetting to default file
    xPos = xPos + w + layout.pbAddRemMargin + 2;
    userData = struct('panIdx', panIdx, 'parIdx', nextParIdx, 'defaultFile', string);
    h2 = CreateButton('Default', 'Select default file', xPos, w, @pb_fileReset_Callback, userData, 'off');
        
    handlers = [h1, h2];
    
    btnName = [name, '_selectResetFile'];
    value = '';
    relPred = 'true';
    valPred = 'true'; % !!
    unit = '';
    CommitParam(btnName, value, relPred, valPred, handlers, unit);
    
end

function handler = CreateButton(text, desc, xPos, w, callback, userData,   enable)
%% Create one button

    global layout palette
    
    if nargin < 7
        enable = 'on';
    end
    
    handler = uicontrol('Style', 'pushbutton', ...
                        'Enable', enable, ...
                        'Units', 'pixels', ...
                        'BackgroundColor', palette.backgroundColor, ...
                        'Position', [xPos, 0, w, layout.pbHeight], ...
                        'String', text, ...
                        'UserData', userData, ...
                        'Callback', callback, ...
                        'TooltipString', desc);
    
end