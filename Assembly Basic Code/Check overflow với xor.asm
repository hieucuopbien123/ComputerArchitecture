#Laboratory Exercise 4, Lab Assignment 4
.text
start:
li $t0,0 #No Overflow is default status
addu $s3,$s1,$s2 # s3 = s1 + s2
xor $t1,$s1,$s2 #Test if $s1 and $s2 have the same sign
bltz $t1,EXIT #If not, exit

xor $t1,$s3,$s1 #Test if $s3 and $s1 have the same sign
bltz $t1, OVERFLOW #if not => overflow
j EXIT

OVERFLOW:
li $t0,1 #the result is overflow
EXIT:
