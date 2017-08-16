function PrepareEmptyDir(path)
%% Given path, create a new or clean up the existing directory 
    
    % Temporarily disable the warning complaining that we deleted a directory present in Matlab path
    % (it can be there if an error occurred during the previous running of the host)
    id1 = 'MATLAB:rmpath:DirNotFound';
    warning('off', id1);
    
    % Remove the directory
    [success, message, id2] = rmdir(path, 's');
    
    % Enable the warning
    warning('on', id1);
    
    % A message about not existing directory is OK
    if ~success && ~strcmp(id2, 'MATLAB:RMDIR:NotADirectory');
        error(message);
    end
    
    % Create a new empty directory
    [success, message, ~] = mkdir(path);  
    if ~success
        error(message);
    end
    
end