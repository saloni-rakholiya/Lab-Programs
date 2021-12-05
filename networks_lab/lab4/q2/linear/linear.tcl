#Create a simulator object
set ns [new Simulator]

# color packets of flow 0 red flow 1 blue
$ns color 0 Red
$ns color 1 Blue

#Open the nam file basic1.nam and the variable-trace file basic1.tr
set namfile [open out.nam w]
$ns namtrace-all $namfile
set tracefile [open trace.tr w]
$ns trace-all $tracefile

#Define a 'finish' procedure
proc finish {} {
        global ns namfile tracefile
        $ns flush-trace
        close $namfile
        close $tracefile
        exit 0
}

set start1 [lindex $argv 0]
set stop1 [lindex $argv 1]
set start2 [lindex $argv 2]
set stop2 [lindex $argv 3]

#creating Nodes        
for {set i 0} {$i<10} {incr i} {
set n($i) [$ns node]
}

#Make Connections
for {set i 0} {$i < 9} {incr i} {
$ns duplex-link $n($i) $n([expr $i+1]) 1Mb 10ms DropTail
}

#UDP Agent
set udp0 [new Agent/UDP]
$ns attach-agent $n([expr ($start1-1)]) $udp0
set cbr0 [new Application/Traffic/CBR]

$cbr0 set packetSize_ 500
$cbr0 attach-agent $udp0

set null0 [new Agent/Null]
$ns attach-agent $n([expr ($stop1-1)]) $null0

#TCP Agent
set tcp0 [new Agent/TCP]
$ns attach-agent $n([expr ($start2-1)]) $tcp0

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ftp0 set type_ FTP

set end0 [new Agent/TCPSink]
$ns attach-agent $n([expr ($stop2-1)]) $end0


$ns connect $udp0 $null0  
$cbr0 set fid_ 0
$ns connect $tcp0 $end0
$tcp0 set fid_ 1

$ns at 1.0 "$cbr0 start"
$ns at 49.0 "$cbr0 stop"

$ns at 1.0 "$ftp0 start"
$ns at 49.0 "$ftp0 stop"


$ns at 50.0 "finish"
$ns run

