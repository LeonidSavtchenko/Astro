function SaveDistributionDataToFile(distributionData, minRadii, maxRadii)
%% Save radii distribution data to .txt file.

    global geometryFileName
    
    [file,path] = uiputfile(strcat(geometryFileName, '_radii_dist.txt'), 'Save Radii Distribution As');

    if ~isequal(path, 0) || ~isequal(file, 0)
        fileId = fopen(fullfile(path, file), 'w');
        saved = fileId ~= -1;
        
        if (saved)
            dataColsSize = size(distributionData, 2);
            if dataColsSize > 2
                cylindersPerLevel = dataColsSize - 2;
            else
                cylindersPerLevel = dataColsSize - 1;
            end
        
            fprintf(fileId, 'Summary min-max\n');     
            fprintf(fileId, '------------------------------\n');     
            fprintf(fileId, '%f\t %f\n\n', minRadii(1, 1), maxRadii(1, 1)); 
            
            if cylindersPerLevel == 2
                fprintf(fileId, 'Normal cylinders min-max\n');  
                fprintf(fileId, '------------------------------\n');     
                fprintf(fileId, '%f\t %f\n\n', minRadii(3, 1), maxRadii(3, 1));             

                fprintf(fileId, 'Intermediate cylinders min-max\n');    
                fprintf(fileId, '------------------------------\n');     
                fprintf(fileId, '%f\t %f\n\n', minRadii(2, 1), maxRadii(2, 1)); 
            end
            
            % Data format for number of cylinder groups
            dataFormat = '%f %i';        
            if (cylindersPerLevel > 1)
                for i = 1:cylindersPerLevel
                    dataFormat = strcat(dataFormat, '\t\t %i');
                end
            end
            dataFormat = strcat(dataFormat, '\n');
            
            fprintf(fileId, 'Range\t ');
            if cylindersPerLevel == 2
                fprintf(fileId, 'Summ.\t Inter.\t Norm.\n');                
            else
                fprintf(fileId, 'Distribution\n');                
            end 
            fprintf(fileId, '------------------------------\n');        
            fprintf(fileId, dataFormat, distributionData');            
            fprintf(fileId, '%f\n\n', maxRadii(1, 1));
                                    
            % Save data for NEURON
            radiiStep = (maxRadii(1, 1) - minRadii(1, 1)) / size(distributionData, 1);
            fprintf(fileId, 'NEURON\n');
            % For NEURON diameters are saved (radii * 2)
            fprintf(fileId, '%f\n', radiiStep * 2);
            for group = 3:cylindersPerLevel + 2
                groupCol = distributionData(:, group);
                radiiSum = sum(groupCol);
                groupCol = groupCol./radiiSum;
                nonZeroIndices = find(groupCol);
                nonZeroIndicesSize = size(nonZeroIndices, 1);
                
                probabilities = distributionData(nonZeroIndices, group) / radiiSum;
                for i = 2:nonZeroIndicesSize
                    probabilities(i, 1) = probabilities(i, 1) + probabilities(i - 1, 1);
                end
                
                fprintf(fileId, '%i\n', nonZeroIndicesSize);
                fprintf(fileId, '%f %f\n', [distributionData(nonZeroIndices, 1) * 2, probabilities]');   
            end
            
            fclose(fileId);            
            fprintf('%s saved\n', file);
        else            
            fprintf('Can not save %s\n', file);
        end
    end    
    
end

