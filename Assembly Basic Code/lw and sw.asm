.data # DECLARE VARIABLES
X : .word 5 # Variable X, word type, init value = 
Y : .word -1 # Variable Y, word type, init value = 
Z : .word # Variable Z, word type, no init value
.text # DECLARE INSTRUCTIONS 
 # Load X, Y to registers
 la $t8, X # Get the address of X in Data Segment
 la $t9, Y # Get the address of Y in Data Segment
 lw $t1, 0($t8) # $t1 = X => luu gia tri tu vi tri 0 cuca $t8 vào $t1
 lw $t2, 0($t9) # $t2 = Y
 # Calcuate the expression Z = 2X + Y with registers only
 add $s0, $t1, $t1 # $s0 = $t1 + $t1 = X + X = 2X
 add $s0, $s0, $t2 # $s0 = $s0 + $t2 = 2X + Y
 # Store result from register to variable Z
 la $t7, Z # Get the address of Z in Data Segment 
 sw $s0, 0($t7) # Z = $s0 = 2X + Y => luu gia tri cua $s0 vao vi tri 0 cua $t7

#Co che: la se load dia chi chua bien X, Y trong Data Segment l?u vao thanh ghi nao
#lw se lay gia tri tai dia chi nao luu vao thanh ghi nao
#la + lw: lay gia tri tai dia chi
#la + sw: luu gia tri tai thanh ghi vao vi tri nao
#0($t1) chang han tuc la $t1 co gia tri la 1 dia chi va ta dang refer toi vi tri 0 cua thanh dia chi do trong DATA SEGMENT