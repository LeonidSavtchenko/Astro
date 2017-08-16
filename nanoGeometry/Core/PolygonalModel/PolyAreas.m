function areas = PolyAreas(polygons)
%% Find areas of the set of polygons.

	polygonsSize = size(polygons, 1);
    areas = zeros(polygonsSize, 1);

    for i = 1:polygonsSize
        areas(i, 1) = polyarea(polygons{i, 1}(:, 1), polygons{i, 1}(:, 2));
    end

end