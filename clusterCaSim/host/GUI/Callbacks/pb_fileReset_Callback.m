function pb_fileReset_Callback(hObject, ~)
%% Callback function for resetting value of HocFileSelector

    global params
    
    userData = get(hObject, 'UserData');
    
    ebParIdx = userData.parIdx - 1;
    ebHandler = params{userData.panIdx}{ebParIdx}.handlers(2);
    set(ebHandler, 'String', userData.defaultFile);
    
    set(hObject, 'Enable', 'off');
    
    generic_Callback(ebHandler);
    
end