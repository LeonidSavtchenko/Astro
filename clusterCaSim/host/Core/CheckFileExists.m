function isPresent = CheckFileExists(varargin)
%% Determine whether the file is present in the directory given relative path
%  from the HPC kernel root directory.
%  varargin - the chain of folder names followed by the file name.

    global remoteHPC
    
    command = ScriptCallCommand('check_file');
    
    if xor(ispc, remoteHPC)
        % Windows separator
        separator = '\';
    else
        % Linux separator
        separator = '/';
    end
    
    filePath = strjoin(varargin, separator);
    command = [command, ' ', filePath];
    
    status = system(command);
    
    isPresent = (status == 0);
    
end