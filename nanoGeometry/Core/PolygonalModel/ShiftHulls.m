function shiftedHulls = ShiftHulls(convexHulls)
%% Shift coordinates of all the hulls.
%  Make zero point start at the center of the lowest one
%  and lift them up on levelHeight.

    hullsSize = size(convexHulls, 1);
    shiftedHulls = convexHulls;
    
    firstHullGeometry = polygeom(convexHulls{1, 1}(:, 1), convexHulls{1, 1}(:, 2));
    
    for i = 1:hullsSize
        shiftedHulls{i, 1} = [convexHulls{i, 1}(:, 1)- firstHullGeometry(2) ...
            convexHulls{i, 1}(:, 2) - firstHullGeometry(3), ...
            convexHulls{i, 1}(:, 3) - convexHulls{1, 1}(1, 3)];
    end    

end