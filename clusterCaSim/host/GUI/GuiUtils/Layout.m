function Layout()
%% Initialize global constants for GUI layout (all in pixels)

    global layout
    
    layout.xMargin0 = 10;       % The distance "window border - panel border"
    layout.xMargin1 = 10;       % The distance "panel border - param name text"
    layout.xMargin2 = 5;        % The distance "param name text - value control"
    layout.xMargin3 = 10;       % The distance "value edit box - unit text"
    
    layout.yMargin0 = 10;       % The distance between two controls
    
    layout.rgWidth = 140;       % Radiogroup panel width
    layout.rbHeight = 23;       % Radiobutton height
    
    % Sizes of main controls for parameters
    layout.ebWidth = 200;       % Editbox width
    layout.ebHeight = 23;       % Editbox height
    layout.cbHeight = 23;       % Checkbox height
    layout.pmHeight = 20;       % Popup menu height
    layout.tcHdrWidth0to9 = 32;     % Table header column width (plus table rightmost border line width) in case of 0 to 9 rows
    layout.tcHdrWidth10to99 = 35;   % The same in case of 10 to 99 rows
    layout.trHdrHeight = 22;    % Table header row height (plus table bottom border line width)
    layout.tcMinWidth = 40;        % Min table data column width
    layout.tcMaxWidth = 80;        % Max table data column width
    layout.trHeight = 18;       % Table data row height
    layout.tHorSliderHeight = 17;   % Table horizontal slider height
    layout.tVertSliderWidth = 17;   % Table vertical slider width
    layout.tMaxWidth = 400;         % Max table width
    
    % Sizes of auxiliary controls for parameters
    layout.nameWidth = 135;     % Parameter name width
    layout.unitWidth = 95;      % Unit text width
    layout.tHeight = 22;        % Text label height
    
    layout.yStep = 30;          % Y-step for controls placement
    
    % Non-parameter controls sizes
    layout.pbWidth = 69;        % Pushbutton width ("Load", "Save", "OK")
    layout.pbHeight = 22;       % Pushbutton height ("Load", "Save", "OK")
    layout.pbAddRemMargin = 10; % The distance between "Add Row" and "Remove Row" buttons 
    layout.bsHeight = 2;        % Height of blank strips
    layout.sWidth = 17;         % Rightmost slider width
    
    % Name and Unit labels margins
    layout.ebNameUnitYMargin = 5;   % Simple editbox name and unit
    layout.mlebNameYMargin1 = 5;    % Multiline editbox name for panel 1
    layout.mlebNameYMargin2 = 1;    % Multiline editbox name for other panels
    layout.cbNameYMargin = 4;       % Checkbox name
    layout.pmNameYMargin = 8;       % Popup menu name
    layout.tNameYMargin = 5;        % Table name
    
    % Main controls margins
    layout.mlebYMargin1 = 4;    % Multiline editbox from above
    layout.mlebYMargin2 = 19;   % Multiline editbox from below
    layout.tYMargin = 23;       % Table from below

end