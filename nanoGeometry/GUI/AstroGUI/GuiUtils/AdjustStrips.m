function AdjustStrips()
% Adjust gray strips at top and bottom of the window

    global ht hs
    
    vis = GetVisibility(hs);
    if vis
        val = get(hs, 'Value');
        max = get(hs, 'Max');
        vis = val < max;
        SetVisibility(ht(2), vis);
                
        vis = val > 0;
        SetVisibility(ht(3), vis);
    else
        for i = 2 : 3
            SetVisibility(ht(i), false);
        end
    end

end
