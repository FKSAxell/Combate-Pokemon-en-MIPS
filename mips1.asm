# Loop
# 2019-2
# Ejercicios de loop
# PROGRAMA CON VALIDACI�N DE ERROR (CON NUEVO INGRESO)

        .data


bienvenida:  .asciiz "verdadero"
newline: .asciiz "\n" 
fin: .asciiz "Fin del Programa"       
myFile: .asciiz "pokeTypes.txt"      # filename for input
buffer: .space 1024
        #Declaro main como una funcion global
        .globl main
		.text
# La etiqueta main representa el punto de partida		
main:
            
        #ABRIENDO ARCHIVO
        li   $v0, 13          # system call for open file
        la   $a0, myFile      # input file name
        li   $a1, 0           # flag for reading
        li   $a2, 0           # mode is ignored
        syscall               # open a file 
        move $s0, $v0         # save the file descriptor 
	loop:
        	# reading from file just opened
        	li   $v0, 14        # system call for reading from file
        	move $a0, $s0       # file descriptor 
        	la   $a1, buffer    # address of buffer from which to read
        	li   $a2,  1       # hardcoded buffer length <- hasta cuantos caracteres presentar (SE SELECCIONA 1 PARA RECORRER POR CARACTER) 
        	syscall             # read from file
        	beq $v0,$zero,exit #SALIDA DEL BUCLE AL LEER TODO EL ARCHIVO
		lb $t5, 0($a1) #CARGANDO EL CARACTER QUE LEE EL BUFFER
		bne $t5,0xD,nocounter #COMPARANDO SI ES ENTER 
        	addi $s3,$s3,1 #i+=1 #CONTANDO +1
        	nocounter: #SALTANDO AL OTRO LOOP POR SI NO ES UN ENTER
        	# Printing File Content
        	#li  $v0, 4          # system Call for PRINT STRING
        	#la  $a0, buffer     # buffer contains the values
        	#syscall             # print int
        		j loop
      
	exit:
	#TERMINAMOS IMPRIMIENDO CONTADOR DE LINEAS (es 108, pero el archivo tiene mas enters)
	move $a0,$s3
	li $v0, 1   
        syscall   
        
        #Terminar programa
        li $v0, 10
        syscall


#FUNCIONES
randomNumber:		# funcion randomNumber
        li $v0, 42  	# 42 funcion del sistema para aleatorio
        li $a1, 109     # Se aumenta a 109 para que salga el 108
        syscall     	# en $a0 se guarda aleatorio

        addi $t0, $a0, 1  # aumenta para cuestiones de intervalo
        add $v0, $t0, $zero # retorno v1

        li $v0, 1   #Service 1, print int, esto hay que borrar solo se usa para prueba
        syscall    

        jr $ra
        	
#call the strcpy function
#la $a0 full
#la $a1 full
#la $a2 buffer
#jal strcatFirst  
strcatFirst:
        lb $t0, ($a1)
        beqz $t0, strcatSecond
        sb $t0, ($a0)
        addi $a1, $a1, 1
        addi $a0, $a0, 1
    j strcatFirst

    strcatSecond:
        lb $t0,($a2)
        beqz $t0, endStrcat
        sb $t0, ($a0)
        addi $a2, $a2, 1
        addi $a0, $a0, 1
        j strcatSecond
    endStrcat:
        jr $ra


        
        




		
        

