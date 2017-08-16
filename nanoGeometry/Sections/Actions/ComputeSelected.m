function ComputeSelected()
%% Compute selected sections one by one.

    [~, sectionData] = GetSelectedSections();
    
    for i = 1:size(sectionData, 1)  
        DiffusionSimulation(sectionData{i});
    end
    
end

