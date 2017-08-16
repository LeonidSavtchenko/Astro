function style = GetUIControlStyle(h2)
%% Get "Style" property of the given handle.
%  Return custom style name "uitable" for tables and "mledit" for multiline editboxes.

    try
        style = get(h2, 'Style');
    catch
        % Use custom style name for tables because they do not have this property
        style = 'uitable';
        return
    end
    
    if strcmp(style, 'edit') && IsMultilineEditBox(h2)
        % Use custom style name for convenience
        style = 'mledit';
    end

end

function isMLEB = IsMultilineEditBox(h2)
%% Check whether given editbox is multiline

    min = get(h2, 'Min');
    max = get(h2, 'Max');
    isMLEB = (max - min > 1);
    
end
