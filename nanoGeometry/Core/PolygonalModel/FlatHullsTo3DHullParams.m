function hullParams = FlatHullsTo3DHullParams(convexHulls)
%% Calculate geometrical parameters of 3D level hulls.

    levelHullsSize = size(convexHulls, 1) - 1;    
    hullParams = cell(levelHullsSize, 2);
    
    for i = 1:levelHullsSize
        [A, b]=vert2lcon([...
            convexHulls{i, 1}(:, 1:3); ...
            convexHulls{i + 1, 1}(:, 1:3)]);
        
        hullParams{i, 1} = A;
        hullParams{i, 2} = b;
    end

end

