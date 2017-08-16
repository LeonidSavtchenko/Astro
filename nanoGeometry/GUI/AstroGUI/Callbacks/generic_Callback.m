function generic_Callback(hObject, ~)
%% Callback function for editbox, checkbox, popupmenu and uitable

    global params
            
    userData = get(hObject, 'UserData');
    panIdx = userData(1);
    parIdx = userData(2);
    
    value = GetUIControlValue(hObject);
    params{panIdx}{parIdx}.value = value;

    % Update the main controls, slider and gray strips
    UpdateView();
    
end