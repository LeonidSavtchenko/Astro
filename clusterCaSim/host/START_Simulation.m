function START_Simulation()
    
    % Clear all variables, but do not remove breakpoints
    clearvars;
    clearvars -global;
    
    close all;
    clc;
    
    AddPaths();
    
    % Initialize the basic parmeters
    BasicParams();
    
    global remoteHPC
    
    % Check if the process is running at the moment
    isRunning = CheckIfRunning();
    assert(~isRunning, 'HPC kernel is running at the moment. Please wait until it completes or use SCRIPT_KillBackgroundProcess.m. Current progress will be lost in that case.');
    
    % Check whether file "complete" exists
    disp('Checking whether results of simulation are present in HPC kernel directory ...')
    isPresent = CheckFileExists('results', 'complete');
    
    % Prepare invitation hint for user input
    if isPresent
        if remoteHPC
            verb = 'Download';
        else
            verb = 'Take';
        end
        hint = [...
            '1. ', verb, ' and analyse results.\n', ...
            '2. Start simulation from scratch (current results will be lost).\n'];
    else
        hint = [...
            '1. Start simulation from scratch.\n', ...
            '2. Do nothing\n'];
    end
    
    hint = ['\nPlease specify what to do:\n', hint, '[1 or 2]: '];
    
    % Loop until user inputs correct data
    while true
        % MATLAB 2018a has a bug and may not show prompt passed to input() function
        % so the prompt has to be printed separately
        fprintf(hint);
        reply = input('', 's');
        if strcmp(reply, '1') || strcmp(reply, '2')
            fprintf('\n');
            break
        end
    end
    
    if isPresent && strcmp(reply, '1')          
        % Grab results from HPC folder and put them to host folder
        GrabResults();
        
        figure('Name', 'Results', 'NumberTitle', 'off');
        % Read and visualize results
        ReadAndVisualizeResults();
    elseif (isPresent && strcmp(reply, '2')) || (~isPresent && strcmp(reply, '1'))        
        % Prepare and show the GUI
        PrepareAndShowGUI();        
    end
    
end