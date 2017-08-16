@echo off

rem Export path
call neuron_home_win.bat

if exist %NEURON_HOME_WIN%\bin\neuron.exe (
    rem Build nrnmech.dll
    call %NEURON_HOME_WIN%\mingw\bin\sh.exe "scripts/compile_mechanisms.sh"

    rem Run program
    cd neuronSims
    %NEURON_HOME_WIN%\bin\neuron.exe init.hoc
) else (
    echo ERROR
    echo ----------------------------------------------------------------
	echo NEURON wasn't found in the specified place.
    echo Please specify the correct neuron installation folder by setting 
    echo NEURON_HOME_WIN and NEURON_HOME_LIN variables in correspoding 
    echo files in the root folder. They should point to the same folder.
    echo ----------------------------------------------------------------
    echo Path example: WIN - "C:\Programs\nrn", LIN - "/C/Programs/nrn"
    echo ----------------------------------------------------------------
    echo Alternatively you can manually compile mechanisms in "neuron"
    echo folder using mknrndll and open "neuron/init.hoc" in NEURON.
)