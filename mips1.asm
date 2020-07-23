# Proyecto: Combate Pokemon en MIPS

        .data


bienvenida:  .asciiz "Bienvenido al sistema de combates Pokemon:"
input1: .asciiz "Ingrese el n�mero del primer Pok�mon para el combate: "
input2: .asciiz "Ingrese el n�mero del segundo Pok�mon para el combate: "
combatientes: .asciiz "Combatientes: "
vs: .asciiz " vs. "
dospuntos: .asciiz ": "
resultado: .asciiz "Resultado del ataque: "
vida: .asciiz "Vida: "
ataque: .asciiz "Ataque: "
error: .asciiz "Error, por favor ingrese un n�mero v�lido (1 al 11): "

newline: .asciiz "\n" 
fin: .asciiz "Fin del Programa"       
myFile: .asciiz "pokeTypes.txt"      # filename for input
printtext: .asciiz "?"
dot: .asciiz ". "
buffer: .space 1024
full: .space 1024
pokemon:  .space 15
tipo: .space 15
pokemon1:  .space 15
tipo1: .space 15
pokemon2:  .space 15
tipo2: .space 15



linea: .space 25
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
	add $t4,$zero,$zero
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
                                     		addi $t4,$t4,1
                                                la $a0 full
                                                la $a1 full
                                                la $a2 buffer
                                                jal strcatFirst
                                                j loop2
        	no_counter_concatenate: #SALTANDO AL OTRO LOOP POR SI NO ES UN ENTER
        	        #quiero que esto concatene las 9 lineas que son mas de 9 bucles
        		j loop
      
	exit:
        
        	#CERRANDO ARCHIVO
        	li   $v0, 16       # system call for close file
		move $a0, $s0      # file descriptor to close
		syscall            # close file
	#IMPRIMIENDO FULL	
	#li $v0, 4
	#la $a0,full
        #syscall
        #vaciando todo
        add $s1,$zero,$zero
        add $s2,$zero,$zero
        add $s3,$zero,$zero
        add $t0,$zero,$zero
        add $t1,$zero,$zero
        add $t2,$zero,$zero
        add $t3,$zero,$zero
        
        add $t5,$zero,$zero
        add $t6,$zero,$zero
        add $t7,$zero,$zero
	addi $t8,$zero,1
	#IMPRIMIENDO FULL	
	#li $v0, 4
	#la $a0,full
        #syscall
        #"pokemon1,tipo1
        #pokemon2,tipo2
        #..."

	
	la $t7,full
        #lb $a0, 1($t7)
        #li $v0, 11
        #syscall
	
	#bievenida print
	li  $v0, 4        
        la  $a0, bienvenida
       	syscall
       	jal enter
        loopChar:slt $t2,$t4,$t1
        	bne $t2,$zero,exitChar
        	addi $t7,$t7,1
        	lb $t5, ($t7) #t3 1 2 3 4 5 6, t5 es el char
        	
        	#imprimiendo char by char
        	#move $a0, $t5
        	#li $v0, 11
        	#syscall
        	#fin
        	beq $t5, 0x9, sale
        	beq $t5, 0xa, loopChar
        	
        	#aqui concatenar los char
        	la $a0 linea
                la $a1 linea
                move $a2, $t5
                jal strcatFirstC
                #jal print
                
        	#fin de concatenar
        	addi $t1,$t1,1
        	j loopChar
        	
        	sale:
        		#IMPRIMIENDO linea	
			#li $v0, 4
			#la $a0,linea
        		#syscall
        		#jal enter
        		
        		#---separado---
        		la $a0,pokemon
                        la $a1,tipo
                        la $a2,linea
                        jal split
			
			#--presentacion de num. pokemon--
                        move $a0,$t8 #num
                        li $v0, 1
                        syscall
                        
			li  $v0, 4        
                        la  $a0, dot
       	                syscall
       	                
                        li  $v0, 4        
                        la  $a0, pokemon
       	                syscall
       	                jal enter

                        addi $t8,$t8,1
                     
                        
    			
        		
        		#limpieando la wea :V 
        		#a0 es el tamano del string a limpiar
        		addi $a0,$zero,24
        		la $a1,linea
        		jal limpiar
        		
        		#limpiar pokemon y tipo
        		addi $a0,$zero,14
        		la $a1,pokemon
        		jal limpiar
        		
        		#addi $a0,$zero,14
        		#la $a1,tipo
        		#jal limpiar
        		#FIN LIMPIAR
        		
        		#j exitChar
        		#fin linea
             
        		
        		addi $t1,$t1,1
        		j loopChar
       	exitChar:
       	#todas los registros estan limpios
       	#ingresos de usuario1
        add $s1,$zero,$zero
        add $s2,$zero,$zero
        add $s3,$zero,$zero
        add $t0,$zero,$zero
        add $t1,$zero,$zero
        add $t2,$zero,$zero
        add $t3,$zero,$zero
        #add $t4,$zero,$zero
        add $t5,$zero,$zero
        add $t6,$zero,$zero
        add $t7,$zero,$zero
        add $t9,$zero,$zero
	addi $t8,$zero,1
       	jal enter
       	li  $v0, 4        
        la  $a0, input1
       	syscall
       	#Obtener int de usuario
        li $v0, 5
        syscall
        #Mover el input a otro registro
        move $t9, $v0
        #NO OLVIDAR VALIDAR LPTM
        addi $t9,$t9,-1
       	jal enter
       	#ingresos de usuario2
       	li  $v0, 4        
        la  $a0, input2
       	syscall
       	#Obtener int de usuario
        li $v0, 5
        syscall
        #Mover el input a otro registro
        move $t1, $v0
        addi $t1,$t1,-1
        #NO OLVIDAR VALIDAR LPTM
        
        jal enter

        
        la $s7,full
        loopPoke:slt $t8,$t4,$t2
        	bne $t8,$zero,exitPoke
        	
        	lb $t5, ($s7) #t3 1 2 3 4 5 6, t5 es el char
                
                beq $t5, 0x9, salePoke
        	beq $t5, 0xa, tabulador
                #aqui concatenar los char
        	la $a0 linea
                la $a1 linea
                move $a2, $t5
                jal strcatFirstC
                #jal print
                
        	#fin de concatenar
        	addi $t2,$t2,1
                addi $s7,$s7,1
        	j loopPoke
                salePoke:
                	
                	#li $v0, 4
			#la $a0,linea
        		#syscall
        		#jal enter
        		
                        beq $t9,$t7,asignacion1
                        beq $t1,$t7,asignacion2
                        addi $t7,$t7,1
                        addi $a0,$zero,24
        		la $a1,linea
        		jal limpiar
                        addi $s7,$s7,1
                        j loopPoke
                        asignacion1:
                                la $a0,pokemon1
                                la $a1,tipo1
                                la $a2,linea
                                jal split
                                
                                                               
                                
                                
                                addi $t2,$t2,1
                                addi $a0,$zero,24
        		        la $a1,linea
        		        jal limpiar
                                addi $s7,$s7,1
                                addi $t7,$t7,1
                                j loopPoke
                        asignacion2:
                                la $a0,pokemon2
                                la $a1,tipo2
                                la $a2,linea
                                jal split
                                
                                addi $t2,$t2,1
                                addi $a0,$zero,24
        		        la $a1,linea
        		        jal limpiar
                                addi $s7,$s7,1
                                addi $t7,$t7,1
                                j loopPoke
              tabulador:
              	addi $s7,$s7,1
              	j loopPoke
        exitPoke:
		li  $v0, 4        
                la  $a0, pokemon1
       	        syscall
       	        jal enter
       	        li  $v0, 4        
                la  $a0, tipo1
       	        syscall
       	        jal enter
       	        li  $v0, 4        
                la  $a0, pokemon2
       	        syscall
       	        jal enter
       	        li  $v0, 4        
                la  $a0, tipo2
       	        syscall
       	        jal enter
                        

        
        
        
        
       		
        	
        

        terminar:
        #Terminar programa
        li $v0, 10
        syscall






#FUNCIONES
#s0 t3 t6 s1 s2 s3
split: 
    move $s0, $a0 
    move $s1, $a1
    move $s2, $a2  # la means load address (so we load the address of str into $t0)  
    

    la $t6, 44   # 43 is ASCII of ',' in DEC
 countChr:  
    lb $s3, 0($s2)  # Load the first byte from address in $t0  
    beqz $s3, end   # if $t2 == 0 then go to label end
    
    beq $s3, $t6, sum   # branch if symbol equals 43 (+)
    sb      $s3,0($s0)              # add to output
    addi    $s0,$s0,1               # advance output pointer  	
    #add $t0, $t0,1}
    add $s2, $s2,1      # else increment the address  
  
    j countChr
    #la $t4, ($t0) # save the position

sum:
    add $s2, $s2,1 
proceed:
    lb $s3, 0($s2)  # Load the first byte from address in $t0  
    beqz $s3, end   # if $s3 == 0 then go to label end 
    sb      $s3,0($s1)              # add to output
    addi    $s1,$s1,1               # advance output pointer  	

    add $s2, $s2,1      # else increment the address  
    
    j proceed

 end:   
 
    
    jr $ra
        

limpiar:

        add $s0, $zero,$a0
        add $t3,$zero,$zero
        loop3:  slt $t6, $s0,$t3
                bne $t6,$zero,exit3                  
                sb $zero, ($a1)
                addi $a1, $a1, 1
                addi $t3,$t3,1
                j loop3
        exit3:   
        	jr $ra

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

strcatFirstC:
        lb $t0, ($a1)
        beqz $t0, strcatSecondC
        sb $t0, ($a0)
        addi $a1, $a1, 1
        addi $a0, $a0, 1
    j strcatFirstC

    strcatSecondC:
        move $t0,$a2
        sb $t0, ($a0)
        j endStrcatC
        addi $a0, $a0, 1
        j strcatSecondC
    endStrcatC:
        jr $ra

#Funcion para que la vida sea mejor :v 
enter:
	li  $v0, 4        
        la  $a0, newline
       	syscall
       	jr $ra
print:
	li  $v0, 4        
        la  $a0, printtext
       	syscall
       	jr $ra


        
        




		
        

