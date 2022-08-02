#Laboratory Exercise 4, Lab Assignment 2
.text
addi $s0, $zero, 0x12345678

andi $t0, $s0, 0xFF000000 # get MSB of $s0
srl $t0, $t0, 24

andi $s0, $s0, 0xFFFFFF00 # clear LSB of $s0

ori $s0, $s0, 0x000000FF # set LSB of $s0

xor $s0, $s0, $s0 # clear $s0

EXIT: