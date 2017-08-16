function dataPlot = PlotData(data, figureHandle, plotHulls)
%% Diplay data on figure and set it as UserData to figure controls.
       
    % Plot
    figure(figureHandle);
    
    % Set UserData to controls
    controls = findobj(figureHandle, 'Type', 'uicontrol');  
    
    for i = 1:size(controls)
        set(controls(i), 'UserData', data);
    end
    
    if nargin >= 3 && plotHulls
        levels = SplitToLevels(data);
        convexHulls = PointsToConvexHulls(levels);   
        hold off;
        dataPlot = scatter3(data(:, 1), data(:, 2), data(:, 3), 10, '*', 'b');
        hold on;
        PlotHulls(convexHulls, true, 0.1, 0.01);
        hold off;
    else
        dataPlot = scatter3(data(:, 1), data(:, 2), data(:, 3), 15, '*', 'b');         
    end    
    daspect([1, 1, 1]);  
    
end