package require PWI_Glyph 4.18.4

set where [file dirname [info script]]
source [file join $where pwAlphaNumeric.glf]

pw::Application setGridPreference Unstructured
pw::Connector setCalculateDimensionMethod Spacing
pw::Connector setCalculateDimensionSpacing 0.01
pw::DomainUnstructured setDefault Algorithm AdvancingFrontOrtho
pw::DomainUnstructured setDefault IsoCellType TriangleQuad

set dx 0.6
set dy 1.0

proc doTranslate {entities vec} {
  set translateMode [pw::Application begin Modify $entities]
    pw::Entity transform [pwu::Transform translation $vec] [$translateMode getEntities]
  $translateMode end
  unset translateMode
}

proc createSimpleDomain {outerLoop} {
  set dom [pw::DomainUnstructured createFromConnectors -reject unusedCons $outerLoop]
  unset unusedCons

  return dom
}

proc createComplexDomain {outerLoop args} {
  set mode1 [pw::Application begin Create]
    #puts "outerLoop = $outerLoop"
    #puts "in createDomain..."
    #puts "\targs is: $args"

    set outerEdge [pw::Edge create]
    foreach c $outerLoop {
      $outerEdge addConnector $c
    }

    #puts "length of args is [llength $args]"
    set dom [pw::DomainUnstructured create]
    $dom addEdge $outerEdge
    unset outerEdge

    # This _assumes_ correct winding
    if {[llength $args] > 0} {
      foreach l $args {
        set innerEdge [pw::Edge create]
        foreach c [join $l] {
          $innerEdge addConnector $c
          }
        $dom addEdge $innerEdge
        unset innerEdge
      }
    }
  $mode1 end
  unset mode1
}

proc createCon {pt1 pt2} {
  set mode1 [pw::Application begin Create]
    set spline [pw::SegmentSpline create]
    $spline addPoint $pt1
    $spline addPoint $pt2
    set con [pw::Connector create]
    $con addSegment $spline
    unset spline
    $con calculateDimension
  $mode1 end
  unset mode1

  return $con
}

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
