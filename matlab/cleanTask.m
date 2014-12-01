function [f] = cleanTask(dataPath)
    
    
    data = importdata(dataPath);
    
    

    fs = 1000;
    fsResamp = 100;
    

    vResamp = resample(data, fsResamp, fs);
    tResamp = (0:numel(vResamp)-1) / fsResamp;
    vAvgResamp = sgolayfilt(vResamp,1,11);
    plot(tResamp,vAvgResamp);
    
    dat = (sgolayfilt(vAvgResamp,3,11));
    
    normdat = mat2gray(dat);
    plot(normdat);
    
    p = strsplit(dataPath, '\\');
    
    filename = p{length(p)};
    
    q = strsplit( filename, '.');
    name = q{1};
    filename = strcat(name,'c.txt');
    
    dlmwrite(filename, normdat);
    
    %fileID = fopen(filename);
    %fwrite(fileID, normdat);
    %dlmcell(filename, normdat);
    
    f = normdat;
end




