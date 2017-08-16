function pb_fileSelector_Callback(hObject, ~)
%% Callback function for MOD files selector pushbuttons

    global params
    
    userData = get(hObject, 'UserData');
    panIdx = userData.panIdx;
    parIdx = userData.parIdx;
        
    [filename, path] = uigetfile({strcat('*', userData.extension), 'Files'}, userData.title);
    if isequal(filename, 0) || isequal(path, 0)
        % Loading was cancelled
    else            
        ebParIdx = parIdx - 1;
        ebHandler = params{panIdx}{ebParIdx}.handlers(2);
        set(ebHandler, 'String', strjoin({'''', path, filename, ''''}, ''));
        
        % Enable "Default" button
        removeRowHandler = params{panIdx}{parIdx}.handlers(2);
        set(removeRowHandler, 'Enable', 'on');
        
        generic_Callback(ebHandler);
    end
    
end