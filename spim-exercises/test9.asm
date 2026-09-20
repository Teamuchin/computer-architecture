.data
msg1: .asciiz "Sayı1 girin: "
msg2: .asciiz "Sayı2 girin: "
msg3: .asciiz "Sayı toplam: "
.text
.globl main

addfunc:
add $v1,$a1,$a2
jr $ra

main:
la $a0,msg1
li $v0,4
syscall
li $v0,5
syscall
move $a1,$v0
la $a0,msg2
li $v0,4
syscall
li $v0,5
syscall
move $a2,$v0
jal addfunc
la $a0,msg3
li $v0,4
syscall
move $a0,$v1
li $v0,1
syscall
li $v0,10
syscall