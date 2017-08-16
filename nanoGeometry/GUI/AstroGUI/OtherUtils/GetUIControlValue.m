function [value, style, field] = GetUIControlValue(h2)
%% Get the main property of the given handle.
%  Also, return the control style name and the property name.

    style = GetUIControlStyle(h2);
            
    switch style
        case {'edit', 'mledit', 'pushbutton'}
            field = 'String';
        case {'checkbox', 'popupmenu'}
            field = 'Value';
        case 'uitable'
            field = 'Data';
        otherwise
            assert(false);
    end

    value = get(h2, field);

end

