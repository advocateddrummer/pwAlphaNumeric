package require PWI_Glyph 4.18.4

set where [file dirname [info script]]
source [file join $where pwAlphaNumeric.glf]

set dx 0.6
set dy 1.0
set animationSpeed 0.5

set all [list]

###########################################################################
set loop [do1 0.0 [expr {2*$dy}] 0.0]

lappend all {*}$loop

###########################################################################
set loop [do2 $dx [expr {2*$dy}] 0.0]

lappend all {*}$loop

###########################################################################
set loop [do3 [expr {2*$dx}] [expr {2*$dy}] 0.0]

lappend all {*}$loop

###########################################################################
set loop [do4 [expr {3*$dx}] [expr {2*$dy}] 0.0]

lappend all {*}$loop

###########################################################################
set loop [do5 [expr {4*$dx}] [expr {2*$dy}] 0.0]

lappend all {*}$loop

###########################################################################
set loops [do6 0.0 $dy 0.0]

lappend all {*}$loops

###########################################################################
set loop [do7 $dx $dy 0.0]

lappend all {*}$loop

###########################################################################
set loops [do8 [expr {2*$dx}] $dy 0.0]

lappend all {*}$loops

###########################################################################
set loops [do9 [expr {3*$dx}] $dy 0.0]

lappend all {*}$loops

###########################################################################
set loops [do0 [expr {4*$dx}] $dy 0.0]

lappend all {*}$loops

###########################################################################
set loops [doA]

lappend all {*}$loops

###########################################################################
set loops [doB $dx 0.0 0.0]

lappend all {*}$loops

###########################################################################
set loop [doC [expr {2*$dx}] 0.0 0.0]

lappend all {*}$loop

###########################################################################
set loops [doD [expr {3*$dx}] 0.0 0.0]

lappend all {*}$loops

###########################################################################
set loop [doE [expr {4*$dx}] 0.0 0.0]

lappend all {*}$loop

###########################################################################
set loop [doF 0.0 -$dy 0.0]

lappend all {*}$loop

###########################################################################
set loop [doG $dx -$dy 0.0]

lappend all {*}$loop

###########################################################################

set loop [doH [expr {2*$dx}] -$dy 0.0]

lappend all {*}$loop

###########################################################################
set loop [doI [expr {3*$dx}] -$dy 0.0]

lappend all {*}$loop

###########################################################################
set loop [doJ [expr {4*$dx}] -$dy 0.0]

lappend all {*}$loop

###########################################################################
set loop [doK 0.0 [expr {-2*$dy}] 0.0]

lappend all {*}$loop

###########################################################################
set loop [doL [expr {1*$dx}] [expr {-2*$dy}] 0.0]

lappend all {*}$loop

###########################################################################
set loop [doM [expr {2*$dx}] [expr {-2*$dy}] 0.0]

lappend all {*}$loop

###########################################################################
set loop [doN [expr {3*$dx}] [expr {-2*$dy}] 0.0]

lappend all {*}$loop

###########################################################################
set loops [doO [expr {4*$dx}] [expr {-2*$dy}] 0.0]

lappend all {*}$loops

#########################################################################
set loops [doP 0.0 [expr {-3*$dy}] 0.0]

lappend all {*}$loops

###########################################################################
set loops [doQ $dx [expr {-3*$dy}] 0.0]

lappend all {*}$loops

###########################################################################
set loops [doR [expr {2*$dx}] [expr {-3*$dy}] 0.0]

lappend all {*}$loops

###########################################################################
set loop [doS [expr {3*$dx}] [expr {-3*$dy}] 0.0]

lappend all {*}$loop

###########################################################################
set loop [doT [expr {4*$dx}] [expr {-3*$dy}] 0.0]

lappend all {*}$loop

###########################################################################
set loop [doU 0.0 [expr {-4*$dy}] 0.0]

lappend all {*}$loop

###########################################################################
set loop [doV $dx [expr {-4*$dy}] 0.0]

lappend all {*}$loop

###########################################################################
set loop [doW [expr {2*$dx}] [expr {-4*$dy}] 0.0]

lappend all {*}$loop

###########################################################################
set loop [doX [expr {3*$dx}] [expr {-4*$dy}] 0.0]

lappend all {*}$loop

###########################################################################
set loop [doY [expr {4*$dx}] [expr {-4*$dy}] 0.0]

lappend all {*}$loop

###########################################################################
set loop [doZ 0.0 [expr {-5*$dy}] 0.0]

lappend all {*}$loop

###########################################################################
set loop [doPeriod $dx [expr {-5*$dy}] 0.0]

lappend all {*}$loop

###########################################################################
set loop [doComma]

doTranslate $loop "[expr {2*$dx}] [expr {-5*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loops [doExclamation]

doTranslate [join $loops] "[expr {3*$dx}] [expr {-5*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed [join $loops]

lappend all {*}$loops

set dom [createSimpleDomain [lindex $loops 0]]
set dom [createSimpleDomain [lindex $loops 1]]

###########################################################################
set loops [doQuestion]

doTranslate [join $loops] "[expr {4*$dx}] [expr {-5*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed [join $loops]

lappend all {*}$loops

set dom [createSimpleDomain [lindex $loops 0]]
set dom [createSimpleDomain [lindex $loops 1]]

pw::Display zoomToEntities -animate $animationSpeed [join $all]

# vim: set ft=tcl:
