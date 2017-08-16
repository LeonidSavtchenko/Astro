function pb_removeRow_Callback(hObject, ~)
%% Callback function for "Remove Row" pushbutton

    global params
    
    userData = get(hObject, 'UserData');
    panIdx = userData(1);
    parIdx = userData(2);
    
    % Remove the last row from the table
    tblParIdx = parIdx - 1;
    tblHandler = params{panIdx}{tblParIdx}.handlers(2);
    data = get(tblHandler, 'Data');
    data(end, :) = [];
    set(tblHandler, 'Data', data);
    
    if size(data, 1) == 1
        % Disable "Remove Row" button
        set(hObject, 'Enable', 'off');
    end
    
    % Accept the changes in the table
    generic_Callback(tblHandler);
    
end