function  button_StopSimmulation_Callback(handle, ~)
%% Set 'stopSimulation' flag to true.
%  Difusion simulation checks this flag state every particle iteration.

    global stopSimulation
    
    stopSimulation = true;
    
end

