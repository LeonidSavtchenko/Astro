function AddTextArea(name, text, varName, desc,   relPred, valPred)
%% Add text area for custom m-code

    assert(iscell(text));
%     assert(size(text, 2) == 1);
    
    if nargin < 5
        relPred = 'true';
    end
    
    % Make sure that evaluation of the code does not lead to an error
    valPred_ = 'true';
%     if nargin == 6
%         valPred_ = [valPred_, ' && ', valPred];
%     end

    % The name
    [handlers, xPos] = CreateParamNameText(name);
    
    % Prepare tooltip
    desc = DescToHtmlString(desc);

    % The control itself
    [handlers(end + 1), ~] = CreateMultiLineEditBox(text, desc, xPos);
    
    CommitParam(name, text, relPred, valPred_, handlers, '');

end

function [hc, xPos] = CreateMultiLineEditBox(text, desc, xPos)

    global panIdx params layout palette
    
    xPos = xPos + layout.xMargin2;
    parIdx = length(params{panIdx}) + 1;
    
    hc = uicontrol('Style', 'edit', ...
                   'Units', 'pixels', ...
                   'Position', [xPos, 0, layout.ebWidth, 1], ...
                   'String', text, ...
                   'UserData', [panIdx, parIdx], ...
                   'BackgroundColor', palette.validColor, ...
                   'Callback', @textArea_callback, ...
                   'TooltipString', desc, ...
                   'Max', 2, ...
                   'HorizontalAlignment', 'left', ...
                   'FontName', 'FixedWidth');
    xPos = xPos + layout.ebWidth;
    
end

function textArea_callback(hObject, ~)
    
    generic_Callback(hObject);
    
end