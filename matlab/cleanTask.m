function [f] = cleanTask(dataPath)
    
    
    data = importdata(dataPath);
    
    %Plotting
    %figure
    %plot(data);

    %xlabel('Time (ms)')
    %ylabel('Conductance (microSiemens)')
    %title('Raw data from whole task')
    
    fs = 1000;
    fsResamp = 100;
    

    vResamp = resample(data, fsResamp, fs);
    tResamp = (0:numel(vResamp)-1) / fsResamp;
    vAvgResamp = sgolayfilt(vResamp,1,11);
    %plot(tResamp,vAvgResamp);
    
    dat = (sgolayfilt(vAvgResamp,3,11));
    
    %normdat = mat2gray(dat);
    normdat = dat;
    %plot(normdat);
    
    p = strsplit(dataPath, '\\');
    
    filename = p{length(p)};
    
    q = strsplit( filename, '.');
    name = q{1};
    filename = strcat(name,'c.txt');
    
    dlmwrite(filename, normdat);
    

    f = normdat;
    
    figure
    plot(f);

    xlabel('Time (ms)')
    ylabel('Conductance (microSiemens)')
    title('Filtered data from whole task')
    
end




