function AddList(name, list, index, desc, descItems,   relPred)
%% Add a list with two or more items

    global layout palette
    global panIdx params
    
    assert(length(list) == length(descItems));
    numItems = length(list);
    assert(index >= 1 && index <= numItems);
    
    if nargin < 6
        % The parameter is always relevant
        relPred = 'true';
    end
    
    % The name
    [handlers, xPos] = CreateParamNameText(name);

    % Prepare tooltip
    desc = DescToHtmlString(desc, false);
    desc = ['<html>', desc];
    for i = 1 : numItems
        descItem = DescToHtmlString(descItems{i}, false);
        desc = sprintf('%s<br><b>%s:</b> <i>%s</i>', desc, list{i}, descItem);
    end
    desc = [desc, '</html>'];
    
    % The control itself
    xPos = xPos + layout.xMargin2;
    parIdx = length(params{panIdx}) + 1;
    handlers(end + 1) = uicontrol('Style', 'popupmenu', ...
                                  'Units', 'pixels', ...
                                  'Position', [xPos , 0, layout.ebWidth, layout.pmHeight], ...
                                  'BackgroundColor', palette.validColor, ...
                                  'Callback', @generic_Callback, ...
                                  'String', list, ...
                                  'Value', index, ...
                                  'UserData', [panIdx, parIdx], ...
                                  'TooltipString', desc);
    valPred = 'true';
    unit = '';
    CommitParam(name, index, relPred, valPred, handlers, unit);
    
end
