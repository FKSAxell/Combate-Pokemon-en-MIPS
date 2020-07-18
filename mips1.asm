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
full: .space 1024
        #Declaro main como una funcion global
        .globl main
		.text
# La etiqueta main representa el punto de partida
#Registro
#$s0	file descriptor 
#$s1    random number
#$s2    contador
#$s3	random+9
#$s4    controlador 
main:   
        add $s1,$zero,$zero
        add $s3,$zero,$zero

        add $t1,$zero,$zero #random controlador de linea
        

        #GENERANDO RANDOM
        jal randomNumber
        add $s1,$v0, $zero
        move $a0,$s1
        li $v0, 1
        syscall
        jal enter
        #limite random+9
        addi $s3,$s1,9
        move $a0,$s3
        li $v0, 1
        syscall
        jal enter

        #iniciando el controlador (para escoger las 10 lineas)
        addi $t1, $s1, -1


        #ABRIENDO ARCHIVO
        li   $v0, 13          # system call for open file
        la   $a0, myFile      # input file name
        li   $a1, 0           # flag for reading
        li   $a2, 0           # mode is ignored
        syscall               # open a file 
        move $s0, $v0         # save the file descriptor 
        
        add $s2,$zero,$zero # declarando contador de lineas
	loop:
        	# reading from file just opened
        	li   $v0, 14        # system call for reading from file
        	move $a0, $s0       # file descriptor 
        	la   $a1, buffer    # address of buffer from which to read
        	li   $a2,  1       # hardcoded buffer length <- hasta cuantos caracteres presentar (SE SELECCIONA 1 PARA RECORRER POR CARACTER) 
        	syscall             # read from file
        	beq $v0,$zero,exit #SALIDA DEL BUCLE AL LEER TODO EL ARCHIVO
		lb $t5, 0($a1) #CARGANDO EL CARACTER QUE LEE EL BUFFER
		bne $t5,0xD,no_counter_concatenate #COMPARANDO SI ES ENTER 
        		addi $s2,$s2,1 #contador+=1
                        bne $t1,$s2, no_counter_concatenate #si t1 == s2 estamos en la primera linea que necesitamos
                                #---comienzo de lectura de las 10 lineas:---
                                #se crea el contador que solo tiene que llegar a 10:
                                add $t2,$zero,$zero
                                addi $t3,$zero,10
                                loop2:
                                        li   $v0, 14        # system call for reading from file
                                        move $a0, $s0       # file descriptor 
                                        la   $a1, buffer    # address of buffer from which to read
                                        li   $a2,  1       # hardcoded buffer length <- hasta cuantos caracteres presentar (SE SELECCIONA 1 PARA RECORRER POR CARACTER) 
                                        syscall             # read from file
                                        lb $t6, 0($a1) #CARGANDO EL CARACTER QUE LEE EL BUFFER
                                        bne $t6,0xD,no_counter_si_concatenate  #COMPARANDO SI ES ENTER 
                                                addi $t2,$t2,1  #contando enter
                                                beq $t2,$t3, exit #SI ESTO ES IGUAL QUIERE DECIR QUE YA TENGO MIS 10 LINEAS EN FULL
                                                j loop2
                                        #concatenando en full
                                        no_counter_si_concatenate:
                                                la $a0 full
                                                la $a1 full
                                                la $a2 buffer
                                                jal strcatFirst
                                                j loop2
        	no_counter_concatenate: #SALTANDO AL OTRO LOOP POR SI NO ES UN ENTER
        	        #quiero que esto concatene las 9 lineas que son mas de 9 bucles
        		j loop
      
	exit:
        
        #IMPRIMIENDO FULL
	li $v0, 4
	la $a0,full
        syscall
        
        
        #CERRANDO ARCHIVO
        li   $v0, 16       # system call for close file
	move $a0, $s0      # file descriptor to close
	syscall            # close file
	
        #Terminar programa
        li $v0, 10
        syscall


#FUNCIONES
randomNumber:		# funcion randomNumber
        li $v0, 42  	# 42 funcion del sistema para aleatorio
        li $a1, 99     
        syscall     	# en $a0 se guarda aleatorio
        addi $t0, $a0, 1  # aumenta para cuestiones de intervalo
        add $v0, $t0, $zero # retorno v0
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

#Funcion para agregar nueva linea :v 
enter:
	li  $v0, 4        
        la  $a0, newline
       	syscall
       	jr $ra


        
        




		
        

