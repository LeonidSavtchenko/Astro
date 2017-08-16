function button_StoreSection_Callback(handle, ~)
%% Store data from the caller in sections table.
%  Takes points which are currently present on the figure.
%  Doesn't store deleted points.

    global figures

    remainingPoints = GetRemainingPoints(gca, get(handle, 'UserData'));
    if numel(remainingPoints) > 0
        StoreSection(remainingPoints); 
        set(figures.tableWindow, 'Visible', 'off');
        set(figures.tableWindow, 'Visible', 'on');
    else 
        disp('No points to store'); 
    end    
    
end