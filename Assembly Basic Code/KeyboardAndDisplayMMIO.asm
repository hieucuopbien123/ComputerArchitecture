.eqv KEY_CODE 0xFFFF0004
.eqv KEY_READY 0xFFFF0000
.eqv DISPLAY_CODE 0xFFFF000C
.eqv DISPLAY_READY 0xFFFF0008
.text
 li $k0, KEY_CODE
 li $k1, KEY_READY
 li $s0, DISPLAY_CODE
 li $s1, DISPLAY_READY
loop: nop
 
WaitForKey: lw $t1, 0($k1)
 nop
 beq $t1, $zero, WaitForKey
 nop
ReadKey: lw $t0, 0($k0)
 nop
WaitForDis: lw $t2, 0($s1)
 nop
 beq $t2, $zero, WaitForDis
 nop

#Can do like press "exit" to exit by use like state machine, press each button then change current state of program

#Stop when pressing q 
Encrypt: addi $t0, $t0, 0
 beq $t0, 113, end

ShowKey: sw $t0, 0($s0)
 nop 
 
 j loop
 nop
end:
