package require PWI_Glyph 4.18.4

set where [file dirname [info script]]
source [file join $where pwAlphaNumeric.glf]

set dx 0.6
set dy 1.0

###########################################################################
set loop [doH]

doTranslate $loop {0.0 0.0 0.1}

pw::Display zoomToEntities -animate 1 $loop

set all [list {*}$loop]

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doE]

doTranslate $loop "$dx 0.0 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doL]

doTranslate $loop "[expr {2*$dx}] 0.0 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loop [doL]

doTranslate $loop "[expr {3*$dx}] 0.0 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loops [doO]

doTranslate [join $loops] "[expr {4*$dx}] 0.0 0.1"

pw::Display zoomToEntities -animate 1 [join $loops]

lappend all {*}$loops

set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

###########################################################################
set loop [doW]

doTranslate $loop "0.0 -$dy 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loops [doO]

doTranslate [join $loops] "$dx -$dy 0.1"

pw::Display zoomToEntities -animate 1 [join $loops]

lappend all {*}$loops

set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

###########################################################################
set loops [doR]

doTranslate [join $loops] "[expr {2*$dx}] -$dy 0.1"

pw::Display zoomToEntities -animate 1 [join $loops]

lappend all {*}$loops

set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

###########################################################################
set loop [doL]

doTranslate $loop "[expr {3*$dx}] -$dy 0.1"

pw::Display zoomToEntities -animate 1 $loop

lappend all {*}$loop

set dom [createSimpleDomain $loop]

###########################################################################
set loops [doD]

doTranslate [join $loops] "[expr {4*$dx}] -$dy 0.1"

pw::Display zoomToEntities -animate 1 [join $loops]

lappend all {*}$loops

set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

pw::Display zoomToEntities -animate 1 [join $all]

# vim: set ft=tcl:
