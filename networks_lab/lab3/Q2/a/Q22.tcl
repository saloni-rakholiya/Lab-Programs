#create a simulator object
set ns [new Simulator]

$ns color 1 Blue
$ns color 2 Red
$ns color 3 Green

#create a trace file, file is for logging purpose
set tracefile [open Q22.tr w]
$ns trace-all $tracefile

#create animation information / nam file
set namfile [open Q22.nam w]
$ns namtrace-all $namfile

#creating nodes
set n1 [$ns node]
set n2 [$ns node]

$n1 shape box

#creation of link between node 1 and other nodes with DropTail Queue
$ns duplex-link $n1 $n2 1Mb 1ms DropTail

#creation of Agent between node 1 and node 2
set udp1 [new Agent/UDP]
set null1 [new Agent/Null]
$ns attach-agent $n1 $udp1
$ns attach-agent $n2 $null1
$ns connect $udp1 $null1
$udp1 set fid_ 1


# creation of Application using CBR
# CBR - Constant Bit Rate
#FTP - File Transfer Protocol
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1

#start traffic
$ns at 1.0 "$cbr1 start"
$ns at 200.0 "finish"

#procedure to be called at end
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec awk -f t.awk Q22.tr &
    exit 0
}
puts "Simulation starting"
$ns run
