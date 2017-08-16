function figureHandle = MakeDataFigure(title, position, ...
    addComputeButton, addStoreButton, addSaveButton, hideOnClose, ...
    activateBrush, brushPostCallback, brushPreCallback)
%% Make figure to display data with optional controls.
%  Figure is hidden by default.
         
    if (nargin < 6)
        hideOnClose = false;
    end

    figureHandle = MakeFigure(title, position, hideOnClose); 
    
    position = [20, 20];
    dimensions = [100, 20];
    spaceBetween = 10;
    
    if (addComputeButton)
        uicontrol('Style', 'pushbutton', ...
            'String', 'Simulate diffusion', ...
            'Position', [position, dimensions], ...
            'Callback', @button_Compute_Callback);   
        
        position(1) = position(1) + dimensions(1) + spaceBetween;
    end
    
    dimensions(1) = 60;
    
    if (addStoreButton)
        uicontrol('Style', 'pushbutton', ...
            'String', 'Store', ...
            'Position', [position, dimensions], ...
            'Callback', @button_StoreSection_Callback);  
        
        position(1) = position(1) + dimensions(1) + spaceBetween;
    end    
    
    dimensions(1) = 70;
    
    if (addSaveButton)
        uicontrol('Style', 'pushbutton', ...
            'String', 'Save to file', ...
            'Position', [position, dimensions], ...
            'Callback', @button_SaveDataToFile_Callback);    
    end
    
    brushHandle = brush;    
    if (nargin >= 7 && activateBrush)
        set(brushHandle, 'Enable', 'on');        
    end
        
    if (nargin >= 8) 
        set(brushHandle, 'ActionPostCallback', brushPostCallback);
    end

    if (nargin >= 9) 
        set(brushHandle, 'ActionPreCallback', brushPreCallback);
    end
    
end

