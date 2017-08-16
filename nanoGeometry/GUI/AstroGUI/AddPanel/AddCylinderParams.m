function AddCylinderParams()

    global cylindersPerLevel interCoef cylinderFormula
    
    AddPanel('Cylinder computation');
    
    AddPosIntScalar('cylindersPerLevel', cylindersPerLevel, '', 'Number of cylinders per level');
    AddNonNegRatScalar('interCoef', interCoef, '', 'Multiplier of intermediate cylinders radii');
    AddTextArea('cylinderFormula', cylinderFormula, 'customVars', 'Formula for cylinder radius computation');
    
end