.data
msg1: .asciiz "sayı girin: "
.text
.globl main

fact:
addi $sp,$sp,-8
sw $ra,4($sp)
sw $a0,0($sp)#saved func arguments for fact
slti $t1,$a0,2
beq $t1,$zero,fact1#if a0 more than or equal two jump to fact1
li $v0,1
addi $sp,$sp,8
jr $ra

fact1:
addi $a0,$a0,-1
jal fact
lw $ra,4($sp)
lw $a0,0($sp)
addi $sp,$sp,8
mul $v0,$v0,$a0
jr $ra

main:
la $a0,msg1
li $v0,4
syscall
li $v0,5
syscall
move $a0,$v0

jal fact
move $a0,$v0
li $v0,1
syscall
li $v0,10
syscall