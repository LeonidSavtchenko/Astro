@echo off

rem This BAT-script determines if at least one process with name "nrniv.exe" is running on this machine

tasklist /fi "imagename eq nrniv.exe" | find ":" > NUL