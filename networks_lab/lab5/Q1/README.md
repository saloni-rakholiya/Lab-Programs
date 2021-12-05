*Instructions* 

For each topology, there exists two protocol folders in which respective TCL File is present.

Run as following on BASH
```
cd bus/udp
ns file.tcl <src> <sink>
nam out.nam &
python ../../simulate.py <src> <sink> <protocol - either tcp or cbr> <interval -- optional, default 1.0>

xgraph *delay.txt -t 'End to End Delay vs Time'
xgraph pdr* -t 'PDR vs Time'
xgraph throughput* -t 'Throughput vs Time'

```