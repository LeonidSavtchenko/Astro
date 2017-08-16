function isRunning = CheckIfRunning(silentMode)
%% Checks if HPC kernel is running in background mode

    global remoteHPC availableNodes
    
    if nargin == 0
        silentMode = false;
    end
    
    command = ScriptCallCommand('check_running');
    
    if remoteHPC
        args = strjoin(availableNodes, ' ');
        command = [command, ' ', args];
    end
    
    if silentMode
        command = [command, ' > NUL'];
    else
        disp('Checking whether HPC kernel is running in background mode ...');
    end
    
    status = system(command);
    
    isRunning = (status == 0);
    
    if ispc && ~remoteHPC
        isRunning = ~isRunning;
    end
    
    if ~silentMode
        if isRunning
            fprintf('It is.\n\n');
        else
            fprintf('It is not.\n\n');
        end
    end
    
end
