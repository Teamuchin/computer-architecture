.globl main
main:
li $a0,1
jal double_it
add $a0,$v0,$zero
jal double_it
add $a0,$v0,$zero
jal double_it   
add $a0,$v0,$zero
jal double_it
add $t0,$v0,$zero

li $v0,10
syscall

double_it:
addi $sp,$sp,-4
sw $s0, 0($sp)
li $s0,0
add $s0,$s0,$a0
li $v0,0
add $v0,$a0,$s0
lw $s0,0($sp)
addi$sp,$sp,4
jr $ra