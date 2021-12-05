# creating a new simulator object
set ns [new Simulator]

#setting colors
$ns color 1 Blue
$ns color 2 Red

# making files for trace and nam data
set namtracefile [open mytopology.nam w]
set tracefile [open mytopology.tr w]
$ns namtrace-all $namtracefile
$ns trace-all $tracefile

# writing finish procedure to close files
proc finish {} {
    global ns namtracefile tracefile
    $ns flush-trace
    close $namtracefile
    close $tracefile
    exec nam mytopology.nam &
    exit 0
}

#setting link for nodes
set r1 [$ns node]
set r2 [$ns node]
$ns duplex-link $r1 $r2 2Mb 10ms DropTail

for {set i 0} {$i < 3} {incr i} {
    
    # creating nodes
    set a($i) [$ns node]
    set b($i) [$ns node]
    
    # making links
    $ns duplex-link $r1 $a($i) 2Mb 10ms DropTail
    $ns duplex-link $r2 $b($i) 2Mb 10ms DropTail

    # creating agents
    set tcp($i) [new Agent/TCP]
    set sink($i) [new Agent/TCPSink]
    
    # attaching agents
    $ns attach-agent $a($i) $tcp($i)
    $ns attach-agent $b($i) $sink($i)
    $ns connect $tcp($i) $sink($i)

    # settng packet information
    set ftp($i) [new Application/FTP]
    $ftp($i) attach-agent $tcp($i)
    $ftp($i) set type_ FTP

    #setting color
    $tcp($i) set class_ 2
    $tcp($i) set fid_ 1

    # queuing limit for p-loss
    $ns queue-limit $a($i) $r1 10
    $ns queue-limit $r1 $a($i) 10
    $ns queue-limit $b($i) $r2 10
    $ns queue-limit $r2 $b($i) 10

    # scheduling start and stop
    $ns at 0.1 "$ftp($i) start"
    $ns at 9.9 "$ftp($i) stop"
}

# schedule finish
$ns at 10 "finish"

# run
$ns run

