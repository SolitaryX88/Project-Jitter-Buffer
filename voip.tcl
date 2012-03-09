set opt(speed) 		[lindex $argv 0] ;# Simulation Speed
set opt(try) 		[lindex $argv 1] ;# Replication id
set opt(buffer) 	[lindex $argv 2] ;# Buffer type
set opt(codec) 		[lindex $argv 3] ;# Codec used
set opt(voipflows) 	[lindex $argv 4] ;# Number of correlated VoIP flows


set file "outputs/out-S$opt(speed)-T$opt(try)-B$opt(buffer)-C$opt(codec)-V$opt(voipflows).output"

if {[file exists $file] == 1} {
	puts ""
	puts "# # # FILE EXISTS!!! SKIPPING SIMULATION!"
	puts ""
	set skip [open file_skip a]
	puts $skip "skiped: $file"
	close $skip
	exit 0

} else {
	puts "The output file does not exist. Cont. w/ Sim"
	
}

set val(chan)       Channel/WirelessChannel
set val(prop)       Propagation/TwoRayGround
set val(netif)      Phy/WirelessPhy
set val(mac)        Mac/802_11
set val(ifq)        Queue/DropTail/PriQueue
set val(ll)         LL
set val(ant)        Antenna/OmniAntenna
set val(x)              600  
set val(y)              600 
set val(ifqlen)         50 
set val(seed)           5.0
set val(adhocRouting)   AODV
set val(nn)            	70
set val(stop)           4000.0     
set val(cp)           	"./cbr-tcp/nobgt.tcl" ;
set val(sc)            	"../setdest/setdest-m-$opt(speed)-$opt(try).tcl";# 
set val(vip)		"./voip.tcl"
# M A I N

set ns_		[new Simulator]

set topo	[new Topography]
$topo load_flatgrid $val(x) $val(y)

set tracefile	[open "/dev/null" w]
#set namtrace    [open main-out.nam w]
$ns_ trace-all $tracefile
#$ns_ namtrace-all-wireless $namtrace $val(x) $val(y)

# SET G O D
set god_ [create-god $val(nn)]

#  N O D E   Config
$ns_ node-config -adhocRouting $val(adhocRouting) \
                 -llType $val(ll) \
                 -macType $val(mac) \
                 -ifqType $val(ifq) \
                 -ifqLen $val(ifqlen) \
                 -antType $val(ant) \
                 -propType $val(prop) \
                 -phyType $val(netif) \
                 -channelType $val(chan) \
		 -topoInstance $topo \
		 -agentTrace OFF \
                 -routerTrace OFF \
                 -macTrace OFF 


for {set i 0} {$i < $val(nn) } {incr i} {
	set node_($i) [$ns_ node]	
	$node_($i) random-motion 0
	#Xωρίς τυχαία κίνηση
	}
puts "Loading connection pattern..."
source $val(cp)
puts "Loading scenario file..."
source $val(sc)
puts "Loading VoIP Scenario File..."
source $val(vip)

for {set i 0} {$i < $val(nn)} {incr i} {
    $ns_ at $val(stop).0 "$node_($i) reset";
    $ns_ initial_node_pos $node_($i) 20
}
$ns_ initial_node_pos $node_(57) 40
$ns_ initial_node_pos $node_(28) 40 

$ns_ at  $val(stop).0002 "puts \"NS EXITING...\" ; $ns_ halt"


puts $tracefile "M 0.0 nn $val(nn) x $val(x) y $val(y) rp $val(adhocRouting)"

#Uncomment when it's ok...
puts $tracefile "M 0.0 sc $val(sc) cp $val(cp) seed $val(seed)"
puts $tracefile "M 0.0 prop $val(prop) ant $val(ant)"

puts "Starting Simulation..."
$ns_ run

