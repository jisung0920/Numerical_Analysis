SHELL = /bin/sh

default:
	@echo Please invoke this makefile using sdssmake. >&2
	@exit 1

all :
	rm -f *.f.html
	dervish -command "source makeHtml.tcl; makeKeyIndex; makeRoutineIndex"

clean :
	rm -f *~ core *.bak *.orig *.old MAIN.* .#* #*#
