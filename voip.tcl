# vim: syntax=tcl
#
# The following TCL Script is a modification of the original TCL example script of the ns2VoIP++ patch.
##############################################################################
##                       VOIP CONFIGURATION OF PARAMETERS                   ##
##############################################################################


#
# Simulation environment
#
set opt(run)        0         ;# replic ID
set opt(duration)   $val(stop)     ;# run duration, in seconds
set opt(warm)       10.0       ;# run duration, in seconds
set opt(out)        "$file"     ;# statistics output file
set opt(debug)      "debug"   ;# debug configuration file, "" = no debug
set opt(startdebug) 100.0     ;# start time of debug output


#
# e2et Configuration
#
set opt(e2et-delay)          off      ;# If "on" let e2et to add delay
set opt(e2et-delay-dir)      both       ;# Direction for which e2et adds delay
set opt(e2et-delay-dst)      uniform  ;# Dst used to add delay
set opt(e2et-delay-mean)     0.080      ;# Mean of dst
set opt(e2et-delay-devstd)   0.050      ;# Standard Deviation of dst
set opt(e2et-delay-min)      0.000      ;# Min of dst
set opt(e2et-delay-max)      0.120      ;# Max of dst
set opt(e2et-delay-b)        0.005      ;# B factor of laplacin distribution
set opt(e2et-delay-reorder)  true       ;# If false avoid pkt reordering
set opt(e2et-per)            0.0        ;# Add Packet Error Rate
#
# VoIP configuration
#

set opt(voip-bidirectional) 	     "on"        ;# VoIP bidirectional enable switch <on|off>
set opt(voip-debug)		     "nodebug"	  ;# VoIP debug options - "debug" or "nodebug"
set opt(voip-model)                  one-to-one   ;# VoIP VAD model
set opt(voip-exponential-talk)       1            ;# Average talkspurt period duration, in sec, with exponential VAD model
set opt(voip-exponential-silence)    1.5          ;# Average silence period duration, in sec, with exponential VAD model
set opt(voip-codec)                  $opt(codec)	;#G.723.1;# VoIP codec
set opt(voip-comp-hdr-size)          3            ;# header size, in bytes
set opt(voip-aggr)                   2            ;# number of frames per packet
set opt(voip-mos-threshold)          3.0 ;#3.0         ;# to detect 'good' talkspurt
set opt(voip-cell-mos-threshold)     0.75         ;# to measure cell satisfation
set opt(voip-cell-loss-threshold)    0.02         ;# to measure cell outage
set opt(voip-decoder-chain)          $opt(buffer) ;# decoders

# H323 configuration
set opt(voip-decoder-min-jitter)     0.020        ;# H323 dejitter min jitter time (s)
set opt(voip-decoder-max-jitter)     0.100	  ;# H323 dejitter max jitter time (s)
#####################################################################################
# Custom parameters for the Unidirectional VoIP model.
# They are meaningful only if voip-model is set to weibull-custom.
set opt(voip-talk-scale)      0.4122
set opt(voip-talk-shape)      0.824
set opt(voip-silence-scale)   0.899 
set opt(voip-silence-shape)   1.089


# static decoder parameters
set opt(static-buffer)  20
set opt(static-delay)   0.08

##############################################################################
#                       DEFINITION OF PROCEDURES                             #
##############################################################################

#
# parse command-line options and store values into the $opt(.) hash
#

#
# print out options
#
proc printopt { } {
        global opt

        foreach x [lsort [array names opt]] {
                puts "$x = $opt($x)"
        }
}

#
# die function
#
proc die { x } {
        puts $x
        exit 1
}

#
# alive function
#
proc alive { } {
        global ns_ opt

        if { [$ns_ now] != 0 } {
                puts -nonewline \
                 [format "elapsed %.0f s (remaining %.0f s) completed %.f%%" \
                 [$ns_ now] \
                 [expr $opt(duration) - [$ns_ now]] \
                 [expr 100 * [$ns_ now] / $opt(duration)]]
                if { [$ns_ now] >= $opt(warm) } {
                        puts " stat collection ON"
                } else {
                        puts ""
                }
        }
        $ns_ at [expr [$ns_ now] + $opt(duration) / 10.0] "alive"
}

#
# collect statistics at the end of the simulation
#
proc finish {} {
        global ns_ simtime file
	set simtimefile [open time a]
        # print statistics to output file
        $ns_ stat print

        # print out the simulation time
        set simtime [expr [clock seconds] - $simtime]
        puts "run duration: $simtime s"

	#print the simtime in a text file
        puts $simtimefile "duration of $file:	$simtime s"
	close $simtimefile
	exit 0
}

#
# initialize simulation
#
proc init {} {
        global opt defaultRNG ns_ simtime

        # create the simulator instance
       # set ns_ [new Simulator]  ;# create a new simulator instance
        $defaultRNG seed 1

        # initialize statistics collection
        $ns_ run-identifier $opt(run)
        $ns_ stat file "$opt(out)"
        $ns_ at $opt(warm) "$ns_ stat on"
        $ns_ at $opt(duration) "finish"

        # add default probes
        $ns_ stat add e2e_owd_a    avg discrete
        $ns_ stat add e2e_tpt      avg rate
        $ns_ stat add e2e_owpl     avg rate
        #$ns_ stat add tcp_cwnd_a   avg continuous
        #$ns_ stat add tcp_dupacks  avg continuous
        #$ns_ stat add tcp_ssthresh avg continuous
        #$ns_ stat add tcp_rtt      avg continuous
        #$ns_ stat add tcp_srtt     avg continuous

        #$ns_ stat add tcp_cwnd_d   dst continuous 0 128 128
        $ns_ stat add e2e_owd_d    dst discrete 0.0 1.0 1000
        #$ns_ stat add e2e_ipdv_d   dst discrete 0.0 5.0 100 

        $ns_ stat add voip_state_duration avg discrete
	$ns_ stat add voip_frames_recv avg counter
        $ns_ stat add voip_frames_sent avg counter
        $ns_ stat add voip_cell_outage avg discrete
        $ns_ stat add voip_mos_conversation avg discrete
        $ns_ stat add voip_playout_talkspurt_delay avg discrete
        $ns_ stat add voip_playout_talkspurt_per avg discrete
        $ns_ stat add voip_satisfaction avg discrete
        $ns_ stat add voip_cell_satisfaction avg discrete
        $ns_ stat add voip_talkspurt_duration avg discrete
	     $ns_ stat add voip_silence_duration avg discrete
		  $ns_ stat add voip_dur_fid_silence avg discrete
  		 

        ## open trace files
       	#set opt(trace) [open "/dev/null" w]
        #$ns_ trace-all $opt(trace)
        

	set simtime [clock seconds]

}

##############################################################################
#                       SCENARIO CONFIGURATION                               #
##############################################################################
proc e2etConf { tag fid } {
   global opt

   $tag per $opt(e2et-per)

   if { $opt(e2et-delay-dst) == "uniform" } {
      set tag_ranvar [new RandomVariable/Uniform]
      $tag_ranvar set min_ $opt(e2et-delay-min)
      $tag_ranvar set max_ $opt(e2et-delay-max)

   } elseif { $opt(e2et-delay-dst) == "exponential" } {
      set tag_ranvar [new RandomVariable/Exponential]
      $tag_ranvar set avg_ $opt(e2et-delay-mean)

   } elseif { $opt(e2et-delay-dst) == "normal" } {
      set tag_ranvar [new RandomVariable/Normal]
      $tag_ranvar set avg_ $opt(e2et-delay-mean)
      $tag_ranvar set std_ $opt(e2et-delay-devstd)

   } elseif { $opt(e2et-delay-dst) == "lognormal" } {
      set tag_ranvar [new RandomVariable/LogNormal] 
      set mean $opt(e2et-delay-mean)
      set stdd $opt(e2et-delay-devstd)   
      $tag_ranvar set avg_ \
         [expr log(pow($mean,2) / sqrt(pow($stdd,2) + pow($mean,2)))]
      $tag_ranvar set std_ [expr sqrt(log(pow(($stdd / $mean),2) + 1))]

   } elseif { $opt(e2et-delay-dst) == "constant" } {
      set tag_ranvar [new RandomVariable/Constant]
      $tag_ranvar set val_ $opt(e2et-delay-mean)
   } elseif { $opt(e2et-delay-dst) == "threshold_uniform" } {
      set tag_ranvar [new RandomVariable/Uniform]
	if { $fid < $opt(e2et-threshold-fid) } {
      		$tag_ranvar set min_  $opt(e2et-threshold-low)
      		$tag_ranvar set max_  [expr $opt(e2et-threshold-window) * $opt(e2et-threshold-low) ]
	} else {
		$tag_ranvar set min_  $opt(e2et-threshold-high)
      		$tag_ranvar set max_  [expr $opt(e2et-threshold-window) * $opt(e2et-threshold-high) ]
	}
   } else {
      puts "Unknown distribution '%s'" $opt(e2et-delay-dst)
      exit 0
   }
   if { $opt(e2et-delay)== "on" } {
   	$tag ranvar $tag_ranvar 
   	$tag reorder $opt(e2et-delay-reorder)
   }
#   $tag fid $fid
}


proc create_udp { n0 n1 fid app } {
   global ns_ voip opt

   set agtsrc [new Agent/UDP]
   set agtdst [new Agent/UDP]

   $agtsrc set fid_    $fid
     
   $agtsrc set packetSize_ 65535
  
   
   set src $n0
   set dst $n1
   
   $ns_ attach-agent $n0 $agtsrc
   $ns_ attach-agent $n1 $agtdst
   $ns_ connect $agtsrc $agtdst
   if { $app == "voip" } {
      $voip(encoder) attach-agent $agtsrc
      $voip(decoder) attach-agent $agtdst
      $voip(header)  attach-agent $agtsrc

      if { $opt(voip-bidirectional) != "off" } {
	  $voip(decoder) peer-id [expr $fid - 1] 
      }
   } else { 
     puts "Application not supported"
      exit 1
   }

   # end-to-end modules statistics collection
   set tag [new e2et]
   set mon [new e2em]
   e2etConf $tag $fid
   $agtsrc attach-e2et $tag
   $agtdst attach-e2em $mon
   $mon index $fid
   $mon start-log

	return 1
}

#
# create a VoIP traffic flow between two nodes, agents included
#
proc create_voip { fid start stop } {
   global opt ns_ voip bidirectional
       # create a RNG for this application
   set rng [new RNG]

   # create and configure the VoIP application
   set app [new VoipSource]

  # create and configure voip bidirectional (if enabled)
  if { $opt(voip-bidirectional) == "on" } {
	  if { $opt(voip-model) != "one-to-one" } {
		  puts "Bidirectional is available for 'one-to-one' conversations only!"
		  exit 1
	  }
	      set bidirectional [new VoipBidirectionalModifiedBrady]
		$ns_ at $start "$bidirectional start"
	      if { $stop != "never" } {
		$ns_ at $stop "$bidirectional stop"
	      }
	      ;# if { $opt(voip-bidir-debug) == "true" } { $bidirectional debug }
	   $bidirectional source $app
	   $app bidirectional $bidirectional

  } elseif { $opt(voip-bidirectional) == "unrelated" } {
	  if { $opt(voip-model) != "one-to-one" } {
		  puts "Bidirectional is available for 'one-to-one' conversations only!"
		  exit 1
	  }
	  # With one-to-one bidirectional model use a separate 
	  # bidirectional object for each source.
	  set bidirectional [new VoipBidirectionalModifiedBrady]
	  $ns_ at $start "$bidirectional start"
	  if { $stop != "never" } {
		  $ns_ at $stop "$bidirectional stop"
	  }
	  $bidirectional source $app
	  $app bidirectional $bidirectional
  } elseif { $opt(voip-bidirectional) == "off" } { ;# VoIP bidirectional "off"
	  # If voip-bidirectional is "on" or "unrelated"
	  # then sources are started by bidirectional objects,
	  # otherwise we start voip sources.				
	  $ns_ at $start "$app start"
	  if { $stop != "never" } { $ns_ at $stop "$app stop" }

  } else {
	  puts "Unknown value '$opt(voip-bidirectional)' for VoIP bidirectional"
	  exit 1
  }

   if { $opt(voip-model) == "weibull-custom" } {
      $app model $opt(voip-model) \
         $opt(voip-talk-scale) $opt(voip-talk-shape) \
         $opt(voip-silence-scale) $opt(voip-silence-shape)
   } elseif { $opt(voip-model) == "exponential" } {
      $app model $opt(voip-model) $opt(voip-exponential-talk) $opt(voip-exponential-silence)
   } else {
      $app model $opt(voip-model)
   }

   set header [new Application/VoipHeader]
   $header compression $opt(voip-comp-hdr-size)
   
   set encoder [new Application/VoipEncoder]
   
   $encoder id $fid
   $encoder codec $opt(voip-codec)
   $encoder header $header
   
   ;# debug option
   $encoder $opt(voip-debug)

   $app encoder $encoder 
   
   # Create VoIPDecoder according to the chain 
   
   set n_dec [ llength $opt(voip-decoder-chain) ]

   for { set idx [ expr $n_dec -1 ] } { $idx >= 0 } { incr idx -1 } {
      
      set decType [ lindex $opt(voip-decoder-chain) $idx ]
      
      if { $decType == "optimal" } {   
         set decoder($idx) [new Application/VoipDecoderOptimal]
         $decoder($idx) mos-threshold $opt(voip-mos-threshold)
         $decoder($idx) cell-mos-threshold $opt(voip-cell-mos-threshold)
         $decoder($idx) emodel $opt(voip-codec)
      } elseif { $decType == "80216m" } {
         set decoder($idx) [new Application/VoipDecoder80216m]
         $decoder($idx) cell-loss-threshold $opt(voip-cell-loss-threshold)
      } elseif { $decType == "atzori" } {
         set decoder($idx) [new Application/VoipDecoderAtzori]
         $decoder($idx) cell-loss-threshold $opt(voip-cell-loss-threshold)
      } elseif { $decType == "h323" } {
         set decoder($idx) [new Application/VoipDecoderH323]
         $decoder($idx) cell-loss-threshold $opt(voip-cell-loss-threshold)
	 $decoder($idx) min-jitter $opt(voip-decoder-min-jitter)
	 $decoder($idx) max-jitter $opt(voip-decoder-max-jitter) 
      } elseif { $decType == "static" } {
         puts "Static decoder is DEPRECATED, abort"
         exit 1
      } else {
         puts "Unknown decoder type $decType, abort"
         exit 1
      }
      
      # Common Configuration

      $decoder($idx) id $fid
      $decoder($idx) cell-id 0

      ;# debug option
      $decoder($idx) $opt(voip-debug)
      
      # Connect Decoder to the Chain
      if { $idx < [ expr $n_dec -1 ] } {
         $decoder($idx) next-decoder $decoder([ expr $idx+1 ])
      }
   }

   set aggregate [new Application/VoipAggregate]
   $aggregate nframes $opt(voip-aggr)
   $aggregate header $header
   $encoder aggregate $aggregate

   set voip(encoder) $encoder
   set voip(decoder) $decoder(0)
   set voip(header)  $header

   return $app
}

proc scenario {} {
        global ns_ opt node_
        #set n0 [$ns_ node]
        #set n1 [$ns_ node]
	set fid 1
	#a total of 23 start times
	set start {1.0 1.5 2.0 2.5 3.0 3.5 4.0 4.5 5.0 5.5 6.0 6.5 7.0 7.5 8.0 8.5 9.0 9.5 10.0 10.5 11.0 11.5 12.0}
	#Total of 18 correlated flows (VoIP Flows: 36 in total)
	set vnode1 {2 6 10 14 18 22 26 30 34 38 42 46 50 54 58 62 64 68}
	set vnode2 {3 7 11 15 19 23 27 31 35 39 43 47 51 55 59 63 65 69}

	set stop [expr $opt(duration)-5]
	
		  for { set i 0} { $i < $opt(voipflows)} { incr i } {
			  create_voip $fid [lindex $start $i] $stop
			  set f [create_udp $node_([lindex $vnode1 $i]) $node_([lindex $vnode2 $i]) $fid "voip"]
			  if {$opt(voip-bidirectional) != "off"} {
			      ;# create the opposite dir correlated flow
			      create_voip [expr $fid+1] [lindex $start $i] $stop
			      create_udp $node_([lindex $vnode2 $i]) $node_([lindex $vnode1 $i]) [expr $fid+1] "voip"
			      set f [expr $f+1]
			  }

			 set fid [expr $fid+2] 
		  }
			 
}	    


##############################################################################
#                            MAIN BODY                                       #
##############################################################################

init
scenario
if { $opt(debug) != "" } {
        printopt
}
alive
#$ns_ run
