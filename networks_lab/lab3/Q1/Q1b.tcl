#creating a simulator object
set ns [new Simulator]

#node setting colours simulator
$ns color 1 Blue
$ns color 2 Red

#create animation information(nam) file
set namfile [open Q1.nam w]
#trace all
$ns namtrace-all $namfile

#creating nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

#creation of link between nodes with DropTail Queue
$ns duplex-link $n0 $n1 10Mb 1ms DropTail
$ns duplex-link $n2 $n1 10Mb 1ms DropTail
$ns duplex-link $n1 $n4 1Mb 3ms DropTail
$ns duplex-link $n4 $n3 10Mb 1ms DropTail
$ns duplex-link $n4 $n5 10Mb 1ms DropTail

#creation of Agents
#node 0 to node 3
set tcp1 [new Agent/TCP]
set sink1 [new Agent/TCPSink]
$ns attach-agent $n0 $tcp1
$ns attach-agent $n3 $sink1
$ns connect $tcp1 $sink1
$tcp1 set fid_ 1

#creation of TCP Agent
set tcp2 [new Agent/TCP]
set sink2 [new Agent/TCPSink]
$ns attach-agent $n2 $tcp2
$ns attach-agent $n5 $sink2
$ns connect $tcp2 $sink2
$tcp2 set fid_ 2

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

#start traffic
$ns at 1.0 "$ftp1 start"
$ns at 1.0 "$ftp2 start"

$ns at 200.0 "finish"

#procedure to be called at end
proc finish {} {
    global ns th1 th2 pl1 pl2 pd1 pd2 namfile 
    $ns flush-trace
    close $namfile
    exit 0
}
puts "Simulation starts now"
$ns run
