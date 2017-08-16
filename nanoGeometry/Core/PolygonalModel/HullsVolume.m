function hullVolumes = HullsVolume(convexHulls)
%% Calculate volume of the levels.

    levelHullsSize = size(convexHulls, 1) - 1;
    
    hullVolumes = zeros(levelHullsSize, 1);    
    
    for i = 1:levelHullsSize
        X = [convexHulls{i,1}(:, 1:3); convexHulls{i+1,1}(:, 1:3)];
        [~, hullVolumes(i, 1)] = convhulln(X);          
    end

end