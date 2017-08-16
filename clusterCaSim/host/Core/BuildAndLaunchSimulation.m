function BuildAndLaunchSimulation()
%% Translate to C and compile MOD files,
%  generate helper file "mcomplex.dat",
%  split geometry by processes and launch simulation

    global np scalTest procScheme minNP maxNP procStep
    
    if scalTest
        scriptName = 'scaltest';
        args = {minNP, maxNP, procStep, procScheme};
    else
        scriptName = 'run';
        args = {np, procScheme};
    end
    
    command = ScriptCallCommand(scriptName, args{:});
    
    status = system(command);
    
    success = (status == 0);
    
    assert(success, 'Simulation finished unsuccessfully.');
    
    fprintf('\nSimulation finished successfully.\n\n');
    
end