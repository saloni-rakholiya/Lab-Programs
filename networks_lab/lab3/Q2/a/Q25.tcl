#create a simulator object
set ns [new Simulator]

$ns color 1 Blue
$ns color 2 Red
$ns color 3 Green

#create a trace file, file is for logging purpose
set tracefile [open Q25.tr w]
$ns trace-all $tracefile

#create animation information / nam file
set namfile [open Q25.nam w]
$ns namtrace-all $namfile

#creating nodes
set n1 [$ns node]
# $n1 color [1];
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$n1 shape box
$n3 shape box
$n5 shape box

#creation of link between node 1 and other nodes with DropTail Queue
$ns duplex-link $n1 $n2 1Mb 1ms DropTail
$ns duplex-link $n1 $n3 1Mb 1ms DropTail
$ns duplex-link $n1 $n4 1Mb 1ms DropTail
$ns duplex-link $n1 $n5 1Mb 1ms DropTail

#creation of link between node 2 and other nodes with DropTail Queue
$ns duplex-link $n2 $n3 1Mb 1ms DropTail
$ns duplex-link $n2 $n4 1Mb 1ms DropTail
$ns duplex-link $n2 $n5 1Mb 1ms DropTail

#creation of link between node 3 and other nodes with DropTail Queue
$ns duplex-link $n3 $n4 1Mb 1ms DropTail
$ns duplex-link $n3 $n5 1Mb 1ms DropTail

#creation of link between node 4 and other nodes with DropTail Queue
$ns duplex-link $n4 $n5 1Mb 1ms DropTail



#creation of Agent between node 1 and node 2
set udp12 [new Agent/UDP]
# $udp12 set packetSize_ 512
set null12 [new Agent/Null]
$ns attach-agent $n1 $udp12
$ns attach-agent $n2 $null12
$ns connect $udp12 $null12
$udp12 set fid_ 1

#creation of Agent between node 1 and node 4
set udp14 [new Agent/UDP]
set null14 [new Agent/Null]
$ns attach-agent $n1 $udp14
$ns attach-agent $n4 $null14
$ns connect $udp14 $null14
$udp14 set fid_ 1

#creation of Agent between node 3 and node 2
set udp32 [new Agent/UDP]
set null32 [new Agent/Null]
$ns attach-agent $n3 $udp32
$ns attach-agent $n2 $null32
$ns connect $udp32 $null32
$udp32 set fid_ 2

#creation of Agent between node 3 and node 4
set udp34 [new Agent/UDP]
set null34 [new Agent/Null]
$ns attach-agent $n3 $udp34
$ns attach-agent $n4 $null34
$ns connect $udp34 $null34
$udp34 set fid_ 2

#creation of Agent between node 5 and node 2
set udp52 [new Agent/UDP]
set null52 [new Agent/Null]
$ns attach-agent $n5 $udp52
$ns attach-agent $n2 $null52
$ns connect $udp52 $null52
$udp52 set fid_ 3

#creation of Agent between node 5 and node 4
set udp54 [new Agent/UDP]
set null54 [new Agent/Null]
$ns attach-agent $n5 $udp54
$ns attach-agent $n4 $null54
$ns connect $udp54 $null54
$udp54 set fid_ 3


# creation of Application using CBR
# CBR - Constant Bit Rate
#FTP - File Transfer Protocol
set cbr12 [new Application/Traffic/CBR]
$cbr12 attach-agent $udp12

set cbr14 [new Application/Traffic/CBR]
$cbr14 attach-agent $udp14

set cbr32 [new Application/Traffic/CBR]
$cbr32 attach-agent $udp32

set cbr34 [new Application/Traffic/CBR]
$cbr34 attach-agent $udp34

set cbr52 [new Application/Traffic/CBR]
$cbr52 attach-agent $udp52

set cbr54 [new Application/Traffic/CBR]
$cbr54 attach-agent $udp54

# set ftp1 [new Application/FTP]
# $ftp1 attach-agent $tcp1

# set ftp2 [new Application/FTP]
# $ftp2 attach-agent $tcp2

#start traffic
$ns at 1.0 "$cbr12 start"
$ns at 1.0 "$cbr14 start"
$ns at 1.0 "$cbr32 start"
$ns at 1.0 "$cbr34 start"
$ns at 1.0 "$cbr52 start"
$ns at 1.0 "$cbr54 start"

$ns at 200.0 "finish"

#procedure to be called at end
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec awk -f t.awk Q25.tr &
    exit 0
}
puts "Simulation starting"
$ns run
