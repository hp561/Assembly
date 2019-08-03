#Harsh Patel
#Project 1
#09/22/2017


.data
numbers:  .word 89, 19, 91, 23, 31, 96, 3, 67, 17, 11, 43, 75
message1: .asciiz "Index of the largest number is: "
message2: .asciiz "The largest number is: "
newline: .asciiz "\n"
NL: .asciiz "\n"       #new line
arraySize: .word 12
maxIndex: .word 0
maxInt: .word 0
i: .word 0


.text

main:

la $s0, numbers        #load array addeess

lw $s1, arraySize      #loads register $s1 with 12

lw $t0, maxInt         #loads maxInt (0) to $t0

lw $t1, maxIndex       #loads maxIndex (0) to $t1

lw $t2, i              #loads counter (i=0) to $t2


loop:

beq $t2, $s1, exit     #i<12

sll $t4, $t2, 2        #shift bits

add $t5, $s0, $t4      #increase array pointer by 4

lw $t6, 0($t5)         #stores next number in array in t6

slt $t4, $t0, $t6      #compares $t0 and $t6

beq $t4, $zero, else   #if $t6 < $t0, goes to else

move $t0, $t6          #Stores value into max

move $t1, $t2          #Stores index value into maxIndex

else:

addi $t2, $t2, 1       #i++

j loop                 #jump back to loop

exit:

#loads and prints first message

la $a0, message1
li $v0, 4
syscall

#loads and prints max index
li $v0, 1
add $a0, $zero, $t1
syscall

#loads and prints newline
la $a0, NL
li $v0, 4
syscall

#loads and prints second message

la $a0, message2
li $v0, 4
syscall

#loads and prints max number
li $v0, 1
add $a0, $zero, $t0
syscall

#syscall to end the program
li $v0, 10
syscall

