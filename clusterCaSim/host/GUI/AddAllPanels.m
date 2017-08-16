function AddAllPanels()
%% Add all panels to GUI,
%  select a default panel

    global panIdx
    
    % Add all panels
    AddCustomParams();
    AddTimingParams();
    AddCaParams();
    AddGeometryParams();
    AddMeasuredParams();
    AddHpcParams();
    
    % Select a default panel
    panIdx = 2;
    
end