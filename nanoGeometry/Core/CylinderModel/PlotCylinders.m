function PlotCylinders(cylinderRadii, levelHeight)
%% Plot concentric cylinders one over another.

    cylindersSize = size(cylinderRadii, 1);    
    [cylinderX, cylinderY, cylinderZ] = cylinder;
    
    for i = 1:cylindersSize
        cylinderZ(1, :) = (i - 1) * levelHeight; 
        cylinderZ(2, :) = i * levelHeight;         
        sylinderSurf = surf(cylinderRadii(i) * cylinderX, cylinderRadii(i) * cylinderY, cylinderZ);
        set(sylinderSurf, 'FaceAlpha', 0.1);
    end
    
end