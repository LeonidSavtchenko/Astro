function pb_addRow_Callback(hObject, ~)
%% Callback function for "Add Row" pushbutton

    global params
    
    userData = get(hObject, 'UserData');
    panIdx = userData.panIdx;
    parIdx = userData.parIdx;
    
    % Add one row to the table from below
    tblParIdx = parIdx - 1;
    tblHandler = params{panIdx}{tblParIdx}.handlers(2);
    data = get(tblHandler, 'Data');
    data = [data; userData.defaultValues];
    set(tblHandler, 'Data', data);
    
    % Enable "Remove Row" button
    removeRowHandler = params{panIdx}{parIdx}.handlers(2);
    set(removeRowHandler, 'Enable', 'on');
    
    % Accept the changes in the table
    generic_Callback(tblHandler);
    
end