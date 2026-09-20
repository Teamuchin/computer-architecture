.globl main
main:
li $t0,1#start num
li $t1,1#current loop
li $t2,5#amount of loop
loop:
beq $t1,$t2,end
li $t3,0#multiplication beginner
li $t4,0#the number that will multiplicate
add $t4,$t4,$t0
loop2:
beq $t3,$t1,mend
add $t0,$t0,$t4
addi $t3,1
j loop2
mend:
addi $t1,1
j loop
end:
li $v0,10
syscall
        