# Assembly starter file for Exercise 3

.data 0x0
  
  columnPrompt:	.asciiz "Enter the column to print a line at (must be an integer in the range 0-7):\n"
  newline:	.asciiz "\n"
  displayChar:  .asciiz "*"
  lineChar:  .asciiz "|"
  


.text 0x3000

main:
 	# Print the prompt for reading the column number
  addi	$v0, $0, 4  			# system call 4 is for printing a string
  la 	$a0, columnPrompt 		# address of columnPrompt is in $a0
  syscall           			# print the string


  addi	$v0, $0, 5			# system call 5 is for reading an integer
  syscall 				# integer value read is in $v0
  add	$s0, $0, $v0			# copy the column number into $s0
  

  addi $9, $0, 7			#$9 holds how many * should be in a row
  addi $10, $0, 8			#$10 holds how many rows there should be

  add $11, $0, $0			#$11 register for storing number of rows that have been printed
  
Rows:
  add $8, $0, $0			#$8 register for storing columns of *, initialized to zero 
 	# Print star
printRow:  
  beq   $8, $s0, bar

  back_to_row:
  addi	$v0, $0, 4  			  # system call 4 is for printing a string
  la 	$a0, displayChar		  # address of columnPrompt is in $a0
  syscall           			  # print the string
  addi  $8,  $8, 1			  #increment star counter
  
  addi  $t9, $8, 1
  beq   $s0, $8, bar_end
 
  bne	$9, $8, printRow
  
   	# Print new line
  addi	$v0, $0, 4  			  # system call 4 is for printing a string
  la 	$a0, newline 			  # address of columnPrompt is in $a0
  syscall           			  # print the string

  addi $11, $11, 1			  #increments number of rows printed
  bne	$10, $11, Rows
   
 	# Print new line
  addi	$v0, $0, 4  			  # system call 4 is for printing a string
  la 	$a0, newline 			  # address of columnPrompt is in $a0
  syscall           			  # print the string
  
# Print bar
bar:
  beq $10, $11, exit
  addi	$v0, $0, 4  			  # system call 4 is for printing a string
  la 	$a0, lineChar 			  # address of columnPrompt is in $a0
  syscall           			  # print the string
  j back_to_row
  
bar_end:
  beq $10, $11, exit
  addi	$v0, $0, 4  			  # system call 4 is for printing a string
  la 	$a0, lineChar 			  # address of columnPrompt is in $a0
  syscall  
  bne	$9, $8, printRow		  #if we didn't print bar at end of line, go back to row of * loop and finish
   	# Print new line
  addi	$v0, $0, 4  			  # system call 4 is for printing a string
  la 	$a0, newline 			  # address of columnPrompt is in $a0
  addi $11, $11, 1			  #increments number of rows printed (if | comes at end of row)
  syscall  

  bne	$10, $11, Rows			  #if we havn't printed all our rows, reloop

 

   

	# Exit from the program
exit:
  ori $v0, $0, 10       		# system call code 10 for exit
  syscall               		# exit the program
