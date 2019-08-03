.data
outformat:     .asciz "%c"  
flush:          .asciz "\n"      
stringread:     .asciz "%s" 
lengthread:     .asciz "%d" 
strbuffer: .space 400       
lenbuffer: .space 8       

string:
	.asciz "Length of string is: "

input:
	.asciz "Input a string to see if it is a palindrome: "

notpali:
    .asciz "Not a palindrome\n"

yespali:
    .asciz "This is a palindrome\n"

debug: 
    .asciz "debug command\n"


.text

.global main


main:       

            ldr x0, =stringread
            ldr x1, =input
            bl printf

            ldr x0, =stringread
            ldr x1, =strbuffer
            bl scanf

            

            //length counter
            mov x19, #0
            
            //string address
            ldr x1, =strbuffer


            b loop

            //iterates through string and stores count in x19 until it reaches null
            loop: 
            ldrb w0, [x1, x19]

             cmp w0, #0
             beq gotlength   
             add x19, x19, #1


             b loop



gotlength:

            ldr x0, =stringread
            ldr x1, =string
            bl printf


            ldr x0, =lengthread
            mov x1, x19
            bl printf
           
            #Flush the stdout buffer
            ldr x0, =flush
            bl printf


            #Change length to length-1
            sub x19, x19, #1 

            #Move string address to x1
            ldr x1, =strbuffer

            ldr x20, =strbuffer

            //length counter of original string
            mov x23, #0
           
            

//            b exit

            #Starting index for reverse
            mov x2, #0

            #Branch to reverse, setting return address
            bl reverse


            #Exit the program
            b exit


reverse:    #In reverse we want to maintain
            #x19 is length-1
            #x1 is memory location where string is
            #x2 is index

            subs x3, x2, x19
            

            #If we haven't reached the last index, recurse
            b.lt recurse

base:       #We've reached the end of the string. Print!

            ldr x0, =outformat
        
            #We need to keep x1 around because that's the string address!
            #Also bl will overwrite return address, so store that too
            stp x30, x1, [sp, #-16]!

            //this line gets the BASE char of the reversed string and original string

            

            ldrb w1, [x1, x2]
            ldrb w2, [x20, x23]

            //here we check if the last character is equal to the first character
            cmp w1, w2
            bne notpalistring


            //inc the length counter of string
            add x23, x23, #1

           // ldr x0, =stringread
           // ldr x1, =debug
           // bl printf


            ldp x30, x1, [sp], #16

            #Go back and start executing at the return
            #address that we stored 
            br x30

recurse:    #First we store the frame pointer(x29) and 
            #link register(x30)
            sub sp, sp, #16
            str x29, [sp, #0]
            str x30, [sp, #8]

            #Move our frame pointer
            add x29, sp, #8

            #Make room for the index on the stack
            sub sp, sp, #16

            #Store it with respect to the frame pointer
            str x2, [x29, #-16]

            add x2, x2, #1 

            #Branch and link to original function. 
            bl reverse

            #Back from other recursion, so load in our index
end_rec:    ldr x2, [x29, #-16]

            //compare each character from original string and reversed string. if they dont agree, go to notpalistring label and end
            stp x30, x1, [sp, #-16]!
            ldr x0, =outformat
            ldrb w1, [x1, x2]

            ldrb w2, [x20, x23]
            cmp w1, w2
            bne notpalistring

            //inc lengthcounter from original string
            add x23, x23, #1

            //bl printf

            //ldr x0, =stringread
            //ldr x1, =debug
            //bl printf
            ldp x30, x1, [sp], #16

            #Clear off stack space used to hold index
            add sp, sp, #16

            #Load in fp and lr
            ldr x29, [sp, #0]
            ldr x30, [sp, #8]
            
            #Clear off the stack space used to hold fp and lr
            add sp, sp, #16

            #Return to correct location in execution
            br x30

notpalistring:


            ldr x0, =stringread
            ldr x1, =notpali
            bl printf

            mov x0, #0
            mov x8, #93
            svc #0


exit:       

            ldr x0, =stringread
            ldr x1, =yespali
            bl printf
           


            mov x0, x20
            mov x8, #93
            svc #0
