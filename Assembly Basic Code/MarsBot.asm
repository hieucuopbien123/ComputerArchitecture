.eqv HEADING 0xffff8010
.eqv MOVING 0xffff8050
.eqv LEAVETRACK 0xffff8020
.eqv WHEREX 0xffff8030
.eqv WHEREY 0xffff8040
.text 
main: 
 addi $a0, $zero, 135
 jal ROTATE
 nop
 jal GO
 nop
 sleep1: addi $v0,$zero,32
 li $a0,4000 
 syscall

 jal TRACK
 nop
 
goDOWN: addi $a0, $zero, 180
 jal ROTATE
 nop
 
sleep2: addi $v0,$zero,32
 li $a0,4000 
 syscall
 jal UNTRACK
 nop
 jal TRACK
 nop
 
goUP: addi $a0, $zero, 0
 jal ROTATE
 nop
 
sleep3: addi $v0,$zero,32
 li $a0,2000 
 syscall
 jal UNTRACK
 nop
 jal TRACK 
 nop
 
goRIGHT:addi $a0, $zero, 90
 jal ROTATE 
 nop
 
sleep4: addi $v0,$zero,32
 li $a0,2000 
 syscall 
 
 jal UNTRACK
 nop
 jal TRACK
 nop 
 
goUP2:addi $a0, $zero, 0 
 jal ROTATE 
 nop
sleep5: addi $v0,$zero,32
 li $a0,2000 
 syscall 
 jal UNTRACK
 nop
 jal TRACK
 nop
 
goDOWN2:addi $a0, $zero, 180
 jal ROTATE 
 nop
sleep6: addi $v0,$zero,32
 li $a0,4000 
 syscall 
 jal UNTRACK
 nop
 
 jal STOP
 nop
 syscall 

end_main:
 
#-----------------------------------------------------------
# GO procedure, to start running
# param[in] none
#-----------------------------------------------------------
GO: li $at, MOVING # change MOVING port
 addi $k0, $zero,1 # to logic 1,
 sb $k0, 0($at) # to start running
 nop 
 jr $ra
 nop
#-----------------------------------------------------------
# STOP procedure, to stop running
# param[in] none
#----------------------------------------------------------
STOP: li $at, MOVING # change MOVING port to 0
 sb $zero, 0($at) # to stop
 nop
 jr $ra
 nop
#-----------------------------------------------------------
# TRACK procedure, to start drawing line 
# param[in] none
#----------------------------------------------------------- 
TRACK: li $at, LEAVETRACK # change LEAVETRACK port
 addi $k0, $zero,1 # to logic 1,
 sb $k0, 0($at) # to start tracking
 nop
 jr $ra
 nop 
#-----------------------------------------------------------
# UNTRACK procedure, to stop drawing line
# param[in] none
#----------------------------------------------------------- 
UNTRACK:li $at, LEAVETRACK # change LEAVETRACK port to 0
 sb $zero, 0($at) # to stop drawing tail
 nop
 jr $ra
 nop
#-----------------------------------------------------------
# ROTATE procedure, to rotate the robot
# param[in] $a0, An angle between 0 and 359
# 0 : North (up)
# 90: East (right)
# 180: South (down)
# 270: West (left)
#-----------------------------------------------------------
ROTATE: li $at, HEADING # change HEADING port
 sw $a0, 0($at) # to rotate robot
 nop
 jr $ra
 nop
