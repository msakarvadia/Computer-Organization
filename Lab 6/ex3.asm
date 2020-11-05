.data 0x10000000 ##!
  display: 	.space 65536
  		.align 2
  redPrompt:	.asciiz "Enter a RED color value for the background (integer in range 0-255):\n"
  greenPrompt:	.asciiz "Enter a GREEN color value for the background (integer in range 0-255):\n"
  bluePrompt:	.asciiz "Enter a BLUE color value for the background (integer in range 0-255):\n"
  redLinePrompt:	.asciiz "Enter a RED color value for the line (integer in range 0-255):\n"
  greenLinePrompt:	.asciiz "Enter a GREEN color value for the line (integer in range 0-255):\n"
  blueLinePrompt:	.asciiz "Enter a BLUE color value for the line (integer in range 0-255):\n"
  x1Prompt: 	.asciiz "Enter x1 (integer in range 0-127):\n"  
  y1Prompt: 	.asciiz "Enter y1 (integer in range 0-127):\n"
  x2Prompt: 	.asciiz "Enter x2 (integer in range 0-127):\n"
  y2Prompt: 	.asciiz "Enter y2 (integer in range 0-127):\n"
  x3Prompt: 	.asciiz "Enter x3 (integer in range 0-127):\n"
  y3Prompt: 	.asciiz "Enter y3 (integer in range 0-127):\n"


.text 0x00400000 ##!
main:

	addi	$v0, $0, 4  			# system call 4 is for printing a string
	la 	$a0, redPrompt 		# address of columnPrompt is in $a0
	syscall           			# print the string
	# read in the R value
	addi	$v0, $0, 5			# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
 	add	$s0, $0, $v0			# copy N into $s0
 	
 	
 	
 	addi	$v0, $0, 4  			# system call 4 is for printing a string
	la 	$a0, greenPrompt 		# address of columnPrompt is in $a0
	syscall           			# print the string
	# read in the G value
	addi	$v0, $0, 5			# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
 	add	$s1, $0, $v0			# copy N into $s1
 	
 	
 	
 	addi	$v0, $0, 4  			# system call 4 is for printing a string
	la 	$a0, bluePrompt 		# address of columnPrompt is in $a0
	syscall           			# print the string
	# read in the B value
	addi	$v0, $0, 5			# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
 	add	$s2, $0, $v0			# copy N into $s2
 	
 	j setupDisplay
 	
 	
	
# Exit from the program
exit:
  ori $v0, $0, 10       		# system call code 10 for exit
  syscall               		# exit the program
  
##################################################################################
##   Do not modify any of the code above    		                        ##
##################################################################################
	
setupDisplay:
	li $t0, 0
	li $s3, 16384
##################################################################################
##   Insert your code for getting combinging the RGB integers (from 		##
##   exercise 1) here!    		                        		##

	sll $s0, $s0, 16
	sll $s1, $s1, 8
	or $s0, $s1, $s0
	or $s0, $s0, $s2
	
	addi $t1, $s0, 0
##################################################################################
	j drawDisplay
	
drawDisplay:
	mul $t3, $t0, 4
	sw $t1, display($t3)
	addi $t0, $t0, 1
	bne $t0, $s3, drawDisplay
	
	
readLineColors:
	addi	$v0, $0, 4  	
	la 	$a0, redLinePrompt 
	syscall           	
	# read in the R value
	addi	$v0, $0, 5	
	syscall 		
 	add	$s0, $0, $v0	
 	
 	
 	
 	addi	$v0, $0, 4  			
	la 	$a0, greenLinePrompt 		
	syscall           			
	# read in the G value
	addi	$v0, $0, 5			
	syscall 				
 	add	$s1, $0, $v0			
 	
 	
 	
 	addi	$v0, $0, 4  		
	la 	$a0, blueLinePrompt 	
	syscall           		
	# read in the B value
	addi	$v0, $0, 5		
	syscall 			
 	add	$s2, $0, $v0	
 	
 	
##################################################################################
##   Insert your code for getting combinging the RGB integers (from 		##
##   exercise 1) here!								##

	sll $s0, $s0, 16
	sll $s1, $s1, 8
	or $s0, $s1, $s0
	or $s0, $s0, $s2
	addi $t9, $s0, 0
	
##################################################################################	
	j setupDrawTriangle # Do not change this line
	
readLineCoordinates:
	addi	$v0, $0, 4  	
	la 	$a0, x1Prompt
	syscall           	
	addi	$v0, $0, 5	
	syscall 		
 	add	$s0, $0, $v0	
 	
 	
 	
 	addi	$v0, $0, 4  			
	la 	$a0, y1Prompt
	syscall           			
	addi	$v0, $0, 5			
	syscall 				
 	add	$a1, $0, $v0			
 	
 	
 	
 	addi	$v0, $0, 4  		
	la 	$a0, x2Prompt	
	syscall           		
	addi	$v0, $0, 5		
	syscall 			
 	add	$a2, $0, $v0	
 	
 	addi	$v0, $0, 4  		
	la 	$a0, y2Prompt	
	syscall           		
	addi	$v0, $0, 5		
	syscall 			
 	add	$a3, $0, $v0
 	
 	addi	$v0, $0, 4  		
	la 	$a0, x3Prompt	
	syscall           		
	addi	$v0, $0, 5		
	syscall 			
 	add	$t0, $0, $v0	# We only have 4 argument registers!! We're storing these 
			 	# last two values for now in $t registers, but you'll 
			 	# have to save them onto the stack!
 	
 	addi	$v0, $0, 4  		
	la 	$a0, y3Prompt	
	syscall           		
	addi	$v0, $0, 5		
	syscall 		
 	add	$t1, $0, $v0
 	
 	move $a0, $s0	
 	
 	jr $ra		#return to proper spot in draw line

setupDrawTriangle:
	# Insert any code necessary before calling drawTriangle
	jal readLineCoordinates
	

drawTriangle:
	# Insert any code necessary to prepare the stack
	addi $sp, $sp, -8	#allocate space on stack
	sw $ra, 4($sp)		#save $ra
	sw $fp, 0($sp)		#save $fp of caller
	addi $fp, $sp, 4	#set $fp of draw triangle
	
	addi $sp, $sp, -8	#allocate space on stack
	sw $t0, 4($sp)		#save x3 on stack
	sw $t1, 0($sp)		#save y3 on stack

	sub $t0, $a2, $a0	#dx = x2-x1
 	sub $t1, $a3, $a1	#dy = y2-y1
 	addi $t2, $a0, 0	#initializing x to x1
 	
 
 	
	jal drawLine 
	
	# Insert any code necessary to prepare the stack
	lw $t0, 4($sp)		# load x3 into t0
	lw $t1, 0($sp)		#load y3 into t1
	
	sw $a2, 4($sp)		#save x2 into stack
	sw $a3, 0($sp)		#save y2 into stack
	
	addi $a2, $t0, 0	#save x3 into a2
	addi $a3, $t1, 0	#save y3 into a3
	
	sub $t0, $a2, $a0	#dx = x2-x1
 	sub $t1, $a3, $a1	#dy = y2-y1
 	addi $t2, $a0, 0	#initializing x to x1

	jal drawLine
	
	addi $a0, $a2, 0	#load x3 into a0
	addi $a1, $a3, 0	#load y3 into a1
	
	lw $a2, 4($sp)		# load x2 into a2
	lw $a3, 0($sp)		#load y2 into a3
	
	sub $t0, $a2, $a0	#dx = x2-x1
 	sub $t1, $a3, $a1	#dy = y2-y1
 	addi $t2, $a0, 0	#initializing x to x1
	
	# Insert any code necessary to prepare the stack	
	
	jal drawLine 
	
	addi $sp, $fp, 4	#restore $sp
	lw $ra, 0($fp)		#restore $ra
	lw $fp, -4($fp)		#restore $fp
	j exit	     # Do not change this line	


drawLine:
##################################################################################
##   Insert your code here for setting up the stack frame and drawing 		##
##   the line itself. Return to appropriate point in drawTriangle when 		##
##   finished. You can reuse your code from exercise 2, but you'll have 	##
##   to make additions to deal with saving some arguments			##
##   on the stack and reading them from there.					##
##################################################################################
	addi $sp, $sp, -8	#allocate space on stack
	sw $ra, 4($sp)		#save $ra
	sw $fp, 0($sp)		#save $fp of caller
	addi $fp, $sp, 4	#set $fp of draw line
	
	sub $t3, $t2, $a0	# (x-x1)
	mul $t3, $t3, $t1	#mult dy *(x-x1)
	div $t3, $t3, $t0	# dy *(x-x1)/ dx
	add $t3, $t3, $a1	# y1 + dy *(x-x1)/ dx
	
	#t2 = x, t3 = y, t5 is corresponding address
	# t5 = 4*(y*128 + x)
	
	sll $t3, $t3, 7
	add $t5, $t3, $t2
	sll $t5, $t5, 2
	addi $t5, $t5, 0x10000000 #start at correct pointer
	
	sw $t9, ($t5)      # set pixel (or simply memory word)
	
	addi $t2, $t2, 1	#incrementing x
	#bne $t2, $a2, drawLine	#if x1 and x2 not equal QUESTION - should we allow them to be equal????
	
	addi $sp, $sp, 8	#restore $sp
	addi $sp, $fp, 4	#restore $sp
	lw $ra, 0($fp)		#restore $ra
	lw $fp, -4($fp)		#restore $fp
	
	ble $t2, $a2, drawLine	
	
	
	jr $ra			#return



