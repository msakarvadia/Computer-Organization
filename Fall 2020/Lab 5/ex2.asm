.data 0x0
  display:	.asciiz "****************************************************************"
  columnPrompt:	.asciiz "Enter the column to print a line at (must be an integer in the range 0-7):\n"
  newline:	.ascii "\n"
  displayChar:  .ascii "*"
  lineChar:  .ascii "|" # Note, we don't need to use asciiz here, since we're storing a single character! (using asciiz would also store\0, which would be two characters)
  
  


.text 0x3000
main:
 					# Print the prompt for reading the column
   addi	$v0, $0, 4  			# system call 4 is for printing a string
   la 	$a0, columnPrompt 		# address of columnPrompt is in $a0
   syscall           			# print the string


   addi	$v0, $0, 5			# system call 5 is for reading an integer
   syscall 				# integer value read is in $v0
   add	$s0, $0, $v0			# copy the column number into $s0
   
   li $s1 64				# $s1 will store the size of the array
  
##################################################################################
##   Insert code here for changing appropriate * characters to |                ##
##################################################################################
la $t0, display
add $t0, $t0, $s0
loop:
	la $t1, lineChar
	lb $a1, ($t1)
  	sb $a1, ($t0)
  	addi $t0, $t0, 8
  	slt $t3, $t0, $s1
  	bne $0, $t3, loop

##################################################################################
##   Insert code here for printing thre resulting display.                      ##
##   The code for printing a new line character is given to you.		##
##################################################################################  
	addi, $t8, $0, 8 #number of charecters pre row
	addi $t9, $0, 0 #number of charecters total
	
	
 la $t0, display
rows:
	addi $t7, $0, 0 #number of charecter we have printed in the row
     	col:	
		lb $a0, ($t0)
		li $v0, 11
		syscall
		addi $t0, $t0, 1
		addi $t9, $t9, 1
		addi $t7, $t7, 1
		beq $s1, $t9, exit #if we have printed all 64 charecters, exit
		bne $t8, $t7, col  #if we have printed 8 char in a row, go to next row
     		j print_new_line   #print new line between rows
  
print_new_line:
	addi $v0, $0, 11
	lb $a0, newline
	syscall
	j rows

# Exit from the program
exit:
  ori $v0, $0, 10       		# system call code 10 for exit
  syscall               		# exit the program
