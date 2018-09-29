C Num_analysis lab1
	INTEGER i, j
	REAL SUM, TMP
	SUM = 0
	TMP = 0
	
	do 10 j=1,10,1
		do 20 i=1,10,1
			TMP =TMP+ cos(i*0.7 + j+2) / (i+j-1)
20	CONTINUE
		IF(SUM .LT. TMP) SUM = TMP
		TMP = 0
10 	CONTINUE
	WRITE(*,*) SUM
	END
