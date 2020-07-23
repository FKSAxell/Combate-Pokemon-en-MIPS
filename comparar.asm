.data
    newline: .ascii "\n"
    prueba1: .asciiz "figth"
    prueba2: .asciiz "fairy"
    normal: .asciiz "normal"
    figth: .asciiz "figth"
    flying: .asciiz "flying"
    poison: .asciiz "poison"
    ground: .asciiz "ground"
    rock: .asciiz "rock"
    bug: .asciiz "bug"
    ghost: .asciiz "ghost"
    steel: .asciiz "steel"
    fire: .asciiz "fire"
    water: .asciiz "water"
    grass: .asciiz "grass"
    electr: .asciiz "electr"
    physic: .asciiz "physic"
    ice: .asciiz "ice"
    dragon: .asciiz "dragon"
    dark: .asciiz "dark"
    fairy: .asciiz "fairy"
    types: .word normal, figth, flying, poison, ground, rock, bug, ghost, steel, fire, water, grass, electr, physic, ice, dragon, dark, fairy
.text
    .globl main

main:
    strcmp:
        la $a0, prueba1
        la $a1, figth
        jal strAux
    
    strAux:
        add $t0, $zero, $zero
        add $t1, $zero, $a0
        add $t2, $zero, $a1
    
    loop:
        lb $t3,($t1)
        lb $t4,($t2)
        beqz $t3, check
        beqz $t4, match
        beq	$t3, $t4, match2
        addi $t1, $t1, 1
        addi $t2, $t2, 1
        j loop
        
    match2:
        addi $v0, $zero, 1
        addi $t1, $t1, 1
        addi $t2, $t2, 1
        j loop

    match:
        addi $v0, $zero, 1
        j exit
        
    check:
        add $v0, $zero, $zero
        beqz $t4, match
        j exit

    exit:
        move $a0, $v0
        li $v0, 1
        syscall  
        
        li $v0,10
        syscall      


    
    