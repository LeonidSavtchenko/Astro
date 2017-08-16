function SetVisibility(h, vis)
%% Set visibility property for the given handle or vector of handles

    if vis
        vis = 'on';
    else
        vis = 'off';
    end
    set(h, 'Visible', vis);
    
end
