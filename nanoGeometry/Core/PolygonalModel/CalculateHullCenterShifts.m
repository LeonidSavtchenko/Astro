function centerShifts = CalculateHullCenterShifts(convexHulls)
%% Calculate distance between the centers of the consecutive polygons.

    centerShiftsSize = size(convexHulls, 1) - 1;
    centerShifts = zeros(centerShiftsSize, 1);    
    
    for i = 1:centerShiftsSize        
        aGeom = polygeom(convexHulls{i, 1}(:, 1), convexHulls{i, 1}(:, 2));
        bGeom = polygeom(convexHulls{i+1, 1}(:, 1), convexHulls{i+1, 1}(:, 2));
        centerShifts(i, 1) = sqrt((bGeom(2) - aGeom(2))^2 + (bGeom(3) - aGeom(3))^2); 
    end
    
end