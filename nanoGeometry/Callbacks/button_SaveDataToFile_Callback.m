function button_SaveDataToFile_Callback(handle, ~)
%% Save points passed in UserData to file.    

    global geometryFileName
        
    [fileName, folderName] = uiputfile(strcat(geometryFileName, '_section.dat'), 'Save file name');
    
    if ~isequal(path, 0) || ~isequal(fileName, 0)
        fullFilePath = fullfile(folderName, fileName);
        SavePointDataToFile(fullFilePath, GetRemainingPoints(gca, get(handle, 'UserData'))', fileName);
    end
    
end

