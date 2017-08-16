@echo off

rem Run this BAT-script with one argument specifying relative path to the file to search for

rem Initialize variables
call Core\scripts\win-lin\params.bat

rem Go to 3rd party software directory containing plink.exe
cd %THIRDPARTYDIR%

rem Execute two commands on remote server:
rem 1) go to HPC kernel input/output directory,
rem 2) check if a file with specified relative path exists
plink -pw %PASSWORD% %LOGIN%@%HEADNODEIP% "cd \"%HEADNODEWORKERDIR%\"; if [ -f %1 ]; then exit 0; else exit 1; fi"