C Num Analysis lab 1 2-b
       INTEGER i,j,k
       k=0
       i=1
       
       do
        i = i+1
        do 10 j=2,i,1
          if(i.eq.j) then
            k = k+1
            if(k.EQ.300) then
              write(*,*)i
              goto 20
            endif
            EXIT
          endif
          if(mod(i,j).EQ.0) EXIT
10        continue
       enddo
20       end
