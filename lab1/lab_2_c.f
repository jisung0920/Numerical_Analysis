C Num Analysis lab 1 2-c
       INTEGER i,j,k
       i = 1
       k=0
       
       do
        i = i+1
        do 10 j=2,i,1
          if(i.eq.j) then
            k = k+1
            if(i.GE.10000) then
              write(*,*)k
              goto 20
            endif
            EXIT
          endif
          if(mod(i,j).EQ.0) EXIT
10        continue
       enddo
20       end
