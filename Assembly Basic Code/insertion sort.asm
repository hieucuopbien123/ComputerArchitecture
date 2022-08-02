.data
  A: .word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5 # initialize
  Aend: .word # helper array to get the last index of the array

.text
  main: 
    la $a0, A #$a0 = Address(A[0])
    la $a1, Aend # a1 = address to check wether we haven't gone through all elements of the array
    la $v0, A 
    addi $v0, $v0, 4 # v0 is current address 
    j sort #sort
    
  sort: 
    lw $t0, 0($v0) #save value of current element
    add $t1, $v0, $zero# save address for the inside loop
    add $t3, $v0, $zero# save address for the inside loop
    j compare
    
  compare: 
    addi $t1, $t1, -4 # we go though the array from the current index backwards
    beq $t1, $a0, comparelast 
    lw $t6, 0($t1) 
    slt $t2, $t6, $t0
    bne $t2, $zero, ok # check if the previous element is bigger than the current element of the inside loop 

    sw $t6, 0($t3) # we assign value of current element of inside loop
    addi $t3, $t3, -4 # decrease index of 
    
    j compare
    
  comparelast:# when the current element is the first element in the array, we will do the same and go to the next element
    lw $t6, 0($t1)
    slt $t2, $t6, $t0
    bne $t2, $zero, ok
    sw $t6, 0($t3)
    addi $t3, $t3, -4
    j ok
    
  ok:
    sw $t0, 0($t3) # insert the element in its right order
    addi $v0, $v0, 4 # increase the current index of outside loop
    beq $v0, $a1, end
    j sort
  end: 
    
