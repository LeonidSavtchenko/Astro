function DiffusionSimulation(data)
%% Show window with diffusion sumulation the real data 
%% repsesnted as a set on polygons and calculated cylinders.
%  After simullation graphs show up.

    global TimePeriod GTimeStep np charge interCoef diffCoef simComplexity plotTimeStep
    global figures stopSimulation
    stopSimulation = false;
    
    % Find geometry params
    [cylinderRadii, convexHulls, realLevelHeight, cylinderHeight] = CalculateCylinders(data);

    hulls3d = Calculate3DLevelHulls(convexHulls);
    hullParams = FlatHullsTo3DHullParams(convexHulls);  
    cylinderRadiiSquares = cylinderRadii.^2;

    cylinderGeometry = 1;
    realGeometry = 2;
    epsilonDistance = 1e-6;
    
    % Number of levels
    levelsSize = zeros(2, 1);
    levelsSize(cylinderGeometry, 1) = size(cylinderRadii, 1);
    levelsSize(realGeometry, 1) = size(hullParams, 1);
    
    % Heights of levels
    levelHeight = zeros(2, 1);
    levelHeight(cylinderGeometry, 1) = cylinderHeight;
    levelHeight(realGeometry, 1) = realLevelHeight;
    
    % Plot colors
    plotColor = cell(2, 1);
    plotColor{cylinderGeometry} = 'blue';
    plotColor{realGeometry} = 'red';    

    particlesLeftPlot = cell(2, 1);
    
    % Simulation window   
    figure(figures.simulationWindow);
    clf;
    
    % Calculate plot boundaries
    xyAxis = max(cylinderRadii);
    for hull = 1:size(convexHulls, 1)
        maxHullXY = max(max(abs(convexHulls{hull}(:, 1:2))));
        
        if maxHullXY > xyAxis
            xyAxis = maxHullXY;
        end
    end
    xyAxis = xyAxis * 1.1;
    
    % Setup plots and plot geometry
    for geometry = [cylinderGeometry, realGeometry]
        subplot(3, 2, [0, 2] + geometry);
        view([0, 0]);
        daspect([1, 1, 1]);
        axis([-xyAxis, xyAxis, ...
            -xyAxis, xyAxis, ...
            0, levelsSize(geometry, 1) * levelHeight(geometry, 1) * 1.1]);
        grid on;
        hold on;

        if (geometry == realGeometry)
            PlotHulls(convexHulls);
            title('Polygonal model');
        elseif (geometry == cylinderGeometry)
            PlotCylinders(cylinderRadii, cylinderHeight);
            title('Cylinder model');
        end
    end
            
    % Add controls
    interCoefEdit = uicontrol('Style', 'edit', ...
           'Position', [20, 20, 70, 20], ...
           'String', interCoef);
       
    uicontrol('Style', 'pushbutton', ...
       'Position', [95, 20, 150, 20], ...
       'String', 'Set interCoef and restart', ...
       'UserData', {data, interCoefEdit}, ...
       'Callback', @button_RestartSimulation_Callback);   
   
    uicontrol('Style', 'pushbutton', ...
       'Position', [255, 20, 150, 20], ...
       'String', 'Stop simulation', ...
       'Callback', @button_StopSimmulation_Callback);    

    % Simulation params
    StepRad = sqrt(6*diffCoef*GTimeStep); % Space step for the given diffusion coefficient
    Time = 0:GTimeStep:TimePeriod; % Vector Time
    NIteretionTime = size(Time, 2) - 1; % Number of Impulses/change in track

    % Initialization of the position of particles..i.e origin
    DifCoefTotal = cell(2, 1);
    DifCoefTotal{1, 1} = zeros(1);
    DifCoefTotal{2, 1} = zeros(1);
    ParticleatFinish = zeros(2, 1);

    TotalNumberinteration = 1;
    for NumberIteretion = 1:TotalNumberinteration
        startX = zeros(2, np);
        startY = zeros(2, np);
        startZ = zeros(2, np);
        
        endX = zeros(2, np);
        endY = zeros(2, np);
        endZ = zeros(2, np);

        % Statistics
        particleLeftStatus = zeros(2, np);
        particlesLeftThisStep = zeros(2, 1);
        particlesLeftInTime = zeros(2, size(Time, 2));
        particlesLeftInTime(:, 2:end) = NaN;        
        Distance = zeros(2, NIteretionTime+1);
        TempDistance = zeros(2, 1);
        TimeofOutControl = zeros(2, 1);
        TimeofOut = zeros(2, NIteretionTime+1);
        DifCoef = zeros(2, NIteretionTime+1);

        % Plot initial point positions in subplots
        pointPlots = zeros(2, 1);
        for geometry = [cylinderGeometry, realGeometry]                   
            subplot(3, 2, [0, 2] + geometry);
            pointPlots(geometry, 1) = scatter3(...
                startX(geometry, 1, :), ...
                startY(geometry, 1, :), ...
                startZ(geometry, 1, :), 12, 'filled', plotColor{geometry});
        end
        
        % Add particles-left plot
        subplot(3, 2, [5, 6]);  
        ylabel('Particles passed');       
        xlabel('Time (ms)');
        hold on;
        for geometry = [cylinderGeometry, realGeometry]
            particlesLeftPlot{geometry} = plot(Time, particlesLeftInTime(geometry, :), plotColor{geometry});
        end
        grid on;
        hold off; 
        
        % Iterate over time
        for i = 1:NIteretionTime % Time repeated
            % Iterate over geometries
            for geometry = [cylinderGeometry realGeometry]
                % Iterate over particles
                for j = 1:np %  particles repeated
                    if stopSimulation
                        disp('Simulation stopped.');
                        return;
                    end
                    
                    % Check if particle already left the geometry
                    if particleLeftStatus(geometry, j)  
                        % Do nothing if particle is already left
                        endX(geometry, j) = startX(geometry, j);
                        endY(geometry, j) = startY(geometry, j);
                        endZ(geometry, j) = startZ(geometry, j);
                    else
                        % Calculate new position for the particle
                        
                        % Simulate random movement
                        endX(geometry, j) = startX(geometry, j) - StepRad *randn();
                        endY(geometry, j) = startY(geometry, j) - StepRad *randn();
                        endZ(geometry, j) = startZ(geometry, j) - StepRad *randn();
                        
                        % Add charge
                        if (startX(geometry, j)^2+startY(geometry, j)^2+startZ(geometry, j)^2) > 0.001^2 && charge ~= 0
                            endZ(geometry, j) = endZ(geometry, j) + charge * 0.1 * StepRad * startZ(geometry, j) / sqrt(startX(geometry, j)^2+startY(geometry, j)^2+startZ(geometry, j)^2);
                        end
                                                
                        % Choose between simulation complexity
                        if simComplexity == 1
                            % Simple simulation
                            if endZ(geometry, j) < 0
                                % Dont move particle if goes under the floor
                                endX(geometry, j) = startX(geometry, j);
                                endY(geometry, j) = startY(geometry, j);
                                endZ(geometry, j) = startZ(geometry, j);
                            else
                                particleLevel = floor(endZ(geometry, j)/levelHeight(geometry, 1)) + 1;
                                
                                % Check if particle left the structure
                                if (particleLevel <= levelsSize(geometry, 1))
                                    % Check if particle is inside the structure
                                    if (geometry == cylinderGeometry)
                                        particleInside = ((endX(geometry, j))^2+(endY(geometry, j))^2) < cylinderRadiiSquares(particleLevel);
                                    elseif (geometry == realGeometry)
                                        particleInside = IsPointInsideHull(hullParams{particleLevel, 1}, hullParams{particleLevel, 2}, endX(geometry, j), endY(geometry, j), endZ(geometry, j));
                                    end
                                    
                                    if ~particleInside
                                        % Don't move particle if it's new
                                        % cooridnate out of the structure
                                        endX(geometry, j) = startX(geometry, j);
                                        endY(geometry, j) = startY(geometry, j);
                                        endZ(geometry, j) = startZ(geometry, j);
                                    end
                                elseif particleLeftStatus(geometry, j) == 0
                                    % Update statistics when particle left
                                    particleLeftStatus(geometry, j) = 1;
                                    TimeofOutControl(geometry, 1) = TimeofOutControl(geometry, 1) + i * GTimeStep;
                                    ParticleatFinish(geometry, 1) = ParticleatFinish(geometry, 1) + 1;
                                    particlesLeftThisStep(geometry, 1) = particlesLeftThisStep(geometry, 1) + 1;
                                end
                            end
                        else
                            % Complex simulation
                            if startZ(geometry, j) == 0 && endZ(geometry, j) < 0
                                % Dont move particle if starts and goes under the floor
                                endX(geometry, j) = startX(geometry, j);
                                endY(geometry, j) = startY(geometry, j);
                                endZ(geometry, j) = startZ(geometry, j);
                            else
                                particleLeft = false;
                                
                                % Levels of the old and new position
                                particleLevel = floor(endZ(geometry, j)/levelHeight(geometry, 1))+1;
                                previousLevel = floor(startZ(geometry, j)/levelHeight(geometry, 1))+1;

                                % Current and new postition of the particle
                                preX = startX(geometry, j);
                                preY = startY(geometry, j);
                                preZ = startZ(geometry, j);

                                postX = endX(geometry, j);
                                postY = endY(geometry, j);
                                postZ = endZ(geometry, j);

                                % Coord change
                                xDiff = postX - preX;
                                yDiff = postY - preY;
                                zDiff = postZ - preZ;

                                % Check if particle is inside the geometry
                                if previousLevel > levelsSize(geometry, 1)
                                    particleLeft = true;
                                else
                                    % The level on which the particle
                                    % should stay
                                    leaveParticleAtLevel = previousLevel;   
                                    % Movement up/down
                                    movesUp = particleLevel >= previousLevel;
                                    
                                    % Find the level on which the particle
                                    % should stay
                                    if particleLevel ~= previousLevel
                                        if movesUp
                                            for level = previousLevel:min(particleLevel - 1, levelsSize(geometry, 1))
                                                % Find intersection coords
                                                pathPercentageBeforeFloorIntersection = (level * levelHeight(geometry, 1) - preZ) / zDiff;
                                                floorIntersectionX = preX + xDiff * pathPercentageBeforeFloorIntersection;
                                                floorIntersectionY = preY + yDiff * pathPercentageBeforeFloorIntersection;

                                                % Check if particle passed
                                                % through the gap between
                                                % levels
                                                if geometry == cylinderGeometry
                                                    if level < levelsSize(geometry, 1)
                                                        smallerRadiusSquare = min(cylinderRadiiSquares(level), cylinderRadiiSquares(level + 1));
                                                    else
                                                        smallerRadiusSquare = cylinderRadiiSquares(level);
                                                    end
                                                    intersectedSmallerRadius = (floorIntersectionX^2 + floorIntersectionY^2) <= smallerRadiusSquare;
                                                else
                                                    inside = inpolygon(floorIntersectionX, floorIntersectionY, convexHulls{level + 1}(:, 1), convexHulls{level + 1}(:, 2));
                                                    intersectedSmallerRadius = inside > 0;
                                                end

                                                if ~intersectedSmallerRadius
                                                    leaveParticleAtLevel = level;
                                                    break;
                                                else                                    
                                                    leaveParticleAtLevel = level + 1;
                                                end
                                            end
                                        else
                                            for level = previousLevel:-1:max(particleLevel + 1, 1)
                                                % Find intersection coords
                                                pathPercentageBeforeFloorIntersection = ((level - 1) * levelHeight(geometry, 1) - preZ) / zDiff;
                                                floorIntersectionX = preX + xDiff * pathPercentageBeforeFloorIntersection;
                                                floorIntersectionY = preY + yDiff * pathPercentageBeforeFloorIntersection;

                                                % Check if particle passed
                                                % through the gap between
                                                % levels
                                                if geometry == cylinderGeometry
                                                    if level > 1
                                                        smallerRadiusSquare = min(cylinderRadiiSquares(level), cylinderRadiiSquares(level - 1));
                                                    else
                                                        smallerRadiusSquare = -1;
                                                    end
                                                    intersectedSmallerRadius = (floorIntersectionX^2 + floorIntersectionY^2) <= smallerRadiusSquare;
                                                else
                                                    if level > 1
                                                        inside = inpolygon(floorIntersectionX, floorIntersectionY, convexHulls{level}(:, 1), convexHulls{level}(:, 2));
                                                        intersectedSmallerRadius = inside > 0;
                                                    else
                                                        intersectedSmallerRadius = false;
                                                    end
                                                end

                                                if ~intersectedSmallerRadius
                                                    leaveParticleAtLevel = level;
                                                    break;
                                                else             
                                                    leaveParticleAtLevel = level - 1;
                                                end
                                            end
                                        end
                                    end
                                    % Found leaveParticleAtLevel

                                    % Check if particle sould stay inside
                                    % the structure
                                    if leaveParticleAtLevel > levelsSize(geometry, 1)
                                        particleLeft = true;
                                    else
                                        % Find the position of the particle
                                        % inside its level
                                        levelCeiling = leaveParticleAtLevel * levelHeight(geometry, 1);
                                        levelFloor = (leaveParticleAtLevel - 1) * levelHeight(geometry, 1);

                                        if movesUp
                                            intersectedPlane = postZ >= levelCeiling;
                                            intersectionHeight = levelCeiling;
                                        else
                                            intersectedPlane = postZ < levelFloor;
                                            intersectionHeight = levelFloor;
                                        end

                                        particleHitWall = ~intersectedPlane;                      

                                        % Check if particle left the floor or
                                        % the ceiling.
                                        if intersectedPlane
                                            % Find intersection coords
                                            pathPercentageBeforeFloorIntersection = (intersectionHeight - preZ) / zDiff;
                                            floorIntersectionX = preX + xDiff * pathPercentageBeforeFloorIntersection;
                                            floorIntersectionY = preY + yDiff * pathPercentageBeforeFloorIntersection;

                                            % Find if particle intersected
                                            % its level floor/ceiling area
                                            if geometry == cylinderGeometry
                                                intersectedRadius = (floorIntersectionX^2 + floorIntersectionY^2) <= cylinderRadiiSquares(leaveParticleAtLevel);
                                            else
                                                if movesUp
                                                    inside = inpolygon(floorIntersectionX, floorIntersectionY, convexHulls{leaveParticleAtLevel+1}(:, 1), convexHulls{leaveParticleAtLevel+1}(:, 2));
                                                else
                                                    inside = inpolygon(floorIntersectionX, floorIntersectionY, convexHulls{leaveParticleAtLevel}(:, 1), convexHulls{leaveParticleAtLevel}(:, 2));
                                                end

                                                intersectedRadius = inside > 0;
                                            end

                                            % Check if particle hit the
                                            % floor/ceiling
                                            if intersectedRadius
                                                % Left particle where it
                                                % intersected the
                                                % floor/ceiling
                                                endX(geometry, j) = floorIntersectionX;
                                                endY(geometry, j) = floorIntersectionY;
                                                
                                                if movesUp
                                                    endZ(geometry, j) = intersectionHeight - epsilonDistance;
                                                else
                                                    endZ(geometry, j) = intersectionHeight;
                                                end
                                            else
                                                particleHitWall = true;
                                            end
                                        end

                                        % Check if particle hit the wall.
                                        % Otherwise its new coordinate is fine and
                                        % shouldn't be changed.
                                        if particleHitWall
                                            if geometry == cylinderGeometry
                                                % Cylinder geometry
                                                if (postX^2 + postY^2) > cylinderRadiiSquares(leaveParticleAtLevel)
                                                    intersections = intersectLineCircle([preX preY 1 yDiff/xDiff], [0, 0, cylinderRadii(leaveParticleAtLevel)]);
                                                    interX = intersections(:, 1)';
                                                    interY = intersections(:, 2)';
                                                    
                                                    if ((postX - interX(1))^2 + (postY - interY(1))^2) < ((postX - interX(2))^2 + (postY - interY(2))^2)
                                                        circleIntersectionX = interX(1);
                                                        circleIntersectionY = interY(1);
                                                    else
                                                        circleIntersectionX = interX(2);  
                                                        circleIntersectionY = interY(2);                                            
                                                    end

                                                    pathPercentageBeforeWallIntersection = sqrt(((circleIntersectionX - preX)^2 + (circleIntersectionY - preY)^2)/(xDiff^2 + yDiff^2));
                                                    circleIntersectionZ = preZ + zDiff * pathPercentageBeforeWallIntersection;

                                                    if circleIntersectionX < 0
                                                        circleIntersectionX = circleIntersectionX + epsilonDistance;
                                                    else
                                                        circleIntersectionX = circleIntersectionX - epsilonDistance;
                                                    end

                                                    if circleIntersectionY < 0
                                                        circleIntersectionY = circleIntersectionY + epsilonDistance;                                                
                                                    else
                                                        circleIntersectionY = circleIntersectionY - epsilonDistance;
                                                    end

                                                    endX(geometry, j) = circleIntersectionX;
                                                    endY(geometry, j) = circleIntersectionY;
                                                    endZ(geometry, j) = circleIntersectionZ;
                                                end
                                            else 
                                                % Polygonal geometry
                                                interPoints = zeros(0, 3);

                                                polyCoords = hulls3d{leaveParticleAtLevel, 1};
                                                polyIndices = hulls3d{leaveParticleAtLevel, 2};
                                                
                                                % Find intersected polygons
                                                for k = 1:size(polyIndices, 1)
                                                    vertex1 = polyCoords(polyIndices(k, 1), :);
                                                    vertex2 = polyCoords(polyIndices(k, 2), :);
                                                    vertex3 = polyCoords(polyIndices(k, 3), :);

                                                    maxDiff = max([xDiff, yDiff, zDiff]);
                                                    interPoint = intersectLineTriangle3d([preX, preY, preZ, xDiff/maxDiff, yDiff/maxDiff, zDiff/maxDiff], ...
                                                        [vertex1, vertex2, vertex3]);

                                                    if ~isnan(interPoint)
                                                        dotProduct = dot([xDiff yDiff zDiff], ([preX preY preZ] - interPoint));
                                                        if abs(dotProduct) > epsilonDistance && dotProduct < 0
                                                            interPoints = cat(1, interPoints, interPoint);
                                                            break;
                                                        end
                                                    end
                                                end

                                                numOfInters = size(interPoints, 1);
                                                if numOfInters == 1
                                                    postDist = sum([xDiff yDiff zDiff].^2);
                                                    interDist = sum((interPoints(1, :) - [preX preY preZ]).^2);
                                                    
                                                    % Chose closest point 
                                                    if interDist < postDist
                                                        endX(geometry, j) = interPoints(1, 1);
                                                        endY(geometry, j) = interPoints(1, 2);
                                                        endZ(geometry, j) = interPoints(1, 3);      
                                                    end
                                                elseif numOfInters == 0
                                                    % Leave particle where
                                                    % it was
                                                    endX(geometry, j) = preX;
                                                    endY(geometry, j) = preY;
                                                    endZ(geometry, j) = preZ;
                                                end
                                            end
                                        end
                                    end
                                end
                                
                                % Update statistics
                                if particleLeft && ~particleLeftStatus(geometry, j)
                                    particleLeftStatus(geometry, j) = 1;
                                    TimeofOutControl(geometry, 1) = TimeofOutControl(geometry, 1) + i * GTimeStep;
                                    ParticleatFinish(geometry, 1) = ParticleatFinish(geometry, 1) + 1;
                                    particlesLeftThisStep(geometry, 1) = particlesLeftThisStep(geometry, 1) + 1;
                                end
                            end
                        end
                    end
                    % Update statistics
                    TempDistance(geometry, 1) = TempDistance(geometry, 1) + (endX(geometry, j)^2 + endY(geometry, j)^2 + endZ(geometry, j)^2) / (6 * i * GTimeStep);
                end % Repeate over particles

            end

            if (strcmp(get(figures.simulationWindow, 'Visible'), 'off'))
                break;
            end
            
            % Update plots
            for geometry = [cylinderGeometry, realGeometry]
                % Update particles
                set(pointPlots(geometry, 1),'XData',endX(geometry, :));                                                   
                set(pointPlots(geometry, 1),'YData',endY(geometry, :));
                set(pointPlots(geometry, 1),'ZData',endZ(geometry, :));               
                
                % Update plot
                particlesLeftInTime(geometry, i+1) = particlesLeftThisStep(geometry, 1);
                set(particlesLeftPlot{geometry}, 'XData', Time);
                set(particlesLeftPlot{geometry}, 'YData', particlesLeftInTime(geometry, :));
                
                % Update statistics
                if ParticleatFinish(geometry, 1) > 0
                    TimeofOut(geometry, i+1) = ParticleatFinish(geometry, 1); %TimeofOutControl /ParticleatFinish;
                else
                    TimeofOut(geometry, i+1) = 0;
                end
                ParticleatFinish(geometry, 1) = 0;

                Distance(geometry, i+1) = (TempDistance(geometry, 1)^2) / np;
                DifCoef(geometry, i+1) = (TempDistance(geometry, 1) / np / 3) / 10^6;
                TempDistance(geometry, 1) = 0;
                DifCoefTotal{geometry, 1} = DifCoefTotal{geometry, 1} + DifCoef(geometry, :);
            end
            
            pause(0.0000005);
            
            startX = endX;
            startY = endY;
            startZ = endZ;
        end
    end
       
    if (strcmp(get(figures.simulationWindow, 'Visible'), 'off'))
        return;
    end    

    % Plot resulting graphs
    figure(figures.graphDistance);
    clf;
    grid on;

    figure(figures.graphDiffCoef);
    clf;
    grid on;

    figure(figures.graphTimeOfOut);
    clf;
    grid on;

    plotTime = 0:plotTimeStep:TimePeriod;
    plotTimeSize = size(plotTime, 2);
    
    for geometry = [cylinderGeometry realGeometry]
        figure(figures.graphDistance);
        hold on;
        plot(plotTime, ReduceVectorToSize(Distance(geometry, :), plotTimeSize), plotColor{geometry});
        xlabel('Time');
        ylabel('Distance');

        figure(figures.graphDiffCoef);
        hold on;
        plot(plotTime, ReduceVectorToSize(DifCoefTotal{geometry, :}, plotTimeSize)/TotalNumberinteration, plotColor{geometry});
        xlabel('Time');
        ylabel('Diff coef.');

        figure(figures.graphTimeOfOut);
        hold on;
        
        % Create plot
        reduced = IntegrateVectorToSize(particlesLeftInTime(geometry, :), plotTimeSize, GTimeStep, plotTimeStep);
        for i = 2:size(reduced, 2)
            plot(plotTime, reduced, plotColor{geometry});
        end
        xlabel('Time, ms');
        ylabel('Particles per ms');
    end

end



