	.data

text1:  .asciiz "Enter a number: "
text2:  .asciiz "Error: Ingrese un número entre 0 y 10"
space:  .asciiz "\n"
        #Declaro main como una funcion global
        .globl main
		.text
# La etiqueta main representa el punto de partida		
 main:
        #Print mensaje
        li $v0, 4
        la $a0, text1
        syscall

        addi $v0, $zero, 42
        syscall 