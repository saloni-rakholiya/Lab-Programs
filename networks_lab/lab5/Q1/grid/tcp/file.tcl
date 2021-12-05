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

set rows 5
set cols 5
set start1 [lindex $argv 0]
set stop1 [lindex $argv 1]

for {set i 0} {$i < ($rows * $cols)} {incr i} {
        set n($i) [$ns node]
}
for {set j 0} {$j < $rows-1} {incr j} {
	for {set i 0} {$i < $cols-1} {incr i} {
		$ns duplex-link $n([expr ($cols*($j)+$i)]) $n([expr ($cols*($j)+$i+1)]) 1Mb 10ms DropTail
	}
	for {set i 0} {$i < $cols} {incr i} {
		$ns duplex-link $n([expr ($cols*($j)+$i)]) $n([expr ($cols*($j+1)+$i)]) 1Mb 10ms DropTail
	}
}
for {set i 0} {$i < $cols-1} {incr i} {
	$ns duplex-link $n([expr ($rows-1)*($cols)+$i]) $n([expr ($rows-1)*($cols)+$i+1]) 1Mb 10ms DropTail	
}

#TCP Agent
set tcp0 [new Agent/TCP]
$ns attach-agent $n([expr ($start1-1)]) $tcp0

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ftp0 set type_ FTP

set end0 [new Agent/TCPSink]
$ns attach-agent $n([expr ($stop1-1)]) $end0

$ns connect $tcp0 $end0
$tcp0 set fid_ 1

$ns at 1.0 "$ftp0 start"
$ns at 49.0 "$ftp0 stop"

$ns at 50.0 "finish"
$ns run