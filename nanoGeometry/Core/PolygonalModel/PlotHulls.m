function PlotHulls(convexHulls, showPoints, faceAlpha, edgeAlpha)
%% Plot polygons in 3D space.

    if nargin < 4
        edgeAlpha = 0.1;
    end
    
    if nargin < 3
        faceAlpha = 0.1;
    end
    
    if nargin < 2
        showPoints = false;
    end

    hullsSize = size(convexHulls, 1);
    
    for i = 1:hullsSize
        if convexHulls{i, 2} == true
            pointColor = 'blue';
            pointSize = 20;
        else  
            pointColor = 'red'; 
            pointSize = 25;    
        end     
        
        plot3(convexHulls{i, 1}(:, 1), convexHulls{i, 1}(:, 2), convexHulls{i, 1}(:, 3), pointColor); 

        if showPoints
            scatter3(convexHulls{i, 1}(:, 1), convexHulls{i, 1}(:, 2), convexHulls{i, 1}(:, 3), pointSize, '*', pointColor);
        end   
        
        if (i < hullsSize)
            if size(convexHulls{i, 1}, 1) > 1 && size(convexHulls{i + 1, 1}, 1) > 1
                X = [convexHulls{i, 1}(:, 1:3); convexHulls{i + 1, 1}(:, 1:3)];
                K = convhulln(X);

                hullSurface = trisurf(K, X(:, 1), X(:, 2), X(:, 3));
                set(hullSurface, 'FaceAlpha', faceAlpha);
                set(hullSurface, 'EdgeAlpha', edgeAlpha);
            end
        end
                  
    end
    
end