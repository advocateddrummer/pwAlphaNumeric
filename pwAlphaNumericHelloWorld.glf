package require PWI_Glyph 4.18.4

set where [file dirname [info script]]
source [file join $where pwAlphaNumeric.glf]

set dx 0.6
set dy 1.0

###########################################################################
set loop [doH 0.0 0.0 0.0]

set all [list {*}$loop]

###########################################################################
set loop [doE $dx 0.0 0.0]

lappend all {*}$loop

###########################################################################
set loop [doL [expr {2*$dx}] 0.0 0.0]

lappend all {*}$loop

###########################################################################
set loop [doL [expr {3*$dx}] 0.0 0.0]

lappend all {*}$loop

###########################################################################
set loops [doO [expr {4*$dx}] 0.0 0.0]

lappend all {*}$loops

###########################################################################
set loop [doW 0.0 -$dy 0.0]

lappend all {*}$loop

###########################################################################
set loops [doO $dx -$dy 0.0]

lappend all {*}$loops

###########################################################################
set loops [doR [expr {2*$dx}] -$dy 0.0]

lappend all {*}$loops

###########################################################################
set loop [doL [expr {3*$dx}] -$dy 0.0]

lappend all {*}$loop

###########################################################################
set loops [doD [expr {4*$dx}] -$dy 0.0]

lappend all {*}$loops

###########################################################################
#set loops [doExclamation]
#
#doTranslate [join $loops] "[expr {5*$dx}] -$dy 0.1"
#
#pw::Display zoomToEntities -animate $animationSpeed [join $loops]
#
#lappend all {*}$loops
#
#set dom [createSimpleDomain [lindex $loops 0]]
#set dom [createSimpleDomain [lindex $loops 1]]

pw::Display zoomToEntities -animate 1 [join $all]

# vim: set ft=tcl:
