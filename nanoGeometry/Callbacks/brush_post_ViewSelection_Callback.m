function brush_post_ViewSelection_Callback(handle, ~)
%% Display brushed data in section window.
    
    global figures mainDataPlot mainData

    brushData = get(mainDataPlot, 'BrushData'); 
    selectedIndices = find(brushData);
    
    if (size(selectedIndices, 2) > 0)
        XData = mainData(:, 1);
        YData = mainData(:, 2);
        ZData = mainData(:, 3);
        
        selectedData = [
            XData(selectedIndices), ...
            YData(selectedIndices), ...
            ZData(selectedIndices)];

        PlotData(selectedData, figures.sectionWindow, true);
    else
       disp('No points selected'); 
    end    
    
end

