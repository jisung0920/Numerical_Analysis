NOTE:	Some of the BLAS1 routines (coded in Fortran in the
	original SLATEC sources) were replaced by the fast
	Pentium-optimized assembly language coded routines
	of Mr Manuel Kessler (the reader is referred to the
	page http://cip.physik.uni-wuerzburg.de/~mlkessle
	for details.)  	This results in a considerable speedup 
	of many critical operations like vector dot products etc., 
	which in turn speeds up many other SLATEC routines that 
	depend on these critical operations (e.g., the solution 
	of large systems of linear equations).

	-------------------------------------------------------

	Typically a program that contains calls to SLATEC 
	routines is compiled as:

	g77 myprog.f -o myprog.exe -lslatec

	Of course one can apply a number of optimizations
	(like -O2, -mpentium, -malign-double etc., see the
	G77 documentation for these compiler options), so
	a more typical command line would be:

	g77 -O2 myprog.f -o myprog.exe -lslatec




