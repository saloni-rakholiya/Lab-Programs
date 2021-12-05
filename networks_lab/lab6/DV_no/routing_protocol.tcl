#ns routing_protocol.tcl no_of_row_matrix (routing protocol: LS or DV) (failure or no_failure)
# creating a new object(simulator)
set ns [new Simulator]
#setting colors
$ns color 1 Red
$ns color 2 Blue
$ns color 3 Green

set s [ lindex $argv 0 ]
set stations_count [expr $s * $s]
set protocol_type [ lindex $argv 1 ]

# setting the routing protocol(DV or LS here)
$ns rtproto $protocol_type
# variable if link failure is there or not
set link_failure [lindex $argv 2]
# making the out.tr and out.nam
set namtracefile [open out.nam w]
set tracefile [open out.tr w]
$ns namtrace-all $namtracefile
$ns trace-all $tracefile


# finish procedure for the file
proc finish {} {
    global ns namtracefile tracefile
    $ns flush-trace
    close $namtracefile
    close $tracefile
    exit 0
}

# Grid topology
# making grid nodes
for {set i 0} {$i < $stations_count} {incr i} {
    set n($i) [$ns node]   
}

# creating the node links having droptail 
# packet size
for {set i 0} {$i < $stations_count} {incr i} {
    if {[expr $i % $s] != 0} {
        $ns duplex-link $n($i) $n([expr $i - 1]) 1Mb 10ms DropTail
        $ns queue-limit $n($i) $n([expr $i - 1]) 20
        $ns queue-limit $n([expr $i - 1]) $n($i) 20
        
        if { $link_failure == "failure" } {
            if {$i < [expr 0.15 * $stations_count]} {
                $ns rtmodel-at 30.0 down $n($i) $n([expr $i - 1])
                if {$i < [expr 0.05 * $stations_count]} {
                    $ns rtmodel-at 60.0 up $n($i) $n([expr $i - 1])
                } else {
                    $ns rtmodel-at 90.0 up $n($i) $n([expr $i - 1])
                }
            }
        }
    }
    if {$i >= $s} {
        $ns duplex-link $n($i) $n([expr $i - $s]) 1Mb 10ms DropTail
        $ns queue-limit $n($i) $n([expr $i - $s]) 20
        $ns queue-limit $n([expr $i - $s]) $n($i) 20
    }
}
set temp [expr $stations_count - 1 ]

for {set i 0} { $i < [ expr $stations_count / 2] } {incr i} {
    # setup tcp part
    set tcp($i) [new Agent/TCP]
    set sink($i) [new Agent/TCPSink]
    $ns attach-agent $n($i) $tcp($i)
    $ns attach-agent $n([expr $temp - $i]) $sink($i)
    $ns connect $tcp($i) $sink($i)


    # giving packet related details
    set ftp($i) [new Application/FTP]
    $ftp($i) attach-agent $tcp($i)
    $ftp($i) set type_ FTP
    #setting packetsize
    $ftp($i) set packetsize_ 512
    
    $tcp($i) set fid_ 1
    # schedule time for simulation
    $ns at 1.0 "$ftp($i) start"
    $ns at 99.0 "$ftp($i) stop"
}
#total simulation time= 100s
$ns at 100.0 "finish"

# procedure run (ns)
$ns run
