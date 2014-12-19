function values = extractfeatures(subjects)

	result = cell(length(subjects), 1); %8 tasks

    for i = (1:length(subjects))
	
		subject = subjects(i)
		subjresult = cell(8, 10); % 8 tasks, x datapoints
        
        
		files = cell (8,1);
		num = 1;
		for diff = 1:4
			files{num} = strcat(subject, num2str(diff));
			num = num + 1;
			
			files{num}  = strcat(files{num-1}, 'b');
			num = num + 1;
        end
        
		%normalized = normalizedGSR(files);
        normalized = normalizedGSRByAvg(files);
        
        
        %Smoothen out DC current (almost) fully
        for j = 1:8
            normalized{j} = sgolayfilt(normalized{j}, 5, 251);
        end
        
        %N = length(normalized{2});
        %Fs = 100;
        %f = 0 : Fs / N : Fs - 1 / N;
        
		%plot(normalized{2})
        
        figure;
        plot(normalized{3}, 'LineWidth', 2);

        xlabel('Time (s/100)')
        ylabel('Conductance (microSiemens)')
        title('Filtered task data for subject task 3')
        
        
        
        sel = (max(normalized{2})-min(normalized{2}))/100;
        %peakfinder(normalized{2}, sel);
        a = peakfinder(normalized{2}, sel);
        length(a);
        
        
        %plot (f(1:10), fft(normalized{2}));
        %plot(angle(fft(normalized{2})));
        %plot(pwelch(normalized{6}));
		
		for diff = 1:4
            
			index = 2*diff-1;
            subjresult = addFeatures(subject, subjresult, index, diff, normalized);
            
			index = 2*diff;
            subjresult = addFeatures(subject, subjresult, index, diff, normalized);
			
		end
		
		result{i} = subjresult;
    end
    result
    %Append all subjects into one big list of 1x4 cells
    for i = 1:length(result) % 10 
        %i
        %for j = 1: length(result{i}) % 8
            j=1000
            length(result{i})
            sres = result{i}(:,:);
            values{(i-1) * length(result{i}) + j, 1} = sres;
        %end
    end
    values = cat(1, values{:})
    
    %headers = {'name', 'taskDiff', 'gsrACC', 'gsrAVG'};
    cell2csv('gsrdata.csv', values)
    
end


function subjresult = addFeatures(subject, subjresult, index, diff, normalized) 
            subjresult{index, 1} = char(subject); %Subject name
			subjresult{index, 2} = strcat('diff', num2str(diff)); %Difficulty
			acc = sum(normalized{index});
            avg = acc / length(normalized{index});
            stdev = std(normalized{index});
            
            le = length(normalized{index});
            diff = normalized{index}(le) - normalized{index}(1); 

            sel = max(normalized{index})-min(normalized{index});
            
            a = peakfinder(normalized{index}, sel/32);
            peakcount32 = length(a);
            a = peakfinder(normalized{index}, sel/16);
            peakcount16 = length(a);
            a = peakfinder(normalized{index}, sel/8);
            peakcount8 = length(a);
            a = peakfinder(normalized{index}, sel/4);
            peakcount4 = length(a);
            
            
            
            subjresult{index, 3} = acc; %Accumulative
            subjresult{index, 4} = avg; %Average
            subjresult{index, 5} = stdev; %Standard Deviation
            subjresult{index, 6} = diff; %Difference between start and end
            subjresult{index, 7} = peakcount32;
            subjresult{index, 8} = peakcount16;
            subjresult{index, 9} = peakcount8;
            subjresult{index, 10} = peakcount4;
            
            
            
end


function norm = normalizedGSR(files) %Normalized from 0 to 1
    norm = cell(length(files), 1);
    
    minV = 0;
    maxV = 0;
    
    
    for i = (1:length(files))
       data = importdata(char(files{i}));
       
       maxi = max(data(:));
       mini = min(data(:));
       
       if (i == 1 || maxi > maxV)
           maxV = maxi;
       end
       if (i == 1 || mini < minV)
           minV = mini;
       end
       
       norm{i} = data;
       
    end
       

     for i = (1:length(files))
       %norm{i} = ((norm{i}-minV) ./ (maxV-minV)-0.5)*2; %Normalize between
       % -1 and 1
       
       norm{i} = ((norm{i}-minV) ./ (maxV-minV));
     end
       
    
    
end


function norm = normalizedGSRByAvg(files) %Normalized by dividing by subject average
    norm = cell(length(files), 1);
    s = 0;
        for i = (1:length(files))
        data = importdata(char(files{i}));
        s = s + sum(data);
    end
    for i = (1:length(files))
        data = importdata(char(files{i}));
        mean = s/length(data);
        norm{i} = data/mean;
    end
end


