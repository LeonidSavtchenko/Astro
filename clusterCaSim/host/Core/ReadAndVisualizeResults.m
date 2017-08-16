function ReadAndVisualizeResults()
%% Summarize results of scalability test or single run

    disp('Reading results ...');
    
    % Prepare array of watched variable names and process grid based on the results directory content analysis
    watchedVars = {};
    procs = [];
    content = dir('results');
    for i = 1 : length(content)
        fileName = content(i).name;
        if ~isempty(strfind(fileName, 'trajec_'))
            j = strfind(fileName, '_for_');
            watchedVar = fileName(8 : j - 1);
            k = strfind(fileName, '_procs');
            proc = str2double(fileName(j + 5 : k - 1));
            
            watchedVars = AddStringOnce(watchedVars, watchedVar);
            procs = AddDoubleOnce(procs, proc);
        end
    end
    
    % Open file with run times
    file1 = fullfile('results', 'runtimes.dat');
    fid1 = fopen(file1);
    assert(fid1 ~= -1, ['Failed to open ', file1]);
    fid1Guard = onCleanup(@() fclose(fid1));
    
    line = fgetl(fid1);
    assert(~isnumeric(line), ['Invalid format of ', file1, ' (1)']);
    line = fgetl(fid1);
    assert(~isnumeric(line), ['Invalid format of ', file1, ' (2)']);

    numWatchedVars = length(watchedVars);
    numProcs = length(procs);
    runtimes = zeros(1, numProcs);
    setuptimes = zeros(1, numProcs);

    leg = cell(numProcs * numWatchedVars, 1);

    curveIdx = 1;
    for procIdx = 1 : numProcs
        
        proc = procs(procIdx);
        
        % Read run time
        line = fgetl(fid1);
        assert(~isnumeric(line), ['Invalid format of ', file1, ' (3)']);
        idx = find(line == ' ');
        assert(length(idx) == 1, ['Invalid format of ', file1, ' (4)'])
        runtimes(procIdx) = str2double(line(idx + 1 : end));

        % Read setup time
        fileName = sprintf('setuptime_for_%i_procs.dat', proc);
        file2 = fullfile('results', fileName);
        fid2 = fopen(file2);
        assert(fid2 ~= -1, ['Failed to open ', file2]);
        fid2Guard = onCleanup(@() fclose(fid2));
        
        line = fgetl(fid2);
        assert(~isnumeric(line), ['Invalid format of ', file2, ' (1)']);
        setuptimes(procIdx) = str2double(line);
        line = fgetl(fid2);
        assert(isnumeric(line), ['Invalid format of ', file2, ' (2)']);
        
        clear fid2Guard    % This calls fclose(fid2)
        
        for watchedVarIdx = 1 : numWatchedVars
        
            watchedVar = watchedVars{watchedVarIdx};
            
            % Read trajectory
            fileName = sprintf('trajec_%s_for_%i_procs.dat', watchedVar, proc);
            file2 = fullfile('results', fileName);
            disp(['    ', file2]);
            fid2 = fopen(file2);
            assert(fid2 ~= -1, ['Failed to open ', file2]);
            fid2Guard = onCleanup(@() fclose(fid2));
            
            time = zeros(1, 0);
            value = zeros(1, 0);
            while true
                line = fgetl(fid2);
                if isnumeric(line)
                    % End of file
                    break
                end
                idx = find(line == ' ');
                assert(length(idx) == 1, ['Invalid format of ', file2, ' (1)'])

                time(end + 1) = str2double(line(1 : idx - 1)); %#ok<AGROW>
                value(end + 1) = str2double(line(idx + 1 : end)); %#ok<AGROW>
            end
            assert(~isempty(time), ['Invalid format of ', file2, ' (2)']);
            
            clear fid2Guard    % This calls fclose(fid2)
            
            color = CurveIndexToColor(curveIdx);
            plot(time, value, 'color', color);
            hold on
            
            if proc == 1
                ending = '';
            else
                ending = 'es';
            end
            leg{curveIdx} = sprintf('%s for %i process%s', watchedVar, proc, ending);
            
            curveIdx = curveIdx + 1;
        end
    end
    
    grid on
    xlabel('t, ms');

    legend(leg);

    line = fgetl(fid1);
    assert(isnumeric(line), ['Invalid format of ', file1, ' (5)']);

    clear fid1Guard    % This calls fclose(fid1)

    if numProcs ~= 1
        figure
        plot(procs, runtimes, 'b.-');
        hold on
        plot(procs, setuptimes, 'r.-');
        legend({'runtimes', 'setuptimes'});
        grid on
        xlabel('Number of processes');

        figure
        plot(procs, 1 ./ runtimes, 'b.-');
        hold on
        plot(procs, 1 ./ (runtimes - setuptimes), 'r.-');
        ylabel('Time^{-1}, sec^{-1}')
        legend({'1 / run time', '1 / (run time - setup time)'}, 'Location', 'NorthWest');
        grid on
        xlabel('Number of processes');
        title('Scalability');
    end
    
    disp('Done.');
    
end

function array = AddStringOnce(array, value)
    for i = 1 : length(array)
        if strcmp(array(i), value)
            return;
        end
    end
    array{end + 1} = value;
end

function array = AddDoubleOnce(array, value)
    for i = 1 : length(array)
        if array(i) == value
            return;
        end
    end
    array(end + 1) = value;
end

function color = CurveIndexToColor(curveIdx)
    v0 = 0;
    v1 = 1;
    v2 = 1 / sqrt(2);
    v3 = 1 / sqrt(3);
    palette = [...
       v1, v0, v0; ...
       v0, v0, v1; ...
       v0, v1, v0; ...
       v2, v2, v0; ...
       v2, v0, v2; ...
       v0, v2, v2; ...
       v3, v3, v3];
    palSize = size(palette, 1);
    colorIdx = 1 + rem(curveIdx - 1, palSize);
    damper = 1 + floor((curveIdx - 1) / palSize);
    color = palette(colorIdx, :) / damper;
end