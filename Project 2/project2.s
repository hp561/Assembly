#Harsh Patel
#Project 2
#10/01/2017


.data
input1: .asciiz "Enter first integer n1: "
input2: .asciiz "Enter first integer n2: "
output1: .asciiz "The greatest common divisor of n1 and n2 is: "
output2: .asciiz "The least common multiple of n1 and n2 is:  "
NL: .asciiz "\n"       #new line


.text

main:

#load input1 message to register and display to user
la $a0, input1
li $v0, 4
syscall

#take user input 1 and load it to $t0
li $v0, 5         	# an I/O sequence to read an integer from
syscall
addi $t0, $v0, 0

#load input2 message to register and display to user
la $a0, input2
li $v0, 4
syscall

#take user input 2 and load it to $t1
li $v0, 5         	# an I/O sequence to read an integer from
syscall
addi $t1, $v0, 0

#if $t0!=0 go to numOneZero
bne $t0, 0, numOneZero

#if false do this
la $a0, output1
li $v0, 4
syscall

li $v0, 1
move $a0, $t1
syscall

la $a0, NL
li $v0, 4
syscall

la $a0, output2
li $v0, 4
syscall

li $v0, 1
move $a0, $zero
syscall

#syscall to end the program
li $v0, 10
syscall

numOneZero:


#if $t1==0 go to label numTwoZero
beq $t1, 0, numTwoZero

#if $t0<$t1 store 0 to $s1
slt $s1, $t0, $t1

#if $s1!=0 go to newIter
bne $s1, $zero, newIter

#this is where the counter will start from until it reaches 0
add $s0, $zero, $t1

j loop

newIter:

#this is where the counter will start from until it reaches 0
add $s0, $zero, $t0


loop:

#loop until counter $s0==0
beq $s0, $zero, exit

#divides int 1 by counter $s0
div $t0, $s0

#gets remainder from division and stores in $t2
mfhi $t2

#divides int 2 by counter $s0
div $t1, $s0

#gets remainder from division and stores in $t3
mfhi $t3


#if $t2==0 go to NumOneModZero
beq $t2, 0, NumOneModZero

#decrements counter if false and restarts loop
sub $s0, $s0, 1
j loop

NumOneModZero:

#if $t3==0 go to NumTwoModZero
beq $t3, 0, NumTwoModZero

#decrements counter if false and restarts loop
sub $s0, $s0, 1

j loop

#if code reaches here GCD has been found and is equal to to the counter
NumTwoModZero:

#rest of code is simple print statements on screen
la $a0, output1
li $v0, 4
syscall

li $v0, 1
move $a0, $s0
syscall

la $a0, NL
li $v0, 4
syscall

la $a0, output2
li $v0, 4
syscall

#mul and div is used to find LCM and final value is stored in $t5
mul $t4, $t0, $t1

div $t5, $t4, $s0

li $v0, 1
move $a0, $t5
syscall


#syscall to end the program
li $v0, 10
syscall


#code comes here if 2nd int is 0, in that case return n1 as the GCD and 0 for LCM
numTwoZero:

la $a0, output1
li $v0, 4
syscall

li $v0, 1
move $a0, $t0
syscall

la $a0, NL
li $v0, 4
syscall

la $a0, output2
li $v0, 4
syscall

li $v0, 1
move $a0, $zero
syscall


#if counter==0
exit:

#syscall to end the program
li $v0, 10
syscall
