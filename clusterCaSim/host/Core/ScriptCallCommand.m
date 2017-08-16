function command = ScriptCallCommand(scriptName,   varargin)
%% Prepare a command to call the script with the arguments

    global remoteHPC
    
    assert(ispc);
    
    if remoteHPC
        dirName = 'win-lin';
    else
        dirName = 'win-win';
    end
    
    command = sprintf('call Core\\scripts\\%s\\%s.bat', dirName, scriptName);
    
    if ~isempty(varargin)
        command = [command, ' ', PrepareArgs(varargin)];
    end
    
end

function args = PrepareArgs(args)
%% Convert the cell array of arguments to a string of space-separated arguments

    for i = 1 : length(args)
        args{i} = num2str(args{i});
    end
    
    args = strjoin(args, ' ');
    
end
