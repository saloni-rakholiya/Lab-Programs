#setting durations values
set duration 100;
set val(intervalVal) 0.02;
set val(packetSizeVal) 16; 

#setting node params
#setting channel Type
set val(chan)           Channel/WirelessChannel;
#setting radio-propagation model
set val(prop)           Propagation/TwoRayGround;
#setting network interface type
set val(netif)          Phy/WirelessPhy;
# MAC option
set val(mac)            Mac/RandomMacNew;
# interface queue type
set val(ifq)            Queue/DropTail/PriQueue;
# type of link layer
set val(ll)             LL;
# setting antenna model
set val(ant)            Antenna/OmniAntenna;
# max packet in ifq
set val(ifqlen)         50;

#setting routing protocol
set val(rp)              DumbAgent;

#setting params
Mac/RandomMacNew set numRetransmit [lindex $argv 0];
Mac/RandomMacNew set intervalDuration 0.02;
Mac/RandomMacNew set fullduplex_mode_ 0;

#starting simulation
set ns [new Simulator]
set tracefd [open randommac.tr w]
$ns trace-all $tracefd

#tracing everything in trace file
set namtrace [open random-mac.nam w]
$ns  namtrace-all-wireless $namtrace 50 50

set topo       [new Topography]
$topo load_flatgrid         50 50

create-god 26
#file for node config
$ns node-config \
                   -adhocRouting $val(rp) \
                   -llType $val(ll) \
                   -macType $val(mac) \
                   -ifqType $val(ifq) \
                   -ifqLen $val(ifqlen) \
                   -antType $val(ant) \
                   -propType $val(prop) \
                   -phyType $val(netif) \
                   -topoInstance $topo \
                   -channel [new $val(chan)] \
                   -agentTrace ON \
                   -routerTrace ON \
                   -macTrace ON \
                   -movementTrace OFF

#creating the node positions
#random number generator
set random_number_generator [new RNG]
$random_number_generator seed 0

set randomX [new RandomVariable/Uniform]
$randomX use-rng $random_number_generator
$randomX set min_ 0
$randomX set max_ 50

set randomY [new RandomVariable/Uniform]
$randomY use-rng $random_number_generator
$randomY set min_ 0
$randomY set max_ 50

set randomTime [new RandomVariable/Uniform]
$randomTime use-rng $random_number_generator
$randomTime set min_ 0
$randomTime set max_ 0.02

#make sink and connect to sink
set sinkNode [$ns node]
$sinkNode random-motion 0
$sinkNode set X_ 25
$sinkNode set Y_ 25
$sinkNode set Z_ 0
$ns initial_node_pos $sinkNode 3
#attach agent to sink
set null0 [new Agent/Null] 
$ns attach-agent $sinkNode $null0

for {set i 0} {$i < 25} {incr i} {
        #setting random values and node vals
	set node($i) [$ns node]
	set random1 [$randomX value]
	set random2 [$randomY value]
	$node($i) set X_ $random1
	$node($i) set Y_ $random2
	$node($i) set Z_ 0
	$ns initial_node_pos $node($i) 1

        #creating agents
	set udp($i) [new Agent/UDP]
        $udp($i) set class_ $i
	$ns attach-agent $node($i) $udp($i)

	#connect agents
	$ns connect $udp($i) $null0

        #create traffic
	set cbr($i) [new Application/Traffic/CBR]
	$cbr($i) set packetSize_ $val(packetSizeVal)
	$cbr($i) set interval_ $val(intervalVal)
	$cbr($i) attach-agent $udp($i)
        #starting n stopping traffic
	set time1 $randomTime
	$ns at $time1 "$cbr($i) start"
	$ns at $duration "$cbr($i) stop"

}

#procedure for finish
proc finish {} {
        #creating trace files output
        global ns tracefd namtrace
        $ns flush-trace
        close $namtrace
        close $tracefd
        exit 0
}

#finish simulation
$ns at 100.5 "finish"
#Simulating using random mac
puts "Starting simulation with random mac"
$ns run

