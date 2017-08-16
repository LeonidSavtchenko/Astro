@echo off

rem This BAT-script determines whether a process with name "nrniv" is running on remote cluster
rem This script takes names of nodes as arguments

rem Initialize variables
call Core\scripts\win-lin\params.bat

rem Go to 3rd party software directory containing plink.exe
cd %THIRDPARTYDIR%

rem Check if process "nrniv" is running
plink -pw %PASSWORD% %LOGIN%@%HEADNODEIP% sh %REMOTESCRIPTSDIR%/check_running.sh %*