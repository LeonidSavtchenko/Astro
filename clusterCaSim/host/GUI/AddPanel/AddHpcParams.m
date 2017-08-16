function AddHpcParams()
    
    global remoteHPC ProcSchemes zipDataFiles
    
    AddPanel('HPC');
    
    desc = {'On/off scalability test', ...
            '<b>unchecked:</b> <i>single run</i>', ...
            '<b>checked:</b> <i>multiple runs</i>'};
    AddBoolScalar('scalTest', false, desc);
    
    desc = {'Whether to use remote High Performance Computing server', ...
            '<b>unchecked:</b> <i>call HPC kernel on this machine/cluster</i>', ...
            '<b>checked:</b> <i>call HPC kernel on remote machine/cluster</i>'};
    AddBoolScalar('remoteHPC', remoteHPC, desc);
    
    procSchemeTypesDesc = {'<i>Only master works (up to 4 processes)</i>', ...
                           '<i>Only slaves work (up to 12 processes)</i>', ...
                           '<i>Master and slaves work together (up to 13 processes)</i>'};
    AddList('procScheme', fieldnames(ProcSchemes), ProcSchemes.OnlyMaster, 'The process distribution scheme', procSchemeTypesDesc, 'remoteHPC');
    
    AddPosIntScalar('np', 1, '', 'The number of MPI processes', '~scalTest', 'valPred_procSchemeMaxProc(remoteHPC, procScheme, np)');
    valPred = '(minNP <= maxNP) && valPred_procSchemeMaxProc(remoteHPC, procScheme, minNP)';
    AddPosIntScalar('minNP', 1, '', 'The minimum number of MPI processes', 'scalTest', valPred);
    valPred = '(minNP <= maxNP) && valPred_procSchemeMaxProc(remoteHPC, procScheme, maxNP)';
    AddPosIntScalar('maxNP', 12, '', 'The maximum number of MPI processes', 'scalTest', valPred);
    AddPosIntScalar('procStep', 1, '', 'The step of process grid', 'scalTest');
    
    desc = {'Whether files of results should be zipped before and unzipped after transferring between local machine and head node of the cluster', ...
            '<b>unchecked:</b> <i>the files are transferred without compressing</i>', ...
            '<b>checked:</b> <i>the files are compressed before and decompressed after transferring</i>'};
    AddBoolScalar('zipDataFiles', zipDataFiles, desc, 'remoteHPC');
    
end