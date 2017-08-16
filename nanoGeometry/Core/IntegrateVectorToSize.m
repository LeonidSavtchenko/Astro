function reduced = IntegrateVectorToSize(inMat, toSize, preStep, postStep)
%% Makes integral distribution of single row matrix of size.

    reduced = zeros(1, toSize);
    reduced(1, 1) = inMat(1, 1);
    
    indexStep = postStep / preStep;
    for i = 2:toSize
        % Calculate dx/dt
        reduced(1, i) = (GetValueAtFloatIndex(inMat, 1 + indexStep * (i - 1)) ...
            - GetValueAtFloatIndex(inMat, 1 + indexStep * (i - 2))) / postStep;        
    end
    
end

function value = GetValueAtFloatIndex(inMat, floatIndex) 
%% Return average value of non integral index.

    floorIndex = floor(floatIndex);
    ceilIndex = ceil(floatIndex);
         
    if mod(floatIndex, 1) > 0 && ceilIndex <= size(inMat, 2) 
        value = inMat(1, floorIndex) + ...
            (floatIndex - floorIndex) *  (inMat(1, ceilIndex) - inMat(1, floorIndex));
    else
        value = inMat(1, floorIndex);
    end    
    
end