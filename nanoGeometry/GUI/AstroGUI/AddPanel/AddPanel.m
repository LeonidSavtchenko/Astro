function AddPanel(name)

    global numPanels panIdx panelName params
    
    numPanels = numPanels + 1;
    panIdx = numPanels;
    panelName{panIdx} = name;
    params{panIdx} = {};
    
end