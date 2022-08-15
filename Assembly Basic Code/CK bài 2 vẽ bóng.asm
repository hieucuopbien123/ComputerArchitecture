.data

buffer: .space 0x100000

buffer1: .space 10000
Message: .asciiz "”

# Set up key code read key MIMO
.eqv KEY_READY 0xFFFF0000 
.eqv KEY_CODE 0xFFFF0004
.eqv COLOR 0x00FF0000 # RED

.text
li $k1, KEY_READY # = 1 when a key is pressed, =0 when use lw to read
li $k0, KEY_CODE # ASCII code at low-order byte of 0xFFFF0004


# set up for bitmap display

# start game
li $v0, 51
la $a0, Message
syscall 
addi $t0, $a0, 0

li $a0, 0
li $v0, 0

color:
li $t4, 256 # $t4 = x_center = 256 first position
li $t5, 256 # $t5 = y_center = 256
li $t3, COLOR # color red in bitmap display
la $t1, buffer
li $t6, 262144 # area of display = 512 x 512 initialization different from a w d s code
#li $t0, 4 # => speed = 4 or 8 
li $t9, 32 # => Radius = 16 or 32



update:

waitForKey: 
  lw $t8, 0($k1)
  nop
  beq $t8, $zero, option # get the key
  nop
  
  # read key
  lw $t6, 0($k0) # t6 store the key code when press
  j option

combackRight:
  li $t6 , 100
  j option

combackLeft:
  li $t6, 97	
  j option
  
combackDown:
  li $t6 , 115
  j option

combackUp:
  li $t6 , 119
  j option
		
option:
  beq $t6, 100, moveRight # press d
  beq $t6, 97, moveLeft	# press a
  beq $t6, 119, moveUp	# press w 
  beq $t6, 115, moveDown # press s
  li $t3, COLOR 
  jal drawCircle
  j waitForKey

moveUp:
  # erase old position circle by draw the same color with the screen => black
  li $t3, 0x000000 
  jal drawCircle

  sub $t4, $t4, $t0 # move center point of circle up

  # draw new position circle with specific color
  li $t3, COLOR 
  jal drawCircle

  # check position of center point, if x = 32 then collide with upper bound -> move down
  beq $t4, $t9, combackDown
  
  # loop again to catch next keyboard character
  j update

moveRight:
  li $t3, 0x000000
  jal drawCircle

  add $t5, $t5, $t0

  li $t3, COLOR 
  jal drawCircle

  beq $t5, 480, combackLeft
  j update

moveDown:
  li $t3, 0x000000
  jal drawCircle

  add $t4, $t4, $t0

  li $t3, COLOR 
  jal drawCircle

  beq $t4, 480, combackUp
  j update

moveLeft:
  li $t3, 0x000000
  jal drawCircle

  sub $t5, $t5, $t0

  li $t3, COLOR 
  jal drawCircle

  beq $t5, $t9, combackRight
  j update

# Procedure draw circle
drawCircle:
  # store data
  sw $fp, -4($sp) # save frame pointer to -4
  addi $fp, $sp ,0 # fp point to 0 is the end
  addi $sp, $sp, -8 # sp point to -8 is the beginning
  sw $ra, 0($sp) # save data ra to -8

  addi $s0, $t9, 0  # $s0 = y = R = $t9 => radius
  li $s1, 0   # $s1 = x = 0

  # draw first 4 point, A is center
  add $s3, $s0, $t4 # s3 = Ax + R
  add $s4, $s1, $t5 # s4 = Ay + 0
  jal drawPoint

  add $s3, $s1, $t4 # s3 = Ax + 0
  add $s4, $s0, $t5 # s4 = Ay + R
  jal drawPoint

  sub $s3, $t4, $s0 # s3 = Ax - R
  add $s4, $s1, $t5 # s4 = Ay + 0
  jal drawPoint
  
  add $s3, $s1, $t4 # s3 = Ax + 0
  sub $s4, $t5, $s0 # s4 = Ay - R
  jal drawPoint

  # Draw remaining point
  # Draw from (0, R) = (s1, s0) in one 1/8 part
  subi $t7, $t9, 1  # $t7 = P = 1 - R = 1 - t9
  sub $t7, $zero, $t7
loop1:
  addi $s1, $s1, 1 # x = x + 1

  # update Pi+1 if Pi < 0 or >= 0
  ble $t7, $zero, getHigherPoint
  subi $s0, $s0, 1
  addi $t7, $t7, 5
  add $t7, $t7, $s1 
  add $t7, $t7, $s1
  sub $t7, $t7, $s0
  sub $t7, $t7, $s0 # P = P + 2x - 2y + 5
  j next

getHigherPoint: 
  addi $t7, $t7, 3
  add $t7, $t7, $s1 
  add $t7, $t7, $s1 # P = P + 2x + 3
        	   	
next: 
  blt $s0, $s1, done # if y < A , finish drawing first quater -> end

  add $s3, $s0, $t4 # s3 = x + Ax
  add $s4, $s1, $t5 # s4 = y + Ay
  jal drawPoint

  sub $s3, $t4, $s0 # s3 = Ax - x
  add $s4, $s1, $t5 # s3 = Ay + y
  jal drawPoint

  add $s3, $s0, $t4 # s3 = x + Ax
  sub $s4, $t5, $s1 # s4 = Ay - y
  jal drawPoint
  
  sub $s3, $t4, $s0 # s3 = Ax - x
  sub $s4, $t5, $s1 # s4 = Ay - y
  jal drawPoint

  beq $s0,$s1, nextLoop1 # x = y => next loop right away because of duplicate point, also finish drawing in the next loop
  
  add $s3, $s1, $t4 # s3 = y + Ax
  add $s4, $s0, $t5 # s4 = x + Ay
  jal drawPoint
  
  sub $s3, $t4, $s1 # s3 = Ax - y
  add $s4, $s0, $t5 # s4 = Ay + x
  jal drawPoint 
  
  add $s3, $s1, $t4 # s3 = Ax + y
  sub $s4, $t5, $s0 # s4 = Ay - x 
  jal drawPoint
  
  sub $s3, $t4, $s1 # s3 = Ax - y
  sub $s4, $t5, $s0 # s3 = Ay - x
  jal drawPoint

nextLoop1:
  bgt $s0, $s1, loop1 # y > x, do it again
  j done



# Fill the coordiate (x,y) = ($s3, $s4)
drawPoint: 
  # save data to stack pointer
  sw $fp, -4($sp) # save fp to -4
  addi $fp, $sp, 0 # fp = 0 is the end
  addi $sp, $sp, -8 # sp = -8 is the beginning
  sw $ra, 0($sp) # save data ra to 0 

  # calculate relative
  mul $s3, $s3, 512 
  add $s3, $s3, $s4 
  mul $s3, $s3, 4 # relative = (x*512 + y )*4 (1 element took 4 bytes)

  # show it on bitmap
  la $t1, buffer # reset t1 to (0,0)
  add $t1, $t1 , $s3
  sw $t3, 0($t1)
  la $t1, buffer # reset $t1 to (0,0)
  
  # restore data from stack pointer
  lw $ra, 0($sp) # restore pointer ra
  addi $sp, $fp, 0 # restore sp
  lw $fp, -4($sp) # restore fp
  jr $ra



done:
  # restore for drawCircle function
  lw $ra, 0($sp) # restore pointer ra
  addi $sp, $fp, 0 # restore sp pointer
  lw $fp, -4($sp) # restore fp pointer
  jr $ra 
