@echo off

rem Run this BAT-script with one argument:
rem the flag (0/1) indicating whether to compress "results" folder before and decompress after downloading.

rem Initialize variables
call Core\scripts\win-lin\params.bat

rem Delete old results
if exist results rd /s /q results

rem Go to 3rd party software directory containing pscp.exe, plink.exe and 7za.exe
cd %THIRDPARTYDIR%

if %1 == 1 (
    rem Compress directory "results"
    plink -pw %PASSWORD% %LOGIN%@%HEADNODEIP% cd \"%HEADNODEWORKERDIR%\"; rm results.zip -f; zip -r results.zip results > NUL;
    
    rem Download file "results.zip"
    pscp -pw %PASSWORD% %LOGIN%@%HEADNODEIP%:"%HEADNODEWORKERDIR%/results.zip" "%MATLABHOSTDIR%" > NUL
    
    rem Unzip just downloaded file
    echo Unzipping downloaded directory ...
    7za.exe x "%MATLABHOSTDIR%\results.zip" -o"%MATLABHOSTDIR%" > NUL
    
    rem Delete the archive on remote machine
    plink -pw %PASSWORD% %LOGIN%@%HEADNODEIP% cd \"%HEADNODEWORKERDIR%\"; rm results.zip -f;

    rem Delete the archive on local machine
    del "%MATLABHOSTDIR%\results.zip"
) else (
    rem Download directory "results"
    pscp -r -pw %PASSWORD% %LOGIN%@%HEADNODEIP%:"%HEADNODEWORKERDIR%/results" "%MATLABHOSTDIR%\results" > NUL
)