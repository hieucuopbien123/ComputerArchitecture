.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012 
.data
Message: .asciiz "Oh my god. Someone's presed a button.\n"
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MAIN Procedure
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.text
main:
 #---------------------------------------------------------
 # Enable interrupts you expect
 #---------------------------------------------------------
 # Enable the interrupt of Keyboard matrix 4x4 of Digital Lab Sim
 li $t1, IN_ADRESS_HEXA_KEYBOARD
 li $t3, 0x80 # bit 7 of = 1 to enable interrupt => cu bit 7 bang 1 thi bam phim se tu tao interrupt
 sb $t3, 0($t1)
 #---------------------------------------------------------
 # No-end loop, main program, to demo the effective of interrupt
 #---------------------------------------------------------
Loop: nop
 nop
 nop
 nop
 b Loop # Wait for interrupt
end_main:
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# GENERAL INTERRUPT SERVED ROUTINE for all interrupts
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.ktext 0x80000180 
 #--------------------------------------------------------
 # Processing ktext below
 #-------------------------------------------------------- 
IntSR: 
 addi $v0, $zero, 4 # show message 
 la $a0, Message
 syscall
 #--------------------------------------------------------
 # Evaluate the return address of main routine
 # epc <= epc + 4
 #--------------------------------------------------------
next_pc:
 mfc0 $at, $14 # $at <= Coproc0.$14 = Coproc0.epc => doc gia tri thanh ghi epc $14
 addi $at, $at, 4 # $at = $at + 4 (next instruction) => cong gia tri do len
 mtc0 $at, $14 # Coproc0.$14 = Coproc0.epc <= $at => luu lai gia tri vao thanh ghi $14 epc
return: eret # Return from exception => chay vao gia tri thanh ghi $14 epc