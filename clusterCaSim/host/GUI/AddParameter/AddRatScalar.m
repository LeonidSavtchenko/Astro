function AddRatScalar(name, value, unit, desc,   relPred, valPred)
%% Add rational scalar

    if nargin < 5
        % The parameter is always relevant
        relPred = 'true';
    end
    
    % Extend the validation expression
    valPred_ = sprintf('isnumeric(%s) && ~isnan(%s) && ~isinf(%s) && isreal(%s)', name, name, name, name);
    if nargin == 6
        valPred_ = [valPred_, ' && ', valPred];
    end
    
    % The name
    [handlers, xPos] = CreateParamNameText(name);

    % The control itself
    [handlers(end + 1), xPos] = CreateParamEditBox(value, xPos, desc);
    
    % The unit
    if ~isempty(unit)
        handlers(end + 1) = CreateParamUnitText(unit, xPos);
    end
    
    CommitParam(name, value, relPred, valPred_, handlers, unit);

end