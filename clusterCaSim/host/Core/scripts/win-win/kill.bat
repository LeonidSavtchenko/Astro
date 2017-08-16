@echo off

rem Terminate all NEURON processes forcibly

taskkill /f /im nrniv.exe > NUL
