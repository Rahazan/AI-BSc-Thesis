@echo off

matlab -r cleanTask('jasperdat.txt');exit -nosplash -nodesktop -noFigureWindows
matlab -r cleanTask('lucdat.txt');exit -nosplash -nodesktop -noFigureWindows
matlab -r cleanTask('robbertdat.txt');exit -nosplash -nodesktop -noFigureWindows
matlab -r cleanTask('stevendat.txt');exit -nosplash -nodesktop -noFigureWindows
matlab -r cleanTask('jorisdat.txt');exit -nosplash -nodesktop -noFigureWindows
matlab -r cleanTask('veradat.txt');exit -nosplash -nodesktop -noFigureWindows

echo ===Wait for matlab to finish===
pause


neko ../ResultCutter/bin/ResultCutter.n 14:14:38 100 D:\Dropbox\bsc\Task\jasper.txt jasperdatc.txt
neko ../ResultCutter/bin/ResultCutter.n 20:57:36 100 D:\Dropbox\bsc\Task\luc.txt lucdatc.txt
neko ../ResultCutter/bin/ResultCutter.n 18:52:22 100 D:\Dropbox\bsc\Task\robbert.txt robbertdatc.txt
neko ../ResultCutter/bin/ResultCutter.n 01:18:04 100 D:\Dropbox\bsc\Task\steven.txt stevendatc.txt
neko ../ResultCutter/bin/ResultCutter.n 19:14:42 100 D:\Dropbox\bsc\Task\joris.txt jorisdatc.txt
neko ../ResultCutter/bin/ResultCutter.n 18:55:52 100 D:\Dropbox\bsc\Task\vera.txt veradatc.txt

pause
cd out

../processtocsv.bat

