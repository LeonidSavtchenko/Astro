#!sh

# Build MOD files with "mknrndll" bash script,
# i.e. translate MOD-s to C-s, compile C-s to O-s, link O-s to "nrnmech.dll"

# Initialize variables
. ./Core/scripts/win-win/params.sh

# Export path to "mknrndll" script and "sh.exe" used by the script
export PATH=$NRNDIR/bin:$NRNDIR/mingw/bin:$PATH

# Export variable used by "mknrndll" script
export N=$NRNDIR

# Go to the folder containing "model" subfolder
cd $HPCDIR

# Translate MOD-s to C-s, compile C-s to O-s, link O-s to "nrnmech.dll"
sh mknrndll model
