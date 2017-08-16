function CommitParam(name, value, relPred, valPred, handlers, unit)

    if strcmp(unit, 'tg') || strcmp(unit, 'it')
        caster = @int32; 
    else
        caster = @(x)x; 
    end
    
    global params panIdx
    params{panIdx}{end + 1} = struct('name', name, 'relPred', relPred, 'valPred', valPred, 'handlers', handlers, 'caster', caster);
    
    % Assign the value individually, because in case of the value being a cell array,
    % the command above creates a struct array instead of a single struct (if the cell array has several elements)
    % or unwraps the value from the cell (if the cell array has only one element)
    params{panIdx}{end}.value = value;
    
    cmd1 = ['global ', name];
    cmd2 = [name, ' = value;'];
    eval(cmd1);
    eval(cmd2);

end