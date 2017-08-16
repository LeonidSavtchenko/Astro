function levelHulls = Calculate3DLevelHulls(convexHulls)
%% Calculate 3D convex hull of the whole level.

    levelHullsSize = size(convexHulls, 1) - 1;    
    levelHulls = cell(levelHullsSize, 2);
    
    for i = 1:levelHullsSize
        levelHulls{i, 1} = [...
            convexHulls{i, 1}(:, 1:3); ...
            convexHulls{i + 1, 1}(:, 1:3)];
        
        levelHulls{i, 2} = convhulln(levelHulls{i, 1});
    end

end