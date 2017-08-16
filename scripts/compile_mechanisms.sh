# Build MOD files with "mknrndll" bash script
source neuron_home_lin.sh

# Export path to "mknrndll" script and "sh.exe" used by the script
export PATH=$NEURON_HOME_LIN/bin:$NEURON_HOME_LIN/mingw/bin:$PATH

# Export variable used by "mknrndll" script
export N=$NEURON_HOME_LIN

# Go to the folder containing mechanisms
cd neuronSims

# Translate MOD-s to C-s, compile C-s to O-s, link O-s to "nrnmech.dll"
sh $NEURON_HOME_LIN/bin/mknrndll