function AddSimulationParams()

    global simComplexity simComplexities TimePeriod GTimeStep diffCoef charge np plotTimeStep
    
    AddPanel('Simullation params');       
    AddList('simComplexity', fieldnames(simComplexities), simComplexity, ...
        'Complexity of particle behavior during diffusion simulation', ...
        {'Particles stay in place when their new coordinate is out of the structure. Fast.', ...
        'Particles hit walls when they try to leave the structure. Slow.'});
    AddPosRatScalar('TimePeriod', TimePeriod, 'ms', 'The time period to simulate');
    AddPosRatScalar('GTimeStep', GTimeStep, 'ms', 'The time step of Monte Carlo simulations');
    AddPosRatScalar('diffCoef', diffCoef, 'mkm^2/ms', 'Diffusion coefficient');
    AddNonNegRatScalar('charge', charge, 'Valence', 'A charged particle in an electric field 100 V/m');
    AddPosIntScalar('np', np, '', 'Number of Particles');
    AddPosRatScalar('plotTimeStep', plotTimeStep, 'ms', 'Time step for the resulting plots, does not affect simulation.');
    
end