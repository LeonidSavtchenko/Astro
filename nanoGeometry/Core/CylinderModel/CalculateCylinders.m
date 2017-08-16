function [cylinderRadii, convexHulls, levelHeight, cylinderHeight]  = CalculateCylinders(data)
%% Calculate cylinder radii form data.

    [levels, levelHeight] = SplitToLevels(data);
    convexHulls = PointsToConvexHulls(levels);
    convexHulls = ShiftHulls(convexHulls);
    [cylinderRadii, cylinderHeight] = HullsToCylinders(convexHulls, levelHeight);

end