function InitFigures()
%% Initialize UI and position of the main figures.
    
    global geometryFileName figures
    
    % TODO Make position and dimensions depend on the screen resolution.
        
    % Main data figure
    position = [200, 200];
    dimensions = [700, 500];  
    
    figures.mainDataWindow = MakeDataFigure(sprintf('Original data - %s', geometryFileName), ...
        [position, dimensions], true, false, false, false, true, ...
        @brush_post_ViewSelection_Callback, 'RemoveSectionsHighlight()');
    
    % Selected section figure
    position(1) = position(1) + dimensions(1) + 20;
    dimensions(1) = 500;   
    
    figures.sectionWindow = MakeDataFigure('Selected section', ...
        [position, dimensions], true, true, true, true, true);

    % Sections table figure
    tableDimensions = [395, 374];
    position = position + dimensions / 2 - tableDimensions / 2;
    
    figures.tableWindow = MakeFigure('Stored sections', ...
        [position, tableDimensions], true);
        
    figures.cylinderRadii = MakeFigure('Cylinder radii distribution', ...
        [100, 100, 700, 500], true);
    
    figures.simulationWindow = MakeFigure('Diffusion simulation', ...
        [100, 100, 700, 500], true);
    
    figures.graphDistance = MakeFigure('Time / Distance', ...
        [200, 100, 700, 500], true);
    
    figures.graphDiffCoef = MakeFigure('Time / DiffCoef', ...
        [300, 100, 700, 500], true);

    figures.graphTimeOfOut = MakeFigure('Time / TimeOfOut', ...
        [400, 100, 700, 500], true);

end

