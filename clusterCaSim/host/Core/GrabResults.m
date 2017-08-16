function GrabResults()
%% Grab results from HPC folder and put them to host folder

    global remoteHPC zipDataFiles
    
    if remoteHPC
        msg = 'Downloading results from the cluster ...';
        command = ScriptCallCommand('download', zipDataFiles);
    else
        msg = 'Taking results ...';
        command = ScriptCallCommand('copy_output');
    end
    
    disp(msg);
    system(command);

end