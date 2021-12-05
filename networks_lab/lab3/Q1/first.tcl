set ns [new Simulator]
$ns color 1 Blue
$ns color 2 Red
set th1 [ open out1.tr w]
set th2 [ open out2.tr w]
set pl1 [ open lost1.tr w]
set pl2 [ open lost2.tr w]
set pd1 [ open delay1.tr w]
set pd2 [ open delay2.tr w]

set holdtime0 0
set holdtime1 0
set holdseq 0
set holdseq1 0
set holdrate0 0
set holdrate1 0

proc record {} {
	global sink1 sink2 th1 th2 pl1 pl2 pd1 pd2 holdtime0 holdtime1 holdseq holdseq1 holdrate0 holdrate1
	set ns [Simulator instance]
    set time 10.01
    set bw0 [$sink1 set bytes_]
    set bw1 [$sink2 set bytes_]

    set bw2 [$sink1 set nlost_]
    set bw3 [$sink2 set nlost_]
    
    #puts $bw2
    set bw4 [$sink1 set lastPktTime_]
    set bw5 [$sink1 set npkts_]

    set bw6 [$sink1 set lastPktTime_]
    set bw7 [$sink1 set npkts_]

    set now [$ns now]
    puts $th1 "$now [expr (($bw0+$holdrate0)*8)/($time*2*1000000)]"
    puts $th2 "$now [expr (($bw1+$holdrate1)*8)/($time*2*1000000)]"
    puts $pl1 "$now [expr $bw2/$time]"
    puts $pl2 "$now [expr $bw3/$time]"
    if { $bw5 > $holdseq } {
    
        puts $pd1 "$now [expr ($bw4 - $holdtime0)/($bw5 - $holdseq)] "
    } else {
        puts $pd1 "$now [expr $bw5- $holdseq]"
    }
     if { $bw7 > $holdseq1 } {
        puts $pd2 "$now [expr ($bw6 - $holdtime1)/($bw7 - $holdseq1)]"
    } else {
        puts $pd2 "$now [expr $bw7-$holdseq1]"
    }
    
    $sink1 set bytes_ 0
    $sink2 set bytes_ 0

    $sink1 set nlost_ 0
    $sink2 set nlost_ 0
    
    set holdtime0 $bw4
    set holdseq $bw5

    set holdtime1 $bw6
    set holdseq1 $bw7

    set holdrate1 $bw0
    set holdrate2 $bw1
    $ns at [expr $now+$time] "record"
}


set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$ns duplex-link $n0 $n1 10Mb 1ms DropTail
$ns duplex-link $n2 $n1 10Mb 1ms DropTail
$ns duplex-link $n1 $n4 1Mb 3ms DropTail
$ns duplex-link $n4 $n3 10Mb 1ms DropTail
$ns duplex-link $n4 $n5 10Mb 1ms DropTail
set tcp1 [new Agent/TCP]
set sink1 [new Agent/LossMonitor]
$ns attach-agent $n0 $tcp1
$ns attach-agent $n3 $sink1
$ns connect $tcp1 $sink1
$tcp1 set fid_ 1

set tcp2 [new Agent/TCP]
set sink2 [new Agent/LossMonitor]
$ns attach-agent $n2 $tcp2
$ns attach-agent $n5 $sink2
$ns connect $tcp2 $sink2
$tcp2 set fid_ 2

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

$ns at 0.0 "record"
$ns at 1.0 "$ftp1 start"
$ns at 1.0 "$ftp2 start"

$ns at 200.0 "finish"
proc finish {} {
    global ns th1 th2 pl1 pl2 pd1 pd2 namfile 
    $ns flush-trace
    close $th1
    close $th2
	close $pl1
	close $pl2
	close $pd1
	close $pd2
	exec xgraph out1.tr out2.tr -P &
	exec xgraph lost1.tr lost2.tr -P &
	exec xgraph delay1.tr delay2.tr -P &
    exit 0
}
puts "Simulation starting now"
$ns run
