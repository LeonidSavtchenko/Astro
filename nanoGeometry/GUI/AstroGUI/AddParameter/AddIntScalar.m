function AddIntScalar(name, value, unit, desc,   relPred, valPred)
%% Add integer scalar

    if nargin < 5
        % The parameter is always relevant
        relPred = 'true';
    end
    
    % Extend the validation expression to verify that an integer value is provided
    valPred_ = sprintf('rem(%s, 1) == 0', name);
    if nargin == 6
        valPred_ = [valPred_, ' && ', valPred];
    end
    
    AddRatScalar(name, value, unit, desc, relPred, valPred_);

end
