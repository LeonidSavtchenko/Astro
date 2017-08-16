function saved = SavePointDataToFile(sectionFile, sectionData, logFileName)
%% Save 3D point data to .dat file.

    fileId = fopen(sectionFile, 'w');
    saved = fileId ~= -1;
    
    if (saved)
        fprintf(fileId, '%f %f %f\n', sectionData);
        fclose(fileId);
    end
    
    if (nargin >= 3)
        if (saved)
            fprintf('%s saved\n', logFileName);
        else        
            fprintf('Can not save %s\n', logFileName);
        end
    end
    
end

