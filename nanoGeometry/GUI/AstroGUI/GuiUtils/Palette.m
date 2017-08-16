function Palette()
%% Initialize global constants for color palette

    global palette
    
    palette.backgroundColor = [0.941, 0.941, 0.941];
    
    palette.validColor = [1, 1, 1];
    palette.invalidColor = [1, 0.5, 0.5];
    
    palette.tableValidColor = [1, 1, 1; ...     % odd rows
                               0.8, 0.9, 1];    % even rows
    palette.tableInvalidColor = [1, 0.5, 0.5;
                                 0.8, 0.4, 0.5];
                            
    palette.stripColor = [0.5, 0.5, 0.5];

end