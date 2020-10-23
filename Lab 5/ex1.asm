.data 0x0
  
  nPrompt:	.asciiz "Enter the size (N) of the array:\n"
  newline:	.asciiz "\n"
  displayChar:  .asciiz "*"
  lineChar:  .asciiz "|"
  


.text 0x3000
main:
				# Print the prompt for reading N
	addi	$v0, $0, 4  			# system call 4 is for printing a string
	la 	$a0, nPrompt 		# address of nPrompt is in $a0
	syscall           			# print the string
	
	# read in the N (number of elements)
	addi	$v0, $0, 5			# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
 	add	$s0, $0, $v0			# copy N into $s0
	
##################################################################################
##   Insert code here for reading N array elements into memory                  ##
##################################################################################
	addi 	$t0, $0, 0			#initialize location of memory to be zero
	addi 	$t1, $s0, 0			#keep an additional variable of N
read:
	addi	$v0, $0, 5			# system call 5 is for reading an integer
	syscall 				# integer value read is in $v0
	#store word into memory
	addi 	$t0, $t0, 4 			#increment location of next word
	sw 	$v0, 0($t0)			#store word into memory
	subi	$s0, $s0, 1
	bne	$s0, $0, read
		
	
##################################################################################
##   Insert code here for reversing the elements in memory                      ##
##################################################################################	
reverse:
	lw	$t2, 0($t0)				
  	addi 	$v0, $0, 1  			# system call 1 is for printing an integer
  	add 	$a0, $0, $t2 			# load word into $a0
  	syscall           			# print the integer
  	
  	 	  				# Print a newline
 	addi $a0, $0, 0xA 			#ascii code for LF, if you have any trouble try 0xD for CR.
        addi $v0, $0, 0xB			#syscall 11 prints the lower 8 bits of $a0 as an ascii character.
        syscall
 	
 	subi	$t0, $t0, 4			#decrement memory location
  	
	subi	$t1, $t1, 1			#move this into a temporary
	bne	$t1, $0, reverse
	
##################################################################################
##   Insert code here for printing the reversed array                           ##
##################################################################################


# Exit from the program
exit:
  ori $v0, $0, 10       		# system call code 10 for exit
  syscall               		# exit the program
