function remainingPoints = GetRemainingPoints(axes, allData)
%% Returns points which are currently present on the figure.

    plotChildren = get(axes, 'Children'); 
    XData = getLastIfCell(get(plotChildren, 'XData'));
    YData = getLastIfCell(get(plotChildren, 'YData'));
    ZData = getLastIfCell(get(plotChildren, 'ZData'));
               
    % In different version of Matlab deleted NaN points 
    % are in different data.
    hasDeletedPoints = true;
    if numel(find(isnan(XData))) > 0        
        remainingIndices = find(~isnan(XData));
    elseif numel(find(isnan(YData))) > 0 
        remainingIndices = find(~isnan(YData));
    elseif numel(find(isnan(ZData))) > 0 
        remainingIndices = find(~isnan(ZData));
    else
        hasDeletedPoints = false;
    end
        
    if ~hasDeletedPoints
        remainingPoints = allData;
    else
        if (size(remainingIndices, 2) > 0)
            selectedData = [
                XData(remainingIndices)', ...
                YData(remainingIndices)', ...
                ZData(remainingIndices)'];

            remainingPoints = selectedData;        
        else
            remainingPoints = [];
        end   
    end
    
end

function last = getLastIfCell(data)
%% Returns last element if data is cell or just data otherwise.

    if iscell(data)
        last = data{end};
    else
        last = data;
    end
    
end

