#!/bin/bash

# Kill process "nrniv" running on one of the specified nodes
# This script takes names of nodes as arguments

for var in "$@";
do
    ssh $var "pkill nrniv" > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
        exit 0 # process is found and killed
    fi
done

exit 1 # process is not running