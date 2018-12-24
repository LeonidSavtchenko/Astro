#!/bin/bash

# Check if process "nrniv" is running on one of the specified nodes
# This script takes names of nodes as arguments

for var in "$@";
do
    echo "    Checking" $var "..."
    ssh $var "pidof nrniv" > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
        exit 0 # process is found
    fi
done

exit 1 # process is not found