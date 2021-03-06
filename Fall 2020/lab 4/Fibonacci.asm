# Find the largest Fibonacci number smaller than 100
#
# Here is the C code.
#
# int x = 0;
# int y = 1;
#
# main() {
#   while (y < 100) {
#     int t = x;
#     x = y;
#     y = t + y;
#   }
# }



# And here is the corresponding MIPS assembly version.
# It has been developed by converting the C code to
# assembly line-by-line.  The corresponding line of
# C code is shown in the comments.

.data

x:    .word 0          # int x = 0;
y:    .word 1          # int y = 1;


.text

main:
     lw    $8,x        # read x into $8
     lw    $9,y        # read y into $9

while:                  # while (y < 100) {
     slti  $10,$9,100   #  y < 100?
     beq   $10,$0,endw  #  if false exit loop
     add   $10,$0,$8    #     int t = x;
     add   $8,$0,$9     #     x = y;
     add   $9,$10,$9    #     y = t + y;
     j     while        # }

endw:
     sw    $8,x         # answer is in x
     sw    $9,y         # update y as well
     ori   $v0, $0, 10  # system call 10 for exit
     syscall            # we are out of here.
