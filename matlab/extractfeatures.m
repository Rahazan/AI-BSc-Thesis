function values = extractfeatures(subjects)

	result = cell(length(subjects), 1); %8 tasks

    for i = (1:length(subjects))
	
		subject = subjects(i)
		subjresult = cell(8, 4); % 8 tasks
        
        
		files = cell (8,1);
		num = 1;
		for diff = 1:4
			files{num} = strcat(subject, num2str(diff));
			num = num + 1;
			
			files{num}  = strcat(files{num-1}, 'b');
			num = num + 1;
        end
        
		normalized = normalizedGSR(files);
        
        %Smoothen out DC current (almost) fully
        for j = 1:8
            normalized{j} = sgolayfilt(normalized{j}, 5, 251);
        end
        
		plot(normalized{6})
        
		
		for diff = 1:4
            % NOT DRY!
            % TODO fix
            
            
			index = 2*diff-1;
			subjresult{index, 1} = char(subject); %Subject name
			subjresult{index, 2} = diff; %Difficulty
			acc = sum(normalized{index});
            avg = acc / length(normalized{index});
            
            subjresult{index, 3} = acc; %Difficulty
            subjresult{index, 4} = avg; %Difficulty
            
            
            
            %Repetition
            
			index = 2*diff;
			subjresult{index, 1} = char(subject);
			subjresult{index, 2} = diff; %Difficulty
            acc = sum(normalized{index, :});
            avg = acc / length(normalized{index, :});
            
            subjresult{index, 3} = acc; %Difficulty
            subjresult{index, 4} = avg; %Difficulty
			
		end
		
		result{i} = subjresult;
    end
    
    %Append all subjects into one big list of 1x4 cells
    for i = 1:length(result) % 6 
        for j = 1: length(result{i}) % 8
            sres = result{i}(j,:);
            values{(i-1) * length(result{i}) + j, 1} = sres;
        end
    end
    values = cat(1, values{:})
    
    %headers = {'name', 'taskDiff', 'gsrACC', 'gsrAVG'};
    cell2csv('gsrdata.csv', values)
    
end


function norm = normalizedGSR(files) 
    norm = cell(length(files), 1);
    
    s = 0;
    for i = (1:length(files))
       data = importdata(char(files{i}));
       s = s + sum(data);
       
    end
     for i = (1:length(files))
       data = importdata(char(files{i}));
       mean = s/length(data);
       norm{i} =  data/mean;
       
    end
       
    
    
end
%
%function avg = avgGSR(data) 
%    norm = cell(length(files));
%    for i = (i:length(files))
%       d = data(i);
%       s = sum(data);
%       mean = s/length(data)
%       norm{i} =  data/mean;
%    end
%    
%end



function x = extractTFeatures(data) 

    x = '';
end



