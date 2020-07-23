.data
    newline: .asciiz "\n"
    tipo1: .asciiz "grass"
    tipo2: .asciiz "fire"
    pokemon1: .asciiz "grass"
    pokemon2: .asciiz "fire"
    newspace: .asciiz " "
    newpoint: .asciiz ": "
    vida: .asciiz "Vida: "
    ataca: .asciiz " Ataque: "
    mensaje: .asciiz " ataca a "
    resultado:.asciiz "\nResultado del ataque: \n"
    ganador: .asciiz " es el ganador!"
    combatientes: .asciiz "Combatientes: "
    vs: .asciiz " vs. "
    am: .asciiz "¡"


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
    tabla: .word 1, 1, 1, 1, 1, 3, 1, 0, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 3, 3, 1, 2, 3, 0, 2, 1, 1, 1, 1, 3, 2, 1, 2, 3, 1, 2, 1, 1, 1, 3, 2, 1, 3, 1, 1, 2, 3, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 1, 3, 0, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 0, 2, 1, 2, 1, 1, 2, 2, 1, 3, 2, 1, 1, 1, 1, 1, 1, 3, 2, 1, 3, 1, 2, 1, 3, 2, 1, 1, 1, 1, 2, 1, 1, 1, 1, 3, 3, 3, 1, 1, 1, 3, 3, 3, 1, 2, 1, 2, 1, 1, 2, 3, 0, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 3, 1, 1, 1, 1, 1, 1, 2, 1, 1, 3, 3, 3, 1, 3, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 3, 2, 1, 2, 3, 3, 2, 1, 1, 2, 3, 1, 1, 1, 1, 1, 1, 2, 2, 1, 1, 1, 2, 3, 3, 1, 1, 1, 3, 1, 1, 1, 1, 3, 3, 2, 2, 3, 1, 3, 3, 2, 3, 1, 1, 1, 3, 1, 1, 1, 1, 2, 1, 0, 1, 1, 1, 1, 1, 2, 3, 3, 1, 1, 3, 1, 1, 1, 2, 1, 2, 1, 1, 1, 1, 3, 1, 1, 1, 1, 3, 1, 1, 0, 1, 1, 1, 2, 1, 2, 1, 1, 1, 3, 3, 3, 2, 1, 1, 3, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1, 2, 1, 0, 1, 3, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 2, 1, 1, 3, 3, 1, 2, 1, 3, 1, 1, 1, 1, 3, 3, 1, 1, 1, 1, 1, 2, 2, 1

.text
    .globl main

main:
    la $a0, tipo1
    jal poketypes
    move $s2, $t8
    la $a0, tipo2
    jal poketypes
    move $s3, $t8
    jal factor
    jal ataque
    add $s4, $zero, $t9 #ataque pkmn 1
    move $t0, $s3
    move $s3, $s2
    move $s2, $t0
    jal factor
    jal ataque
    add $s5, $zero, $t9 #ataque pkmn 1
    addi $s6, $zero, 5 #vida pkmn 1
    addi $s7, $zero, 5 #vida pkmn 2   
    li $v0, 4
    la $a0, combatientes
    syscall   
    li $v0, 4
    la $a0, pokemon1
    syscall   
    li $v0, 4
    la $a0, vs
    syscall   
    li $v0, 4
    la $a0, pokemon2
    syscall   
    li $v0, 4
    la $a0, newline
    syscall
    bucle:  
            li $v0, 4
            la $a0, newline
            syscall
            jal batalla1
            li $v0, 4
            la $a0, newline
            syscall
            jal batalla2
            j bucle
            
    
            
      
    fin1:
        li $v0, 4
        la $a0, am
        syscall
        li $v0, 4
        la $a0, pokemon1
        syscall
        li $v0, 4
        la $a0, ganador
        syscall

        li $v0,10
        syscall

    fin2:
        li $v0, 4
        la $a0, am
        syscall
        li $v0, 4
        la $a0, pokemon2
        syscall
        li $v0, 4
        la $a0, ganador
        syscall

        li $v0,10
        syscall

batalla1:
        la $t7, ($ra)
        jal presentar1
        li $v0, 4
        la $a0, mensaje
        syscall
        jal presentar2       

        li $v0, 4
        la $a0, resultado
        syscall

        sub $s7, $s7,$s4
        jal comprobar1

        jal presentar1
        li $v0, 4
        la $a0, newline
        syscall
        jal presentar2
        li $v0, 4
        la $a0, newline
        syscall

        ble	$s6, $zero, fin2
        ble	$s7, $zero, fin1
        jr $t7
        
batalla2:
    la $t7, ($ra)
    jal presentar2
    li $v0, 4
    la $a0, mensaje
    syscall
    jal presentar1       

    li $v0, 4
    la $a0, resultado
    syscall

    sub $s6, $s6,$s5
    jal comprobar2

    jal presentar1
    li $v0, 4
    la $a0, newline
    syscall
    jal presentar2
    li $v0, 4
    la $a0, newline
    syscall

    ble	$s6, $zero, fin2
    ble	$s7, $zero, fin1
    
    jr $t7
        
presentar1:
    li $v0, 4
    la $a0, pokemon1
    syscall
    li $v0, 4
    la $a0, newpoint
    syscall
    li $v0, 4
    la $a0, vida
    syscall
    li $v0, 1
    move $a0, $s6
    syscall
    li $v0, 4
    la $a0, ataca
    syscall
    li $v0, 1
    move $a0, $s4
    syscall
    jr $ra

presentar2:
    li $v0, 4
    la $a0, pokemon2
    syscall
    li $v0, 4
    la $a0, newpoint
    syscall
    li $v0, 4
    la $a0, vida
    syscall
    li $v0, 1
    move $a0, $s7
    syscall
    li $v0, 4
    la $a0, ataca
    syscall
    li $v0, 1
    move $a0, $s5
    syscall
    jr $ra
comprobar1:
        la $t6, ($ra)
        blt $s7, $zero, cambio1
        jr $t6

        cambio1:
            add $s7, $zero, $zero
            jr $t6
comprobar2:
        la $t6, ($ra)
        blt $s6, $zero, cambio2
        jr $t6

        cambio2:
            add $s6, $zero, $zero
            jr $t6
        


ataque: 
    beq $t4, $t8, dividir
    bne $t4, $t8, multiplicar
    dividir: 
        addi $t9, $zero, 1
        jal $ra
    multiplicar:
        addi $t1, $zero, 1
        addi $t2, $zero, 2
        beqz $t4, cero
        beq $t4, $t1, uno
        beq $t4, $t2, dos
        cero:
            addi $t9, $zero, 0
            jal $ra
        uno:
            addi $t9, $zero, 2
            jal $ra
        dos:
            addi $t9, $zero, 4
            jal $ra
    

poketypes:
    la $t7, ($ra)
    la $a1, normal
    add  $t8, $zero, $zero
    jal compare
    beqz $t5, bfigth
    jr $t7

    bfigth:
        la $a1, figth
        addi  $t8, $t8, 1
        jal compare
        beqz $t5, bflying
        jr $t7

    bflying:
        la $a1, flying
        addi  $t8, $t8, 1
        jal compare
        beqz $t5, bpoison
        jr $t7

    bpoison:
        la $a1, poison
        addi  $t8, $t8, 1
        jal compare
        beqz $t5, bground
        jr $t7

    bground:
        la $a1, ground
        addi  $t8, $t8, 1
        jal compare
        beqz $t5, brock
        jr $t7

    brock:
        la $a1, rock
        addi  $t8, $t8, 1
        jal compare
        beqz $t5, bbug
        jr $t7

    bbug:
        la $a1, bug
        addi  $t8, $t8, 1
        jal compare
        beqz $t5, bghost
        jr $t7

    bghost:
        la $a1, ghost
        addi  $t8, $t8, 1
        jal compare
        beqz $t5, bsteel
        jr $t7

    bsteel:
        la $a1, steel
        addi  $t8, $t8, 1
        jal compare
        beqz $t5, bfire
        jr $t7

    bfire:
        la $a1, fire
        addi  $t8, $t8, 1
        jal compare
        beqz $t5, bwater
        jr $t7

    bwater:
        la $a1, water
        addi  $t8, $t8, 1
        jal compare
        beqz $t5, bgrass
        jr $t7

    bgrass:
        la $a1, grass
        addi  $t8, $t8, 1
        jal compare
        beqz $t5, belectr
        jr $t7

    belectr:
        la $a1, electr
        addi  $t8, $t8, 1
        jal compare
        beqz $t5, bphysic
        jr $t7

    bphysic:
        la $a1, physic
        addi  $t8, $t8, 1
        jal compare
        beqz $t5, bice
        jr $t7

    bice:
        la $a1, ice
        addi  $t8, $t8, 1
        jal compare
        beqz $t5, bdragon
        jr $t7

    bdragon:
        la $a1, dragon
        addi  $t8, $t8, 1
        jal compare
        beqz $t5, bdark
        jr $t7

    bdark:
        la $a1, dark
        addi  $t8, $t8, 1
        jal compare
        beqz $t5, bfairy
        jr $t7

    bfairy:
        la $a1, fairy
        addi  $t8, $t8, 1
        jal compare
        jr $t7


compare:
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
        move $t5, $v0
        jr $ra

factor:
    addi	$t0, $zero, 0			# $t0 = $t1 + 0
    addi    $t1, $zero, 18          #max types
    addi    $t8, $zero, 3
    #pruebas
    #0normal, 1figth, 2fly, 3poison, 4ground, 5rock
    #6bug, 7ghost, 8steel, 9fire, 10water, 11grass, 
    #12elec, 13phychc, 14ice, 15dragon, 16 dark, 17fairy
    #indice= renglon *maxtypes + columna
    add    $t2, $zero, $s2      #primer poke
    add    $t3, $zero, $s3      #segundo poke
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
        jr $ra





