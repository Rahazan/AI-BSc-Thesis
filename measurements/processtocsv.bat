@echo off    
matlab -r "r = extractfeatures({'luc', 'joris', 'robbert', 'steven', 'jasper', 'vera'});exit" -nosplash -nodesktop -noFigureWindows

echo Wait for matlab to finish
pause


echo name, difficulty, acc, avg > gsrdataWithHeaders.csv
type gsrdata.csv >> gsrdataWithHeaders.csv
