function pb_OK_Callback(~, ~)

    global invalidParams hf
    
    if ~isempty(invalidParams)
        msg = ['The following parameters are not valid:', invalidParams];
        warndlg(msg, 'Invalid parameters');
        return
    end
    
    % Close the figure as late as possible so that maximum number of errors could occur before it is closed
    close(hf);
    
    % Generate "params.hoc" file based on the values from GUI
    GenerateParamsHoc();
    
    % Deploy "params.hoc" file (required) and custom geometry HOC file (optional) to HPC folder
    DeployInputFiles();
    
    % Translate to C and compile MOD files,
    % generate helper file "mcomplex.dat",
    % split geometry by processes and launch simulation
    BuildAndLaunchSimulation();
    
    % Grab results from HPC kernel directory and put them to host directory
    GrabResults();
    
    figure('Name', 'Results', 'NumberTitle', 'off');
    % Read and visualize results
    ReadAndVisualizeResults();
    
    % Check whether file "complete" exists
    disp('Checking whether results of simulation are present ...')
    isPresent = CheckFileExists('results', 'complete');
    assert(isPresent, 'Simulation has been finished unsuccessfully.');
    
end
