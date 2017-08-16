function button_Compute_Callback(handle, ~)
%% Compute data passed in handle.

    DiffusionSimulation(GetRemainingPoints(gca, get(handle, 'UserData')));
    
end

