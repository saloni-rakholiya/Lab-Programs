#!/bin/sh
for x in 1 2 3 4 5 6 7 8 9 10
do 
    echo "For X = $x"
    ns file.tcl $x
    python3 parse_trace.py randommac.tr $x
done
xgraph pr-values.txt