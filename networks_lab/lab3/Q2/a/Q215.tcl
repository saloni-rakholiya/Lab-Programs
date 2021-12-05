#create a simulator object
set ns [new Simulator]

$ns color 1 Black
$ns color 2 Green
$ns color 3 Red
$ns color 4 Orange
$ns color 5 Yellow
$ns color 6 Violet
$ns color 7 Brown
$ns color 8 Blue


#create a trace file, file is for logging purpose
set tracefile [open Q215.tr w]
$ns trace-all $tracefile

#create animation information / nam file
set namfile [open Q215.nam w]
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
set n11 [$ns node]
set n12 [$ns node]
set n13 [$ns node]
set n14 [$ns node]
set n15 [$ns node]


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
$ns duplex-link $n1 $n11 1Mb 1ms DropTail
$ns duplex-link $n1 $n12 1Mb 1ms DropTail
$ns duplex-link $n1 $n13 1Mb 1ms DropTail
$ns duplex-link $n1 $n14 1Mb 1ms DropTail
$ns duplex-link $n1 $n15 1Mb 1ms DropTail

#creation of link between node 2 and other nodes with DropTail Queue
$ns duplex-link $n2 $n3 1Mb 1ms DropTail
$ns duplex-link $n2 $n4 1Mb 1ms DropTail
$ns duplex-link $n2 $n5 1Mb 1ms DropTail
$ns duplex-link $n2 $n6 1Mb 1ms DropTail
$ns duplex-link $n2 $n7 1Mb 1ms DropTail
$ns duplex-link $n2 $n8 1Mb 1ms DropTail
$ns duplex-link $n2 $n9 1Mb 1ms DropTail
$ns duplex-link $n2 $n10 1Mb 1ms DropTail
$ns duplex-link $n2 $n11 1Mb 1ms DropTail
$ns duplex-link $n2 $n12 1Mb 1ms DropTail
$ns duplex-link $n2 $n13 1Mb 1ms DropTail
$ns duplex-link $n2 $n14 1Mb 1ms DropTail
$ns duplex-link $n2 $n15 1Mb 1ms DropTail

#creation of link between node 3 and other nodes with DropTail Queue
$ns duplex-link $n3 $n4 1Mb 1ms DropTail
$ns duplex-link $n3 $n5 1Mb 1ms DropTail
$ns duplex-link $n3 $n6 1Mb 1ms DropTail
$ns duplex-link $n3 $n7 1Mb 1ms DropTail
$ns duplex-link $n3 $n8 1Mb 1ms DropTail
$ns duplex-link $n3 $n9 1Mb 1ms DropTail
$ns duplex-link $n3 $n10 1Mb 1ms DropTail
$ns duplex-link $n3 $n11 1Mb 1ms DropTail
$ns duplex-link $n3 $n12 1Mb 1ms DropTail
$ns duplex-link $n3 $n13 1Mb 1ms DropTail
$ns duplex-link $n3 $n14 1Mb 1ms DropTail
$ns duplex-link $n3 $n15 1Mb 1ms DropTail

#creation of link between node 4 and other nodes with DropTail Queue
$ns duplex-link $n4 $n5 1Mb 1ms DropTail
$ns duplex-link $n4 $n6 1Mb 1ms DropTail
$ns duplex-link $n4 $n7 1Mb 1ms DropTail
$ns duplex-link $n4 $n8 1Mb 1ms DropTail
$ns duplex-link $n4 $n9 1Mb 1ms DropTail
$ns duplex-link $n4 $n10 1Mb 1ms DropTail
$ns duplex-link $n4 $n11 1Mb 1ms DropTail
$ns duplex-link $n4 $n12 1Mb 1ms DropTail
$ns duplex-link $n4 $n13 1Mb 1ms DropTail
$ns duplex-link $n4 $n14 1Mb 1ms DropTail
$ns duplex-link $n4 $n15 1Mb 1ms DropTail


#creation of link between node 5 and other nodes with DropTail Queue
$ns duplex-link $n5 $n6 1Mb 1ms DropTail
$ns duplex-link $n5 $n7 1Mb 1ms DropTail
$ns duplex-link $n5 $n8 1Mb 1ms DropTail
$ns duplex-link $n5 $n9 1Mb 1ms DropTail
$ns duplex-link $n5 $n10 1Mb 1ms DropTail
$ns duplex-link $n5 $n11 1Mb 1ms DropTail
$ns duplex-link $n5 $n12 1Mb 1ms DropTail
$ns duplex-link $n5 $n13 1Mb 1ms DropTail
$ns duplex-link $n5 $n14 1Mb 1ms DropTail
$ns duplex-link $n5 $n15 1Mb 1ms DropTail


#creation of link between node 6 and other nodes with DropTail Queue
$ns duplex-link $n6 $n7 1Mb 1ms DropTail
$ns duplex-link $n6 $n8 1Mb 1ms DropTail
$ns duplex-link $n6 $n9 1Mb 1ms DropTail
$ns duplex-link $n6 $n10 1Mb 1ms DropTail
$ns duplex-link $n6 $n11 1Mb 1ms DropTail
$ns duplex-link $n6 $n12 1Mb 1ms DropTail
$ns duplex-link $n6 $n13 1Mb 1ms DropTail
$ns duplex-link $n6 $n14 1Mb 1ms DropTail
$ns duplex-link $n6 $n15 1Mb 1ms DropTail


#creation of link between node 7 and other nodes with DropTail Queue
$ns duplex-link $n7 $n8 1Mb 1ms DropTail
$ns duplex-link $n7 $n9 1Mb 1ms DropTail
$ns duplex-link $n7 $n10 1Mb 1ms DropTail
$ns duplex-link $n7 $n11 1Mb 1ms DropTail
$ns duplex-link $n7 $n12 1Mb 1ms DropTail
$ns duplex-link $n7 $n13 1Mb 1ms DropTail
$ns duplex-link $n7 $n14 1Mb 1ms DropTail
$ns duplex-link $n7 $n15 1Mb 1ms DropTail

#creation of link between node 8 and other nodes with DropTail Queue
$ns duplex-link $n8 $n9 1Mb 1ms DropTail
$ns duplex-link $n8 $n10 1Mb 1ms DropTail
$ns duplex-link $n8 $n11 1Mb 1ms DropTail
$ns duplex-link $n8 $n12 1Mb 1ms DropTail
$ns duplex-link $n8 $n13 1Mb 1ms DropTail
$ns duplex-link $n8 $n14 1Mb 1ms DropTail
$ns duplex-link $n8 $n15 1Mb 1ms DropTail

#creation of link between node 9 and other nodes with DropTail Queue
$ns duplex-link $n9 $n10 1Mb 1ms DropTail
$ns duplex-link $n9 $n11 1Mb 1ms DropTail
$ns duplex-link $n9 $n12 1Mb 1ms DropTail
$ns duplex-link $n9 $n13 1Mb 1ms DropTail
$ns duplex-link $n9 $n14 1Mb 1ms DropTail
$ns duplex-link $n9 $n15 1Mb 1ms DropTail

#creation of link between node 10 and other nodes with DropTail Queue
$ns duplex-link $n10 $n11 1Mb 1ms DropTail
$ns duplex-link $n10 $n12 1Mb 1ms DropTail
$ns duplex-link $n10 $n13 1Mb 1ms DropTail
$ns duplex-link $n10 $n14 1Mb 1ms DropTail
$ns duplex-link $n10 $n15 1Mb 1ms DropTail

#creation of link between node 11 and other nodes with DropTail Queue
$ns duplex-link $n11 $n12 1Mb 1ms DropTail
$ns duplex-link $n11 $n13 1Mb 1ms DropTail
$ns duplex-link $n11 $n14 1Mb 1ms DropTail
$ns duplex-link $n11 $n15 1Mb 1ms DropTail

#creation of link between node 12 and other nodes with DropTail Queue
$ns duplex-link $n12 $n13 1Mb 1ms DropTail
$ns duplex-link $n12 $n14 1Mb 1ms DropTail
$ns duplex-link $n12 $n15 1Mb 1ms DropTail

#creation of link between node 13 and other nodes with DropTail Queue
$ns duplex-link $n13 $n14 1Mb 1ms DropTail
$ns duplex-link $n13 $n15 1Mb 1ms DropTail

#creation of link between node 14 and other nodes with DropTail Queue
$ns duplex-link $n14 $n15 1Mb 1ms DropTail

set packet 512

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

#creation of Agent between node 1 and node 12
set udp112 [new Agent/UDP]
set null112 [new Agent/Null]
$udp112 set packetSize_ $packet
$ns attach-agent $n1 $udp112
$ns attach-agent $n12 $null112
$ns connect $udp112 $null112
$udp112 set fid_ 1

#creation of Agent between node 1 and node 14
set udp114 [new Agent/UDP]
set null114 [new Agent/Null]
$udp114 set packetSize_ $packet
$ns attach-agent $n1 $udp114
$ns attach-agent $n14 $null114
$ns connect $udp114 $null114
$udp114 set fid_ 1

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

#creation of Agent between node 3 and node 12
set udp312 [new Agent/UDP]
set null312 [new Agent/Null]
$udp312 set packetSize_ $packet
$ns attach-agent $n3 $udp312
$ns attach-agent $n12 $null312
$ns connect $udp312 $null312
$udp312 set fid_ 2

#creation of Agent between node 3 and node 14
set udp314 [new Agent/UDP]
set null314 [new Agent/Null]
$udp314 set packetSize_ $packet
$ns attach-agent $n3 $udp314
$ns attach-agent $n14 $null314
$ns connect $udp314 $null314
$udp314 set fid_ 2

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

#creation of Agent between node 5 and node 12
set udp512 [new Agent/UDP]
set null512 [new Agent/Null]
$udp512 set packetSize_ $packet
$ns attach-agent $n5 $udp512
$ns attach-agent $n12 $null512
$ns connect $udp512 $null512
$udp512 set fid_ 3

#creation of Agent between node 5 and node 14
set udp514 [new Agent/UDP]
set null514 [new Agent/Null]
$udp514 set packetSize_ $packet
$ns attach-agent $n5 $udp514
$ns attach-agent $n14 $null514
$ns connect $udp514 $null514
$udp514 set fid_ 3

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

#creation of Agent between node 7 and node 12
set udp712 [new Agent/UDP]
set null712 [new Agent/Null]
$udp712 set packetSize_ $packet
$ns attach-agent $n7 $udp712
$ns attach-agent $n12 $null712
$ns connect $udp712 $null712
$udp712 set fid_ 4

#creation of Agent between node 7 and node 14
set udp714 [new Agent/UDP]
set null714 [new Agent/Null]
$udp714 set packetSize_ $packet
$ns attach-agent $n7 $udp714
$ns attach-agent $n14 $null714
$ns connect $udp714 $null714
$udp714 set fid_ 4

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

#creation of Agent between node 9 and node 12
set udp912 [new Agent/UDP]
set null912 [new Agent/Null]
$udp912 set packetSize_ $packet
$ns attach-agent $n9 $udp912
$ns attach-agent $n12 $null912
$ns connect $udp912 $null912
$udp912 set fid_ 5

#creation of Agent between node 9 and node 14
set udp914 [new Agent/UDP]
set null914 [new Agent/Null]
$udp914 set packetSize_ $packet
$ns attach-agent $n9 $udp914
$ns attach-agent $n14 $null914
$ns connect $udp914 $null914
$udp914 set fid_ 5

#creation of Agent between node 11 and node 2
set udp112 [new Agent/UDP]
set null112 [new Agent/Null]
$udp112 set packetSize_ $packet
$ns attach-agent $n11 $udp112
$ns attach-agent $n2 $null112
$ns connect $udp112 $null112
$udp112 set fid_ 6

#creation of Agent between node 11 and node 4
set udp114 [new Agent/UDP]
set null114 [new Agent/Null]
$udp114 set packetSize_ $packet
$ns attach-agent $n11 $udp114
$ns attach-agent $n4 $null114
$ns connect $udp114 $null114
$udp114 set fid_ 6

#creation of Agent between node 11 and node 6
set udp116 [new Agent/UDP]
set null116 [new Agent/Null]
$udp116 set packetSize_ $packet
$ns attach-agent $n11 $udp116
$ns attach-agent $n6 $null116
$ns connect $udp116 $null116
$udp116 set fid_ 6

#creation of Agent between node 11 and node 8
set udp118 [new Agent/UDP]
set null118 [new Agent/Null]
$udp118 set packetSize_ $packet
$ns attach-agent $n11 $udp118
$ns attach-agent $n8 $null118
$ns connect $udp118 $null118
$udp118 set fid_ 6

#creation of Agent between node 11 and node 10
set udp1110 [new Agent/UDP]
set null1110 [new Agent/Null]
$udp1110 set packetSize_ $packet
$ns attach-agent $n11 $udp1110
$ns attach-agent $n10 $null1110
$ns connect $udp1110 $null1110
$udp1110 set fid_ 6

#creation of Agent between node 11 and node 12
set udp1112 [new Agent/UDP]
set null1112 [new Agent/Null]
$udp1112 set packetSize_ $packet
$ns attach-agent $n11 $udp1112
$ns attach-agent $n12 $null1112
$ns connect $udp1112 $null1112
$udp1112 set fid_ 6

#creation of Agent between node 11 and node 14
set udp1114 [new Agent/UDP]
set null1114 [new Agent/Null]
$udp1114 set packetSize_ $packet
$ns attach-agent $n11 $udp1114
$ns attach-agent $n14 $null1114
$ns connect $udp1114 $null1114
$udp1114 set fid_ 6


#creation of Agent between node 13 and node 2
set udp132 [new Agent/UDP]
set null132 [new Agent/Null]
$udp132 set packetSize_ $packet
$ns attach-agent $n13 $udp132
$ns attach-agent $n2 $null132
$ns connect $udp132 $null132
$udp132 set fid_ 7

#creation of Agent between node 13 and node 4
set udp134 [new Agent/UDP]
set null134 [new Agent/Null]
$udp134 set packetSize_ $packet
$ns attach-agent $n13 $udp134
$ns attach-agent $n4 $null134
$ns connect $udp134 $null134
$udp134 set fid_ 7

#creation of Agent between node 13 and node 6
set udp136 [new Agent/UDP]
set null136 [new Agent/Null]
$udp136 set packetSize_ $packet
$ns attach-agent $n13 $udp136
$ns attach-agent $n6 $null136
$ns connect $udp136 $null136
$udp136 set fid_ 7

#creation of Agent between node 13 and node 8
set udp138 [new Agent/UDP]
set null138 [new Agent/Null]
$udp138 set packetSize_ $packet
$ns attach-agent $n13 $udp138
$ns attach-agent $n8 $null138
$ns connect $udp138 $null138
$udp138 set fid_ 7

#creation of Agent between node 13 and node 10
set udp1310 [new Agent/UDP]
set null1310 [new Agent/Null]
$udp1310 set packetSize_ $packet
$ns attach-agent $n13 $udp1310
$ns attach-agent $n10 $null1310
$ns connect $udp1310 $null1310
$udp1310 set fid_ 7

#creation of Agent between node 13 and node 12
set udp1312 [new Agent/UDP]
set null1312 [new Agent/Null]
$udp1312 set packetSize_ $packet
$ns attach-agent $n13 $udp1312
$ns attach-agent $n12 $null1312
$ns connect $udp1312 $null1312
$udp1312 set fid_ 7

#creation of Agent between node 13 and node 14
set udp1314 [new Agent/UDP]
set null1314 [new Agent/Null]
$udp1314 set packetSize_ $packet
$ns attach-agent $n13 $udp1314
$ns attach-agent $n14 $null1314
$ns connect $udp1314 $null1314
$udp1314 set fid_ 7


#creation of Agent between node 15 and node 2
set udp152 [new Agent/UDP]
set null152 [new Agent/Null]
$udp152 set packetSize_ $packet
$ns attach-agent $n15 $udp152
$ns attach-agent $n2 $null152
$ns connect $udp152 $null152
$udp152 set fid_ 8

#creation of Agent between node 15 and node 4
set udp154 [new Agent/UDP]
set null154 [new Agent/Null]
$udp154 set packetSize_ $packet
$ns attach-agent $n15 $udp154
$ns attach-agent $n4 $null154
$ns connect $udp154 $null154
$udp154 set fid_ 8

#creation of Agent between node 15 and node 6
set udp156 [new Agent/UDP]
set null156 [new Agent/Null]
$udp156 set packetSize_ $packet
$ns attach-agent $n15 $udp156
$ns attach-agent $n6 $null156
$ns connect $udp156 $null156
$udp156 set fid_ 8

#creation of Agent between node 15 and node 8
set udp158 [new Agent/UDP]
set null158 [new Agent/Null]
$udp158 set packetSize_ $packet
$ns attach-agent $n15 $udp158
$ns attach-agent $n8 $null158
$ns connect $udp158 $null158
$udp158 set fid_ 8

#creation of Agent between node 15 and node 10
set udp1510 [new Agent/UDP]
set null1510 [new Agent/Null]
$udp1510 set packetSize_ $packet
$ns attach-agent $n15 $udp1510
$ns attach-agent $n10 $null1510
$ns connect $udp1510 $null1510
$udp1510 set fid_ 8

#creation of Agent between node 15 and node 12
set udp1512 [new Agent/UDP]
set null1512 [new Agent/Null]
$udp1512 set packetSize_ $packet
$ns attach-agent $n15 $udp1512
$ns attach-agent $n12 $null1512
$ns connect $udp1512 $null1512
$udp1512 set fid_ 8

#creation of Agent between node 15 and node 14
set udp1514 [new Agent/UDP]
set null1514 [new Agent/Null]
$udp1514 set packetSize_ $packet
$ns attach-agent $n15 $udp1514
$ns attach-agent $n14 $null1514
$ns connect $udp1514 $null1514
$udp1514 set fid_ 8

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

set cbr112 [new Application/Traffic/CBR]
$cbr112 attach-agent $udp112

set cbr114 [new Application/Traffic/CBR]
$cbr114 attach-agent $udp114

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

set cbr312 [new Application/Traffic/CBR]
$cbr312 attach-agent $udp312

set cbr314 [new Application/Traffic/CBR]
$cbr314 attach-agent $udp314

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

set cbr512 [new Application/Traffic/CBR]
$cbr512 attach-agent $udp512

set cbr514 [new Application/Traffic/CBR]
$cbr514 attach-agent $udp514

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

set cbr712 [new Application/Traffic/CBR]
$cbr712 attach-agent $udp712


set cbr714 [new Application/Traffic/CBR]
$cbr714 attach-agent $udp714


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

set cbr912 [new Application/Traffic/CBR]
$cbr912 attach-agent $udp912

set cbr914 [new Application/Traffic/CBR]
$cbr914 attach-agent $udp914


#
set cbr112 [new Application/Traffic/CBR]
$cbr112 attach-agent $udp112

set cbr114 [new Application/Traffic/CBR]
$cbr114 attach-agent $udp114

set cbr116 [new Application/Traffic/CBR]
$cbr116 attach-agent $udp116

set cbr118 [new Application/Traffic/CBR]
$cbr118 attach-agent $udp118

set cbr1110 [new Application/Traffic/CBR]
$cbr1110 attach-agent $udp1110

set cbr1112 [new Application/Traffic/CBR]
$cbr1112 attach-agent $udp1112

set cbr1114 [new Application/Traffic/CBR]
$cbr1114 attach-agent $udp1114
#

#
set cbr132 [new Application/Traffic/CBR]
$cbr132 attach-agent $udp132

set cbr134 [new Application/Traffic/CBR]
$cbr134 attach-agent $udp134

set cbr136 [new Application/Traffic/CBR]
$cbr136 attach-agent $udp136

set cbr138 [new Application/Traffic/CBR]
$cbr138 attach-agent $udp138

set cbr1310 [new Application/Traffic/CBR]
$cbr1310 attach-agent $udp1310

set cbr1312 [new Application/Traffic/CBR]
$cbr1312 attach-agent $udp1312

set cbr1314 [new Application/Traffic/CBR]
$cbr1314 attach-agent $udp1314
#

#
set cbr152 [new Application/Traffic/CBR]
$cbr152 attach-agent $udp152

set cbr154 [new Application/Traffic/CBR]
$cbr154 attach-agent $udp154

set cbr156 [new Application/Traffic/CBR]
$cbr156 attach-agent $udp156

set cbr158 [new Application/Traffic/CBR]
$cbr158 attach-agent $udp158

set cbr1510 [new Application/Traffic/CBR]
$cbr1510 attach-agent $udp1510

set cbr1512 [new Application/Traffic/CBR]
$cbr1512 attach-agent $udp1512

set cbr1514 [new Application/Traffic/CBR]
$cbr1514 attach-agent $udp1514
#



#start traffic
$ns at 1.0 "$cbr12 start"
$ns at 1.0 "$cbr14 start"
$ns at 1.0 "$cbr16 start"
$ns at 1.0 "$cbr18 start"
$ns at 1.0 "$cbr110 start"
$ns at 1.0 "$cbr112 start"
$ns at 1.0 "$cbr114 start"
$ns at 1.0 "$cbr32 start"
$ns at 1.0 "$cbr34 start"
$ns at 1.0 "$cbr36 start"
$ns at 1.0 "$cbr38 start"
$ns at 1.0 "$cbr310 start"
$ns at 1.0 "$cbr312 start"
$ns at 1.0 "$cbr314 start"
$ns at 1.0 "$cbr52 start"
$ns at 1.0 "$cbr54 start"
$ns at 1.0 "$cbr56 start"
$ns at 1.0 "$cbr58 start"
$ns at 1.0 "$cbr510 start"
$ns at 1.0 "$cbr512 start"
$ns at 1.0 "$cbr514 start"
$ns at 1.0 "$cbr72 start"
$ns at 1.0 "$cbr74 start"
$ns at 1.0 "$cbr76 start"
$ns at 1.0 "$cbr78 start"
$ns at 1.0 "$cbr710 start"
$ns at 1.0 "$cbr712 start"
$ns at 1.0 "$cbr714 start"
$ns at 1.0 "$cbr92 start"
$ns at 1.0 "$cbr94 start"
$ns at 1.0 "$cbr96 start"
$ns at 1.0 "$cbr98 start"
$ns at 1.0 "$cbr910 start"
$ns at 1.0 "$cbr912 start"
$ns at 1.0 "$cbr914 start"
$ns at 1.0 "$cbr112 start"
$ns at 1.0 "$cbr114 start"
$ns at 1.0 "$cbr116 start"
$ns at 1.0 "$cbr118 start"
$ns at 1.0 "$cbr1110 start"
$ns at 1.0 "$cbr1112 start"
$ns at 1.0 "$cbr1114 start"
$ns at 1.0 "$cbr132 start"
$ns at 1.0 "$cbr134 start"
$ns at 1.0 "$cbr136 start"
$ns at 1.0 "$cbr138 start"
$ns at 1.0 "$cbr1310 start"
$ns at 1.0 "$cbr1312 start"
$ns at 1.0 "$cbr1314 start"
$ns at 1.0 "$cbr152 start"
$ns at 1.0 "$cbr154 start"
$ns at 1.0 "$cbr156 start"
$ns at 1.0 "$cbr158 start"
$ns at 1.0 "$cbr1510 start"
$ns at 1.0 "$cbr1512 start"
$ns at 1.0 "$cbr1514 start"



$ns at 200.0 "finish"

#procedure to be called at end
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec awk -f t.awk Q215.tr &
    exit 0
}
puts "Simulation starting"
$ns run