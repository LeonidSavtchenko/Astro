function AddBoolScalar(name, value, desc,   relPred)
    
    global layout palette
    global panIdx params
    
    if nargin == 3
        % The parameter is always relevant
        relPred = 'true';
    end
    
    % The name
    [handlers, xPos] = CreateParamNameText(name);

    % Prepare tooltip
    desc = DescToHtmlString(desc);
    
    % The control itself
    xPos = xPos + layout.xMargin2;
    parIdx = length(params{panIdx}) + 1;
    handlers(end + 1) = uicontrol('Style', 'checkbox', ...
                                  'Units', 'pixels', ...
                                  'Position', [xPos, 0, layout.ebWidth, layout.cbHeight], ...
                                  'BackgroundColor', palette.backgroundColor, ...
                                  'Callback', @generic_Callback, ...
                                  'Value', value, ...
                                  'UserData', [panIdx, parIdx], ...
                                  'TooltipString', desc);
    
    valPred = 'true';
    unit = '';
    CommitParam(name, value, relPred, valPred, handlers, unit);
    
end