.globl main
main:

li $t0,-1
li $t3,0
li $v0,5
syscall
move $t1,$v0
loop:
beq $t1,$t0,exit
add $t2,$t2,$t1
addi $t3,1
li $v0,5
syscall
move $t1,$v0
j loop
exit:
divu $t2,$t3
mflo $a0
li $v0,1
syscall

li $v0,10
syscall