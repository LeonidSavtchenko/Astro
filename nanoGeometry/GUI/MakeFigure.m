function figureHandle = MakeFigure(title, position, hideOnClose)
%% Make figure with ability to hide it on close.
%  Figure is hidden by default.
    
    figureHandle = figure('Name', title, 'NumberTitle', 'off', 'Position', position, 'Visible', 'off');

    if (nargin >= 3 && hideOnClose)
        set(figureHandle, 'CloseRequestFcn', 'set(gcf, ''Visible'', ''off'')'); 
    end
        
    set(figureHandle, 'MenuBar', 'figure', 'ToolBar', 'figure');
    
end

