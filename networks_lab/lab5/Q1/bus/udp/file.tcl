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

#creating Nodes        
for {set i 0} {$i<10} {incr i} {
set n($i) [$ns node]
}

set lan0 [$ns newLan "$n(0) $n(1) $n(2) $n(3) $n(4) $n(5) $n(6) $n(7) $n(8) $n(9)" 1Mb 10ms LL Queue/DropTail MAC/Csma/Cd Channel]

#UDP Agent
set udp0 [new Agent/UDP]
$ns attach-agent $n([expr ($start1-1)]) $udp0
set cbr0 [new Application/Traffic/CBR]

$cbr0 set packetSize_ 500
$cbr0 attach-agent $udp0

set null0 [new Agent/Null]
$ns attach-agent $n([expr ($stop1-1)]) $null0

$ns connect $udp0 $null0  
$cbr0 set fid_ 0

$ns at 1.0 "$cbr0 start"
$ns at 49.0 "$cbr0 stop"

$ns at 50.0 "finish"
$ns run