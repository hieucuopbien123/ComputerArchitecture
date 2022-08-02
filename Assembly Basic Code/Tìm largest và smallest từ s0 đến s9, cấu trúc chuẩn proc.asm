.data

  #message use for printing
  Message: .asciiz "Largest: "
  Message2: .asciiz "\nSmallest: "

.text
  #init array from $s0 to $s7
  li $s0, -3
  li $s1, -9
  li $s2, 1 
  li $s3, 10
  li $s4, 100
  li $s5, 45
  li $s6, -8
  li $s7, 9

  #call the procedure that find smallest and largest
  jal find
  
  #print the result
  li $v0, 4
  la $a0, Message
  syscall
  li $v0, 1
  add $a0, $t2, 0
  syscall
  li $v0, 11
  li $a0, ','
  syscall
  li $v0, 1
  add $a0, $t3, 0
  syscall
  
  li $v0, 4
  la $a0, Message2
  syscall
  li $v0, 1
  add $a0, $t4, 0
  syscall
  li $v0, 11
  li $a0, ','
  syscall
  li $v0, 1
  add $a0, $t5, 0
  syscall
  
  #exit program
  j exit

find: 
  #restore value to sp
  addi $sp, $sp, -36
  sw $s0, 0($sp)
  sw $s1, 4($sp)
  sw $s2, 8($sp)
  sw $s3, 12($sp)
  sw $s4, 16($sp)
  sw $s5, 20($sp)
  sw $s6, 24($sp)
  sw $s7, 28($sp)  
  sw $ra, 32($sp)
  
  #initialization for finding minimum
  li $t0, 0 #index to go through the array
  li $t1, 4 #step int with 4 byte
  addi $t2, $s0, 0 # $t2 saves minimum value 
  li $t3, 0 # 4t3 saves index of minimum value
  
  #call proc to find minimum
  jal min
 
  #initialization for finding maximum
  li $t0, 0
  li $t1, 4
  addi $t4, $s0, 0 # $t4 saves maximum value
  li $t5, 0 # $t5 saves index of maximum value
  li $t7, 0 # $t7 $t8 $t9 save temporary value
  li $t8, 0
  li $t9, 0
  
  #call proc to find maximum
  jal max

  #restore value of ra and quit the proc
  lw $ra, 32($sp)
  addi $sp, $sp, 32
  jr $ra
 
min:
  addi $t0, $t0, 1 # incease index by 1 in each loop
  
  mul $t7, $t0, $t1
  add $t9, $sp, $t7
  lw $t8, 0($t9) # load value from array
  slt $t7, $t8, $t2
  beq $t7, 1, update # if that value is smaller than $t2 => update $t2
  
  beq $t0, 7, exitMin # go to the end of the array => exit proc
  j min
  
update:
  add $t2, $t8, 0 # update minimum value
  add $t3, $t0, 0 # update index of minimum value
  beq $t0, 7, exitMin
  j min
  
exitMin: 
  jr $ra

max:
  addi $t0, $t0, 1 # incease index by 1 in each loop
  
  mul $t7, $t0, $t1
  add $t9, $sp, $t7
  lw $t8, 0($t9) # load value from array
  slt $t7, $t4, $t8
  beq $t7, 1, updateMax # if that value is greater than $t2 => update $t2
  
  beq $t0, 7, exitMax # go to the end of the array => exit proc
  j max
  
updateMax:
  add $t4, $t8, 0 # update maximum value
  add $t5, $t0, 0 # update index of maximum value
  beq $t0, 7, exitMax
  j max
  
exitMax: 
  jr $ra
  
exit:
  