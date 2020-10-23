.data 0x0
  array:	.word 20, 39, 20, 31, 40, 21, 31, 25, 20, 35, 27, 33, 39, 32, 33, 28
  readIntPrompt: .asciiz "Enter next integer (in range 20-40):\n"
  minPrompt:	.asciiz "Enter the new min value (an integer in the range 0-19):\n"
  maxPrompt:	.asciiz "Enter the new max value (an integer in the range 41-255):\n"
  newline:	.ascii "\n"
  .align 4 # This ensures that the space character is in the lowest order byte of its word
  spaceChar:    .asciiz " "



.text 0x3000
main:

##################################################################################
##   Insert code here for reading 16 integers into memory                       ##
##################################################################################
    
 					
   addi	$v0, $0, 4  			
   la 	$a0, minPrompt
   syscall           


   addi	$v0, $0, 5
   syscall 	
   add	$s0, $0, $v0 # NewMin is stored in $s0
   
   					
   addi	$v0, $0, 4  			
   la 	$a0, maxPrompt 		
   syscall           			


   addi	$v0, $0, 5			
   syscall 				
   add	$s1, $0, $v0 # NewMax is stored in $s1
   
   
##################################################################################
##   Insert code here for performing normalization of data                      ##
##################################################################################
  	addi 	$t2, $0, 0
  	la      $t1, array
  	addi 	$t5, $0, 20	#min
  	addi 	$t6, $0, 40	#max
  	sub	$s1, $s1, $s0	#s1 has the newMax-newMin
  	
  	
 loop:
 	#t4 must contain the value we want
	addi 	$t4, $0, 0 	#we need $t4 to contain the value we want to replace the element with
	lw	$t7, ($t1) 	#value of I
	sub	$t8, $t6, $t5	#t8 has the max-min
	div	$t8, $s1, $t8 	#t8 is now (newMax-newMin)/(max-min)
	sub	$t4, $t7, $t5	#t4 contains I-min
	mul	$t9, $t4, $t8	#t9 is now (I - Min)((newMax-newMin)/(Max - Min))
	add	$t4, $t9, $s0	#t4 contains full calculated value
	sw 	$t4, ($t1)
	addi	$t1, $t1, 4	#This is how we jump to next address of array
  	addi    $t2, $t2, 1
  	slti	$t3, $t2, 16
  	bne	$0, $t3, loop
  	
##################################################################################
##   Insert code here for printing the normalized data. 			##
##   Separate each number with a space character.                               ##
##   You can adapt your ex2 printing for this part.				##
##################################################################################
	addi, $t8, $0, 4 #number of charecters pre row
	li      $v0, 0
   	la      $t1, array
rows:
    addi $t7, $0, 0 #number of charecter we have printed in the row
    col:
    bge     $t0, 16, exit

    # load word from addrs and goes to the next addrs
    lw      $t2, 0($t1)
    addi    $t1, $t1, 4

    # syscall to print value
    li      $v0, 1      
    move    $a0, $t2
    syscall
    # syscall number for printing character (space)
    li      $a0, 32
    li      $v0, 11  
    syscall

    addi $t7, $t7, 1   #incremented number of charecters printed on a row

    #increment counter
    addi    $t0, $t0, 1
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
