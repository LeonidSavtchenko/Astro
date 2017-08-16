function AddPosRatScalar(name, value, unit, desc,   relPred, valPred)
%% Add positive rational scalar

    if nargin < 5
        relPred = 'true';
    end
    valPred_ = [name, ' > 0'];
    if nargin == 6
        valPred_ = [valPred_, ' && ', valPred];
    end
    AddRatScalar(name, value, unit, desc, relPred, valPred_);
    
end