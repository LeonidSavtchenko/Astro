function AddTimingParams()

    AddPanel('Timing');
    
    AddPosIntScalar('timePeriod', 10000, 'ms', 'The time period to simulate');
    AddPosIntScalar('timeStep', 1, 'ms', 'The time step');
    
    desc = {'How often simulator must report current progress?', ...
            '<i>It must be evenly divisible by %timeStep.</i>'};
    AddPosIntScalar('reportPeriod', 100, 'ms', desc, true, 'rem(reportPeriod, timeStep) == 0');   
    
end