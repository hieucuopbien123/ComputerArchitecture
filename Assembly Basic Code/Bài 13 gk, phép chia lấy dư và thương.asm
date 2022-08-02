.data
	Message: .asciiz "Enter ticket number(must be even digit number): "
	trueMessage: .asciiz "This is a lucky number"
	falseMessage: .asciiz "This is not a lucky number"
	invalidMessage: .asciiz "Invalid number"
	oddMessage: .asciiz "The number must have even digits"
.text 
#Input dialog:
	li $v0,51
	la $a0, Message
	li $a2,18 #maximum 18 digit
	syscall
#Check if input is invalid
	seq $t5,$a1,-1 
	bnez $t5,invalidDialog
#Start count_digit
	jal count_digit #jump to count digit procedure to caculate the number of digit
	addi $s0,$v0,0 #save the number of digit in $s0
	li $t2,2 #$t2=2
	div $s0,$t2 #s0/2
	mfhi $t4 #remainder of the above save to $t4
	beqz $t4,next #if $t4=0 it means this number has even digit,then continue check_lucky
	j oddDialog #else if $t4=1 it means this number has odd digit ,then show the error dialog
next:	mflo $a1 #quotient of $s0/2 save to $a1
	jal check_lucky #jump to check lucky procedure
	addi $s1,$v0,0
	li $v0, 55
	beq $s1,0,falseDialog
	li $a1,1
	la $a0,trueMessage
	syscall
	j exit
falseDialog:
	la $a0,falseMessage
	li $a1,0
	syscall
	j exit
oddDialog:
	la $a0,oddMessage
	li $v0, 55
	li $a1,0
	syscall
	j exit
invalidDialog:
	la $a0,invalidMessage
	li $v0, 55
	li $a1,0
	syscall
	
exit:	li $v0,10
	syscall
	
	
#-----Procedure to count number of digits of a number-------
count_digit:
	add $t2,$zero,$a0 #the number
	addi $t3,$zero,0 #intital num_of_digit=0
	li $t4,10
loop_digit:	
	div $t2,$t4 #$t2/10
	mflo $t2 #$t2=$t2/10
	addi $t3,$t3,1 #num_of digit +=1
	bne $t2,0,loop_digit #loop util $t2=0
	addi $v0,$t3,0 #the result is saved to $v0
	jr $ra #jump back to the main function
check_lucky:
	addi $t0,$a0,0 # number
	addi $t1,$a1,0 # num_of_digit/2
	li $t2,0 #intitial count=0
	li $t3,0 #intitial sum1=0
	li $t4,0 #initial sum2=0
	li $t5,10
sum_low_half:	
	div $t0,$t5 #$t0/10
	mfhi $t6 #save remainder(value of digit) to $t6
	mflo $t0 #$t0=$t0/10
	addi $t2,$t2,1 #count+=1
	add $t3,$t3,$t6 #sum1+=$t6
	bne $t2,$t1,sum_low_half#loop until count =num_of_string 
sum_high_half:
	div $t0,$t5 #$t0/10
	mfhi $t6 #save remainder(value of digit) to $t6
	mflo $t0 #$t0=$t0/10
	add $t4,$t4,$t6#sum2+=$t6
	bne $t0,0,sum_high_half#loop until $t0=0
	seq $v0,$t3,$t4	 #save
	jr $ra