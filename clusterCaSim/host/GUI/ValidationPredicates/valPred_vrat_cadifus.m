function valid = valPred_vrat_cadifus(vrat_cadifus)
%% Validation predicate for "vrat_cadifus" table

    assert(iscell(vrat_cadifus));
    
    [numRows, numCols] = size(vrat_cadifus);
    
    assert(numRows > 0 && numCols == 2);
    
    for i = 1 : numRows
        index = vrat_cadifus{i, 1};
        value = vrat_cadifus{i, 2};
        valid1 = isnumeric(index) && isreal(index) && ~isnan(index) && index >= 0 && ~isinf(index) && rem(index, 1) == 0;
        valid2 = isnumeric(value) && isreal(value) && ~isnan(value) && value >= 0;
        valid = valid1 && valid2;
        if ~valid
            return
        end
    end
    
end