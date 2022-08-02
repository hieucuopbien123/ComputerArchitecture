#find max absolute value of array
.data
list: .word -1, -2, 4, -5, 3, -20, 10#4 byte
.text
la $s1, list
add $s2,$zero,1
add $s3,$zero,-1
add $t7, $zero,6
loop: 
 add $s3,$s3,$s2 #i=i+step
 add $t1,$s3,$s3 #t1=2*s3
 add $t1,$t1,$t1 #t1=4*s3
 add $t1,$t1,$s1 #t1 store the address of A[i]
 lw $t0,0($t1) #load value of A[i] in $t0
 add $t9, $zero, $t0
 slt $t4,$t0,$zero
 bne $t4,0,reversesign
 j next
reversesign:
 mul $t0,$t0,-1
 j next
next: 
 slt $t2,$t3,$t0
 bne $t2,$zero,else
 bne $s3,$t7,loop 
 j endloop
#thieu j o day la sai
else: 
 add $t3,$zero,$t0
 add $t8,$zero,$t9
 bne $s3,$t7,loop
 j endloop
endloop:
# largest absolute value is stored at $t8
