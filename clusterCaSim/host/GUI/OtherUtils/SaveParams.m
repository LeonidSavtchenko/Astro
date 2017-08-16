function SaveParams(filename)
%% Add all parameters to current workspace and save all necessary input data to file
    
    global params
    
    output = {};
    
    % Loop by panels
    for panIdx_ = 1 : length(params)
        
        % Loop by all parameters of this panel
        for parIdx = 1 : length(params{panIdx_})
            
            varName = params{panIdx_}{parIdx}.name;
            handlers = params{panIdx_}{parIdx}.handlers;
            
            h2 = handlers(2);
            [value, style, ~] = GetUIControlValue(h2); %#ok<ASGLU>
            
            switch style
                case 'checkbox'
                    cmd = sprintf('%s = logical(value);', varName);
                case 'popupmenu'
                    cmd = sprintf('%s = int32(value);', varName);
                case 'pushbutton'
                    continue
                otherwise
                    cmd = sprintf('%s = value;', varName);
            end
            
            eval(cmd);
    
            output = [output; varName];
        end
    end
    
    save(filename, output{:});

end
