
BEGIN{
  stime=0
  ftime=0
  flag=0
  throughput=0
  latency=0
  fsize=0
}
{
if ($1=="r" && ($4==1 || $4==3 || $4==5 || $4==7 || $4==9)  )
{
  fsize+=$6
  if(flag==0)
  {
    flag=1
    stime=$2
  }
  ftime=$2
}
}
END{
  latency=ftime-stime
  throughput=(fsize*8)/latency
  printf("throughput is %f Mbps",throughput/1000000)
}
