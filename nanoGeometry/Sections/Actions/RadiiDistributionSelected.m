function RadiiDistributionSelected()
%% Compute radii distribution for seleceted sections.
%  Has special behavior for case of two radii per level.

    global cylindersPerLevel

    [~, sectionData] = GetSelectedSections();
    
    
    sectionsSize = size(sectionData, 1); 
    if sectionsSize > 0
        
        % Plot params
        plotDivisions = 10;

        cylinderRadii = cell(sectionsSize, 1);

        % Compute min and max radiuses
        for section = 1:sectionsSize   
            cylinderRadii{section} = CalculateCylinders(sectionData{section});

            if (section == 1)         
                minRadius = min(cylinderRadii{section});
                maxRadius = max(cylinderRadii{section});
            else                
                currentMax = max(cylinderRadii{section});
                currentMin = min(cylinderRadii{section});

                if (currentMax > maxRadius)
                    maxRadius = currentMax;
                end

                if (currentMin < minRadius)
                    minRadius = currentMin;            
                end
            end
        end    

        statisticsStep = (maxRadius - minRadius) / plotDivisions;

        % radiiDistribution col meaning:
        % 1 col - range, 
        % 2 col - overall distribution
        % 3+ cols - distribution per group
        if cylindersPerLevel > 1
            radiiDistribution = zeros(plotDivisions, cylindersPerLevel + 2);  
            minRadii = zeros(cylindersPerLevel + 1, 1);
            maxRadii = zeros(cylindersPerLevel + 1, 1);
        else
            radiiDistribution = zeros(plotDivisions, 2);
        end   

        % minRadii/maxRadii col meaning:
        % 1 col - overall min/max, 
        % 2+ cols - min/max per group
        minRadii(1, 1) = minRadius;
        maxRadii(1, 1) = maxRadius;         

        for section = 1:plotDivisions
            radiiDistribution(section, 1) = minRadius + statisticsStep * (section - 1);
        end    

        % Calculate overall distribution
        for section = 1:sectionsSize
            for cylinder = 1:size(cylinderRadii{section}, 1)
                plotDivision = floor((cylinderRadii{section}(cylinder, 1) - minRadius) / statisticsStep);

                if (plotDivision == 0) 
                    plotDivision = 1;
                end

                radiiDistribution(plotDivision, 2) = radiiDistribution(plotDivision, 2) + 1;

                % Calculate distribution, min and max values for each cylinder
                % group
                if cylindersPerLevel > 1
                    for group = 1:cylindersPerLevel
                        if mod(cylinder, cylindersPerLevel) == mod(group, cylindersPerLevel)   
                            radiiDistribution(plotDivision, group + 2) = radiiDistribution(plotDivision, group + 2) + 1;

                            if section == 1 && cylinder <= cylindersPerLevel
                                minRadii(group + 1, 1) = cylinderRadii{section}(cylinder, 1);
                                maxRadii(group + 1, 1) = cylinderRadii{section}(cylinder, 1);
                            else
                                if (cylinderRadii{section}(cylinder, 1) < minRadii(group + 1, 1))
                                    minRadii(group + 1, 1) = cylinderRadii{section}(cylinder, 1);
                                end               

                                if (cylinderRadii{section}(cylinder, 1) > maxRadii(group + 1, 1))
                                    maxRadii(group + 1, 1) = cylinderRadii{section}(cylinder, 1);
                                end            
                            end
                        end
                    end
                end             
            end
        end

        PlotRadiiDistribution(radiiDistribution, minRadii, maxRadii, statisticsStep);
    end
end

