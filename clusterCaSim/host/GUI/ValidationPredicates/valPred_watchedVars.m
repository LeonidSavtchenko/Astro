function valid = valPred_watchedVars(watchedVars)
%% Validation predicate for the watched variables table

    assert(iscell(watchedVars));
    
    [numRows, numCols] = size(watchedVars);
    
    assert(numRows > 0 && numCols == 4);
    
    for i = 1 : numRows
        comp  = watchedVars{i, 1};
        index = watchedVars{i, 2};
        param = watchedVars{i, 3};
        coord = watchedVars{i, 4};
        valid1 = ischar(comp) && ~isempty(comp) && ~strcmp(comp, '?');
        valid2 = isnumeric(index) && isreal(index) && ~isnan(index) && index >= 0 && ~isinf(index) && rem(index, 1) == 0;
        valid3 = ischar(param) && ~isempty(param) && ~strcmp(param, '?');
        valid4 = isnumeric(coord) && isreal(coord) && ~isnan(coord) && coord >= 0 && coord <= 1;
        valid = valid1 && valid2 && valid3 && valid4;
        if ~valid
            return
        end
    end
    
end