#Laboratory 3, Home Assigment 2
.text
loop: add $s1,$s1,$s4 #i=i+step
add $t1,$s1,$s1 #t1=2*s1
add $t1,$t1,$t1 #t1=4*s1
add $t1,$t1,$s2 #t1 store the address of A[i]
lw $t0,0($t1) #load value of A[i] in $t0
add $s5,$s5,$t0 #sum=sum+A[i]

#TH 5a: i < n
#slt $t2,$s1,$s3
#bne $t2,$zero,loop #if i < n, goto loop

#TH 5b: i <= n
#slt $t2,$s1,$s3
#bne $t2,$zero,loop #if i < n, goto loop
#bne $s1,$s2,else #if i = n, goto loop

#TH 5c: sum >= 0
#bgez $s5, loop #if sum >= 0, goto loop

#TH 5d: A[i] == 0
beq $t0, $zero, loop # branch to loop if A[i] == 0
