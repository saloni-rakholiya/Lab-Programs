#create a simulator object
set ns [new Simulator]

$ns color 1 Violet
$ns color 2 Red
$ns color 3 Orange
$ns color 4 Green
$ns color 5 Yellow


#create a trace file, file is for logging purpose
set tracefile [open Q210_2048.tr w]
$ns trace-all $tracefile

#create animation information / nam file
set namfile [open Q210_2048.nam w]
$ns namtrace-all $namfile




#creating nodes
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]
set n10 [$ns node]


$n1 shape box
$n3 shape box
$n5 shape box
$n7 shape box
$n9 shape box

#creation of link between node 1 and other nodes with DropTail Queue
$ns duplex-link $n1 $n2 1Mb 1ms DropTail
$ns duplex-link $n1 $n3 1Mb 1ms DropTail
$ns duplex-link $n1 $n4 1Mb 1ms DropTail
$ns duplex-link $n1 $n5 1Mb 1ms DropTail
$ns duplex-link $n1 $n6 1Mb 1ms DropTail
$ns duplex-link $n1 $n7 1Mb 1ms DropTail
$ns duplex-link $n1 $n8 1Mb 1ms DropTail
$ns duplex-link $n1 $n9 1Mb 1ms DropTail
$ns duplex-link $n1 $n10 1Mb 1ms DropTail

#creation of link between node 2 and other nodes with DropTail Queue
$ns duplex-link $n2 $n3 1Mb 1ms DropTail
$ns duplex-link $n2 $n4 1Mb 1ms DropTail
$ns duplex-link $n2 $n5 1Mb 1ms DropTail
$ns duplex-link $n2 $n6 1Mb 1ms DropTail
$ns duplex-link $n2 $n7 1Mb 1ms DropTail
$ns duplex-link $n2 $n8 1Mb 1ms DropTail
$ns duplex-link $n2 $n9 1Mb 1ms DropTail
$ns duplex-link $n2 $n10 1Mb 1ms DropTail

#creation of link between node 3 and other nodes with DropTail Queue
$ns duplex-link $n3 $n4 1Mb 1ms DropTail
$ns duplex-link $n3 $n5 1Mb 1ms DropTail
$ns duplex-link $n3 $n6 1Mb 1ms DropTail
$ns duplex-link $n3 $n7 1Mb 1ms DropTail
$ns duplex-link $n3 $n8 1Mb 1ms DropTail
$ns duplex-link $n3 $n9 1Mb 1ms DropTail
$ns duplex-link $n3 $n10 1Mb 1ms DropTail

#creation of link between node 4 and other nodes with DropTail Queue
$ns duplex-link $n4 $n5 1Mb 1ms DropTail
$ns duplex-link $n4 $n6 1Mb 1ms DropTail
$ns duplex-link $n4 $n7 1Mb 1ms DropTail
$ns duplex-link $n4 $n8 1Mb 1ms DropTail
$ns duplex-link $n4 $n9 1Mb 1ms DropTail
$ns duplex-link $n4 $n10 1Mb 1ms DropTail


#creation of link between node 5 and other nodes with DropTail Queue
$ns duplex-link $n5 $n6 1Mb 1ms DropTail
$ns duplex-link $n5 $n7 1Mb 1ms DropTail
$ns duplex-link $n5 $n8 1Mb 1ms DropTail
$ns duplex-link $n5 $n9 1Mb 1ms DropTail
$ns duplex-link $n5 $n10 1Mb 1ms DropTail


#creation of link between node 6 and other nodes with DropTail Queue
$ns duplex-link $n6 $n7 1Mb 1ms DropTail
$ns duplex-link $n6 $n8 1Mb 1ms DropTail
$ns duplex-link $n6 $n9 1Mb 1ms DropTail
$ns duplex-link $n6 $n10 1Mb 1ms DropTail


#creation of link between node 7 and other nodes with DropTail Queue
$ns duplex-link $n7 $n8 1Mb 1ms DropTail
$ns duplex-link $n7 $n9 1Mb 1ms DropTail
$ns duplex-link $n7 $n10 1Mb 1ms DropTail

#creation of link between node 8 and other nodes with DropTail Queue
$ns duplex-link $n8 $n9 1Mb 1ms DropTail
$ns duplex-link $n8 $n10 1Mb 1ms DropTail

#creation of link between node 9 and other nodes with DropTail Queue
$ns duplex-link $n9 $n10 1Mb 1ms DropTail

set packet 2048

#creation of Agent between node 1 and node 2
set udp12 [new Agent/UDP]
$udp12 set packetSize_ $packet
set null12 [new Agent/Null]
$ns attach-agent $n1 $udp12
$ns attach-agent $n2 $null12
$ns connect $udp12 $null12
$udp12 set fid_ 1

#creation of Agent between node 1 and node 4
set udp14 [new Agent/UDP]
set null14 [new Agent/Null]
$udp14 set packetSize_ $packet
$ns attach-agent $n1 $udp14
$ns attach-agent $n4 $null14
$ns connect $udp14 $null14
$udp14 set fid_ 1


#creation of Agent between node 1 and node 6
set udp16 [new Agent/UDP]
set null16 [new Agent/Null]
$udp16 set packetSize_ $packet
$ns attach-agent $n1 $udp16
$ns attach-agent $n6 $null16
$ns connect $udp16 $null16
$udp16 set fid_ 1


#creation of Agent between node 1 and node 8
set udp18 [new Agent/UDP]
set null18 [new Agent/Null]
$udp18 set packetSize_ $packet
$ns attach-agent $n1 $udp18
$ns attach-agent $n8 $null18
$ns connect $udp18 $null18
$udp18 set fid_ 1

#creation of Agent between node 1 and node 10
set udp110 [new Agent/UDP]
set null110 [new Agent/Null]
$udp110 set packetSize_ $packet
$ns attach-agent $n1 $udp110
$ns attach-agent $n10 $null110
$ns connect $udp110 $null110
$udp110 set fid_ 1

#creation of Agent between node 3 and node 2
set udp32 [new Agent/UDP]
$udp32 set packetSize_ $packet
set null32 [new Agent/Null]
$ns attach-agent $n3 $udp32
$ns attach-agent $n2 $null32
$ns connect $udp32 $null32
$udp32 set fid_ 2

#creation of Agent between node 3 and node 4
set udp34 [new Agent/UDP]
set null34 [new Agent/Null]
$udp34 set packetSize_ $packet
$ns attach-agent $n3 $udp34
$ns attach-agent $n4 $null34
$ns connect $udp34 $null34
$udp34 set fid_ 2


#creation of Agent between node 3 and node 6
set udp36 [new Agent/UDP]
set null36 [new Agent/Null]
$udp36 set packetSize_ $packet
$ns attach-agent $n3 $udp36
$ns attach-agent $n6 $null36
$ns connect $udp36 $null36
$udp36 set fid_ 2


#creation of Agent between node 3 and node 8
set udp38 [new Agent/UDP]
set null38 [new Agent/Null]
$udp38 set packetSize_ $packet
$ns attach-agent $n1 $udp38
$ns attach-agent $n8 $null38
$ns connect $udp38 $null38
$udp38 set fid_ 2

#creation of Agent between node 3 and node 10
set udp310 [new Agent/UDP]
set null310 [new Agent/Null]
$udp310 set packetSize_ $packet
$ns attach-agent $n3 $udp310
$ns attach-agent $n10 $null310
$ns connect $udp310 $null310
$udp310 set fid_ 2

#creation of Agent between node 5 and node 2
set udp52 [new Agent/UDP]
$udp52 set packetSize_ $packet
set null52 [new Agent/Null]
$ns attach-agent $n5 $udp52
$ns attach-agent $n2 $null52
$ns connect $udp52 $null52
$udp52 set fid_ 3

#creation of Agent between node 5 and node 4
set udp54 [new Agent/UDP]
set null54 [new Agent/Null]
$udp54 set packetSize_ $packet
$ns attach-agent $n5 $udp54
$ns attach-agent $n4 $null54
$ns connect $udp54 $null54
$udp54 set fid_ 3


#creation of Agent between node 5 and node 6
set udp56 [new Agent/UDP]
set null56 [new Agent/Null]
$udp56 set packetSize_ $packet
$ns attach-agent $n5 $udp56
$ns attach-agent $n6 $null56
$ns connect $udp56 $null56
$udp56 set fid_ 3


#creation of Agent between node 5 and node 8
set udp58 [new Agent/UDP]
set null58 [new Agent/Null]
$udp58 set packetSize_ $packet
$ns attach-agent $n5 $udp58
$ns attach-agent $n8 $null58
$ns connect $udp58 $null58
$udp58 set fid_ 3

#creation of Agent between node 5 and node 10
set udp510 [new Agent/UDP]
set null510 [new Agent/Null]
$udp510 set packetSize_ $packet
$ns attach-agent $n5 $udp510
$ns attach-agent $n10 $null510
$ns connect $udp510 $null510
$udp510 set fid_ 3

#creation of Agent between node 7 and node 2
set udp72 [new Agent/UDP]
$udp72 set packetSize_ $packet
set null72 [new Agent/Null]
$ns attach-agent $n7 $udp72
$ns attach-agent $n2 $null72
$ns connect $udp72 $null72
$udp72 set fid_ 4

#creation of Agent between node 7 and node 4
set udp74 [new Agent/UDP]
set null74 [new Agent/Null]
$udp74 set packetSize_ $packet
$ns attach-agent $n7 $udp74
$ns attach-agent $n4 $null74
$ns connect $udp74 $null74
$udp74 set fid_ 4


#creation of Agent between node 7 and node 6
set udp76 [new Agent/UDP]
set null76 [new Agent/Null]
$udp76 set packetSize_ $packet
$ns attach-agent $n7 $udp76
$ns attach-agent $n6 $null76
$ns connect $udp76 $null76
$udp76 set fid_ 4


#creation of Agent between node 7 and node 8
set udp78 [new Agent/UDP]
set null78 [new Agent/Null]
$udp78 set packetSize_ $packet
$ns attach-agent $n7 $udp78
$ns attach-agent $n8 $null78
$ns connect $udp78 $null78
$udp78 set fid_ 4

#creation of Agent between node 7 and node 10
set udp710 [new Agent/UDP]
set null710 [new Agent/Null]
$udp710 set packetSize_ $packet
$ns attach-agent $n7 $udp710
$ns attach-agent $n10 $null710
$ns connect $udp710 $null710
$udp710 set fid_ 4

#creation of Agent between node 9 and node 2
set udp92 [new Agent/UDP]
$udp72 set packetSize_ $packet
set null92 [new Agent/Null]
$ns attach-agent $n9 $udp92
$ns attach-agent $n9 $null92
$ns connect $udp92 $null92
$udp92 set fid_ 5

#creation of Agent between node 9 and node 4
set udp94 [new Agent/UDP]
set null94 [new Agent/Null]
$udp94 set packetSize_ $packet
$ns attach-agent $n9 $udp94
$ns attach-agent $n4 $null94
$ns connect $udp94 $null94
$udp94 set fid_ 5


#creation of Agent between node 9 and node 6
set udp96 [new Agent/UDP]
set null96 [new Agent/Null]
$udp96 set packetSize_ $packet
$ns attach-agent $n9 $udp96
$ns attach-agent $n6 $null96
$ns connect $udp96 $null96
$udp96 set fid_ 5


#creation of Agent between node 9 and node 8
set udp98 [new Agent/UDP]
set null98 [new Agent/Null]
$udp98 set packetSize_ $packet
$ns attach-agent $n9 $udp98
$ns attach-agent $n8 $null98
$ns connect $udp98 $null98
$udp98 set fid_ 5

#creation of Agent between node 9 and node 10
set udp910 [new Agent/UDP]
set null910 [new Agent/Null]
$udp910 set packetSize_ $packet
$ns attach-agent $n9 $udp910
$ns attach-agent $n10 $null910
$ns connect $udp910 $null910
$udp910 set fid_ 5




# creation of Application using CBR
# CBR - Constant Bit Rate
#FTP - File Transfer Protocol
set cbr12 [new Application/Traffic/CBR]
$cbr12 attach-agent $udp12

set cbr14 [new Application/Traffic/CBR]
$cbr14 attach-agent $udp14

set cbr16 [new Application/Traffic/CBR]
$cbr16 attach-agent $udp16

set cbr18 [new Application/Traffic/CBR]
$cbr18 attach-agent $udp18

set cbr110 [new Application/Traffic/CBR]
$cbr110 attach-agent $udp110

set cbr32 [new Application/Traffic/CBR]
$cbr32 attach-agent $udp32

set cbr34 [new Application/Traffic/CBR]
$cbr34 attach-agent $udp34

set cbr36 [new Application/Traffic/CBR]
$cbr36 attach-agent $udp36

set cbr38 [new Application/Traffic/CBR]
$cbr38 attach-agent $udp38

set cbr310 [new Application/Traffic/CBR]
$cbr310 attach-agent $udp310

set cbr52 [new Application/Traffic/CBR]
$cbr52 attach-agent $udp52

set cbr54 [new Application/Traffic/CBR]
$cbr54 attach-agent $udp54

set cbr56 [new Application/Traffic/CBR]
$cbr56 attach-agent $udp56

set cbr58 [new Application/Traffic/CBR]
$cbr58 attach-agent $udp58

set cbr510 [new Application/Traffic/CBR]
$cbr510 attach-agent $udp510

set cbr72 [new Application/Traffic/CBR]
$cbr72 attach-agent $udp72

set cbr74 [new Application/Traffic/CBR]
$cbr74 attach-agent $udp74

set cbr76 [new Application/Traffic/CBR]
$cbr76 attach-agent $udp76

set cbr78 [new Application/Traffic/CBR]
$cbr78 attach-agent $udp78

set cbr710 [new Application/Traffic/CBR]
$cbr710 attach-agent $udp710

set cbr92 [new Application/Traffic/CBR]
$cbr92 attach-agent $udp92

set cbr94 [new Application/Traffic/CBR]
$cbr94 attach-agent $udp94

set cbr96 [new Application/Traffic/CBR]
$cbr96 attach-agent $udp96

set cbr98 [new Application/Traffic/CBR]
$cbr98 attach-agent $udp98

set cbr910 [new Application/Traffic/CBR]
$cbr910 attach-agent $udp910









#start traffic
$ns at 1.0 "$cbr12 start"
$ns at 1.0 "$cbr14 start"
$ns at 1.0 "$cbr16 start"
$ns at 1.0 "$cbr18 start"
$ns at 1.0 "$cbr110 start"
$ns at 1.0 "$cbr32 start"
$ns at 1.0 "$cbr34 start"
$ns at 1.0 "$cbr36 start"
$ns at 1.0 "$cbr38 start"
$ns at 1.0 "$cbr310 start"
$ns at 1.0 "$cbr52 start"
$ns at 1.0 "$cbr54 start"
$ns at 1.0 "$cbr56 start"
$ns at 1.0 "$cbr58 start"
$ns at 1.0 "$cbr510 start"
$ns at 1.0 "$cbr72 start"
$ns at 1.0 "$cbr74 start"
$ns at 1.0 "$cbr76 start"
$ns at 1.0 "$cbr78 start"
$ns at 1.0 "$cbr710 start"
$ns at 1.0 "$cbr92 start"
$ns at 1.0 "$cbr94 start"
$ns at 1.0 "$cbr96 start"
$ns at 1.0 "$cbr98 start"
$ns at 1.0 "$cbr910 start"



$ns at 200.0 "finish"

#procedure to be called at end
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec awk -f t.awk Q210_2048.tr &
    exit 0
}
puts "Simulation starting"
$ns run
