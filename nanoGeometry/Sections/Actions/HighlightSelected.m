function HighlightSelected()
%% Plot selected sections with different colors on mainDataWindow. 
    
    global coloredSections figures

    [sectionNames, sectionData] = GetSelectedSections();
    sectionsSize = size(sectionNames, 1);
      
    figure(figures.mainDataWindow);  
    RemoveSectionsHighlight();     
    
    if (sectionsSize > 0)
        hold on;
        for i = 1:sectionsSize              
            data = sectionData{i};
            coloredSections = cat(1, coloredSections, scatter3(data(:, 1), data(:, 2), data(:, 3), 100, '*'));
        end 
        hold off;
    end
    
end

