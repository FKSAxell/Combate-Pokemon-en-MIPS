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

        #Obtener int de usuario
        li $v0, 5
        syscall

	#Mover el input a otro registro
    move $t0, $v0
	add $t5, $zero, $zero
	li $t1, 11
	slt $t7, $t0, $t1
	bne $t7, $zero, loop
	li $v0, 4
        la $a0, text2
        syscall
	li $v0, 10
        syscall
	loop:	slt $t6, $zero, $t0
		beq $t6, $zero, end
		li $v0, 1
        	move $a0, $t5
        	syscall
		addi $t0, $t0, -1
		addi $t5, $t5, 1
		li $v0, 4
        	la $a0, space
	        syscall
		j loop
	end:	li $v0, 1
        	move $a0, $t5
        	syscall
		li $v0, 10
        	syscall
		b end

#que salga por favor
				