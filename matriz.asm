.data
    tabla: .word 1, 1, 1, 1, 1, 3, 1, 0, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 3, 3, 1, 2, 3, 0, 2, 1, 1, 1, 1, 3, 2, 1, 2, 3, 1, 2, 1, 1, 1, 3, 2, 1, 3, 1, 1, 2, 3, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 1, 3, 0, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 0, 2, 1, 2, 3, 1, 2, 2, 1, 3, 2, 1, 1, 1, 1, 1, 1, 3, 2, 1, 3, 1, 2, 1, 3, 2, 1, 1, 1, 1, 2, 1, 1, 1, 1, 3, 3, 3, 1, 1, 1, 3, 3, 3, 1, 2, 1, 2, 1, 1, 2, 3, 0, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 2, 3, 1, 1, 1, 1, 1, 2, 1, 1, 3, 3, 3, 1, 3, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 3, 2, 1, 2, 3, 3, 2, 1, 1, 2, 3, 1, 1, 1, 1, 1, 1, 2, 2, 1, 1, 1, 2, 3, 3, 1, 1, 1, 3, 1, 1, 1, 1, 3, 3, 2, 2, 3, 1, 3, 3, 2, 3, 1, 1, 1, 3, 1, 1, 1, 1, 2, 1, 0, 1, 1, 1, 1, 1, 2, 3, 3, 1, 1, 3, 1, 1, 1, 2, 1, 2, 1, 1, 1, 1, 3, 1, 1, 1, 1, 3, 3, 1, 1, 0, 1, 1, 1, 2, 1, 2, 1, 1, 1, 3, 3, 3, 2, 1, 1, 3, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1, 2, 1, 0, 1, 3, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 3, 3, 1, 2, 1, 3, 1, 1, 1, 1, 3, 3, 1, 1, 1, 1, 1, 2, 2, 1
    newline: .ascii "\n"
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
    addi	$t0, $zero, 0			# $t0 = $t1 + 0
    addi    $t1, $zero, 18          #max types
    addi    $t8, $zero, 3
    #pruebas
    #0normal, 1figth, 2fly, 3poison, 4ground, 5rock
    #6bug, 7ghost, 8steel, 9fire, 10water, 11grass, 
    #12elec, 13phychc, 14ice, 15dragon, 16 dark, 17fairy
    #indice= renglon *maxtypes + columna
    add    $t2, $zero, $t6
    add    $t3, $zero, $t7
    addi    $t5, $zero, 0     #iterador
    addi    $t6, $zero, 0     #acumulador
    multi:  #para sumar t2 veces el max types
        beq		$t5, $t2, next	# if $t5 == t2 then exit
        add     $t6, $t6, $t1
        addi    $t5, $t5, 1
        j multi
    next:
        add     $t6, $t6, $t3   #le sumo la columna
        addi    $t6, $t6,1     #ajuste de la columna
        sll     $t7, $t6, 2     #para multiplicar por 4 la direccion de la memoria
        lw      $t4, tabla($t7)          
        li		$v0, 1 		#v0 = 2 print int
        move 	$a0, $t4		# a = $t0
        syscall

        li		$v0, 10
        syscall
        
    







    
    




   