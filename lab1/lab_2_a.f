C Num Analysis lab 1 2-a
	INTEGER i,j
	
	DO 10 i=2,300,1
		DO 20 j=2,i,1
		IF(i .EQ. j) write(*,*) i
		IF(MOD(i,j) .EQ. 0) GOTO 10
20		CONTINUE
10		CONTINUE
	END
