@echo off

rem Initialize variables
call Core\scripts\win-lin\params.bat

rem Go to 3rd party software directory containing plink.exe
cd %THIRDPARTYDIR%

rem Kill "nrniv" process
plink -pw %PASSWORD% %LOGIN%@%HEADNODEIP% sh %REMOTESCRIPTSDIR%/kill.sh %* > NUL