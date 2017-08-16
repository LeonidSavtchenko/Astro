function [levels, averageLevelHeight, missingLayers] = SplitToLevels(data)
%% Split the data on the sets of points with the same height.

    z = data(:, 3);    
    uniqueHeights = unique(z);
    levelsSize = size(uniqueHeights, 1);    
    levels = cell(levelsSize, 1);
    averageLevelHeight = 0;
    missingLayers = false;
    
    for i = 1:levelsSize
        heightIndices = z == uniqueHeights(i, 1);
        levels{i, 1} = data(heightIndices, :);

        if (i > 1)
            averageLevelHeight = averageLevelHeight + ...
                uniqueHeights(i, 1) - uniqueHeights(i - 1, 1);        
        end
    end   
    
    averageLevelHeight = averageLevelHeight / (levelsSize - 1);
        
    for i = 1:levelsSize
        heightIndices = z == uniqueHeights(i, 1);
        levels{i, 1} = data(heightIndices, :);

        if (i > 1)
            levelHeight = uniqueHeights(i, 1) - uniqueHeights(i - 1, 1);
            if max(levelHeight, averageLevelHeight) / min(levelHeight, averageLevelHeight) > 1.2
                missingLayers = true;
                break;
            end
        end
    end       
    
end

