function slider_ContinuousValueChange(~, ~)

    global hs
    global yPos00 yPos0
    global panIdx
    
    persistent panIdxOld
    
    yPos0New = yPos00 + get(hs, 'Max') - round(get(hs, 'Value'));
    
    if ~isempty(panIdxOld) && panIdx == panIdxOld && yPos0New == yPos0
        % Avoid flickering, save performance
        return
    end
    
    yPos0 = yPos0New;
    
    % Gray strips
    AdjustStrips();
    
    % All other controls
    UpdateViewControls();
    
    panIdxOld = panIdx;
    
end
