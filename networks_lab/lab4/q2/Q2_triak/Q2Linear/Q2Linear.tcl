#create a simulator object
set ns [new Simulator]

$ns color 1 Blue
$ns color 2 Red

#create animation information / nam file
set namfile [open Q2Linear.nam w]
$ns namtrace-all $namfile

set th [open Q2Linear.tr w]
$ns trace-all $th


#creating nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]

#creation of link between nodes with DropTail Queue
$ns duplex-link $n0 $n1 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link $n2 $n3 2Mb 10ms DropTail
$ns duplex-link $n3 $n4 2Mb 10ms DropTail
$ns duplex-link $n4 $n5 2Mb 10ms DropTail
$ns duplex-link $n5 $n6 2Mb 10ms DropTail
$ns duplex-link $n6 $n7 2Mb 10ms DropTail
$ns duplex-link $n7 $n8 2Mb 10ms DropTail
$ns duplex-link $n8 $n9 2Mb 10ms DropTail


#creation of Agents
#node 0 to node 4
set tcp1 [new Agent/TCP]
set sink1 [new Agent/TCPSink]
$ns attach-agent $n0 $tcp1
$ns attach-agent $n4 $sink1
$ns connect $tcp1 $sink1
$tcp1 set fid_ 1

#creation of Agents
#node 0 to node 3
# set udp [new Agent/UDP]
# set null [new Agent/Null]
# $ns attach-agent $n1 $udp
# $ns attach-agent $n3 $null
# $ns connect $udp $null
# $udp set fid_ 2

# creation of TCP Agent
#node 9 to node 5
set tcp2 [new Agent/TCP]
set sink2 [new Agent/TCPSink]
$ns attach-agent $n9 $tcp2
$ns attach-agent $n5 $sink2
$ns connect $tcp2 $sink2
$tcp2 set fid_ 2

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

# set cbr [new Application/Traffic/CBR]
# $cbr attach-agent $udp

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

#start traffic
$ns at 1.0 "$ftp1 start"
$ns at 1.0 "$ftp2 start"

$ns at 49.0 "$ftp1 stop"
$ns at 49.0 "$ftp2 stop"

$ns at 50.0 "finish"

#procedure to be called at end
proc finish {} {
    global ns namfile th
    $ns flush-trace
    close $namfile
    close $th

    
    exit 0
}
puts "Simulation is starting...."
$ns run
