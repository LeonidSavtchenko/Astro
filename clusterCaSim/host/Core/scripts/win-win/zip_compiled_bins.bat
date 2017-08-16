@echo off

rem Run this BAT-script with one argument specifying:
rem 1) a path to the temporary directory containing compiled host binaries.

rem Initialize variables
call Core\scripts\win-win\params.bat

rem Put selected content of the temporary directory into archive
"%THIRDPARTYDIR%\7za.exe" a %1\..\package.zip -r %1\*.exe %1\Core %1\readme.txt -x!%~n0%~x0 > NUL

rem Delete the temporary directory with all its content
rmdir %1 /s /q