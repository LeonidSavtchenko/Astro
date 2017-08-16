@echo off

rem Measure performance of the astrocyte simulation for the specified number of processes (multiple runs).
rem Run this BAT-script with three arguments specifying:
rem 1) the minimum number of processes;
rem 2) the maximum number of processes;
rem 3) the step of process grid.

rem Initialize variables
call Core\scripts\win-win\params.bat

set I686CYGWIN=i686cygwin
set NRNMECH_DLL=nrnmech.dll
set MCOMPLEX_DAT=mcomplex.dat
set NRNIV_EXE=nrniv.exe
set INIT_HOC=init.hoc
set RESULTS=results
set RUNTIMES_DAT=runtimes.dat

rem Go to HPC kernel root folder
pushd %HPCDIR%

rem Delete the old build and run artifacts
if exist %I686CYGWIN% rmdir /S /Q %I686CYGWIN%
if exist %NRNMECH_DLL% del %NRNMECH_DLL%
if exist %MCOMPLEX_DAT% del %MCOMPLEX_DAT%
if exist %RESULTS% rmdir /S /Q %RESULTS%

rem Create an empty directory for results
mkdir %RESULTS%

rem Back to host root folder
popd

rem Start timer for setup time
set STARTTIME=%TIME%

rem Translate MOD-s to C-s, compile C-s to O-s, link O-s to "nrnmech.dll"
echo.
echo Translating to C and compiling MOD files ...
echo.
call %NRNDIR%\mingw\bin\sh.exe "%MATLABHOSTDIR:\=/%/Core/scripts/win-win/build.sh"

if ERRORLEVEL 1 (
    exit
)

rem Go to HPC kernel root folder
cd /D %HPCDIR%

rem Generate helper DAT file
echo.
echo Generating "%MCOMPLEX_DAT%" file ...
echo.
call %NRNDIR%\bin\%NRNIV_EXE% -dll "%HPCDIR%\%NRNMECH_DLL%" -nogui -c "split=2" %INIT_HOC%

if ERRORLEVEL 1 (
    exit
)

rem Stop the timer and compute setup time in seconds
call :compute_delta
set SETUPTIME=%DELTA%

set LINE1=setuptime: %SETUPTIME%
set LINE2=np runtime
echo %LINE1%>%RESULTS%\%RUNTIMES_DAT%
echo %LINE2%>>%RESULTS%\%RUNTIMES_DAT%

rem Enable assignment to variables inside FOR loop body
setlocal enabledelayedexpansion

for /L %%G in (%1,%3,%2) do (

    rem Start timer for run time
    set STARTTIME=!TIME!

    rem Split geometry by processes and launch simulation
    echo.
    echo Splitting geometry and launching simulation ...
    echo.
    call %NRNDIR%\bin\mpiexec.exe -np %%G %NRNIV_EXE% -mpi -nogui -c "numProcs=%%G" %INIT_HOC%

    if ERRORLEVEL 1 (
        exit
    )

    rem Stop the timer and compute run time in seconds
    call :compute_delta
    set RUNTIME=!DELTA!

    move /Y trajec_*.dat %RESULTS%

    set LINE=%%G !RUNTIME!
    echo !LINE!>>%RESULTS%\%RUNTIMES_DAT%

)

cd user_geometry
del * /Q
cd ..

rem Create the empty file indicating that simulation completed successfully
copy NUL %RESULTS%\complete

exit /B 0


:compute_delta
rem Stop the timer and compute the time interval between STARTTIME and ENDTIME in seconds and assign it to DELTA
rem https://stackoverflow.com/questions/673523/how-to-measure-execution-time-of-command-in-windows-command-line

set ENDTIME=%TIME%

set options="tokens=1-4 delims=:.,"

for /f %options% %%a in ("%STARTTIME%") do set start_h=%%a&set /a start_m=100%%b %% 100&set /a start_s=100%%c %% 100&set /a start_ms=100%%d %% 100
for /f %options% %%a in ("%ENDTIME%") do set end_h=%%a&set /a end_m=100%%b %% 100&set /a end_s=100%%c %% 100&set /a end_ms=100%%d %% 100

set /a hours=%end_h%-%start_h%
set /a mins=%end_m%-%start_m%
set /a secs=%end_s%-%start_s%
set /a ms=%end_ms%-%start_ms%
if %ms% lss 0 set /a secs = %secs% - 1 & set /a ms = 100%ms%
if %secs% lss 0 set /a mins = %mins% - 1 & set /a secs = 60%secs%
if %mins% lss 0 set /a hours = %hours% - 1 & set /a mins = 60%mins%
if %hours% lss 0 set /a hours = 24%hours%

set /a DELTA = %hours%*3600 + %mins%*60 + %secs%

exit /B 0
