.data
msg1: .asciiz "sayılar eşit"
msg2: .asciiz "Sayı1 girin: "
msg3: .asciiz "Sayı2 girin: "
msg4: .asciiz "Sayı1 daha buyuk: "
msg5: .asciiz "Sayı2 daha buyuk: "
.text
.globl main
main:
la $a0,msg2
li $v0,4
syscall
li $v0,5
syscall
move $t0,$v0
la $a0,msg3
li $v0,4
syscall
li $v0,5
syscall
move $t1,$v0
bgt $t0,$t1,firstgt
bgt $t1,$t0,secgt
la $a0,msg1
li $v0,4
syscall
j exit

firstgt:
la $a0,msg4
li $v0,4
syscall
move $a0,$t0
li $v0,1
syscall
j exit

secgt:
la $a0,msg5
li $v0,4
syscall
move $a0,$t1
li $v0,1
syscall
exit:
li $v0,10
syscall