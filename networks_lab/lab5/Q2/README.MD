**Instructions**

Run on BASH:

Under **Q2**, run the following
```
python get_args.py 1 50
```

----------------------------------------------------------------------------------------------------------------
Run file under **high(or)low(or)medium**/**tahoe(or)reno**

For low => 2 connections

For medium => 7 connections

For high => 12 connections

```
ns file.tcl $(cat ../../args.txt)
nam out.nam &
python ../../simulate.py <num of connections> <interval - optional, default - 1.0>

xgraph *control* -t 'Congestion Control vs Time'
xgraph *overhead* -t 'Control Overhead vs Time'
xgraph pdr* -t 'PDR vs Time'
```