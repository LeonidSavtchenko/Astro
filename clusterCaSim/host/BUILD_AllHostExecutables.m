function BUILD_AllHostExecutables()
%% Compile executable files for entry points of the host.
%  Copy all dependent non-M files to the target directory.
%  Create a readme file.
%  Prepare ZIP archive.

    assert(ispc);
    
    % Whether to make Matlab compiler verbose
    beVerbose = false;
    
    tic;
    
    AddPaths();
    
    outDirName = 'host_compiled';
    tempSubDirName = '_BuildTemp';
    
    % Create a new or clean up the existing target directory
    outDirPath = fullfile(cd, '..', outDirName);
    PrepareEmptyDir(outDirPath);
    
    % Copy all dependent non-M files to the target directory
    
    disp('Copying non-M files ...');
    
    srcDir = fullfile(cd, 'Core');
    dstDir = fullfile(cd, '..', outDirName, tempSubDirName, 'Core');
    
    CopyOneDir(dstDir, srcDir, '3rdparty');
    CopyOneDir(dstDir, srcDir, 'scripts', 'win-lin');
    CopyOneDir(dstDir, srcDir, 'scripts', 'win-win');
        
    % Compile all the the entry points
    
    scriptNames = {
        'START_Simulation', ...
        'SCRIPT_KillBackgroundProcess'};
        
    disp('Compiling executables ...');
    tempSubDirPath = fullfile(outDirPath, tempSubDirName);
    for i = 1 : length(scriptNames)
        CompileOneExecutable(scriptNames{i}, tempSubDirPath, beVerbose);
    end
    
    % Create a readme file
    readmePath = fullfile(tempSubDirPath, 'readme.txt');
    fid = fopen(readmePath, 'w');
    assert(fid ~= -1);
    text = [
        'These executables were compiled in MATLAB version ', version, '.\r\n', ...
        'To run them on a machine where this version of MATLAB is not installed, ' ...
        'you have to install corresponding version of MATLAB Runtime.\r\n', ...
        'It is a free package that can be downloaded from the next webpage:\r\n', ...
        '\r\n', ...
        '    https://www.mathworks.com/products/compiler/mcr/', ...
        '\r\n'];
    fprintf(fid, text);
    fclose(fid);
    
    % Create ZIP archive, then delete the temporary subdirectory
    % (we don't use ScriptCallCommand here, because it checks remoteHPC which is not initialized for this build script)
    command = sprintf('call Core\\scripts\\win-win\\zip_compiled_bins.bat "%s"', tempSubDirPath);
    system(command);
    
    toc
    
end


function CopyOneDir(dstDir, srcDir, varargin)
%% Copy one directory

    copyfile(...
        fullfile(srcDir, varargin{:}), ...
        fullfile(dstDir, varargin{:}), ...
        'f');

end


function CompileOneExecutable(scriptName, outDir, beVerbose)
%% Compile one executable file

    disp(['    Compiling ', scriptName, '.exe ...']);
    
    % Prepare arguments for Matlab compiler.
    % Remark: We force "mcc" compile all the m-files in some directories,
    %         because otherwise it skips compilation of the functions
    %         which are not called explicitly anywhere.
    %         For example, some validation predicates are called only implicitly via "eval" function,
    %         and this results in runtime errors of type "Undefined function"
    %         if we do not point compiler to them with '-a' argument.
    attachDir = fullfile(cd, 'GUI', 'ValidationPredicates');
    mainFileName = [scriptName, '.m'];
    args = {'-m', '-d', outDir, '-a', attachDir, mainFileName};
    if beVerbose
        args = ['-v', args];
    end
    
    % Run the compiler
    mcc(args{:});
    
end
