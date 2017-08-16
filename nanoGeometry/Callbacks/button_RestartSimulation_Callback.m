function button_RestartSimulation_Callback(handle, ~)
%% Set interCoef and simulate data passed in handle.

    global interCoef    
    
    userData = get(handle, 'UserData');
    interCoefValue = str2double(get(userData{2}, 'String'));    
    if ~isnan(interCoefValue)
        if interCoefValue >= 0
            interCoef = interCoefValue;
            DiffusionSimulation(userData{1});              
        else
            errordlg('interCoef must be bigger than zero.', 'Error');
        end
    else
        errordlg('interCoef must be a number.', 'Error');
    end
    
end

