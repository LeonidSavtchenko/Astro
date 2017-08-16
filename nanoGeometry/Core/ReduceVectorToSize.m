function reduced = ReduceVectorToSize(inMat, toSize)
%% Reduces single row matrix size to specified value leaving the same value distribution.
%  Example 1-2-3 to size 5 = 1-1.5-2-2.5-3, to size 2 = 1-3

    inMatSize = size(inMat, 2);
    reduced = zeros(1, toSize);
    reduced(1, 1) = inMat(1, 1);
    reduced(1, end) = inMat(1, end);
    
    step = (inMatSize - 1) / (toSize - 1);
    for i = 2:toSize - 1
        floatIndex = 1 + step * (i - 1);
        indexStart = floor(floatIndex);
        indexEnd = ceil(floatIndex);
        percentageDiff = floatIndex - indexStart;        
        reduced(1, i) = (inMat(1, indexEnd) - inMat(1, indexStart)) * percentageDiff ...
            + inMat(1, indexStart);
    end
    
end