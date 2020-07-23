 .data
    str:  .asciiz "Hello,World"
    out:        .space      80
    out2:        .space      80
    newline: .asciiz "\n"
 .text  
 main: 
    la $t5, out 
    la $t6, out2
    la $t0, str  # la means load address (so we load the address of str into $t0)  
    li $t1, 0    # $t1 is the counter. set it to 0  

    la $t3, 44   # 43 is ASCII of ',' in DEC
 countChr:  
    lb $t2, 0($t0)  # Load the first byte from address in $t0  
    beqz $t2, end   # if $t2 == 0 then go to label end
    
    beq $t2, $t3, sum   # branch if symbol equals 43 (+)
    sb      $t2,0($t5)              # add to output
    addi    $t5,$t5,1               # advance output pointer  	
    #add $t0, $t0,1}
    add $t0, $t0,1      # else increment the address  
    add $t1, $t1, 1 # and increment the counter of course  
    j countChr
    #la $t4, ($t0) # save the position

sum:
    add $t0, $t0,1 
proceed:
    lb $t2, 0($t0)  # Load the first byte from address in $t0  
    beqz $t2, end   # if $t2 == 0 then go to label end 
    sb      $t2,0($t6)              # add to output
    addi    $t6,$t6,1               # advance output pointer  	

    add $t0, $t0,1      # else increment the address  
    add $t1, $t1, 1 # and increment the counter of course  
    j proceed

 end:  
    # Do whatever you want here.  
    # Just remember that the length of the string is stored in $t1
    # Here you have the position of '+' saved to t4 
    la      $a0,out
    li      $v0,4
    syscall
    
    li $v0, 4       # you can call it your way as well with addi 
    la $a0, newline       # load address of the string
    syscall
    
    la      $a0,out2
    li      $v0,4
    syscall