function AddPosIntScalar(name, value, unit, desc,   relPred, valPred)
%% Add positive integer scalar

    if nargin < 5
        relPred = 'true';
    end
    
    valPred_ = [name, ' > 0'];
    if nargin == 6
        valPred_ = [valPred_, ' && ', valPred];
    end
    
    AddIntScalar(name, value, unit, desc, relPred, valPred_);
    
end