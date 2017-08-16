function ShowSettings()
%% Show settings panel.

    global hf
    
    if ishandle(hf)
        close(hf);        
    end
    PrepareAndShowGUI();

end

