package require PWI_Glyph 4.18.4

set where [file dirname [info script]]
source [file join $where pwAlphaNumeric.glf]

set dx 0.6
set dy 1.0
set animationSpeed 0.5

set all [list]

###########################################################################
set loop [do1]

doTranslate $loop "0.0 [expr {2*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [do2]

doTranslate $loop "$dx [expr {2*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [do3]

doTranslate $loop "[expr {2*$dx}] [expr {2*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [do4]

doTranslate $loop "[expr {3*$dx}] [expr {2*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [do5]

doTranslate $loop "[expr {4*$dx}] [expr {2*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loops [do6 0.0 $dy 0.0]

lappend all {*}$loops

###########################################################################
set loop [do7]

doTranslate $loop "$dx $dy 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

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
set loop [doC]

doTranslate $loop "[expr {2*$dx}] 0.0 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loops [doD [expr {3*$dx}] 0.0 0.0]

lappend all {*}$loops

###########################################################################
set loop [doE]

doTranslate $loop "[expr {4*$dx}] 0.0 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doF]

doTranslate $loop "0.0 -$dy 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doG]

doTranslate $loop "$dx -$dy 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################

set loop [doH]

doTranslate $loop "[expr {2*$dx}] -$dy 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doI]

doTranslate $loop "[expr {3*$dx}] -$dy 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doJ]

doTranslate $loop "[expr {4*$dx}] -$dy 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doK]

doTranslate $loop "0.0 [expr {-2*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doL]

doTranslate $loop "[expr {1*$dx}] [expr {-2*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doM]

doTranslate $loop "[expr {2*$dx}] [expr {-2*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doN]

doTranslate $loop "[expr {3*$dx}] [expr {-2*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

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
set loop [doS]

doTranslate $loop "[expr {3*$dx}] [expr {-3*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doT]

doTranslate $loop "[expr {4*$dx}] [expr {-3*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doU]

doTranslate $loop "0.0 [expr {-4*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doV]

doTranslate $loop "$dx [expr {-4*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doW]

doTranslate $loop "[expr {2*$dx}] [expr {-4*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doX]

doTranslate $loop "[expr {3*$dx}] [expr {-4*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doY]

doTranslate $loop "[expr {4*$dx}] [expr {-4*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doZ]

doTranslate $loop "0.0 [expr {-5*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doPeriod]

doTranslate $loop "$dx [expr {-5*$dy}] 0.1"

pw::Display zoomToEntities -animate $animationSpeed $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

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
