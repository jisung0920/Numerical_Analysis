proc makeKeyIndex { } {
    set fl [glob ../../src/*f]
    set n [llength $fl]
    echo number of routines in makeKeyIndex is $n; flush stdout
    fl2KeyIndex $fl
}

proc makeRoutineIndex { } {
    set fl [glob ../../src/*f]
    set n [llength $fl]
    echo number of routines in makeRoutineIndex is $n; flush stdout
    fl2html $fl
}

proc fl2html {fl} {
    set list1 ""
    set list2 ""
    foreach f $fl {
	set isSubsidiary [f2html $f]
	if {$isSubsidiary} {
	    lappend list2 [file tail $f]
	} else {
	    lappend list1 [file tail $f]
	}
	set outFile [open routinename.index.html w]
	puts $outFile "<html> <title> SLATEC Routine Name Index </title>"
	puts $outFile "<h1> SLATEC Routine Name Index </h1>"

	puts $outFile "<h2> User Callable Routines </h2>"
	puts $outFile "<ul>"
	foreach f $list1 {
	    puts $outFile "<li> <a href=$f.html> $f </a>"
	}
	puts $outFile "</ul>"

	puts $outFile "<h2> Subsidiary Routines </h2>"
	puts $outFile "<ul>"
	foreach f $list2 {
	    puts $outFile "<li> <a href=$f.html> $f </a>"
	}
	puts $outFile "</ul>"
	close $outFile
    }
}

proc f2html {fname} {
    set isSubsidiary 0
    set ftail [file tail $fname]
    set outFile NULL
    set outFile [open $ftail.html w]
    set inFile [open $fname r]
    puts $outFile "<html> <title> $ftail </title> <h1> $ftail </h1>"

    # skip over the "deck" line
    gets $inFile line
    set mode top
    puts $outFile <pre>
    while {$mode != "END" } {
	gets $inFile line
	if {[string range $line 0 3] == "C***"} {
	    set sub [lindex $line 0]
	    set prevMode $mode
	    set mode [string range $sub 4 end]
	    case $mode in {
		SUBSIDIARY {
		    set isSubsidiary 1
		    puts $outFile "...."
		    puts $outFile "...."
		    puts $outFile "Warning:  \
			this routine is not intended to be user-callable."
		    puts $outFile "...."
		    puts $outFile "...."
		}
	    }
	}
	puts $outFile $line
    }
    puts $outFile "</pre> </html>"
    close $outFile
    close $inFile
    return $isSubsidiary
}

proc fl2KeyIndex {fl} {
    global fl2k
    set fl2k(keylist) ""
    set fl2k(rootList) ""
    foreach f $fl {
	set tail [file tail $f]
	set root [file root $tail]
	lappend fl2k(rootList) $root
	set fl2k($root.list) " "
	set fl2k($root.purpose) " "
	set inFile [open $f r]
	gets $inFile line
	set mode top
	while {$mode != "END" } {
	    gets $inFile line
	    if {[string range $line 0 3] == "C***"} {
		set sub [lindex $line 0]
		set prevMode $mode
		set mode [string range $sub 4 end]
	    }
	    set line [string range $line 13 end]
	    case $mode in {
		KEYWORDS {
		    foreach element [split [string trimright $line ,] ,] {
			set ste [string trim $element]
			lappend fl2k($root.list) $ste
			if {[lsearch $fl2k(keylist) $ste] == -1} {
			    lappend fl2k(keylist) $ste
			}
		    }
		}
		PURPOSE {
		    lappend fl2k($root.purpose) $line
		}
	    }
	}
	close $inFile
    }
    set outFile [open keylist.index.html w]
    puts $outFile "<html> <title> SLATEC Keylist Index </title>"
    puts $outFile "<h1> SLATEC Keylist Index </h1>"

    puts $outFile "<ul>"
    foreach key [lsort $fl2k(keylist)] {
	regsub -all " " $key _ keyName
	puts $outFile "<li> <a href=#$keyName>$key</a>"
    }
    foreach key [lsort $fl2k(keylist)] {
	regsub -all " " $key _ keyName
	puts $outFile "<h3> <a name=\"$keyName\"> $key </a> </h3>"
	puts $outFile "<ul>"
	foreach root $fl2k(rootList) {
	    if {[lsearch $fl2k($root.list) $key] >= 0} {
		puts $outFile "<li><a href=$root.f.html> $root </a>"

		puts $outFile <pre>
		foreach line $fl2k($root.purpose) {
		    puts $outFile $line
		}
		puts $outFile </pre>

	    }

	}
	puts $outFile "</ul>"
    }
    close $outFile
}

