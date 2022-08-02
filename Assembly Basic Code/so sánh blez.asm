start:

#TH 4a: i < j
#slt $t0,$s1,$s2 # i<j; s2 = j, s1 = i
#bne $t0,$zero,else # branch to else if i<j

#TH 4b: i >= j
#slt $t0,$s2,$s1 # i>j; s2 = j, s1 = i
#bne $t0,$zero,else # branch to else if i>j
#bne $s1,$s2,else # branch to else if i=j

#TH 4c: i + j <= 0
#add $t0,$s1,$s2 # s2 = j, s1 = i
#blez $t0,else # branch to else if i+j<=0

#TH 4d: i + j > m + n
add $t0,$s1,$s2 # s2 = j, s1 = i
add $t1,$s3,$s4 # s3 = m, s4 = n
slt $t2,$t1,$t0
bne $t2,$zero,else


addi $t1,$t1,1 
addi $t3,$zero,1
j endif 
else: addi $t2,$t2,-1 
add $t3,$t3,$t3 
endif:
