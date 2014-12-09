@echo off    
cd out

matlab -r "r = extractfeatures({'luc', 'joris', 'robbert', 'steven', 'jasper', 'vera'});exit" -nosplash -nodesktop -noFigureWindows

echo Wait for matlab to finish
pause


echo name, difficulty, acc, avg, std, increase, peak32, peak16, peak8, peak4 > gsrdataWithHeaders.csv
type gsrdata.csv >> gsrdataWithHeaders.csv


echo Done!
echo Press any key to quit
pause