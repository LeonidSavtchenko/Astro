function DeployInputFiles()
%% Deploy "params.hoc" file (required) and custom geometry HOC file (optional) to HPC folder

    global remoteHPC zipDataFiles geometryFile defaultGeometry
    
    if remoteHPC
        msg = 'Uploading input data files to the cluster ...';
        scriptName = 'upload';
        args = {zipDataFiles};
    else
        msg = 'Copying input data files to HPC folder ...';
        scriptName = 'copy_input';
        args = {};
    end
    
    if ~strcmp(geometryFile, defaultGeometry)
        args = [args, geometryFile];
    end
    
    command = ScriptCallCommand(scriptName, args{:});
    
    disp(msg);
    system(command);
    
end