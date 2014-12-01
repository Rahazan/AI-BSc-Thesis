function [f] = cleanTask(data)
    
    


    fs = 1000;
    fsResamp = 100;
    

    vResamp = resample(data, fsResamp, fs);
    tResamp = (0:numel(vResamp)-1) / fsResamp;
    vAvgResamp = sgolayfilt(vResamp,1,11);
    plot(tResamp,vAvgResamp);
    
    dat = (sgolayfilt(vAvgResamp,3,11));
    
    normdat = mat2gray(dat);
    plot(normdat);
    
    
    f = data;
end




