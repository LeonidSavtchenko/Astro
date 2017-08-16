@echo off

rem Copy results folder from HPC kernel directory to Matlab host directory

rem Initialize variables
call Core\scripts\win-win\params.bat

set RESDIR=results

rem Delete old results
if exist %RESDIR% rmdir /S /Q %RESDIR%

rem Go to HPC kernel directory
cd %HPCDIR%

rem Copy results folder from HPC kernel directory to Matlab host directory
xcopy %RESDIR% %MATLABHOSTDIR%\%RESDIR% /I /Q