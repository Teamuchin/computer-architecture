.data
msg1: .asciiz "kaç sayı girmek istersiniz?: "
msg2: .asciiz "\nsayı girin: "
msg3: .asciiz "\nBu sayıların Ortalaması: "
.text
.globl main
main:

li $t0,0
la $a0,msg1
li $v0,4
syscall
li $v0,5
syscall
move $t1,$v0
loop:
beq $t1,$t0,exit

la $a0,msg2
li $v0,4
syscall
li $v0,5
syscall
move $t3,$v0

add $t2,$t2,$t3
addi $t0,1
j loop
exit:
la $a0,msg3
li $v0,4
syscall
divu $t2,$t1
mflo $a0
li $v0,1
syscall

li $v0,10
syscall