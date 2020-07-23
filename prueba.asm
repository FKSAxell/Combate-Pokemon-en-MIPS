.data
    v: .word 7, 8, 3, 4, 5, 6
.text
    .globl main

main: 
    sub $sp, $sp, 24
    sw $ra, 20($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $a2, 12($sp)
    la $a0, v
    li $a1, 6
    li $a2, 5
    jal SumarValor
    li $v0, 1
    li $t0, 0
    move $t1, $a0

SumarValor: 
    li $t0, 0
    move $t1, $a0
    bucle2: 
        bgt $t0, $a1, fin2
        lw $t2, ($t1)
        add $t2, $t2, $a2
        sw $t2, ($t1)
        addi $t0, $t0, 1
        addi $t1, $t1, 4
        b bucle2
    fin2: 
        jr $ra