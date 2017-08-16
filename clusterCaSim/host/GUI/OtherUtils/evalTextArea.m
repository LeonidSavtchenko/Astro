function valid = evalTextArea(text, varName)
%% Evaluate custom m-code from the editable text area.
%  Before the evaluation, get the global variable with the given name
%  so that it can be assigned during evaluation.

    assert(iscell(text));
    assert(size(text, 2) == 1);
    
    eval(['global ', varName]);
    eval([varName, ' = struct;']);
    
    % Join cell array of strings into single string,
    % because "eval" function does not support cell array as an input
    cmd = strjoin(text', '\n');
    
    try
        eval(cmd);
        valid = true;
    catch
        valid = false;
    end

end