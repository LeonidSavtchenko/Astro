function h = CreateParamUnitText(unit, xPos)

    global layout palette
    
    assert(~isempty(unit));
    
    xPos = xPos + layout.xMargin3;
    
    if ~strcmp(unit, 'tg')
        unit_ = ['[', unit, ']'];
    else
        unit_ = '';
    end
    
    h = uicontrol('Style', 'text', ...
                  'Units', 'pixels', ...
                  'HorizontalAlignment', 'left', ...
                  'Position', [xPos, 0, layout.unitWidth, layout.tHeight], ...
                  'BackgroundColor', palette.backgroundColor, ...
                  'String', unit_);
end