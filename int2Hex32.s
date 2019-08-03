.data
stringread:     .asciz "%s"
char:        .asciz "%c"
integer:     .asciz "%d"
flush:          .asciz "\n"
numbuffer: .space 1000      

string:
	.asciz "Binary output is: \n"

input:
	.asciz "Input a integer to convert to hexidecimal: "


debug: 
    .asciz "debug command\n"

.text

.global main


main:       

            ldr x0, =stringread
            ldr x1, =input
            bl printf

            ldr x0, =integer
            ldr x1, =numbuffer
            bl scanf

            //gets integer inputed by user and loads in x19
            ldr x20, =numbuffer
            ldr x20, [x20, #0]

            mov x19, #0


            //reg to divide by 16
            mov x28, #16

            // use to mod by 16
            mov x23, #15

            cbz x20, zeroExit
loop:

            //once integer equals 0 exit


           // x22 holds mod value
            and x22, x20, x23

            cmp x22, #10
            blt tenless
            bgt tengreater

            add x22, x22, #55

//            str x22, [sp, #0]
//cbz x20, print_cheat


//ldr x0, =stringread
//ldr x1, =debug
//bl printf
str:
            sub sp, sp, #16
      str x22, [sp, #0]

//ldr x0, =flush
//bl printf


//ldr x0, =integer
//mov x1, x22
//bl printf
            udiv x20, x20, x28

            //used to hold index of stack pointer
            add x19, x19, #1
        cbz x20, print_cheat

b loop

tengreater:

add x22, x22, #55

b str

tenless:

add x22, x22, #48

b str

print_cheat:
            //add x19, x19, #1
            //ldr x0, =flush
            //bl printf

//            mov x6, #0
//            str x6, [sp, #0]
//
//            ldr x22, [sp, #16]


//ldr x0, =flush
//bl printf

print_out:
//ldr x0, =flush
//bl printf

            ldr x22, [sp, #0]

//          subtract x19 by 1 every time
            ldr x0, =char

//          print out what is in stack
            mov x1, x22
            bl printf

//          add 4 to stack pointer

            add sp, sp, #16
sub x19,x19, #1

//          exit loop when x19 = 0
            cbz x19, exit

            b print_out

//
//
zeroExit:


            ldr x0, =integer
            mov x1, #0
            bl printf


            ldr x0, =flush
            bl printf

            mov x8, #93
            svc #0
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
