function button_SaveRadiiDistribution_Callback(handle, ~)
%% Save distribution data passed in handle.

    userData = get(handle, 'UserData');
    % 1 - data, 2 - min radii per group, 3 - max radii per group
    SaveDistributionDataToFile(userData{1}, userData{2}, userData{3}); 
    
end

