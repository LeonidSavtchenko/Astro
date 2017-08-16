function [sectionNames, sectionData]  = GetSelectedSections()
%% Get data and names of checked sections from the table.

    global sectionsTable storedSections
    
    sectionNames = cell(0);
    sectionData = cell(0);
    
    tableData = get(sectionsTable, 'Data');
    checks = tableData(:, 5);
    
    for i = 1:size(checks, 1)
        if checks{i, 1}
            sectionNames = cat(1, sectionNames, tableData(i, 1));
            sectionData = cat(1, sectionData, storedSections{i});
        end
    end
    
end

