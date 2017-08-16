% The MATLAB code is for transformation from the real
% 3D geometry of astrocyte to the cylindrical geometry of astrocyte as for NEURON simulations.
%
%
% Leonid Savtchenko, UCL, 2017 (c) MIT licence

clc;
close all;
clear all;
addpath(genpath(pwd));

global storedSections geometryFileName figures mainDataPlot mainData

[geometryFilePath, geometryFileName] = SelectDataFile();

if (geometryFilePath ~= 0)
    mainData = load(geometryFilePath, '-ascii');
    storedSections = cell(0);
    
    InitUserParams();
    InitFigures();
    
    % Display initial data 
    mainDataPlot = PlotData(mainData, figures.mainDataWindow);  
    MakeSectionTable();
    StoreSection(mainData, geometryFileName, false);     
end