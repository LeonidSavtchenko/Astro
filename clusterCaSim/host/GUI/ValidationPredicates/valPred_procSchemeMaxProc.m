function valid = valPred_procSchemeMaxProc(remoteHPC, procScheme, np)
%% Validation predicate for "np", "minNP" and "maxNP" (only the upper limit is checked here)

    global ProcSchemes availableNodes
    
    if ~remoteHPC
        valid = true;
        return
    end
    
    switch procScheme
        case ProcSchemes.OnlyMaster
            valid = np <= 4;
        case ProcSchemes.OnlySlaves
            valid = np <= length(availableNodes) - 1;
        case ProcSchemes.MasterAndSlaves
            valid = np <= length(availableNodes);
        otherwise
            assert(false, 'No rule for procScheme');
    end
    
end

