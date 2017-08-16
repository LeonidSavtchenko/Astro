#!/bin/sh
# Measure performance of the astrocyte simulation for the specified number of processes (multiple runs).
# $1 - The minimum number of processes.
# $2 - The maximum number of processes.
# $3 - The step of process grid.
# $4 - The process distribution scheme:
#      1 - only master works,
#      2 - only slaves work,
#      3 - master and slaves work together.
#
# Other input parameters are specified in the file "init.hoc".

if [ ! $# == 4 ]; then
    echo "Four input arguments are expected: the minimum number of processes, the maximum number of processes, the step of process grid and the process distribution scheme."
    exit
fi

cd ..

clear

# Remove old test results
rm -f complete
rm -f perf.dat
rm -r -f results
mkdir results

modeldir=model

export IV=/usr/local/neuron/iv
export N=/usr/local/neuron/nrn
export CPU=x86_64
export PATH="$IV/$CPU/bin:$N/$CPU/bin:$PATH"

# Start timer for setup time
start=$SECONDS

CPU="x86_64"
rm -r -f $CPU
rm -f mcomplex.dat
echo
echo Translating to C and compiling MOD files ...
echo
nrnivmodl $modeldir
echo
echo Generating "mcomplex.dat" file ...
echo
$CPU/special -nogui -c "split=2" init.hoc

setuptime=$(( SECONDS - start ))

echo "setuptime: $setuptime" >> results/runtimes.dat
echo "np runtime" >> results/runtimes.dat

for np in `seq $1 $3 $2` ; do
    
    start=$SECONDS
    
    echo
    echo Splitting geometry and launching simulation ...
    echo
    if [ $4 == 1 ] ; then
        # Only tuxmaster works:
        mpiexec -np $np `which nrniv` -mpi -c "numProcs=$np" init.hoc
    elif [ $4 == 2 ] ; then
        # Only slaves tuxm1 - tuxm12 work:
        mpiexec -np $np -hostfile hostfile_IdleMaster `which nrniv` -mpi -c "numProcs=$np" init.hoc
    else
        # Master and slaves work together
        mpiexec -np $np -hostfile hostfile_BusyMaster `which nrniv` -mpi -c "numProcs=$np" init.hoc
    fi
    if [ ! $? == 0 ] ; then
        exit
    fi
    
    runtime=$(( SECONDS - start ))
    
    mv trajec_*.dat results
    
    echo "$np $runtime" >> results/runtimes.dat
    
done

rm -f user_geometry/*

# Create the empty file indicating that simulation completed successfully
touch results/complete
