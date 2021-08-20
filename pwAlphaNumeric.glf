# Settings
pw::Application setGridPreference Unstructured
pw::Connector setCalculateDimensionMethod Spacing
pw::Connector setCalculateDimensionSpacing 0.01
pw::DomainUnstructured setDefault Algorithm AdvancingFrontOrtho
pw::DomainUnstructured setDefault IsoCellType TriangleQuad

# Utilitiy procedures
proc doTranslate {entities vec} {
  set translateMode [pw::Application begin Modify $entities]
    pw::Entity transform [pwu::Transform translation $vec] [$translateMode getEntities]
  $translateMode end
  unset translateMode
}

proc createSimpleDomain {outerLoop} {
  set dom [pw::DomainUnstructured createFromConnectors -reject unusedCons $outerLoop]
  unset unusedCons

  return $dom
}

proc createComplexDomain {outerLoop {innerLoops {} } } {
  set mode1 [pw::Application begin Create]
    #puts "outerLoop = $outerLoop"
    #puts "in createDomain..."
    #puts "\tinnerLoops is: $innerLoops"

    set outerEdge [pw::Edge create]
    foreach c $outerLoop {
      $outerEdge addConnector $c
    }

    #puts "length of innerLoops is [llength $innerLoops]"

    set dom [pw::DomainUnstructured create]
    $dom addEdge $outerEdge
    unset outerEdge

    # This _assumes_ correct winding
    if {[llength $innerLoops] > 0} {
      foreach l $innerLoops {
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

  return $dom
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

# The height, and height increments, of each letter/number.
set h 0.75
set h2 [expr {$h/2.0}]
set h3 [expr {$h/3.0}]
set h4 [expr {$h/4.0}]
set h5 [expr {$h/5.0}]

# The width, and width increments, of each letter/number.
set w 0.5
set w2 [expr {$w/2.0}]
set w3 [expr {$w/3.0}]
set w4 [expr {$w/4.0}]
set w5 [expr {$w/5.0}]

# Other configurations
set animationSpeed 0.5

# The procedures below return a list (or a list of lists) containing the
# loops/edges that make up each of the letters/numbers. Inner loops are wound
# opposite to the outer loops so they should mesh without a problem.
#
# Each letter/number is initially created in the z = -0.1 plane and must be
# 'translated' somehow to where ever the character is needed. This is to avoid
# potential issues when/if the current letter is created on top of a
# preexisting letter in the z = 0 plane.
set z -0.1

proc doA {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h2
  global h3
  global h4
  global w
  global w2
  global w3
  global z
  global animationSpeed

  set con1 [createCon "0.0 0.0 $z"            "$w3 0.0 $z"]
  set con2 [createCon "$w3 0.0 $z"            "$w2 $h3 $z"]
  set con3 [createCon "$w2 $h3 $z"            "[expr {2*$w3}] 0.0 $z"]
  set con4 [createCon "[expr {2*$w3}] 0.0 $z" "$w 0.0 $z"]
  set con5 [createCon "$w 0.0 $z"             "[expr {2*$w3}] $h $z"]
  set con6 [createCon "[expr {2*$w3}] $h $z"  "$w3 $h $z"]
  set con7 [createCon "$w3 $h $z"             "0.0 0.0 $z"]

  set con8  [createCon "$w3 $h2 $z"            "$w2 [expr {3*$h4}] $z"]
  set con9  [createCon "$w2 [expr {3*$h4}] $z" "[expr {2*$w3}] $h2 $z"]
  set con10 [createCon "[expr {2*$w3}] $h2 $z" "$w3 $h2 $z"]

  set loops [list [list $con1 $con2 $con3 $con4 $con5 $con6 $con7] [list $con8 $con9 $con10]]

  doTranslate [join $loops] "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed [join $loops]

  set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

  return $dom
}


proc doB {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global w4
  global w5
  global z
  global animationSpeed

  set con1 [createCon "0.0 0.0 $z"            "[expr {4*$w5}] 0.0 $z"]
  set con2 [createCon "[expr {4*$w5}] 0.0 $z" "$w $h5 $z"]
  set con3 [createCon "$w $h5 $z"             "$w [expr {4*$h5}] $z"]
  set con4 [createCon "$w [expr {4*$h5}] $z"  "[expr {4*$w5}] $h $z"]
  set con5 [createCon "[expr {4*$w5}] $h $z"  "0.0 $h $z"]
  set con6 [createCon "0.0 $h $z"             "0.0 0.0 $z"]

  set con7  [createCon "$w4 $h5 $z"                        "[expr {2*$w3}] $h5 $z"]
  set con8  [createCon "$w4 $h5 $z"                        "$w4 [expr {2*$h5}] $z"]
  set con9  [createCon "$w4 [expr {2*$h5}] $z"             "[expr {2*$w3}] [expr {2*$h5}] $z"]
  set con10 [createCon "[expr {2*$w3}] [expr {2*$h5}] $z"  "[expr {2*$w3}] $h5 $z"]

  set con11 [createCon "$w4 [expr {3*$h5}] $z"            "[expr {2*$w3}] [expr {3*$h5}] $z"]
  set con12 [createCon "$w4 [expr {3*$h5}] $z"            "$w4 [expr {4*$h5}] $z"]
  set con13 [createCon "$w4 [expr {4*$h5}] $z"            "[expr {2*$w3}] [expr {4*$h5}] $z"]
  set con14 [createCon "[expr {2*$w3}] [expr {4*$h5}] $z" "[expr {2*$w3}] [expr {3*$h5}] $z"]

  set loops [list [list $con1 $con2 $con3 $con4 $con5 $con6] [list $con7 $con8 $con9 $con10] [list $con11 $con12 $con13 $con14]]

  doTranslate [join $loops] "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed [join $loops]

  set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

  return $dom
}

proc doC {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1 [createCon "0.0 0.0 $z"            "$w 0.0 $z"]
  set con2 [createCon "$w 0.0 $z"             "$w $h5 $z"]
  set con3 [createCon "$w $h5 $z"             "$w3 $h5 $z"]
  set con4 [createCon "$w3 $h5 $z"            "$w3 [expr {4*$h5}] $z"]
  set con5 [createCon "$w3 [expr {4*$h5}] $z" "$w [expr {4*$h5}] $z"]
  set con6 [createCon "$w [expr {4*$h5}] $z"  "$w $h $z"]
  set con7 [createCon "$w $h $z"              "0.0 $h $z"]
  set con8 [createCon "0.0 $h $z"             "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc doD {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global w4
  global w5
  global z
  global animationSpeed

  set con1 [createCon "0.0 0.0 $z"            "[expr {4*$w5}] 0.0 $z"]
  set con2 [createCon "[expr {4*$w5}] 0.0 $z" "$w $h5 $z"]
  set con3 [createCon "$w $h5 $z"             "$w [expr {4*$h5}] $z"]
  set con4 [createCon "$w [expr {4*$h5}] $z"  "[expr {4*$w5}] $h $z"]
  set con5 [createCon "[expr {4*$w5}] $h $z"  "0.0 $h $z"]
  set con6 [createCon "0.0 $h $z"             "0.0 0.0 $z"]

  set con7  [createCon "$w4 $h5 $z"                       "$w4 [expr {4*$h5}] $z"]
  set con8  [createCon "$w4 [expr {4*$h5}] $z"            "[expr {2*$w3}] [expr {4*$h5}] $z"]
  set con9  [createCon "[expr {2*$w3}] [expr {4*$h5}] $z" "[expr {2*$w3}] $h5 $z"]
  set con10 [createCon "[expr {2*$w3}] $h5 $z"            "$w4 $h5 $z"]

  set loops [list [list $con1 $con2 $con3 $con4 $con5 $con6] [list $con7 $con8 $con9 $con10]]

  doTranslate [join $loops] "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed [join $loops]

  set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

  return $dom
}

proc doE {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1  [createCon "0.0 0.0 $z"                       "$w 0.0 $z"]
  set con2  [createCon "$w 0.0 $z"                        "$w $h5 $z"]
  set con3  [createCon "$w $h5 $z"                        "$w3 $h5 $z"]
  set con4  [createCon "$w3 $h5 $z"                       "$w3 [expr {2*$h5}] $z"]
  set con5  [createCon "$w3 [expr {2*$h5}] $z"            "[expr {2*$w3}] [expr {2*$h5}] $z"]
  set con6  [createCon "[expr {2*$w3}] [expr {2*$h5}] $z" "[expr {2*$w3}] [expr {3*$h5}] $z"]
  set con7  [createCon "[expr {2*$w3}] [expr {3*$h5}] $z" "$w3 [expr {3*$h5}] $z"]
  set con8  [createCon "$w3 [expr {3*$h5}] $z"            "$w3 [expr {4*$h5}] $z"]
  set con9  [createCon "$w3 [expr {4*$h5}] $z"            "$w [expr {4*$h5}] $z"]
  set con10 [createCon "$w [expr {4*$h5}] $z"             "$w $h $z"]
  set con11 [createCon "$w $h $z"                         "0.0 $h $z"]
  set con12 [createCon "0.0 $h $z"                        "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10 $con11 $con12]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc doF {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1  [createCon "0.0 0.0 $z"                       "$w3 0.0 $z"]
  set con2  [createCon "$w3 0.0 $z"                       "$w3 [expr {2*$h5}] $z"]
  set con3  [createCon "$w3 [expr {2*$h5}] $z"            "[expr {2*$w3}] [expr {2*$h5}] $z"]
  set con4  [createCon "[expr {2*$w3}] [expr {2*$h5}] $z" "[expr {2*$w3}] [expr {3*$h5}] $z"]
  set con5  [createCon "[expr {2*$w3}] [expr {3*$h5}] $z" "$w3 [expr {3*$h5}] $z"]
  set con6  [createCon "$w3 [expr {3*$h5}] $z"            "$w3 [expr {4*$h5}] $z"]
  set con7  [createCon "$w3 [expr {4*$h5}] $z"            "$w [expr {4*$h5}] $z"]
  set con8  [createCon "$w [expr {4*$h5}] $z"             "$w $h $z"]
  set con9  [createCon "$w $h $z"                         "0.0 $h $z"]
  set con10 [createCon "0.0 $h $z"                        "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

# TODO: improve this letter definition.
proc doG {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h2
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1  [createCon "0.0 0.0 $z"            "$w 0.0 $z"]
  set con2  [createCon "$w 0.0 $z"             "$w $h2 $z"]
  set con3  [createCon "$w $h2 $z"             "[expr {2*$w3}] $h2 $z"]
  set con4  [createCon "[expr {2*$w3}] $h2 $z" "[expr {2*$w3}] $h5 $z"]
  set con5  [createCon "[expr {2*$w3}] $h5 $z" "$w3 $h5 $z"]
  set con6  [createCon "$w3 $h5 $z"            "$w3 [expr {4*$h5}] $z"]
  set con7  [createCon "$w3 [expr {4*$h5}] $z" "$w [expr {4*$h5}] $z"]
  set con8  [createCon "$w [expr {4*$h5}] $z"  "$w $h $z"]
  set con9  [createCon "$w $h $z"              "0.0 $h $z"]
  set con10 [createCon "0.0 $h $z"             "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc doH {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1  [createCon "0.0 0.0 $z"                       "$w3 0.0 $z"]
  set con2  [createCon "$w3 0.0 $z"                       "$w3 [expr {2*$h5}] $z"]
  set con3  [createCon "$w3 [expr {2*$h5}] $z"            "[expr {2*$w3}] [expr {2*$h5}] $z"]
  set con4  [createCon "[expr {2*$w3}] [expr {2*$h5}] $z" "[expr {2*$w3}] 0.0 $z"]
  set con5  [createCon "[expr {2*$w3}] 0.0 $z"            "$w 0.0 $z"]
  set con6  [createCon "$w 0.0 $z"                        "$w $h $z"]
  set con7  [createCon "$w $h $z"                         "[expr {2*$w3}] $h $z"]
  set con8  [createCon "[expr {2*$w3}] $h $z"             "[expr {2*$w3}] [expr {3*$h5}] $z"]
  set con9  [createCon "[expr {2*$w3}] [expr {3*$h5}] $z" "$w3 [expr {3*$h5}] $z"]
  set con10 [createCon "$w3 [expr {3*$h5}] $z"            "$w3 $h $z"]
  set con11 [createCon "$w3 $h $z"                        "0.0 $h $z"]
  set con12 [createCon "0.0 $h $z"                        "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10 $con11 $con12]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc doI {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1 [createCon "0.0 0.0 $z"                       "$w 0.0 $z"]
  set con2 [createCon "$w 0.0 $z"                        "$w $h5 $z"]
  set con3 [createCon "$w $h5 $z"                        "[expr {2*$w3}] $h5 $z"]
  set con4 [createCon "[expr {2*$w3}] $h5 $z"            "[expr {2*$w3}] [expr {4*$h5}] $z"]
  set con5 [createCon "[expr {2*$w3}] [expr {4*$h5}] $z" "$w [expr {4*$h5}] $z"]
  set con6 [createCon "$w [expr {4*$h5}] $z"             "$w $h $z"]
  set con7 [createCon "$w $h $z"                         "0.0 $h $z"]
  set con8 [createCon "0.0 $h $z"                        "0.0 [expr {4*$h5}] $z"]
  set con9 [createCon "0.0 [expr {4*$h5}] $z"            "$w3 [expr {4*$h5}] $z"]
  set con10 [createCon "$w3 [expr {4*$h5}] $z"           "$w3 $h5 $z"]
  set con11 [createCon "$w3 $h5 $z"                      "0.0 $h5 $z"]
  set con12 [createCon "0.0 $h5 $z"                      "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10 $con11 $con12]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

# TODO: improve this letter definition.
proc doJ {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1  [createCon "0.0 0.0 $z"                       "[expr {2*$w3}] 0.0 $z"]
  set con2  [createCon "[expr {2*$w3}] 0.0 $z"            "[expr {2*$w3}] [expr {4*$h5}] $z"]
  set con3  [createCon "[expr {2*$w3}] [expr {4*$h5}] $z" "$w [expr {4*$h5}] $z"]
  set con4  [createCon "$w [expr {4*$h5}] $z"             "$w $h $z"]
  set con5  [createCon "$w $h $z"                         "0.0 $h $z"]
  set con6  [createCon "0.0 $h $z"                        "0.0 [expr {4*$h5}] $z"]
  set con7  [createCon "0.0 [expr {4*$h5}] $z"            "$w3 [expr {4*$h5}] $z"]
  set con8  [createCon "$w3 [expr {4*$h5}] $z"            "$w3 $h5 $z"]
  set con9  [createCon "$w3 $h5 $z"                       "0.0 $h5 $z"]
  set con10 [createCon "0.0 $h5 $z"                       "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc doK {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h2
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1  [createCon "0.0 0.0 $z"            "$w3 0.0 $z"]
  set con2  [createCon "$w3 0.0 $z"            "$w3 [expr {2*$h5}] $z"]
  set con3  [createCon "$w3 [expr {2*$h5}] $z" "[expr {2*$w3}] 0.0 $z"]
  set con4  [createCon "[expr {2*$w3}] 0.0 $z" "$w 0.0 $z"]
  set con5  [createCon "$w 0.0 $z"             "[expr {2*$w3}] $h2 $z"]
  set con6  [createCon "[expr {2*$w3}] $h2 $z" "$w $h $z"]
  set con7  [createCon "$w $h $z"              "[expr {2*$w3}] $h $z"]
  set con8  [createCon "[expr {2*$w3}] $h $z"  "$w3 [expr {3*$h5}] $z"]
  set con9  [createCon "$w3 [expr {3*$h5}] $z" "$w3 $h $z"]
  set con10 [createCon "$w3 $h $z"             "0.0 $h $z"]
  set con11 [createCon "0.0 $h $z"             "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10 $con11]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc doL {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1 [createCon "0.0 0.0 $z" "$w 0.0 $z"]
  set con2 [createCon "$w 0.0 $z"  "$w $h5 $z"]
  set con3 [createCon "$w $h5 $z"  "$w3 $h5 $z"]
  set con4 [createCon "$w3 $h5 $z" "$w3 $h $z"]
  set con5 [createCon "$w3 $h $z"  "0.0 $h $z"]
  set con6 [createCon "0.0 $h $z"  "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc doM {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h2
  global h3
  global w
  global w2
  global w3
  global z
  global animationSpeed

  set con1  [createCon "0.0 0.0 $z"            "$w3 0.0 $z"]
  set con2  [createCon "$w3 0.0 $z"            "$w3 $h3 $z"]
  set con3  [createCon "$w3 $h3 $z"            "$w2 0.0 $z"]
  set con4  [createCon "$w2 0.0 $z"            "[expr {2*$w3}] $h3 $z"]
  set con5  [createCon "[expr {2*$w3}] $h3 $z" "[expr {2*$w3}] 0.0 $z"]
  set con6  [createCon "[expr {2*$w3}] 0.0 $z" "$w 0.0 $z"]
  set con7  [createCon "$w 0.0 $z"             "$w $h $z"]
  set con8  [createCon "$w $h $z"              "[expr {2*$w3}] $h $z"]
  set con9  [createCon "[expr {2*$w3}] $h $z"  "$w2 $h2 $z"]
  set con10 [createCon "$w2 $h2 $z"            "$w3 $h $z"]
  set con11 [createCon "$w3 $h $z"             "0.0 $h $z"]
  set con12 [createCon "0.0 $h $z"             "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10 $con11 $con12]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc doN {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h2
  global w
  global w3
  global z
  global animationSpeed

  set con1  [createCon "0.0 0.0 $z"            "$w3 0.0 $z"]
  set con2  [createCon "$w3 0.0 $z"            "$w3 $h2 $z"]
  set con3  [createCon "$w3 $h2 $z"            "[expr {2*$w3}] 0.0 $z"]
  set con4  [createCon "[expr {2*$w3}] 0.0 $z" "$w 0.0 $z"]
  set con5  [createCon "$w 0.0 $z"             "$w $h $z"]
  set con6  [createCon "$w $h $z"              "[expr {2*$w3}] $h $z"]
  set con7  [createCon "[expr {2*$w3}] $h $z"  "[expr {2*$w3}] $h2 $z"]
  set con8  [createCon "[expr {2*$w3}] $h2 $z" "$w3 $h $z"]
  set con9  [createCon "$w3 $h $z"             "0.0 $h $z"]
  set con10 [createCon "0.0 $h $z"             "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc doO {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h4
  global w
  global w3
  global w4
  global z
  global animationSpeed

  set con1 [createCon "0.0 0.0 $z" "$w 0.0 $z"]
  set con2 [createCon "$w 0.0 $z" "$w $h $z"]
  set con3 [createCon "$w $h $z" "0.0 $h $z"]
  set con4 [createCon "0.0 $h $z" "0.0 0.0 $z"]

  set con5 [createCon "$w4 $h4 $z"                       "$w4 [expr {3*$h4}] $z"]
  set con6 [createCon "$w4 [expr {3*$h4}] $z"            "[expr {2*$w3}] [expr {3*$h4}] $z"]
  set con7 [createCon "[expr {2*$w3}] [expr {3*$h4}] $z" "[expr {2*$w3}] $h4 $z"]
  set con8 [createCon "[expr {2*$w3}] $h4 $z"            "$w4 $h4 $z"]

  set loops [list [list $con1 $con2 $con3 $con4] [list $con5 $con6 $con7 $con8]]

  doTranslate [join $loops] "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed [join $loops]

  set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

  return $dom
}

proc doP {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global w4
  global z
  global animationSpeed

  set con1 [createCon "0.0 0.0 $z"            "$w4 0.0 $z"]
  set con2 [createCon "$w4 0.0 $z"            "$w4 [expr {2*$h5}] $z"]
  set con3 [createCon "$w4 [expr {2*$h5}] $z" "$w [expr {2*$h5}] $z"]
  set con4 [createCon "$w [expr {2*$h5}] $z"  "$w $h $z"]
  set con5 [createCon "$w $h $z"              "0.0 $h $z"]
  set con6 [createCon "0.0 $h $z"             "0.0 0.0 $z"]

  set con7  [createCon "$w4 [expr {3*$h5}] $z"            "$w4 [expr {4*$h5}] $z"]
  set con8  [createCon "$w4 [expr {4*$h5}] $z"            "[expr {2*$w3}] [expr {4*$h5}] $z"]
  set con9  [createCon "[expr {2*$w3}] [expr {4*$h5}] $z" "[expr {2*$w3}] [expr {3*$h5}] $z"]
  set con10 [createCon "[expr {2*$w3}] [expr {3*$h5}] $z" "$w4 [expr {3*$h5}] $z"]

  set loops [list [list $con1 $con2 $con3 $con4 $con5 $con6] [list $con7 $con8 $con9 $con10]]

  doTranslate [join $loops] "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed [join $loops]

  set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

  return $dom
}

proc doQ {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h4
  global h5
  global w
  global w2
  global w3
  global w4
  global z
  global animationSpeed

  set con1 [createCon "0.0 0.0 $z" "$w 0.0 $z"]
  set con2 [createCon "$w 0.0 $z"  "$w $h $z"]
  set con3 [createCon "$w $h $z"   "0.0 $h $z"]
  set con4 [createCon "0.0 $h $z"  "0.0 0.0 $z"]

  set con5 [createCon "$w4 $h4 $z"                       "$w4 [expr {3*$h4}] $z"]
  set con6 [createCon "$w4 [expr {3*$h4}] $z"            "[expr {2*$w3}] [expr {3*$h4}] $z"]
  set con7 [createCon "[expr {2*$w3}] [expr {3*$h4}] $z" "[expr {2*$w3}] [expr {2*$h5}] $z"]
  set con8 [createCon "[expr {2*$w3}] [expr {2*$h5}] $z" "$w2 [expr {2*$h5}] $z"]
  set con9 [createCon "$w2 [expr {2*$h5}] $z"            "[expr {2*$w3}] $h4 $z"]
  set con10 [createCon "[expr {2*$w3}] $h4 $z"           "$w4 $h4 $z"]

  set loops [list [list $con1 $con2 $con3 $con4] [list $con5 $con6 $con7 $con8 $con9 $con10]]

  doTranslate [join $loops] "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed [join $loops]

  set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

  return $dom
}

proc doR {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global w4
  global z
  global animationSpeed

  set con1 [createCon "0.0 0.0 $z"                           "$w4 0.0 $z"]
  set con2 [createCon "$w4 0.0 $z"                           "$w4 [expr {2*$h5}] $z"]
  set con3 [createCon "$w4 [expr {2*$h5}] $z"                "[expr {2*$w3}] 0.0 $z"]
  set con4 [createCon "[expr {2*$w3}] 0.0 $z"                "$w 0.0 $z"]
  set con5 [createCon "$w 0.0 $z"                            "[expr {$w4 + $w3}] [expr {2*$h5}] $z"]
  set con6 [createCon "[expr {$w4 + $w3}] [expr {2*$h5}] $z" "$w [expr {2*$h5}] $z"]
  set con7 [createCon "$w [expr {2*$h5}] $z"                 "$w $h $z"]
  set con8 [createCon "$w $h $z"                             "0.0 $h $z"]
  set con9 [createCon "0.0 $h $z"                            "0.0 0.0 $z"]

  set con10 [createCon "$w4 [expr {3*$h5}] $z"            "$w4 [expr {4*$h5}] $z"]
  set con11 [createCon "$w4 [expr {4*$h5}] $z"            "[expr {2*$w3}] [expr {4*$h5}] $z"]
  set con12 [createCon "[expr {2*$w3}] [expr {4*$h5}] $z" "[expr {2*$w3}] [expr {3*$h5}] $z"]
  set con13 [createCon "[expr {2*$w3}] [expr {3*$h5}] $z" "$w4 [expr {3*$h5}] $z"]

  set loops [list [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9] [list $con10 $con11 $con12 $con13]]

  doTranslate [join $loops] "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed [join $loops]

  set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

  return $dom
}

proc doS {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h3
  global h4
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1  [createCon "0.0 0.0 $z"                       "$w 0.0 $z"]
  set con2  [createCon "$w 0.0 $z"                        "$w $h4 $z"]
  set con3  [createCon "$w $h4 $z"                        "$w3 [expr {4*$h5}] $z"]
  set con4  [createCon "$w3 [expr {4*$h5}] $z"            "[expr {2*$w3}] [expr {4*$h5}] $z"]
  set con5  [createCon "[expr {2*$w3}] [expr {4*$h5}] $z" "[expr {2*$w3}] [expr {2*$h3}] $z"]
  set con6  [createCon "[expr {2*$w3}] [expr {2*$h3}] $z" "$w [expr {2*$h3}] $z"]
  set con7  [createCon "$w [expr {2*$h3}] $z"             "$w $h $z"]
  set con8  [createCon "$w $h $z"                         "0.0 $h $z"]
  set con9  [createCon "0.0 $h $z"                        "0.0 [expr {3*$h4}] $z"]
  set con10 [createCon "0.0 [expr {3*$h4}] $z"            "[expr {2*$w3}] $h5 $z"]
  set con11 [createCon "[expr {2*$w3}] $h5 $z"            "$w3 $h5 $z"]
  set con12 [createCon "$w3 $h5 $z"                       "$w3 $h3 $z"]
  set con13 [createCon "$w3 $h3 $z"                       "0.0 $h3 $z"]
  set con14 [createCon "0.0 $h3 $z"                       "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10 $con11 $con12 $con13 $con14]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc doT {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1 [createCon "$w3 0.0 $z"                       "[expr {2*$w3}] 0.0 $z"]
  set con2 [createCon "[expr {2*$w3}] 0.0 $z"            "[expr {2*$w3}] [expr {4*$h5}] $z"]
  set con3 [createCon "[expr {2*$w3}] [expr {4*$h5}] $z" "$w [expr {4*$h5}] $z"]
  set con4 [createCon "$w [expr {4*$h5}] $z"             "$w $h $z"]
  set con5 [createCon "$w $h $z"                         "0.0 $h $z"]
  set con6 [createCon "0.0 $h $z"                        "0.0 [expr {4*$h5}] $z"]
  set con7 [createCon "0.0 [expr {4*$h5}] $z"            "$w3 [expr {4*$h5}] $z"]
  set con8 [createCon "$w3 [expr {4*$h5}] $z"            "$w3 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc doU {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1 [createCon "0.0 0.0 $z"            "$w 0.0 $z"]
  set con2 [createCon "$w 0.0 $z"             "$w $h $z"]
  set con3 [createCon "$w $h $z"              "[expr {2*$w3}] $h $z"]
  set con4 [createCon "[expr {2*$w3}] $h $z"  "[expr {2*$w3}] $h5 $z"]
  set con5 [createCon "[expr {2*$w3}] $h5 $z" "$w3 $h5 $z"]
  set con6 [createCon "$w3 $h5 $z"            "$w3 $h $z"]
  set con7 [createCon "$w3 $h $z"             "0.0 $h $z"]
  set con8 [createCon "0.0 $h $z"             "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc doV {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h3
  global w
  global w2
  global w3
  global z
  global animationSpeed

  set con1 [createCon "$w3 0.0 $z"            "[expr {2*$w3}] 0.0 $z"]
  set con2 [createCon "[expr {2*$w3}] 0.0 $z" "$w $h $z"]
  set con3 [createCon "$w $h $z"              "[expr {2*$w3}] $h $z"]
  set con4 [createCon "[expr {2*$w3}] $h $z"  "$w2 $h3 $z"]
  set con5 [createCon "$w2 $h3 $z"            "$w3 $h $z"]
  set con6 [createCon "$w3 $h $z"             "0.0 $h $z"]
  set con7 [createCon "0.0 $h $z"             "$w3 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc doW {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h3
  global w
  global w2
  global w3
  global z
  global animationSpeed

  set con1  [createCon "0.0 0.0 $z"            "$w3 0.0 $z"]
  set con2  [createCon "$w3 0.0 $z"            "$w2 $h3 $z"]
  set con3  [createCon "$w2 $h3 $z"            "[expr {2*$w3}] 0.0 $z"]
  set con4  [createCon "[expr {2*$w3}] 0.0 $z" "$w 0.0 $z"]
  set con5  [createCon "$w 0.0 $z"             "$w $h $z"]
  set con6  [createCon "$w $h $z"              "[expr {2*$w3}] $h $z"]
  set con7  [createCon "[expr {2*$w3}] $h $z"  "[expr {2*$w3}] $h3 $z"]
  set con8  [createCon "[expr {2*$w3}] $h3 $z" "$w2 [expr {2*$h3}] $z"]
  set con9  [createCon "$w2 [expr {2*$h3}] $z" "$w3 $h3 $z"]
  set con10 [createCon "$w3 $h3 $z"            "$w3 $h $z"]
  set con11 [createCon "$w3 $h $z"             "0.0 $h $z"]
  set con12 [createCon "0.0 $h $z"             "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10 $con11 $con12]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc doX {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h2
  global h5
  global w
  global w2
  global w3
  global z
  global animationSpeed

  set con1  [createCon "0.0 0.0 $z"              "$w3 0.0 $z"]
  set con2  [createCon "$w3 0.0 $z"              "$w2 [expr {2*$h5}] $z"]
  set con3  [createCon "$w2 [expr {2*$h5}] $z"   "[expr {2*$w3}] 0.0 $z"]
  set con4  [createCon "[expr {2*$w3}] 0.0 $z"   "$w 0.0 $z"]
  set con5  [createCon "$w 0.0 $z"               "[expr {$w2+$w3}] $h2 $z"]
  set con6  [createCon "[expr {$w2+$w3}] $h2 $z" "$w $h $z"]
  set con7  [createCon "$w $h $z"                "[expr {2*$w3}] $h $z"]
  set con8  [createCon "[expr {2*$w3}] $h $z"    "$w2 [expr {3*$h5}] $z"]
  set con9  [createCon "$w2 [expr {3*$h5}] $z"   "$w3 $h $z"]
  set con10 [createCon "$w3 $h $z"               "0.0 $h $z"]
  set con11 [createCon "0.0 $h $z"               "[expr {$w2-$w3}] $h2 $z"]
  set con12 [createCon "[expr {$w2-$w3}] $h2 $z" "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10 $con11 $con12]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc doY {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w2
  global w3
  global z
  global animationSpeed

  set con1 [createCon "$w3 0.0 $z"                       "[expr {2*$w3}] 0.0 $z"]
  set con2 [createCon "[expr {2*$w3}] 0.0 $z"            "[expr {2*$w3}] [expr {2*$h5}] $z"]
  set con3 [createCon "[expr {2*$w3}] [expr {2*$h5}] $z" "$w $h $z"]
  set con4 [createCon "$w $h $z"                         "[expr {2*$w3}] $h $z"]
  set con5 [createCon "[expr {2*$w3}] $h $z"             "$w2 [expr {3*$h5}] $z"]
  set con6 [createCon "$w2 [expr {3*$h5}] $z"            "$w3 $h $z"]
  set con7 [createCon "$w3 $h $z"                        "0.0 $h $z"]
  set con8 [createCon "0.0 $h $z"                        "$w3 [expr {2*$h5}] $z"]
  set con9 [createCon "$w3 [expr {2*$h5}] $z"            "$w3 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc doZ {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1  [createCon "0.0 0.0 $z"                       "$w 0.0 $z"]
  set con2  [createCon "$w 0.0 $z"                        "$w $h5 $z"]
  set con3  [createCon "$w $h5 $z"                        "$w3 $h5 $z"]
  set con4  [createCon "$w3 $h5 $z"                       "$w [expr {4*$h5}] $z"]
  set con5  [createCon "$w [expr {4*$h5}] $z"             "$w $h $z"]
  set con6  [createCon "$w $h $z"                         "0.0 $h $z"]
  set con7  [createCon "0.0 $h $z"                        "0.0 [expr {4*$h5}] $z"]
  set con8  [createCon "0.0 [expr {4*$h5}] $z"            "[expr {2*$w3}] [expr {4*$h5}] $z"]
  set con9  [createCon "[expr {2*$w3}] [expr {4*$h5}] $z" "0.0 $h5 $z"]
  set con10 [createCon "0.0 $h5 $z"                       "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

# Begin numbers.

proc do0 {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1 [createCon "0.0 0.0 $z" "$w 0.0 $z"]
  set con2 [createCon "$w 0.0 $z"  "$w $h $z"]
  set con3 [createCon "$w $h $z"   "0.0 $h $z"]
  set con4 [createCon "0.0 $h $z"  "0.0 0.0 $z"]

  set con5 [createCon "$w3 $h5 $z"                       "$w3 [expr {4*$h5}] $z"]
  set con6 [createCon "$w3 [expr {4*$h5}] $z"            "[expr {2*$w3}] [expr {4*$h5}] $z"]
  set con7 [createCon "[expr {2*$w3}] [expr {4*$h5}] $z" "[expr {2*$w3}] $h5 $z"]
  set con8 [createCon "[expr {2*$w3}] $h5 $z"            "$w3 $h5 $z"]

  set loops [list [list $con1 $con2 $con3 $con4] [list $con5 $con6 $con7 $con8]]

  doTranslate [join $loops] "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed [join $loops]

  set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

  return $dom
}

proc do1 {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1  [createCon "0.0 0.0 $z"            "$w 0.0 $z"]
  set con2  [createCon "$w 0.0 $z"             "$w $h5 $z"]
  set con3  [createCon "$w $h5 $z"             "[expr {2*$w3}] $h5 $z"]
  set con4  [createCon "[expr {2*$w3}] $h5 $z" "[expr {2*$w3}] $h $z"]
  set con5  [createCon "[expr {2*$w3}] $h $z"  "0.0 $h $z"]
  set con6  [createCon "0.0 $h $z"             "0.0 [expr {4*$h5}] $z"]
  set con7  [createCon "0.0 [expr {4*$h5}] $z" "$w3 [expr {4*$h5}] $z"]
  set con8  [createCon "$w3 [expr {4*$h5}] $z" "$w3 $h5 $z"]
  set con9  [createCon "$w3 $h5 $z"            "0.0 $h5 $z"]
  set con10 [createCon "0.0 $h5 $z"            "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc do2 {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h4
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1 [createCon "0.0 0.0 $z"                        "$w 0.0 $z"]
  set con2 [createCon "$w 0.0 $z"                         "$w $h5 $z"]
  set con3 [createCon "$w $h5 $z"                         "$w3 $h5 $z"]
  set con4 [createCon "$w3 $h5 $z"                        "$w [expr {4*$h5}] $z"]
  set con5 [createCon "$w [expr {4*$h5}] $z"              "$w $h $z"]
  set con6 [createCon "$w $h $z"                          "0.0 $h $z"]
  set con7 [createCon "0.0 $h $z"                         "0.0 [expr {3*$h4}] $z"]
  set con8 [createCon "0.0 [expr {3*$h4}] $z"             "$w3 [expr {3*$h4}] $z"]
  set con9 [createCon "$w3 [expr {3*$h4}] $z"             "$w3 [expr {4*$h5}] $z"]
  set con10 [createCon "$w3 [expr {4*$h5}] $z"            "[expr {2*$w3}] [expr {4*$h5}] $z"]
  set con11 [createCon "[expr {2*$w3}] [expr {4*$h5}] $z" "0.0 $h5 $z"]
  set con12 [createCon "0.0 $h5 $z"                       "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10 $con11 $con12]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc do3 {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1  [createCon "0.0 0.0 $z"                       "$w 0.0 $z"]
  set con2  [createCon "$w 0.0 $z"                        "$w $h $z"]
  set con3  [createCon "$w $h $z"                         "0.0 $h $z"]
  set con4  [createCon "0.0 $h $z"                        "0.0 [expr {4*$h5}] $z"]
  set con5  [createCon "0.0 [expr {4*$h5}] $z"            "[expr {2*$w3}] [expr {4*$h5}] $z"]
  set con6  [createCon "[expr {2*$w3}] [expr {4*$h5}] $z" "[expr {2*$w3}] [expr {3*$h5}] $z"]
  set con7  [createCon "[expr {2*$w3}] [expr {3*$h5}] $z" "$w3 [expr {3*$h5}] $z"]
  set con8  [createCon "$w3 [expr {3*$h5}] $z"            "$w3 [expr {2*$h5}] $z"]
  set con9  [createCon "$w3 [expr {2*$h5}] $z"            "[expr {2*$w3}] [expr {2*$h5}] $z"]
  set con10 [createCon "[expr {2*$w3}] [expr {2*$h5}] $z" "[expr {2*$w3}] $h5 $z"]
  set con11 [createCon "[expr {2*$w3}] $h5 $z"            "0.0 $h5 $z"]
  set con12 [createCon "0.0 $h5 $z"                       "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10 $con11 $con12]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc do4 {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1 [createCon "[expr {2*$w3}] 0.0 $z"            "$w 0.0 $z"]
  set con2 [createCon "$w 0.0 $z"                        "$w $h $z"]
  set con3 [createCon "$w $h $z"                         "[expr {2*$w3}] $h $z"]
  set con4 [createCon "[expr {2*$w3}] $h $z"             "[expr {2*$w3}] [expr {3*$h5}] $z"]
  set con5 [createCon "[expr {2*$w3}] [expr {3*$h5}] $z" "$w3 [expr {3*$h5}] $z"]
  set con6 [createCon "$w3 [expr {3*$h5}] $z"            "$w3 $h $z"]
  set con7 [createCon "$w3 $h $z"                        "0.0 $h $z"]
  set con8 [createCon "0.0 $h $z"                        "0.0 [expr {2*$h5}] $z"]
  set con9 [createCon "0.0 [expr {2*$h5}] $z"             "[expr {2*$w3}] [expr {2*$h5}] $z"]
  set con10 [createCon "[expr {2*$w3}] [expr {2*$h5}] $z" "[expr {2*$w3}] 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc do5 {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h4
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1  [createCon "0.0 0.0 $z"                       "$w 0.0 $z"]
  set con2  [createCon "$w 0.0 $z"                        "$w [expr {3*$h5}] $z"]
  set con3  [createCon "$w [expr {3*$h5}] $z"             "$w3 [expr {3*$h5}] $z"]
  set con4  [createCon "$w3 [expr {3*$h5}] $z"            "$w3 [expr {4*$h5}] $z"]
  set con5  [createCon "$w3 [expr {4*$h5}] $z"            "[expr {2*$w3}] [expr {4*$h5}] $z"]
  set con6  [createCon "[expr {2*$w3}] [expr {4*$h5}] $z" "[expr {2*$w3}] [expr {3*$h4}] $z"]
  set con7  [createCon "[expr {2*$w3}] [expr {3*$h4}] $z" "$w [expr {3*$h4}] $z"]
  set con8  [createCon "$w [expr {3*$h4}] $z"             "$w $h $z"]
  set con9  [createCon "$w $h $z"                         "0.0 $h $z"]
  set con10 [createCon "0.0 $h $z"                        "0.0 [expr {2*$h5}] $z"]
  set con11 [createCon "0.0 [expr {2*$h5}] $z"            "[expr {2*$w3}] [expr {2*$h5}] $z"]
  set con12 [createCon "[expr {2*$w3}] [expr {2*$h5}] $z" "[expr {2*$w3}] $h5 $z"]
  set con13 [createCon "[expr {2*$w3}] $h5 $z"            "0.0 $h5 $z"]
  set con14 [createCon "0.0 $h5 $z"                       "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10 $con11 $con12 $con13 $con14]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc do6 {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1 [createCon "0.0 0.0 $z"            "$w 0.0 $z"]
  set con2 [createCon "$w 0.0 $z"             "$w [expr {3*$h5}] $z"]
  set con3 [createCon "$w [expr {3*$h5}] $z"  "$w3 [expr {3*$h5}] $z"]
  set con4 [createCon "$w3 [expr {3*$h5}] $z" "$w3 [expr {4*$h5}] $z"]
  set con5 [createCon "$w3 [expr {4*$h5}] $z" "$w [expr {4*$h5}] $z"]
  set con6 [createCon "$w [expr {4*$h5}] $z"  "$w $h $z"]
  set con7 [createCon "$w $h $z"              "0.0 $h $z"]
  set con8 [createCon "0.0 $h $z"             "0.0 0.0 $z"]

  set con9  [createCon "$w3 $h5 $z"                       "$w3 [expr {2*$h5}] $z"]
  set con10 [createCon "$w3 [expr {2*$h5}] $z"            "[expr {2*$w3}] [expr {2*$h5}] $z"]
  set con11 [createCon "[expr {2*$w3}] [expr {2*$h5}] $z" "[expr {2*$w3}] $h5 $z"]
  set con12 [createCon "[expr {2*$w3}] $h5 $z"            "$w3 $h5 $z"]

  set loops [list [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8] [list $con9 $con10 $con11 $con12]]

  doTranslate [join $loops] "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed [join $loops]

  set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

  return $dom
}

proc do7 {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1 [createCon "0.0 0.0 $z" "$w3 0.0 $z"]
  set con2 [createCon "$w3 0.0 $z" "$w [expr {4*$h5}] $z"]
  set con3 [createCon "$w [expr {4*$h5}] $z" "$w $h $z"]
  set con4 [createCon "$w $h $z" "0.0 $h $z"]
  set con5 [createCon "0.0 $h $z" "0.0 [expr {4*$h5}] $z"]
  set con6 [createCon "0.0 [expr {4*$h5}] $z" "[expr {2*$w3}] [expr {4*$h5}] $z"]
  set con7 [createCon "[expr {2*$w3}] [expr {4*$h5}] $z" "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc do8 {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1 [createCon "0.0 0.0 $z" "$w 0.0 $z"]
  set con2 [createCon "$w 0.0 $z"  "$w $h $z"]
  set con3 [createCon "$w $h $z"   "0.0 $h $z"]
  set con4 [createCon "0.0 $h $z"  "0.0 0.0 $z"]

  set con5 [createCon "$w3 $h5 $z"                       "$w3 [expr {2*$h5}] $z"]
  set con6 [createCon "$w3 [expr {2*$h5}] $z"            "[expr {2*$w3}] [expr {2*$h5}] $z"]
  set con7 [createCon "[expr {2*$w3}] [expr {2*$h5}] $z" "[expr {2*$w3}] $h5 $z"]
  set con8 [createCon "[expr {2*$w3}] $h5 $z"            "$w3 $h5 $z"]

  set con9  [createCon "$w3 [expr {3*$h5}] $z"            "$w3 [expr {4*$h5}] $z"]
  set con10 [createCon "$w3 [expr {4*$h5}] $z"            "[expr {2*$w3}] [expr {4*$h5}] $z"]
  set con11 [createCon "[expr {2*$w3}] [expr {4*$h5}] $z" "[expr {2*$w3}] [expr {3*$h5}] $z"]
  set con12 [createCon "[expr {2*$w3}] [expr {3*$h5}] $z" "$w3 [expr {3*$h5}] $z"]

  set loops [list [list $con1 $con2 $con3 $con4] [list $con5 $con6 $con7 $con8] [list $con9 $con10 $con11 $con12]]

  doTranslate [join $loops] "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed [join $loops]

  set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

  return $dom
}

proc do9 {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set con1 [createCon "[expr {2*$w3}] 0.0 $z"            "$w 0.0 $z"]
  set con2 [createCon "$w 0.0 $z"                        "$w $h $z"]
  set con3 [createCon "$w $h $z"                         "0.0 $h $z"]
  set con4 [createCon "0.0 $h $z"                        "0.0 [expr {2*$h5}] $z"]
  set con5 [createCon "0.0 [expr {2*$h5}] $z"            "[expr {2*$w3}] [expr {2*$h5}] $z"]
  set con6 [createCon "[expr {2*$w3}] [expr {2*$h5}] $z" "[expr {2*$w3}] 0.0 $z"]

  set con7  [createCon "$w3 [expr {3*$h5}] $z"            "$w3 [expr {4*$h5}] $z"]
  set con8  [createCon "$w3 [expr {4*$h5}] $z"            "[expr {2*$w3}] [expr {4*$h5}] $z"]
  set con9  [createCon "[expr {2*$w3}] [expr {4*$h5}] $z" "[expr {2*$w3}] [expr {3*$h5}] $z"]
  set con10 [createCon "[expr {2*$w3}] [expr {3*$h5}] $z" "$w3 [expr {3*$h5}] $z"]

  set loops [list [list $con1 $con2 $con3 $con4 $con5 $con6] [list $con7 $con8 $con9 $con10]]

  doTranslate [join $loops] "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed [join $loops]

  set dom [createComplexDomain [lindex $loops 0] [lrange $loops 1 end]]

  return $dom
}

# Begin punctuation.

proc doPeriod {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global w3
  global z
  global animationSpeed

  set con1 [createCon "0.0 0.0 $z" "$w3 0.0 $z"]
  set con2 [createCon "$w3 0.0 $z" "$w3 $w3 $z"]
  set con3 [createCon "$w3 $w3 $z" "0.0 $w3 $z"]
  set con4 [createCon "0.0 $w3 $z" "0.0 0.0 $z"]

  set loop [list $con1 $con2 $con3 $con4]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

proc doComma {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global w3
  global z
  global animationSpeed

  set con1 [createCon "0.0 -$w3 $z" "$w3 0.0 $z"]
  set con2 [createCon "$w3 0.0 $z"  "$w3 $w3 $z"]
  set con3 [createCon "$w3 $w3 $z"  "0.0 $w3 $z"]
  set con4 [createCon "0.0 $w3 $z"  "0.0 -$w3 $z"]

  set loop [list $con1 $con2 $con3 $con4]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return $dom
}

# This procedure has exposed an issue with the way these loops are handled... I
# need to re-think this. Furthermore, now that this interface has changed,
# there are yet more problems with this approach. I do need to re-work/think
# this logic.
proc doExclamation {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h4
  global w3
  global z
  global animationSpeed

  set period [doPeriod $dx $dy $dz]

  set con1 [createCon "0.0 $h4 $z" "$w3 $h4 $z"]
  set con2 [createCon "$w3 $h4 $z" "$w3 $h $z"]
  set con3 [createCon "$w3 $h $z"  "0.0 $h $z"]
  set con4 [createCon "0.0 $h $z"  "0.0 $h4 $z"]

  set loop [list $con1 $con2 $con3 $con4]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return [join $dom $period]
}

proc doQuestion {{dx 0.0} {dy 0.0} {dz 0.0}} {
  global h
  global h2
  global h4
  global h5
  global w
  global w3
  global z
  global animationSpeed

  set period [doPeriod [expr {$dx + $w3}] $dy $dz]

  set con1  [createCon "$w3 $h4 $z"                       "[expr {2*$w3}] $h4 $z"]
  set con2  [createCon "[expr {2*$w3}] $h4 $z"            "[expr {2*$w3}] [expr {2*$h5}] $z"]
  #set con3  [createCon "[expr {2*$w3}] [expr {2*$h5}] $z" "$w $h2 $z"]
  set con3  [createCon "[expr {2*$w3}] [expr {2*$h5}] $z" "$w [expr {2*$h5}] $z"]
  #set con4  [createCon "$w $h2 $z"                        "$w $h $z"]
  set con4  [createCon "$w [expr {2*$h5}] $z"             "$w $h $z"]
  set con5  [createCon "$w $h $z"                         "0.0 $h $z"]
  set con6  [createCon "0.0 $h $z"                        "0.0 [expr {3*$h4}] $z"]
  set con7  [createCon "0.0 [expr {3*$h4}] $z"            "$w3 [expr {3*$h4}] $z"]
  set con8  [createCon "$w3 [expr {3*$h4}] $z"            "$w3 [expr {4*$h5}] $z"]
  set con9  [createCon "$w3 [expr {4*$h5}] $z"            "[expr {2*$w3}] [expr {4*$h5}] $z"]
  set con10 [createCon "[expr {2*$w3}] [expr {4*$h5}] $z" "[expr {2*$w3}] [expr {3*$h5}] $z"]
  set con11 [createCon "[expr {2*$w3}] [expr {3*$h5}] $z" "$w3 [expr {3*$h5}] $z"]
  set con12 [createCon "$w3 [expr {3*$h5}] $z"            "$w3 $h4 $z"]

  set loop [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10 $con11 $con12]

  doTranslate $loop "$dx $dy [expr {$dz - $z}]"

  pw::Display zoomToEntities -animate $animationSpeed $loop

  set dom [createSimpleDomain $loop]

  return [join $dom $period]
}

# vim: set ft=tcl:
