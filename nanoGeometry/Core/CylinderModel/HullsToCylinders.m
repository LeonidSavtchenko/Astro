function [R, H] = HullsToCylinders(convexHulls, lvlH)
%% Convert polygon structure to concentric cylindrical structure.
%  Radii computation formula is taken from the custom code area in the GUI.

    global cylindersPerLevel interCoef cylinderFormula

    levelsSize = size(convexHulls, 1) - 1;
    cylindersSize = (levelsSize) * cylindersPerLevel;     
    levelAreas = PolyAreas(convexHulls);
    
    % Params exposed to GUI
    R = zeros(cylindersSize, 1);
    H = lvlH / cylindersPerLevel;    
    interArea = IntersectionAreas(convexHulls, 100);
    volume = HullsVolume(convexHulls);
    xyShift = CalculateHullCenterShifts(convexHulls);
    botArea = levelAreas(1:levelsSize, 1);
    topArea = levelAreas(2:levelsSize+1, 1);    
    
    % Concat all formula strings in one line
    singleLineFormula = '';
    for i = 1:size(cylinderFormula, 1)
        line = cylinderFormula{i};
        if numel(line) > 0 && ~strcmp(line(1), '%')
            singleLineFormula = strcat(singleLineFormula, cylinderFormula{i});
        end
    end
    
    for cyl = 1:cylindersSize
        lvl = ceil(cyl / cylindersPerLevel);
        eval(singleLineFormula);
    end 
    
end