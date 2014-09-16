# Shan Liu hw9 108400948
.text
.macro PRINTARGS(%REG1, %REG2)
la $a0, p
li $v0, 4
syscall 
move $a0, %REG1
li $v0, 1
syscall
la $a0, comma
li $v0, 4
syscall 

move $a0, %REG2
li $v0, 1
syscall
la $a0, comma
li $v0, 4
syscall 

move $a0, $sp
li $v0, 34
syscall
la $a0,n
li $v0, 4
syscall 
.end_macro

.macro PRINTS
la $a0, p
li $v0, 4
syscall 
la $a0, S
li $v0, 4
syscall 
la $a0, p
li $v0, 4
syscall 

move $a0, $s0
li $v0, 1
syscall
la $a0, comma
li $v0, 4
syscall 
move $a0, $s1
li $v0, 1
syscall
la $a0, comma
li $v0, 4
syscall 
move $a0, $s2
li $v0, 1
syscall
la $a0, comma
li $v0, 4
syscall 
move $a0, $s3
li $v0, 1
syscall
la $a0, comma
li $v0, 4
syscall 
move $a0, $s4
li $v0, 1
syscall
la $a0, comma
li $v0, 4
syscall 
move $a0, $s5
li $v0, 1
syscall
la $a0, comma
li $v0, 4
syscall 
move $a0, $s6
li $v0, 1
syscall
la $a0, comma
li $v0, 4
syscall 
move $a0, $s7
li $v0, 1
syscall

la $a0, n
li $v0, 4
syscall 
.end_macro 

main: 
#text RSTRING
la, $a0, printEnterString
li, $v0, 4
syscall

la $a0, str
li $a1, 50
li $v0, 8 #scan str
syscall
move $a1, $a0 #send the string address to arguemnt $a1
li $s1, 0 # i=0

forstr: 
bge $s1, 3, elsestr
move $a2, $s3
jal funkyfunc
la $a0, printstr # reversed string is..
li $v0, 4
syscall
jal RSTRING
la $v0, rev
move $a0, $v0 #print the rev string
li $v0, 4
syscall
addi $s1, $s1, 1
j forstr
elsestr:

#test POWER
sub $s2, $s1, 1 # j= i-1
mul $s1, $s1, 3 
whilepow:
bgt $s2, $s1, elsepow #check condition
la $a0, enternum1
li $v0, 4
syscall
li $v0, 5 #scan number 
syscall
move $a1, $v0
move $s4, $v0 #for LCM use
la $a0, enternum2
li $v0, 4
syscall
li $v0, 5 #scan power
syscall
move $a2, $v0
move $s5, $v0 #for LCM use
jal funkyfunc
move $a0, $a1 #print num1
li $v0, 1
syscall
la $a0, pow
li $v0, 4
syscall
move $a0, $a2 #print num2
li $v0, 1
syscall
la $a0, is
li $v0, 4
syscall
li $s3, 1 # sum=1
jal POWER
move $a0, $v0 #print out the result 
li $v0, 1
syscall

add $s2, $s2, 1 # j++;

#test LCM
ble $s5, $s4, elselcm
move $a1, $s5
move $a2, $s4
li $a3, 1 #temp
jal LCM
elselcm:
move $a1, $s4
move $a2, $s5
li $a3, 1
jal LCM
la $a0, lcm
li $v0, 4
syscall
move $s3, $v1
move $a0, $s3 #print out result
li $v0, 1
syscall

la $a0, n
li $v0, 4
syscall
#test GCD
move $a1, $s5
move $a2, $s4
jal GCD
la $a0, gcd #print result
li $v0, 4
syscall
move $a0, $v1
li $v0, 1
syscall
la $a0, n
li $v0, 4
syscall
add $s2, $s2, 1

#test FIB
jal funkyfunc
li $a1, 1  #assign parameters
li $a2, 0
move $a3, $s4
jal FIB

la $a0, fib1
li $v0, 4
syscall
move $a0, $s4 # print out num1
li $v0, 1
syscall
la $a0, fib2
li $v0, 4
syscall
move $s6, $v1 # k=FIB return result
move $a0, $s6 #print out k
li $v0, 1
syscall
la $a0, n
li $v0, 4
syscall

jal funkyfunc
li $a1, 1  #assign parameters
li $a2, 0
move $a3, $s5
jal FIB
la $a0, fib1
li $v0, 4
syscall
move $a0, $s5 # print out num2
li $v0, 1
syscall
la $a0, fib2
li $v0, 4
syscall
move $s6, $v1 # k=FIB return result
move $a0, $s6 #print out k
li $v0, 1
syscall
la $a0, n
li $v0, 4
syscall

addi $s2, $s2, 1
j whilepow

elsepow:




li $v0, 10
syscall

funkyfunc:
li $t0, 15
sll $t1, $t0, 4
sll $t2, $t1, 4
sll $t3, $t2, 4
sll $t4, $t3, 4
sll $t5, $t4, 4
sll $t6, $t5, 4
sll $t7, $t6, 4
rol $t8, $t7, 4
neg $t9, $t8
addi $t9, $t9, -1 		
jr $ra

RSTRING:
sub $sp, $sp, 8
sw $ra, ($sp)
sw $a1, 4($sp)

lb $t0, ($a1) #load first byte in str
beqz $t0, nextstr
add $a1, $a1, 1
jal RSTRING
lw $a1, 4($sp)
lb $t0, ($a1)
sb $t0, rev($a2) #byte $t1 = rev [i]

add $a2, $a2, 1

nextstr:
lw $ra, ($sp)
add $sp, $sp, 8
jr $ra

POWER:
addi $sp, $sp, -8
sw $s3, 4($sp)
sw $ra, ($sp)
        
bge $a2, 1, elsepow1 #check if powe>=1	
lw $ra, ($sp)
lw $s3, 4($sp)
addi $sp, $sp, 8
move $v0, $s3 #return sum
jr $ra

elsepow1:
mul $s3, $s3, $a1 #sum=sum*num
mfhi $t1
add $s3, $s3, $t1
subi $a2, $a2, 1
jal POWER 
lw $ra, ($sp)
addi $sp, $sp, 8
jr $ra

LCM:
sub $sp, $sp, 4
sw $ra, ($sp)

div $a3, $a2
mfhi $t1 #move remainder to $t1
div $a3, $a1
mfhi $t2
or $t1, $t1, $t2
bnez $t1,elselcm1
move $v1, $a3
lw $ra ,($sp)
add $sp, $sp, 4
jr $ra
elselcm1:
add $a3, $a3, 1
jal LCM
lw $ra, ($sp)
add $sp, $sp, 4
jr $ra

GCD:
PRINTARGS($a1,$a2)
sub $sp, $sp, 4
sw $ra, ($sp)

li $v1, 0 #result =0
bne $a1, $a2, elsegcd #base case
move $v1, $a1
j ret
elsegcd:
blt $a1, $a2, elsegcd1 #recursive case 1
sub $a1, $a1, $a2
jal GCD
j ret
elsegcd1:
sub $a2, $a2, $a1
jal GCD
j ret
ret:
lw $ra, ($sp)
add $sp, $sp, 4
PRINTARGS($a1, $a2)
jr $ra

FIB:
PRINTARGS($a1,$a3)
PRINTS()
sub $sp, $sp, 4
sw $ra, ($sp)
bnez $a3, elsefib #base case
move $v1, $a2
lw $ra, ($sp) #return
add $sp, $sp, 4
jr $ra
elsefib:
move $t0, $a1
add $a1, $a1, $a2
move $a2, $t0
sub $a3, $a3, 1
jal FIB
lw $ra ($sp) #return
add $sp, $sp, 4
PRINTS()
jr $ra

.data
str: .space 51
rev: .space 51
printEnterString: .asciiz "Enter any string: "
printstr: .asciiz "\nReversed string is: "
comma: .asciiz ", "
n: .asciiz "\n"
p: .asciiz "#"
S: .asciiz "S"
enternum1: .asciiz "\nEnter the first positive number: "
enternum2: .asciiz "Enter the second positive number: "
is: .asciiz " is: "
pow: .asciiz "^"
lcm: .asciiz "\nLCM of two integers is: "
gcd: .asciiz "\nThe GCD is : "
fib1: .asciiz "The FIB of "
fib2: .asciiz " is: "

