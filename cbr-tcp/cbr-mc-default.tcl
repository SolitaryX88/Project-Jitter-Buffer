#;
# nodes: 70, max conn: 20, send rate: 0.2, seed: 5
#
#
# 1 connecting to 2 at time 12.781347563854116
#
set udp_(0) [new Agent/UDP]
$ns_ attach-agent $node_(1) $udp_(0)
set null_(0) [new Agent/Null]
$ns_ attach-agent $node_(2) $null_(0)
set cbr_(0) [new Application/Traffic/CBR]
$cbr_(0) set packetSize_ 512
$cbr_(0) set interval_ 0.2
$cbr_(0) set random_ 1
$cbr_(0) set maxpkts_ 10000
$cbr_(0) attach-agent $udp_(0)
$ns_ connect $udp_(0) $null_(0)
$ns_ at 12.781347563854116 "$cbr_(0) start"
#
# 1 connecting to 3 at time 79.30.25719510.289
#
set udp_(1) [new Agent/UDP]
$ns_ attach-agent $node_(1) $udp_(1)
set null_(1) [new Agent/Null]
$ns_ attach-agent $node_(3) $null_(1)
set cbr_(1) [new Application/Traffic/CBR]
$cbr_(1) set packetSize_ 512
$cbr_(1) set interval_ 0.2
$cbr_(1) set random_ 1
$cbr_(1) set maxpkts_ 10000
$cbr_(1) attach-agent $udp_(1)
$ns_ connect $udp_(1) $null_(1)
$ns_ at 79.25719510289 "$cbr_(1) start"
#
# 3 connecting to 4 at time 101.663696502.00406
#
set udp_(2) [new Agent/UDP]
$ns_ attach-agent $node_(3) $udp_(2)
set null_(2) [new Agent/Null]
$ns_ attach-agent $node_(4) $null_(2)
set cbr_(2) [new Application/Traffic/CBR]
$cbr_(2) set packetSize_ 512
$cbr_(2) set interval_ 0.2
$cbr_(2) set random_ 1
$cbr_(2) set maxpkts_ 10000
$cbr_(2) attach-agent $udp_(2)
$ns_ connect $udp_(2) $null_(2)
$ns_ at 101.66369650200406 "$cbr_(2) start"
#
# 3 connecting to 5 at time 14.825599451933801
#
set udp_(3) [new Agent/UDP]
$ns_ attach-agent $node_(3) $udp_(3)
set null_(3) [new Agent/Null]
$ns_ attach-agent $node_(5) $null_(3)
set cbr_(3) [new Application/Traffic/CBR]
$cbr_(3) set packetSize_ 512
$cbr_(3) set interval_ 0.2
$cbr_(3) set random_ 1
$cbr_(3) set maxpkts_ 10000
$cbr_(3) attach-agent $udp_(3)
$ns_ connect $udp_(3) $null_(3)
$ns_ at 14.825599451933801 "$cbr_(3) start"
#
# 6 connecting to 7 at time 32.69118333826362
#
set udp_(4) [new Agent/UDP]
$ns_ attach-agent $node_(6) $udp_(4)
set null_(4) [new Agent/Null]
$ns_ attach-agent $node_(7) $null_(4)
set cbr_(4) [new Application/Traffic/CBR]
$cbr_(4) set packetSize_ 512
$cbr_(4) set interval_ 0.2
$cbr_(4) set random_ 1
$cbr_(4) set maxpkts_ 10000
$cbr_(4) attach-agent $udp_(4)
$ns_ connect $udp_(4) $null_(4)
$ns_ at 32.69118333826362 "$cbr_(4) start"
#
# 7 connecting to 8 at time 38.511305916361188
#
set udp_(5) [new Agent/UDP]
$ns_ attach-agent $node_(7) $udp_(5)
set null_(5) [new Agent/Null]
$ns_ attach-agent $node_(8) $null_(5)
set cbr_(5) [new Application/Traffic/CBR]
$cbr_(5) set packetSize_ 512
$cbr_(5) set interval_ 0.2
$cbr_(5) set random_ 1
$cbr_(5) set maxpkts_ 10000
$cbr_(5) attach-agent $udp_(5)
$ns_ connect $udp_(5) $null_(5)
$ns_ at 38.511305916361188 "$cbr_(5) start"
#
# 7 connecting to 9 at time 36.0599443204980.2
#
set udp_(6) [new Agent/UDP]
$ns_ attach-agent $node_(7) $udp_(6)
set null_(6) [new Agent/Null]
$ns_ attach-agent $node_(9) $null_(6)
set cbr_(6) [new Application/Traffic/CBR]
$cbr_(6) set packetSize_ 512
$cbr_(6) set interval_ 0.2
$cbr_(6) set random_ 1
$cbr_(6) set maxpkts_ 10000
$cbr_(6) attach-agent $udp_(6)
$ns_ connect $udp_(6) $null_(6)
$ns_ at 36.05994432049802 "$cbr_(6) start"
#
# 8 connecting to 9 at time 53.72.0080813866151
#
set udp_(7) [new Agent/UDP]
$ns_ attach-agent $node_(8) $udp_(7)
set null_(7) [new Agent/Null]
$ns_ attach-agent $node_(9) $null_(7)
set cbr_(7) [new Application/Traffic/CBR]
$cbr_(7) set packetSize_ 512
$cbr_(7) set interval_ 0.2
$cbr_(7) set random_ 1
$cbr_(7) set maxpkts_ 10000
$cbr_(7) attach-agent $udp_(7)
$ns_ connect $udp_(7) $null_(7)
$ns_ at 53.720080813866151 "$cbr_(7) start"
#
# 10 connecting to 11 at time 84.7249690.28412
#
set udp_(8) [new Agent/UDP]
$ns_ attach-agent $node_(10) $udp_(8)
set null_(8) [new Agent/Null]
$ns_ attach-agent $node_(11) $null_(8)
set cbr_(8) [new Application/Traffic/CBR]
$cbr_(8) set packetSize_ 512
$cbr_(8) set interval_ 0.2
$cbr_(8) set random_ 1
$cbr_(8) set maxpkts_ 10000
$cbr_(8) attach-agent $udp_(8)
$ns_ connect $udp_(8) $null_(8)
$ns_ at 84.724969028412 "$cbr_(8) start"
#
# 10 connecting to 12 at time 6.3247494428999493
#
set udp_(9) [new Agent/UDP]
$ns_ attach-agent $node_(10) $udp_(9)
set null_(9) [new Agent/Null]
$ns_ attach-agent $node_(12) $null_(9)
set cbr_(9) [new Application/Traffic/CBR]
$cbr_(9) set packetSize_ 512
$cbr_(9) set interval_ 0.2
$cbr_(9) set random_ 1
$cbr_(9) set maxpkts_ 10000
$cbr_(9) attach-agent $udp_(9)
$ns_ connect $udp_(9) $null_(9)
$ns_ at 6.3247494428999493 "$cbr_(9) start"
#
# 11 connecting to 12 at time 52.27820494783959
#
set udp_(10) [new Agent/UDP]
$ns_ attach-agent $node_(11) $udp_(10)
set null_(10) [new Agent/Null]
$ns_ attach-agent $node_(12) $null_(10)
set cbr_(10) [new Application/Traffic/CBR]
$cbr_(10) set packetSize_ 512
$cbr_(10) set interval_ 0.2
$cbr_(10) set random_ 1
$cbr_(10) set maxpkts_ 10000
$cbr_(10) attach-agent $udp_(10)
$ns_ connect $udp_(10) $null_(10)
$ns_ at 52.27820494783959 "$cbr_(10) start"
#
# 13 connecting to 14 at time 59.50434283330307
#
set udp_(11) [new Agent/UDP]
$ns_ attach-agent $node_(13) $udp_(11)
set null_(11) [new Agent/Null]
$ns_ attach-agent $node_(14) $null_(11)
set cbr_(11) [new Application/Traffic/CBR]
$cbr_(11) set packetSize_ 512
$cbr_(11) set interval_ 0.2
$cbr_(11) set random_ 1
$cbr_(11) set maxpkts_ 10000
$cbr_(11) attach-agent $udp_(11)
$ns_ connect $udp_(11) $null_(11)
$ns_ at 59.50434283330307 "$cbr_(11) start"
#
# 21 connecting to 22 at time 94.4480.2310535771
#
set udp_(12) [new Agent/UDP]
$ns_ attach-agent $node_(21) $udp_(12)
set null_(12) [new Agent/Null]
$ns_ attach-agent $node_(22) $null_(12)
set cbr_(12) [new Application/Traffic/CBR]
$cbr_(12) set packetSize_ 512
$cbr_(12) set interval_ 0.2
$cbr_(12) set random_ 1
$cbr_(12) set maxpkts_ 10000
$cbr_(12) attach-agent $udp_(12)
$ns_ connect $udp_(12) $null_(12)
$ns_ at 94.44802310535771 "$cbr_(12) start"
#
# 21 connecting to 23 at time 4.9633734696374159
#
set udp_(13) [new Agent/UDP]
$ns_ attach-agent $node_(21) $udp_(13)
set null_(13) [new Agent/Null]
$ns_ attach-agent $node_(23) $null_(13)
set cbr_(13) [new Application/Traffic/CBR]
$cbr_(13) set packetSize_ 512
$cbr_(13) set interval_ 0.2
$cbr_(13) set random_ 1
$cbr_(13) set maxpkts_ 10000
$cbr_(13) attach-agent $udp_(13)
$ns_ connect $udp_(13) $null_(13)
$ns_ at 4.9633734696374159 "$cbr_(13) start"
#
# 22 connecting to 23 at time 3.7867753784110.22
#
set udp_(14) [new Agent/UDP]
$ns_ attach-agent $node_(22) $udp_(14)
set null_(14) [new Agent/Null]
$ns_ attach-agent $node_(23) $null_(14)
set cbr_(14) [new Application/Traffic/CBR]
$cbr_(14) set packetSize_ 512
$cbr_(14) set interval_ 0.2
$cbr_(14) set random_ 1
$cbr_(14) set maxpkts_ 10000
$cbr_(14) attach-agent $udp_(14)
$ns_ connect $udp_(14) $null_(14)
$ns_ at 3.786775378411022 "$cbr_(14) start"
#
# 23 connecting to 24 at time 78.699191621830309
#
set udp_(15) [new Agent/UDP]
$ns_ attach-agent $node_(23) $udp_(15)
set null_(15) [new Agent/Null]
$ns_ attach-agent $node_(24) $null_(15)
set cbr_(15) [new Application/Traffic/CBR]
$cbr_(15) set packetSize_ 512
$cbr_(15) set interval_ 0.2
$cbr_(15) set random_ 1
$cbr_(15) set maxpkts_ 10000
$cbr_(15) attach-agent $udp_(15)
$ns_ connect $udp_(15) $null_(15)
$ns_ at 78.699191621830309 "$cbr_(15) start"
#
# 23 connecting to 25 at time 131.6346621660677
#
set udp_(16) [new Agent/UDP]
$ns_ attach-agent $node_(23) $udp_(16)
set null_(16) [new Agent/Null]
$ns_ attach-agent $node_(25) $null_(16)
set cbr_(16) [new Application/Traffic/CBR]
$cbr_(16) set packetSize_ 512
$cbr_(16) set interval_ 0.2
$cbr_(16) set random_ 1
$cbr_(16) set maxpkts_ 10000
$cbr_(16) attach-agent $udp_(16)
$ns_ connect $udp_(16) $null_(16)
$ns_ at 131.6346621660677 "$cbr_(16) start"
#
# 25 connecting to 26 at time 52.2.0046671073905
#
set udp_(17) [new Agent/UDP]
$ns_ attach-agent $node_(25) $udp_(17)
set null_(17) [new Agent/Null]
$ns_ attach-agent $node_(26) $null_(17)
set cbr_(17) [new Application/Traffic/CBR]
$cbr_(17) set packetSize_ 512
$cbr_(17) set interval_ 0.2
$cbr_(17) set random_ 1
$cbr_(17) set maxpkts_ 10000
$cbr_(17) attach-agent $udp_(17)
$ns_ connect $udp_(17) $null_(17)
$ns_ at 52.20046671073905 "$cbr_(17) start"
#
# 27 connecting to 28 at time 122.09458465785467
#
set udp_(18) [new Agent/UDP]
$ns_ attach-agent $node_(27) $udp_(18)
set null_(18) [new Agent/Null]
$ns_ attach-agent $node_(38) $null_(18)
set cbr_(18) [new Application/Traffic/CBR]
$cbr_(18) set packetSize_ 512
$cbr_(18) set interval_ 0.2
$cbr_(18) set random_ 1
$cbr_(18) set maxpkts_ 10000
$cbr_(18) attach-agent $udp_(18)
$ns_ connect $udp_(18) $null_(18)
$ns_ at 122.09458465785467 "$cbr_(18) start"
#
# 27 connecting to 29 at time 110.79029925670022
#
set udp_(19) [new Agent/UDP]
$ns_ attach-agent $node_(27) $udp_(19)
set null_(19) [new Agent/Null]
$ns_ attach-agent $node_(29) $null_(19)
set cbr_(19) [new Application/Traffic/CBR]
$cbr_(19) set packetSize_ 512
$cbr_(19) set interval_ 0.2
$cbr_(19) set random_ 1
$cbr_(19) set maxpkts_ 10000
$cbr_(19) attach-agent $udp_(19)
$ns_ connect $udp_(19) $null_(19)
$ns_ at 110.79029925670022 "$cbr_(19) start"
#
#Total sources/connections: 13/20
#
