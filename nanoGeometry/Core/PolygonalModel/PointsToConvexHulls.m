function convexHulls = PointsToConvexHulls(data)
%% Find 2D convex hulls for sets of points.

    convexHulls = cell(size(data, 1), 2);

    for i = 1:size(data, 1)
        ring = data{i, 1};
        
        try
            convexHulls{i, 1} = ring(convhull(ring(:, 1:2)), :);
            convexHulls{i, 2} = true;
        catch
            convexHulls{i, 1} = ring;
            convexHulls{i, 2} = false;
        end
    end
    
end