function PlotRadiiDistribution(radiiDistribution, minRadii, maxRadii, statisticsStep)
%% Plot radii distribution diagramm with 'Save to file' button.
%  Has special behavior for case of two cillinders per level.

    global figures cylindersPerLevel    
    
    % Plot params
    plotGridXStep = 0.05;
    distributionMode = max(radiiDistribution(:, 2));
    
    % Plot
    figure(figures.cylinderRadii);
    clf;
    
    % Plot colored bars
    bar(radiiDistribution(:, 1) + statisticsStep / 2, radiiDistribution(:, 2), 1, 'FaceColor', [0.25, 0.25, 0.25]);
    if cylindersPerLevel > 1
        hold on;
        smallBarPlot = bar(radiiDistribution(:, 1) + statisticsStep / 2, radiiDistribution(:, 3:(cylindersPerLevel + 2)), 1);  
        set(smallBarPlot(1), 'FaceColor', 'r');
        set(smallBarPlot(2), 'FaceColor', 'g');      
        hold off; 
    end
    
    % Setup plots
    xlabel('Radii range');
    ylabel('Number of cylinders');
    plotWidth = maxRadii(1, 1) + statisticsStep;      
    set(gca, ...
        'XTick', 0:plotGridXStep:plotWidth, ...
        'YTick', 0:(distributionMode), ...
        'XLim',[0, plotWidth], ...
        'YLim',[0, distributionMode + 1]);    
    grid on;
    
    if cylindersPerLevel == 2
        legend({'Summary', ...
            'Intermediate cylinders', ...
            'Normal cylinders'});
    else
        legend({'Summary'});
    end    
    
    % Add 'Save to file' button
    position = [20, 20];
    dimensions = [70, 20];
    uicontrol('Style', 'pushbutton', ...
        'String', 'Save to file', ...
        'Position', [position, dimensions], ...
        'UserData', {radiiDistribution, minRadii, maxRadii}, ...
        'Callback', @button_SaveRadiiDistribution_Callback);
    
end

