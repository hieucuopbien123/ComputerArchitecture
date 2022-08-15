.data 

parity : .space 1000
input : .space 400
Message: .asciiz "Enter the string"
Error1: .asciiz "The length of the string must be divisible by 8"
Disk1str: .asciiz "Disk1"
Disk2str: .asciiz "Disk2" 
Disk3str: .asciiz "Disk3"
newline : .asciiz "\n" 
space20: .asciiz "                    "
dash20: .asciiz "--------------------"
space : .asciiz "            "
space1:  .asciiz "             "
spacestr2: .asciiz "                          "
stringtoload : .space 10
spacestr1: .asciiz "       "
paritytoload: .space 20
straight: .asciiz "|"
comma : .asciiz ","
.text 


 
 li $v0, 54
 la $a0, Message
 la $a1, input
 la $a2, 100
 syscall 
 
 la $t1 ,input
 li $t2,0
 loop_strlen:
 lb $t3,0($t1)
 beq $t3,0,end_strlen
 addi $t1,$t1,1
 addi $t2,$t2,1
 j loop_strlen
 end_strlen:
 subi $t2,$t2,1 #because \0
 li $t4,8
 div $t2,$t4
 mfhi $t5
 mflo $t6
 addi $s6,$t6,0
 beq $t5,0,main_function
 li $v0,55
 la $a0,Error1
 li $a1,0
 syscall
 li $v0,10
 syscall
 main_function:
 la $s7,parity
 la $t1,input
 addi $t2,$t6,0
 subi $t1,$t1,8
 addi $t4,$t1,0
 loop_main:
  addi $t4,$t4,8
  addi $t5,$t4,4
  li $t6,4
  addi $s1,$t4,0
  addi $s2,$t5,0
  loop_xor:
  lb $t7,0($s1)
  lb $t8,0($s2)
  xor $t9,$t7,$t8
  li $t3,16
  div $t9 ,$t3
  mfhi $s3
  mflo $t9
  slti $s4,$s3,10
  bne $s4,1,bit2_greater
  addi $s3,$s3,48
  j end_bit2
  bit2_greater: 
  addi $s3,$s3,55
  end_bit2:
  addi $s7,$s7,1
  sb $s3,0($s7)
  subi $s7,$s7,1
  div $t9 ,$t3
  mfhi $s3
  mflo $t9
  slti $s4,$s3,10
  bne $s4,1,bit1_greater
  addi $s3,$s3,48
  j end_bit1
  bit1_greater: 
  addi $s3,$s3,55
  end_bit1:
  sb $s3,0($s7)
  addi $s7,$s7,2
  addi $s1,$s1,1
  addi $s2,$s2,1
  subi $t6,$t6,1
  bne $t6,0,loop_xor
  subi $t2,$t2,1
 bne $t2,0,loop_main
 li $v0, 4
 la $a0, space20
 syscall 
 li $v0, 4
 la $a0, Disk1str
 syscall 
 li $v0, 4
 la $a0, space1
 syscall 
  li $v0, 4
 la $a0, space1
 syscall 
  li $v0, 4
 la $a0, Disk2str
 syscall 
 li $v0, 4
 la $a0, space1
 syscall
  li $v0, 4
 la $a0, space1
 syscall  
  li $v0, 4
 la $a0, Disk3str
 syscall 
  li $v0, 4
 la $a0, newline
 syscall 
  li $v0, 4
 la $a0, space
 syscall 

  li $v0, 4
 la $a0, dash20
 syscall 
  li $v0, 4
 la $a0, space
 syscall 


  li $v0, 4
 la $a0, dash20
 syscall 

  li $v0, 4
 la $a0, space
 syscall 

  li $v0, 4
 la $a0, dash20
 syscall
  li $v0, 4
 la $a0, newline
 syscall
 
 la $s0,input
 la $s1,parity
 li $t0,3
 loop_print:
 li $t1,1
 print_each:
 bne $t1,$t0,print_str
 print_parity:
 li $t2,4
 li $v0,4
 la $a0,space
 syscall
 li $v0, 11
 li $a0, '['
 syscall 
  li $v0, 11
 li $a0, '['
 syscall 
  li $v0, 11
 li $a0, ' '
 syscall 
   li $v0, 11
 li $a0, ' '
 syscall 
 
 loop_print_parity:
 li $v0,11
 lb $a0,0($s1)
 syscall
 addi $s1,$s1,1
 li $v0,11
 lb $a0,0($s1)
 syscall
 addi $s1,$s1,1
 beq $t2,1,print_end_char
 li $v0,11
 li $a0,44
 syscall
 j sub_t2
 print_end_char:
 li $v0, 11
 li $a0, ' '
 syscall 
 li $v0, 11
 li $a0, ' '
 syscall 
 li $v0, 11
 li $a0, ' '
 syscall 
 li $v0, 11
 li $a0, ']'
 syscall 
 li $v0, 11
 li $a0, ']'
 syscall 
 
 sub_t2:
 subi $t2,$t2,1
 bne $t2,0,loop_print_parity
 
 j condition
 print_str:
 
 li $t2,4
 li $v0,4
 la $a0,space
 syscall
 li $v0,4
 la $a0,straight
 syscall
 li $v0,4
 la $a0,spacestr1
 syscall
 loop_print_str:
 
  
 li $v0,11
 lb $a0,0($s0)
 syscall
 addi $s0,$s0,1
 subi $t2,$t2,1
 bne $t2,0,loop_print_str
 condition:
 bne $t0,$t1,print_endl
 j condit
 print_endl:
 li $v0,4
 la $a0,spacestr1
 syscall
 li $v0,4
 la $a0,straight
 syscall
 condit:
 addi $t1,$t1,1
 bne $t1,4,print_each
 subi $s6,$s6,1
 li $v0, 11
 li $a0, '\n'
 syscall 
 subi $t0,$t0,1
 beq $t0,0,reassign
 j next_loop
 reassign :
 li $t0,3
 next_loop:
 bne $s6,0,loop_print
  li $v0, 4
 la $a0, space
 syscall 

  li $v0, 4
 la $a0, dash20
 syscall 
  li $v0, 4
 la $a0, space
 syscall 


  li $v0, 4
 la $a0, dash20
 syscall 

  li $v0, 4
 la $a0, space
 syscall 

  li $v0, 4
 la $a0, dash20
 syscall




 
  
 
 
 
 
