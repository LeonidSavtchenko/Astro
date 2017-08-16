function SaveSelectedToFiles()
%% Save selected data sections to files.
    
    [sectionNames, sectionData] = GetSelectedSections();
    sectionsSize = size(sectionNames, 1);
    
    if (sectionsSize > 0)
        % NOTE uigetdir doesn't show any files in folders.
        folderName = uigetdir(pwd, 'Select folder to save sections');
        
        if isequal(folderName, 0)
            % Saving was cancelled
        else
            for i = 1:sectionsSize              
                sectionFile = fullfile(folderName, strcat(sectionNames{i}, '.dat'));
                SavePointDataToFile(sectionFile, sectionData{i}', sectionNames{i});
            end
        end
    end
    
end

