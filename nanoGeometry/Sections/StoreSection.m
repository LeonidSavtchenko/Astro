function StoreSection(data, rowName, checked)
%% Add data to sections array and add row to the sections table.

    global sectionsTable storedSections geometryFileName    
            
    [levels, ~, missingLayers] = SplitToLevels(data);
    convexHulls = PointsToConvexHulls(levels);
    levelsSize = size(convexHulls, 1);
    canBeSimulated = true;
    
	% Check if some level has not enough points and can't be simulated
    for i = 1:levelsSize
        if ~convexHulls{i, 2}
            canBeSimulated = false;
            break;
        end
    end
    
    if nargin < 3
        checked = true;
    end
    
    % Default section name
    if nargin < 2
        rowName = sprintf('%s%s%i', ...
            geometryFileName, ...
            '_section_', ...
            size(storedSections, 1));
    end    
    
    % Append row to table data
    storedSections = cat(1, storedSections, data);
    tableData = get(sectionsTable, 'Data');    
    tableData = [tableData; {rowName, StatusToColoredCell(canBeSimulated && ~missingLayers), levelsSize, size(data, 1), checked}];
    set(sectionsTable, 'Data', tableData);  
    
end

function coloredValue = StatusToColoredCell(status)
%% Returns HTML-text that when insterted in uitable cell 
%% makes its background either red or green with status word on it.

    if status
        text = 'Yes';
        color = 'CCFFCC';
    else
        text = 'No';
        color = 'FFCCCC';
    end
	
    coloredValue = ['<html><table border=0 width=400 bgcolor=#', color, '><TR><TD>', text, '</TD></TR> </table></html>'];

end