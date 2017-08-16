function PlotSelected()
%% Plot selected sections in a row.
    
    [sectionNames, sectionData] = GetSelectedSections();
    
    % TODO Make X-shift depend on the screen resolution.
    for i = 1:size(sectionData, 1)        
        sectionFigure = MakeDataFigure(sectionNames{i}, ... 
            [50 + (i - 1) * 100, 50, 500, 500], true, true, true);
        
        PlotData(sectionData{i}, sectionFigure, true);
    end

end

