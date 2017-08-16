function AdjustSliderAndStrips(slideToTop)

    AdjustSlider(slideToTop);
    AdjustStrips();

end


function AdjustSlider(slideToTop)

    global hf hs layout yPos0 yPos
    
    pos = get(hf, 'Position');
    winWidth = pos(3);
    winHeight = pos(4);
    
    availSpace = winHeight - 3 * layout.yMargin0 - layout.yStep - layout.pbHeight;
    reqSpace = yPos0 - yPos;
    vis = availSpace < reqSpace;
    if vis
        diff = reqSpace - availSpace;
        ratio = availSpace / reqSpace;
        x = winWidth - layout.xMargin0 - layout.sWidth;
        y = 2 * layout.yMargin0 + layout.pbHeight;
        w = layout.sWidth;
        h = winHeight - 3 * layout.yMargin0 - layout.pbHeight;
        max = diff;
        if slideToTop
            value = diff;
        else
            oldMax = get(hs, 'Max');
            oldValue = get(hs, 'Value');
            value = max - (oldMax - oldValue);
            if value < 0
                value = 0;
            end
        end
        set(hs, 'Position', [x, y, w, h], ...
                'SliderStep', [0.1, ratio], ...
                'Max', max, ...
                'Value', value);
    else
        % Display full content
        max = get(hs, 'Max');
        set(hs, 'Value', max);
    end
    SetVisibility(hs, vis);
   
    slider_ContinuousValueChange();

end
