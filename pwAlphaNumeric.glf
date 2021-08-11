# The height of each letter/number.
set h 0.75
set h2 [expr {$h/2.0}]
set h3 [expr {$h/3.0}]
set h4 [expr {$h/4.0}]
set h5 [expr {$h/5.0}]

# The width of each letter/number.
set w 0.5
set w2 [expr {$w/2.0}]
set w3 [expr {$w/3.0}]
set w4 [expr {$w/4.0}]
set w5 [expr {$w/5.0}]

# The procedures below return a list (or a list of lists) containing the
# loops/edges that make up each of the letters/numbers. Inner loops are wound
# opposite to the outer loops so they should mesh without a problem.
#
# Each letter/number is initially created in the z = -0.1 plane and must be
# 'translated' somehow to where ever the character is needed. This is to avoid
# potential issues when/if the current letter is created on top of a
# preexisting letter in the z = 0 plane.

proc doA {} {
  global h
  global h2
  global h3
  global h4
  global w
  global w2
  global w3
  set z -0.1

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

  return [list [list $con1 $con2 $con3 $con4 $con5 $con6 $con7] [list $con8 $con9 $con10]]
}


proc doB {} {
  global h
  global h5
  global w
  global w3
  global w4
  global w5
  set z -0.1

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

  return [list [list $con1 $con2 $con3 $con4 $con5 $con6] [list $con7 $con8 $con9 $con10] [list $con11 $con12 $con13 $con14]]
}

proc doC {} {
  global h
  global h5
  global w
  global w3
  set z -0.1

  set con1 [createCon "0.0 0.0 $z"            "$w 0.0 $z"]
  set con2 [createCon "$w 0.0 $z"             "$w $h5 $z"]
  set con3 [createCon "$w $h5 $z"             "$w3 $h5 $z"]
  set con4 [createCon "$w3 $h5 $z"            "$w3 [expr {4*$h5}] $z"]
  set con5 [createCon "$w3 [expr {4*$h5}] $z" "$w [expr {4*$h5}] $z"]
  set con6 [createCon "$w [expr {4*$h5}] $z"  "$w $h $z"]
  set con7 [createCon "$w $h $z"              "0.0 $h $z"]
  set con8 [createCon "0.0 $h $z"             "0.0 0.0 $z"]

  return [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8]
}

proc doD {} {
  global h
  global h5
  global w
  global w3
  global w4
  global w5
  set z -0.1

  set con1  [createCon "0.0 0.0 $z"            "[expr {4*$w5}] 0.0 $z"]
  set con2  [createCon "[expr {4*$w5}] 0.0 $z" "$w $h5 $z"]
  set con3  [createCon "$w $h5 $z"             "$w [expr {4*$h5}] $z"]
  set con4  [createCon "$w [expr {4*$h5}] $z"  "[expr {4*$w5}] $h $z"]
  set con5  [createCon "[expr {4*$w5}] $h $z"  "0.0 $h $z"]
  set con6  [createCon "0.0 $h $z"             "0.0 0.0 $z"]

  set con7  [createCon "$w4 $h5 $z"                       "$w4 [expr {4*$h5}] $z"]
  set con8  [createCon "$w4 [expr {4*$h5}] $z"            "[expr {2*$w3}] [expr {4*$h5}] $z"]
  set con9  [createCon "[expr {2*$w3}] [expr {4*$h5}] $z" "[expr {2*$w3}] $h5 $z"]
  set con10 [createCon "[expr {2*$w3}] $h5 $z"            "$w4 $h5 $z"]

  return [list [list $con1 $con2 $con3 $con4 $con5 $con6] [list $con7 $con8 $con9 $con10]]
}

proc doE {} {
  global h
  global h5
  global w
  global w3
  set z -0.1

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

  return [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10 $con11 $con12]
}

proc doF {} {
  global h
  global h5
  global w
  global w3
  set z -0.1

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

  return [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10]
}

proc doG {} {
  global h
  global h2
  global h5
  global w
  global w3
  set z -0.1

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

  return [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10]
}

proc doH {} {
  global h
  global h5
  global w
  global w3
  set z -0.1

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

  return [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10 $con11 $con12]
}

proc doL {} {
  global h
  global h5
  global w
  global w3
  set z -0.1

  set con1 [createCon "0.0 0.0 $z" "$w 0.0 $z"]
  set con2 [createCon "$w 0.0 $z"  "$w $h5 $z"]
  set con3 [createCon "$w $h5 $z"  "$w3 $h5 $z"]
  set con4 [createCon "$w3 $h5 $z" "$w3 $h $z"]
  set con5 [createCon "$w3 $h $z"  "0.0 $h $z"]
  set con6 [createCon "0.0 $h $z"  "0.0 0.0 $z"]

  return [list $con1 $con2 $con3 $con4 $con5 $con6]
}

proc doO {} {
  global h
  global h4
  global w
  global w3
  global w4
  set z -0.1

  set con1 [createCon "0.0 0.0 $z" "$w 0.0 $z"]
  set con2 [createCon "$w 0.0 $z" "$w $h $z"]
  set con3 [createCon "$w $h $z" "0.0 $h $z"]
  set con4 [createCon "0.0 $h $z" "0.0 0.0 $z"]

  set con5 [createCon "$w4 $h4 $z"                       "$w4 [expr {3*$h4}] $z"]
  set con6 [createCon "$w4 [expr {3*$h4}] $z"            "[expr {2*$w3}] [expr {3*$h4}] $z"]
  set con7 [createCon "[expr {2*$w3}] [expr {3*$h4}] $z" "[expr {2*$w3}] $h4 $z"]
  set con8 [createCon "[expr {2*$w3}] $h4 $z"            "$w4 $h4 $z"]

  return [list [list $con1 $con2 $con3 $con4] [list $con5 $con6 $con7 $con8]]
}

proc doR {} {
  global h
  global h5
  global w
  global w3
  global w4
  set z -0.1

  set con1 [createCon "0.0 0.0 $z"                       "$w4 0.0 $z"]
  set con2 [createCon "$w4 0.0 $z"                       "$w4 [expr {2*$h5}] $z"]
  set con3 [createCon "$w4 [expr {2*$h5}] $z"            "[expr {2*$w3}] 0.0 $z"]
  set con4 [createCon "[expr {2*$w3}] 0.0 $z"            "$w 0.0 $z"]
  set con5 [createCon "$w 0.0 $z"                        "[expr {2*$w3}] [expr {2*$h5}] $z"]
  set con6 [createCon "[expr {2*$w3}] [expr {2*$h5}] $z" "$w [expr {2*$h5}] $z"]
  set con7 [createCon "$w [expr {2*$h5}] $z"             "$w $h $z"]
  set con8 [createCon "$w $h $z"                         "0.0 $h $z"]
  set con9 [createCon "0.0 $h $z"                        "0.0 0.0 $z"]


  set con10 [createCon "$w4 [expr {3*$h5}] $z"            "$w4 [expr {4*$h5}] $z"]
  set con11 [createCon "$w4 [expr {4*$h5}] $z"            "[expr {2*$w3}] [expr {4*$h5}] $z"]
  set con12 [createCon "[expr {2*$w3}] [expr {4*$h5}] $z" "[expr {2*$w3}] [expr {3*$h5}] $z"]
  set con13 [createCon "[expr {2*$w3}] [expr {3*$h5}] $z" "$w4 [expr {3*$h5}] $z"]

  return [list [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9] [list $con10 $con11 $con12 $con13]]
}

proc doW {} {
  global h
  global h3
  global w
  global w2
  global w3
  set z -0.1

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


  return [list $con1 $con2 $con3 $con4 $con5 $con6 $con7 $con8 $con9 $con10 $con11 $con12]
}

# vim: set ft=tcl:
