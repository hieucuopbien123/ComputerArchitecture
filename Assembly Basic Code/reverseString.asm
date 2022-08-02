#co che: luu address string1 giam tu cuoi, luu address string 2 tang tu dau. lan luot gan 1 cho 2
.data
  Message: .space 22 # Buffer 100 byte chua chuoi ki tu can 
  ReverseString: .space 22
.text
  li $v0, 8
  la $a0, Message
  li $a1, 21
  syscall
  
  get_length: 
    la $a0, Message # a0 = Address(string[0])
    xor $v0, $zero, $zero # v0 = length = 0
    xor $t0, $zero, $zero # t0 = i = 0
  check_char: add $t1, $a0, $t0 # t1 = a0 + t0 = Address(string[0]+i) 
    lb $t2, 0($t1) # t2 = string[i]
    beq $t2,$zero,end_of_str # Is null char? 
    addi $v0, $v0, 1 # v0=v0+1->length=length+1
    addi $t0, $t0, 1 # t0=t0+1->i = i + 1
    j check_char
  end_of_str: 
  end_of_get_length:
  sub $v0, $v0, 1
  
  la $a1, ReverseString
  reverse_str:
    add $s0, $zero, $v0 #s0 = i=0
    add $s1, $zero, $zero
  L1:
    add $t1, $s0, $a0 # lay dia chi cua a0[s0] vao t1
    lb $t2, 0($t1) #t2 = value at t1 = y[i]
    add $t3, $s1, $a1 #t3 = s0 + a0 = i + x[0] = address of x[i]
    sb $t2, 0($t3) #x[i]= t2 = y[i]
    beq $t2, $zero, end_of_rever_str #if y[i]==0, exit
    nop
    subi $s0,$s0,1 #s0=s0 + 1 <-> i=i+1
    addi $s1,$s1,1 #s0=s0 + 1 <-> i=i+1
    j L1 #next character
    nop
  end_of_rever_str:
  li $v0, 4
  la $a0, ReverseString
  syscall
