function intersectionAreas = IntersectionAreas(convexHulls, resolution)
%% Calculate intersection areas of the set of polygons.

    intersectionsSize = size(convexHulls, 1) - 1;
    intersectionAreas = zeros(intersectionsSize, 1);
    
    for i = 1:intersectionsSize
        intersectionAreas(i, 1) = areaintersection(convexHulls{i}, convexHulls{i + 1}, resolution);
    end
    
end