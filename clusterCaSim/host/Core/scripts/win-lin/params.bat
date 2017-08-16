@echo off

rem The next parameters must be adjusted before the first launch
set HEADNODEIP=144.82.46.83
set LOGIN=savtchenko
set PASSWORD=h1pp0c
set HEADNODEWORKERDIR=/home/savtchenko/amcbridge/phase14/nano/clusterCaSim/hpc

rem Other parameters
set MATLABHOSTDIR=%cd%
set THIRDPARTYDIR="%cd%\Core\3rdparty"
set REMOTESCRIPTSDIR=%HEADNODEWORKERDIR%/scripts