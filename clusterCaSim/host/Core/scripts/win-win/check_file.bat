@echo off

rem Run this BAT-script with one argument specifying:
rem 1) relative path to the file to search for.

rem Initialize variables
call Core\scripts\win-win\params.bat

rem Go to HPC kernel root directory
cd %HPCDIR%

rem Determine whether the file is present
dir %1 /B > NUL 2<&1