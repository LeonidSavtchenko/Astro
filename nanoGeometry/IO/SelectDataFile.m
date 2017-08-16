function [fullFilePath, fileName] = SelectDataFile()
%% Show dialog to select .dat file.
%  Returns 0 if file wasn't selected.

    [fileName, path] = uigetfile('*.dat', 'Select input data');
    
    if isequal(fileName, 0) || isequal(path, 0)
        % Loading was cancelled
        fullFilePath = 0;
        fileName = 0;
    else
        fullFilePath = fullfile(path, fileName);
    end
    
end

