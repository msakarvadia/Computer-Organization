# Add the numbers in an array
#
# Here is the C code for adding 5 numbers from an array.
#
# int sum, i;
# int a[5] = {7,8,9,10,8};
#
# main() {
#   sum = 0;
#   for (i=0; i<5; i++)
#     sum = sum + a[i];
# }

# And here is the corresponding MIPS assembly version.
# It has been developed by converting the C code to
# assembly line-by-line.  The corresponding line of
# C code is shown in the comments.



# For this example, we put the variables sum, i and the array a[]
# in memory, using the ".data" directive.  Notice that while ".word"
# is used to specify one or more words (32-bit values), the directive
# ".space" is used to simply reserve some space without filling it
# with a value.  That is, ".word" reserves space *and* fills it with
# a word value.  But ".space 4" reserves space of size 4 bytes (=word),
# and leave it uninitialized.

# Registers $8, $9 and $10 are again used as scratch registers.
# $8 holds sum and $9 holds i.  $10 is a scratch register that holds
# several temporary results, namely:  the array offset i*4, 
# the array element a[i], and the Boolean (i<5).


.data

sum:    .space 4
i:      .space 4
a:      .word 7,8,9,10,8

.text

main:

     add   $8,$0,$0     # sum in $8 = 0
     add   $9,$0,$0     # i in $9 = 0

loop:
     sll   $10,$9,2     # convert "i" to word offset by multiplying by 4
     lw    $10,a($10)   # load a[i]
     add   $8,$8,$10    # sum = sum + a[i];
     addi  $9,$9,1      # for (...; ...; i++
     slti  $10,$9,5     # for (...; i<5;
     bne   $10,$0,loop

     sw    $8,sum($0)   # update final sum in memory
     sw    $9,i($0)     # update final i in memory
end:
     ori   $v0, $0, 10  # system call 10 for exit
     syscall            # we are out of here.
