function LoadParams(filename)

    global params

    % Read data from the file
    input = load(filename);

    % Check if params are saved as structure
    guiParamsExist = any(strcmp(fieldnames(input), 'guiParams'));

    if guiParamsExist
        input = input.guiParams; %#ok<NASGU>
    end

    %% Update values of the parameters in the GUI

    % Loop by panels
    for panIdx_ = 1 : length(params)
        % Loop by all parameters of this panel
        for parIdx = 1 : length(params{panIdx_})
            varname = params{panIdx_}{parIdx}.name;
            handlers = params{panIdx_}{parIdx}.handlers;
            h2 = handlers(2);
            
            [oldValue, style, field] = GetUIControlValue(h2);
            
            if strcmp(style, 'pushbutton')
                continue
            end
            
            try
                cmd = sprintf('value = input.%s;', varname);
                eval(cmd);
            catch
                value = oldValue;
            end

            set(h2, field, value);
            params{panIdx_}{parIdx}.value = value;

            if strcmp(style, 'mledit')
               evalTextArea(value, params{panIdx_}{parIdx}.name); 
            end
        end
    end

end
