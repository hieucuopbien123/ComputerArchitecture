#Ex8
.data
  #initialize input store
  studentName: .asciiz
  string: .space 1000
  savePlaceForStudentName: .asciiz
  string4: .space 1000
  mark: .word
  string1: .space 100
  numberOfStudent: .word
  string3: .space 10
  
  #all message
  Message1: .asciiz "\nInput number of student: \n"
  Message2: .asciiz "\nInput name of student "
  Message3: .asciiz "\nInput mark of student "
  Message4: .asciiz ":\n"
  Message5: .asciiz "\nAfter sorting: \n"
  Message6: .asciiz "\n"
  Message7: .asciiz " - "
   
.text 
  #read number of student
  li $v0, 4
  la $a0, Message1
  syscall
  li $v0, 5
  syscall
  la $a1, numberOfStudent
  sw $v0, 0($a1)
  
  #load number of student to $t0
  lw $t0, 0($a1)
  
  #index start from 0
  li $t1, 0
  li $t2, 0
  li $t3, 0
  
  inputLoop:
    beq $t1, $t0, logic # go to logic when finishing input
    
    #input name student number i
    li $v0, 4
    la $a0, Message2
    syscall
    li $v0, 1
    add $a0, $t1, 1
    syscall
    li $v0, 4
    la $a0, Message4
    syscall
    li $v0, 8
    la $a0, studentName
    add $a0, $a0, $t2
    li $a1, 39
    syscall
    
    #input mark of studen number i with handling 0 < nark < 10
    j inputMarkLoop
    
    goNext:
      #increasing index
      addi $t1, $t1, 1
      addi $t2, $t2, 40
      addi $t3, $t3, 4
      j inputLoop
    
  inputMarkLoop:
    #input mark
    li $v0, 4
    la $a0, Message3
    syscall
    li $v0, 1
    add $a0, $t1, 1
    syscall
    li $v0, 4
    la $a0, Message4
    syscall
    li $v0, 5
    syscall
    la $a1, mark
    
    #if mark < 0, input again
    slti $t9, $v0, 0
    beq $t9, 1, inputMarkLoop
    
    #if mark > 10, input again
    sgt $t9, $v0, 10
    beq $t9, 1, inputMarkLoop
    
    #if 0 < mark < 10, go next
    add $a1, $a1, $t3
    sw $v0, 0($a1)
    j goNext

  logic:
    #store address of mark and name array $a0, $a1 for handle logic
    la $a0, mark
    la $a1, studentName
    
    #$s1 save the number of studen
    la $a2, numberOfStudent
    lw $s1, 0($a2)
    
    #initialize index from the zero for the first loop
    li $t1, 0
    
  loop:
    #if traverse to the end, we will show resul
    addi $t1, $t1, 1
    beq $t1, $s1, showRes
    
    #get the address of current position in the mark array
    mul $t2, $t1, 4
    mul $t3, $t1, 40
    add $t2, $a0, $t2 
    lw $t4, 0($t2) #$t4 save the current value for mark
    
    #t2 save the address of current position in studentName array
    add $t2, $a1, $t3 
    #$t9 save the student name
    la $t9, savePlaceForStudentName
    #initialize for calling proc
    li $s2, -4
    #save current student name to the array savePlaceForStudentName
    jal proc
    
    #$t2 save the address of student name array for logic handling
    addi $t2, $t9, 0
    
    #initialize start index for second loop
    addi $t3, $t1, 0 
    
    smallLoop:
      #if we traverse to the begining of array, we would finish
      add $t3, $t3, -1 
      beq $t3, -1, final 
    
      mul $t5, $t3, 4
      mul $t8, $t3, 40
      add $t6, $a0, $t5
      add $t9, $a1, $t8 # $t9 store the current address of studentName of the inside loop
      lw $t5, 0($t6) #$t5 store the current mark of the second loop
    
      #suppose we sort in descending order, if the current mark of inside loop is smaller, we need to assign a[i+1]=a[i]
      slt $t7, $t5, $t4 
      beq $t7, 1, swap
      
      sw $t4, 4($t6)
      add $t9, $t9, 40
      jal proc
      j loop
    
  swap:
    # assign mark[i+1]=mark[i]
    sw $t5, 4($t6)
    li $s2, -4
    
    #save value of t2 and initializa $t2, $t9 for the procedure
    add $s7, $t2, 0
    add $t2, $t9, 0
    add $t9, $t9, 40
    #execute procecdure for assign studentName[i+1]=studentName[i]
    jal proc
    #restore value of t2
    add $t2, $s7, 0
    
    j smallLoop
    
  final: 
    #when traverse to the start of array, we assign a[0]=a[i]. End the small loop and execute next for the big loop
    sw $t4, 0($a0)
    add $t9, $a1, 0
    jal proc
    
    j loop
    
  #This proc will assign string at $t2 to $t9
  proc:
    #initialize
    li $s2, -4
    j loopProc
  loopProc:
    #if we assign all 40 byte, we will exit the proc
    addi $s2, $s2, 4
    beq $s2, 40, getout 
    #get the address of both
    add $s4, $t2, $s2
    add $s5, $t9, $s2
    #assign 4 byte each
    lw $s6, 0($s4)
    sw $s6, 0($s5)
    #repeat
    j loopProc
  getout:
    jr $ra

  showRes:
    li $v0, 4
    la $a0, Message5
    syscall
    
    #initialize for the loopShowRes
    li $t1, 0
    la $s0, mark
    la $s1, studentName
    la $s2, numberOfStudent
    lw $s3, 0($s2)
    j loopShowRes
    
  loopShowRes: 
    #if we print all element, we would finish
    beq $t1, $s3, exit
    
    #set the address of current data to print 
    mul $t2, $t1, 4
    mul $t3, $t1, 40
    add $t4, $s0, $t2
    add $t5, $s1, $t3
    lw $t6, 0($t4)
    
    #print mark
    add $a0, $t6, 0
    li $v0, 1
    syscall
    
    #print seperator
    li $v0, 4
    la $a0, Message7
    syscall
    
    #print name
    add $a0, $t5, 0
    li $v0, 4
    syscall
    
    #increase index and repeat loop
    addi $t1, $t1, 1
    j loopShowRes
    
  exit:
