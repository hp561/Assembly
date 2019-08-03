.data
stringread:     .asciz "%s"
number:     .asciz "%d"
flush:          .asciz "\n"
numbuffer: .space 1000      

string:
	.asciz "Binary output is: \n"

input:
	.asciz "Input a number to convert to binary: "


debug: 
    .asciz "debug command\n"

.text

.global main


main:       

            ldr x0, =stringread
            ldr x1, =input
            bl printf

            ldr x0, =number
            ldr x1, =numbuffer
            bl scanf

            //gets number inputed by user and loads in x19
            ldr x28, =numbuffer
            ldr x28, [x28, #0]

            mov x20, #0


            //reg to divide by 2
            mov x25, #2

            // use to mod by 2
            mov x23, #1

            //cbz x28, zeroExit
loop:

            //once number equals 0 exit


           // x24 holds mod value
            and x24, x28, x23


//            str x24, [sp, #0]
cbz x28, print_cheat


//ldr x0, =stringread
//ldr x1, =debug
//bl printf
            sub sp, sp, #16
      str x24, [sp, #0]

//ldr x0, =flush
//bl printf


//ldr x0, =number
//mov x1, x24
//bl printf
            udiv x28, x28, x25

            //used to hold index of stack pointer
            add x20, x20, #1
//cbz x28, print_cheat

b loop

print_cheat:
            //add x20, x20, #1
            //ldr x0, =flush
            //bl printf

//            mov x6, #0
//            str x6, [sp, #0]
//
//            ldr x24, [sp, #16]


//ldr x0, =flush
//bl printf

print_out:
//ldr x0, =flush
//bl printf

            ldr x24, [sp, #0]

//          subtract x20 by 1 every time
            ldr x0, =number

//          print out what is in stack
            mov x1, x24
            bl printf

//          add 4 to stack pointer

            add sp, sp, #16
sub x20,x20, #1

//          exit loop when x20 = 0
            cbz x20, exit

            b print_out

//
//
//zeroExit:
//
//
//            ldr x0, =number
//            mov x1, #0
//            bl printf
//
//
//            ldr x0, =flush
//            bl printf
//
//            mov x8, #93
//            svc #0
//

exit:       

// ldr x0, =stringread
// ldr x1, =debug
// bl printf
ldr x0, =flush
bl printf

            mov x0, #0
            mov x8, #93
            svc #0
