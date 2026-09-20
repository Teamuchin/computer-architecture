.data
msg1: .asciiz "Başlangic Girin: "
msg2: .asciiz "Hedef Girin: "
msg3: .asciiz "Sayı: "
msg4: .asciiz "\n"
.text
.globl main
main:
la $a0,msg1
li $v0,4
syscall
li $v0,5
syscall
move $t0,$v0
la $a0,msg2
li $v0,4
syscall
li $v0,5
syscall
move $t1,$v0
addi $t1,$t1,1

loop:
beq $t0,$t1,exit
la $a0,msg3
li $v0,4
syscall
add $a0,$t0,$zero
li $v0,1
syscall
addi $t0,$t0,1
la $a0,msg4
li $v0,4
syscall
j loop

exit:
li $v0,10
syscall