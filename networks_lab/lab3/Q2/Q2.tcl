#create a simulator object
set ns [new Simulator]

$ns color 1 Blue
$ns color 2 Red
$ns color 3 Green

#create a trace file, file is for logging purpose
set tracefile [open Q2.tr w]
$ns trace-all $tracefile

#create animation information / nam file
set namfile [open Q2.nam w]
$ns namtrace-all $namfile

#creating nodes
set n1 [$ns node]
# $n1 color [1];
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]

$n1 shape box
$n3 shape box
$n5 shape box

#creation of link between node 1 and other nodes with DropTail Queue
$ns duplex-link $n1 $n2 1Mb 1ms DropTail
$ns duplex-link $n1 $n3 1Mb 1ms DropTail
$ns duplex-link $n1 $n4 1Mb 1ms DropTail
$ns duplex-link $n1 $n5 1Mb 1ms DropTail
$ns duplex-link $n1 $n6 1Mb 1ms DropTail

#creation of link between node 2 and other nodes with DropTail Queue
$ns duplex-link $n2 $n1 1Mb 1ms DropTail
$ns duplex-link $n2 $n3 1Mb 1ms DropTail
$ns duplex-link $n2 $n4 1Mb 1ms DropTail
$ns duplex-link $n2 $n5 1Mb 1ms DropTail
$ns duplex-link $n2 $n6 1Mb 1ms DropTail

#creation of link between node 3 and other nodes with DropTail Queue
$ns duplex-link $n3 $n1 1Mb 1ms DropTail
$ns duplex-link $n3 $n2 1Mb 1ms DropTail
$ns duplex-link $n3 $n4 1Mb 1ms DropTail
$ns duplex-link $n3 $n5 1Mb 1ms DropTail
$ns duplex-link $n3 $n6 1Mb 1ms DropTail

#creation of link between node 4 and other nodes with DropTail Queue
$ns duplex-link $n4 $n1 1Mb 1ms DropTail
$ns duplex-link $n4 $n2 1Mb 1ms DropTail
$ns duplex-link $n4 $n3 1Mb 1ms DropTail
$ns duplex-link $n4 $n5 1Mb 1ms DropTail
$ns duplex-link $n4 $n6 1Mb 1ms DropTail

#creation of link between node 5 and other nodes with DropTail Queue
$ns duplex-link $n5 $n1 1Mb 1ms DropTail
$ns duplex-link $n5 $n2 1Mb 1ms DropTail
$ns duplex-link $n5 $n3 1Mb 1ms DropTail
$ns duplex-link $n5 $n4 1Mb 1ms DropTail
$ns duplex-link $n5 $n6 1Mb 1ms DropTail

#creation of link between node 6 and other nodes with DropTail Queue
$ns duplex-link $n6 $n1 1Mb 1ms DropTail
$ns duplex-link $n6 $n2 1Mb 1ms DropTail
$ns duplex-link $n6 $n3 1Mb 1ms DropTail
$ns duplex-link $n6 $n4 1Mb 1ms DropTail
$ns duplex-link $n6 $n5 1Mb 1ms DropTail

#creation of Agent between node 1 and node 4
set udp1 [new Agent/UDP]
set null1 [new Agent/Null]
$ns attach-agent $n1 $udp1
$ns attach-agent $n4 $null1
$ns connect $udp1 $null1
$udp1 set fid_ 1
#creation of Agent between node 5 and node 2
set udp2 [new Agent/UDP]
set null2 [new Agent/Null]
$ns attach-agent $n5 $udp2
$ns attach-agent $n2 $null2
$ns connect $udp2 $null2
$udp2 set fid_ 2

#creation of Agent between node 3 and node 6
set udp3 [new Agent/UDP]
set null3 [new Agent/Null]
$ns attach-agent $n3 $udp3
$ns attach-agent $n6 $null3
$ns connect $udp3 $null3
$udp3 set fid_ 3
#creation of Agents
#node 0 to node 3
# set tcp1 [new Agent/TCP]
# set sink1 [new Agent/TCPSink]
# $ns attach-agent $n0 $tcp1
# $ns attach-agent $n3 $sink1
# $ns connect $tcp1 $sink1

#creation of TCP Agent
# set tcp2 [new Agent/TCP]
# set sink2 [new Agent/TCPSink]
# $ns attach-agent $n2 $tcp2
# $ns attach-agent $n5 $sink2
# $ns connect $tcp2 $sink2

# creation of Application using CBR
# CBR - Constant Bit Rate
#FTP - File Transfer Protocol
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1

set cbr2 [new Application/Traffic/CBR]
$cbr2 attach-agent $udp2

set cbr3 [new Application/Traffic/CBR]
$cbr3 attach-agent $udp3

# set ftp1 [new Application/FTP]
# $ftp1 attach-agent $tcp1

# set ftp2 [new Application/FTP]
# $ftp2 attach-agent $tcp2

#start traffic
$ns at 1.0 "$cbr1 start"
$ns at 1.0 "$cbr2 start"
$ns at 1.0 "$cbr3 start"

$ns at 200.0 "finish"

#procedure to be called at end
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exit 0
}
puts "Simulation is starting...."
$ns run
