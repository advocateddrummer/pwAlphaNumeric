package require PWI_Glyph 4.18.4

set where [file dirname [info script]]
source [file join $where pwAlphaNumeric.glf]

set dx 0.6
set dy 1.0

set all [list]

###########################################################################
set loop [do1]

doTranslate $loop "0.0 [expr {2*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [do2]

doTranslate $loop "$dx [expr {2*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [do3]

doTranslate $loop "[expr {2*$dx}] [expr {2*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [do4]

doTranslate $loop "[expr {3*$dx}] [expr {2*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [do5]

doTranslate $loop "[expr {4*$dx}] [expr {2*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loops [do6]

doTranslate [join $loops] "0.0 $dy 0.1"

pw::Display zoomToEntities -animate 1 [join $loops]

lappend all {*}$loops

set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

###########################################################################
set loop [do7]

doTranslate $loop "$dx $dy 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loops [do8]

doTranslate [join $loops] "[expr {2*$dx}] $dy 0.1"

pw::Display zoomToEntities -animate 1 [join $loops]

lappend all {*}$loops

set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

###########################################################################
set loops [do9]

doTranslate [join $loops] "[expr {3*$dx}] $dy 0.1"

pw::Display zoomToEntities -animate 1 [join $loops]

lappend all {*}$loops

set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

###########################################################################
set loops [do0]

doTranslate [join $loops] "[expr {4*$dx}] $dy 0.1"

pw::Display zoomToEntities -animate 1 [join $loops]

lappend all {*}$loops

set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

###########################################################################
set loops [doA]

doTranslate [join $loops] "0.0 0.0 0.1"

pw::Display zoomToEntities -animate 1 [join $loops]

lappend all {*}$loops

set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

###########################################################################
set loops [doB]

doTranslate [join $loops] "$dx 0.0 0.1"

pw::Display zoomToEntities -animate 1 [join $loops]

lappend all {*}$loops

set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

###########################################################################
set loop [doC]

doTranslate $loop "[expr {2*$dx}] 0.0 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loops [doD]

doTranslate [join $loops] "[expr {3*$dx}] 0.0 0.1"

pw::Display zoomToEntities -animate 1 [join $loops]

lappend all {*}$loops

set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

###########################################################################
set loop [doE]

doTranslate $loop "[expr {4*$dx}] 0.0 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doF]

doTranslate $loop "0.0 -$dy 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doG]

doTranslate $loop "$dx -$dy 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################

set loop [doH]

doTranslate $loop "[expr {2*$dx}] -$dy 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doI]

doTranslate $loop "[expr {3*$dx}] -$dy 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doJ]

doTranslate $loop "[expr {4*$dx}] -$dy 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doK]

doTranslate $loop "0.0 [expr {-2*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doL]

doTranslate $loop "[expr {1*$dx}] [expr {-2*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doM]

doTranslate $loop "[expr {2*$dx}] [expr {-2*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doN]

doTranslate $loop "[expr {3*$dx}] [expr {-2*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loops [doO]

doTranslate [join $loops] "[expr {4*$dx}] [expr {-2*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 [join $loops]

lappend all {*}$loops

set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

#########################################################################
set loops [doP]

doTranslate [join $loops] "0.0 [expr {-3*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 [join $loops]

lappend all {*}$loops

set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

###########################################################################
set loops [doQ]

doTranslate [join $loops] "$dx [expr {-3*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 [join $loops]

lappend all {*}$loops

set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

###########################################################################
set loops [doR]

doTranslate [join $loops] "[expr {2*$dx}] [expr {-3*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 [join $loops]

lappend all {*}$loops

set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

###########################################################################
set loop [doS]

doTranslate $loop "[expr {3*$dx}] [expr {-3*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doT]

doTranslate $loop "[expr {4*$dx}] [expr {-3*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doU]

doTranslate $loop "0.0 [expr {-4*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doV]

doTranslate $loop "$dx [expr {-4*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doW]

doTranslate $loop "[expr {2*$dx}] [expr {-4*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doX]

doTranslate $loop "[expr {3*$dx}] [expr {-4*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doY]

doTranslate $loop "[expr {4*$dx}] [expr {-4*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doZ]

doTranslate $loop "[expr {2*$dx}] [expr {-5*$dy}] 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

pw::Display zoomToEntities -animate 1 [join $all]

# vim: set ft=tcl:
