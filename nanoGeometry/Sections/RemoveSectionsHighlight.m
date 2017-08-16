function RemoveSectionsHighlight()
%% Delete colored section plots.

    global coloredSections
    
    coloredSectionsSize = size(coloredSections, 1);
    
    if (coloredSectionsSize > 0)    
        hold on;
        for i = 1:size(coloredSections, 1)
            delete(getAtIfCell(coloredSections, i));
        end
        hold off;
    end
        
    coloredSections = cell(0);
    
end

function value = getAtIfCell(data, index)
%% Returns element at index if data is cell or just data otherwise.

    if iscell(data)
        value = data{index};
    else
        value = data;
    end
    
end