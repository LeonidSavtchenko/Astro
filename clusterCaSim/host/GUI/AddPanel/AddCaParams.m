function AddCaParams()

    % TODO Split params by different panels
    AddPanel('Ca');
    
    AddNonNegRatScalar('Z_coordinate'           , 10       , ''      , 'The stochastic parameter changes the Z-distribution of astrocytes branches');
    AddNonNegRatScalar('ScalingDiam'            , 0.127    , ''      , 'The parameter scales the diameter of the central dendrites')
    AddNonNegRatScalar('dt'                     , 1        , ''      , 'Time of integration');
    AddNonNegRatScalar('steps_per_ms'           , 1        , ''      , 'Time of plotting data');
    AddNonNegRatScalar('Initseed'               , 124      , ''      , 'Initial seed number');

    %Leaves Geometry. These are  structures large in diameter and short
    %Uniform distribution between min and max

    AddNonNegRatScalar('MaxDimLeaves'           , 2.5      , 'um'    , 'Max diam of Leaves');
    AddNonNegRatScalar('MinDimLeaves'           , 0.1      , 'um'    , 'Min diam of Leaves');
    AddNonNegRatScalar('MaxLenLeaves'           , 0.12     , 'um'    , 'Max Length of Leaves');
    AddNonNegRatScalar('MinLenLeaves'           , 0.1      , 'um'    , 'Min Length of Leaves');

    %Stalks Geometry. These are transitional structures between the leaves.
    %They are small in diameter and long.
    %Uniform distribution between min and max
    AddNonNegRatScalar('MaxDimStalk'            , 0.1      , 'um'    , 'Max diam of stalk');
    AddNonNegRatScalar('MinDimStalk'            , 0.1      , 'um'    , 'Min diam of stalk');
    AddNonNegRatScalar('MaxLenStalk'            , 1        , 'um'    , 'Max Length of stalk');
    AddNonNegRatScalar('MinLenStalk'            , 0.9      , 'um'    , 'Min Length of stalk');

    AddNonNegRatScalar('TotalNUmberGapJunction' , 100      , ''      , ''); 
    AddNonNegRatScalar('BasicStimulus'          , 100      , ''      , 'Total number of noisy Ca channels');
    AddNonNegRatScalar('Interval'               , 3        , 'ms'    , 'The interval between stimulus in ms for a noisy calcium dynamics');
    AddNonNegRatScalar('ECaresting'             , 0.001    , 'muM'   , 'Reverse Calcium concentration');
    AddNonNegRatScalar('Tau1St'                 , 10       , 'ms'    , 'The Rise time of Ca ');
    AddNonNegRatScalar('Tau2St'                 , 0.1      , 'ms'    , 'The time delay Calcium signal in ms ');
    AddNonNegRatScalar('NumberStim'             , 600      , ''      , 'Number of stimulus of noisy Ca');
    AddNonNegRatScalar('Noise1_NoNoise0'        , 1        , ''      , '1  is noisy, 0 is constant Ca signal');
    AddNonNegRatScalar('NoiseCaBegin'           , 7000     , 'ms'    , 'Begins of Ca signal ');
    AddNonNegRatScalar('BasicCaFlux'            , 20       , ''      , 'Basic Ca flux of noise and large responses');
    AddNonNegRatScalar('NoiseBasicInterval'     , 200      , ''      , 'Interval between Ca noisy signals');

    AddNonNegRatScalar('DCa_cadifus'            , 0.15     , ''      , 'The diffusion coefficient of intracellular calcium dynamics');
    AddNonNegRatScalar('TBufs_cadifus'          , 0.07     , ''      , 'The total concentration of endogeneous Ca buffer');
    AddNonNegRatScalar('kfs_cadifus'            , 'kf'     , '/mM-ms', 'The Kf of endogeneous buffer');
    AddNonNegRatScalar('KDs_cadifus'            , 10       , 'uM'    , 'The KD of endogeneous buffer');
    AddNonNegRatScalar('TBufm_cadifus'          , 0.0075   , ''      , 'The total concentration of mobile/added Ca buffer');
    AddNonNegRatScalar('kfm_cadifus'            , 'kf'     , '/mM-ms', 'The Kf of mobile/added buffer');
    AddNonNegRatScalar('KDm_cadifus'            , 0.24     , 'uM'    , 'The KD of mobile/added buffer');
    AddNonNegRatScalar('DBufm_cadifus'          , 0.05     , ''      , 'The diffusion coefficient of mobile buffer');
    AddNonNegRatScalar('cath_cadifus'           , 5e-005   , ''      , 'Threshold for Ca pump activity');
    AddNonNegRatScalar('vmax_cadifus'           , 3.75e-006, ''      , 'Maximum flux of pump');
    AddNonNegRatScalar('ip3i_cadifus'           , 0.00001  , ''      , 'Basic concentration of ip3i');
    AddNonNegRatScalar('gamma_cadifus'          , 20       , ''      , 'A pump flux density');
    AddNonNegRatScalar('Kp_cadifus'             , 0.00027  , ''      , 'Parameter of Ca sensivity of pump');
    AddNonNegRatScalar('jmax_cadifus'           , 0.0035   , ''      , 'Parameter of Ca flux of SERCA channel');
    AddNonNegRatScalar('caer_cadifus'           , 0.4      , ''      , 'Ca reverse concentration of ER');
    AddNonNegRatScalar('Kip3_cadifus'           , 0.0008   , ''      , 'Parameter of IP3 flux');
    AddNonNegRatScalar('Kact_cadifus'           , 0.0003   , ''      , 'Parameter of flux SERCA channel');
    AddNonNegRatScalar('kon_cadifus'            , 2.7      , ''      , 'Open kinetic parameter of  SERCA channel');
    AddNonNegRatScalar('Kinh_cadifus'           , 0.0002   , ''      , 'Close kinetic parameter of  SERCA channel');
    vrat_cadifus = { ...
%       Index      Value
        0      0.239983};
    % NOTE Table precision isn't enough to display 0.239983 value! It's rounded to 0.24000.
    defaultValues = { ...
        -1,     nan};
    colNames = {'Index', 'Value'};
    desc = {'Dimensionless numeric value of vrat[i] equals the volume of annulus i of a 1um diameter cylinder multiply by diam^2 to get volume per um length'};
    AddResizableMatrix('vrat_cadifus', vrat_cadifus, defaultValues, colNames, desc, true, 'valPred_vrat_cadifus(vrat_cadifus)');
    
    AddNonNegRatScalar('DurationIP3iCalciumWave', 1000     , ''      , 'Duration of Ca waves');
    AddNonNegRatScalar('TimeDelayW'             , 1000     , ''      , 'Dealy Ca waves');
    AddNonNegRatScalar('InitIp3'                , 0.05     , ''      , 'Initial concentration ip31 on the soma');
 
end