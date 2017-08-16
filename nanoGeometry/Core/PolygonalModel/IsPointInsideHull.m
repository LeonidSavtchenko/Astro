function inside = IsPointInsideHull(hullParamA, hullParamB, x, y, z)
%% Check if point is inside the hull

    inside = all(hullParamA * [x; y; z] <= hullParamB);

end

