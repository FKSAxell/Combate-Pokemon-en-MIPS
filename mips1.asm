# Loop
# 2019-2
# Ejercicios de loop
# PROGRAMA CON VALIDACI�N DE ERROR (CON NUEVO INGRESO)

        .data


bienvenida:  .asciiz "Bienvenido al sistema de combates Pokémon:"
newline: .asciiz "\n" 
fin: .asciiz "Fin del Programa"       
myFile: .asciiz "pokeTypes.txt"      # filename for input
buffer: .space 1024
        #Declaro main como una funcion global
        .globl main
		.text
# La etiqueta main representa el punto de partida		
main:
        nuevamente:
        #Print mensaje
        li $v0, 4
        la $a0, bienvenida
        syscall

        jal randomNumber


        #ABRIENDO ARCHIVO
        li   $v0, 13          # system call for open file
        la   $a0, myFile      # input file name
        li   $a1, 0           # flag for reading
        li   $a2, 0           # mode is ignored
        syscall               # open a file 
        move $s0, $v0         # save the file descriptor 

        # reading from file just opened
        li   $v0, 14        # system call for reading from file
        move $a0, $s0       # file descriptor 
        la   $a1, buffer    # address of buffer from which to read
        li   $a2,  11       # hardcoded buffer length <- hasta cuantos caracteres presentar 
        syscall             # read from file


        # Printing File Content
        li  $v0, 4          # system Call for PRINT STRING
        la  $a0, buffer     # buffer contains the values
        syscall             # print int
        

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
 


        
        




		
        

