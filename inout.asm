# Loop
# 2019-2
# Ejercicios de loop
#

        .data


text1:  .asciiz "Enter a number: "
        #Declaro main como una funcion global
        .globl main
		.text
# La etiqueta main representa el punto de partida		
 main:
        #Print mensaje
        li $v0, 4
        la $a0, text1
        syscall

        #Obtener int de usuario
        li $v0, 5
        syscall

        #Mover el input a otro registro
        move $t0, $v0

        #Print int de usuario
        li $v0, 1
        move $a0, $t0
        syscall

        #Terminar programa
        li $v0, 10
        