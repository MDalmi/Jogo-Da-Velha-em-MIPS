######################################
# 	       AUTOR                 #
#           Maicon Dalmina           #                                                                
######################################

.data
	line0:	.byte ' ',' ',' '
	line1:	.byte ' ',' ',' '
	line2:	.byte ' ',' ',' '
	x:         .byte 'x'
	bola:        .byte 'o'
	vazio:       .byte ' '
	jogada:  .byte 0
	tam_matriz:   .byte 2
	welcome_msg:	.asciiz "Seja bem vindo ao Jogo Da Velha! Boa sorte!\n"
	msg_ganhador_o: .asciiz "\n O Jogador O ganhou. \n" 
	msg_ganhador_x: .asciiz "\n O Jogador X ganhou. \n"
	msg_empate: .asciiz "Jogo encerrado!! Muita habilidade para pouco jogo. \n"	
	linebreak:		.asciiz "\n"
	msg_linha:      .asciiz "\n Informe a linha: "
	msg_coluna:     .asciiz "\n Informe a coluna "
	msg_maior: .asciiz  "Erro! Maior que 2!!"
	msg_menor: .asciiz  "Erro! Menor que 0!!"
	msg_erro: .asciiz  "Erro! Jogada já realizada!!"
	desenho_1:             .asciiz  "   |";  
	desenho_1_1:   			.asciiz "  |";
	desenho_2:             .asciiz  "----+---+----\n"

.text
	.globl main
main:
	PRINT_STR = 4
	PRINT_CHAR = 11
	READ_STRING = 8
	END_PROGRAM = 10
	PRINT_INT = 1
	READ_INT = 5
	MAIOR_L = 2
	MENOR_L = 0
	
	jal welcome		# função de boas-vindas ao usuário
	
inicio:		
	
	li $t0, 9
	lb $t1, jogada
	beq $t0, $t1, empate_msg
	
    jal print_jogo
	jal rodadas
	jal verifica_vitoria
	
welcome:
	li $v0, PRINT_STR						# syscall 4 (print string)
	la $a0, welcome_msg						# argument (string)
	syscall									# print the string (welcome_msg)

	j inicio
	
print_jogo:


        li $t1, 0
		lb $a0, line0($t1)
		li $v0, PRINT_CHAR						# mostra o valor lido
	    syscall
		
		li $v0, PRINT_STR						# syscall 4 (print string)
		la $a0, desenho_1						# argument (string)
		syscall	
		
		li $t1, 1
		lb $a0, line0($t1)
		li $v0, PRINT_CHAR						# mostra o valor lido
	    syscall
		
		li $v0, PRINT_STR						# syscall 4 (print string)
		la $a0, desenho_1_1						# argument (string)
		syscall	
		
		li $t1, 2
		lb $a0, line0($t1)
		li $v0, PRINT_CHAR						# mostra o valor lido
	    syscall
		
		li $v0, PRINT_STR						# syscall 4 (print string)
		la $a0, linebreak						# argument (string)
		syscall	
		
		
		li $v0, PRINT_STR						# syscall 4 (print string)
		la $a0, desenho_2						# argument (string)
		syscall	
		
		li $t1, 0
		lb $a0, line1($t1)
		li $v0, PRINT_CHAR						# mostra o valor lido
	    syscall
		
		li $v0, PRINT_STR						# syscall 4 (print string)
		la $a0, desenho_1						# argument (string)
		syscall	
		
		li $t1, 1
		lb $a0, line1($t1)
		li $v0, PRINT_CHAR						# mostra o valor lido
	    syscall
		
		li $v0, PRINT_STR						# syscall 4 (print string)
		la $a0, desenho_1_1					# argument (string)
		syscall	
		
		li $t1, 2
		lb $a0, line1($t1)
		li $v0, PRINT_CHAR						# mostra o valor lido
	    syscall
		
		
		li $v0, PRINT_STR						# syscall 4 (print string)
		la $a0, linebreak						# argument (string)
		syscall	
		
		li $v0, PRINT_STR						# syscall 4 (print string)
		la $a0, desenho_2						# argument (string)
		syscall	
			
		li $t1, 0
		lb $a0, line2($t1)
		li $v0, PRINT_CHAR						# mostra o valor lido
	    syscall
		
		li $v0, PRINT_STR						# syscall 4 (print string)
		la $a0, desenho_1						# argument (string)
		syscall	
		
		li $t1, 1
		lb $a0, line2($t1)
		li $v0, PRINT_CHAR						# mostra o valor lido
	    syscall
		
		li $v0, PRINT_STR						# syscall 4 (print string)
		la $a0, desenho_1_1						# argument (string)
		syscall	
		
		li $t1, 2
		lb $a0, line2($t1)
		li $v0, PRINT_CHAR						# mostra o valor lido
	    syscall
		
    exit_print_desenho:
        jr $ra
		
rodadas:
    
    li $v0, PRINT_STR						# syscall 4 (print string)
	la $a0, msg_linha						# argument (string)
	syscall		

  	li $v0, READ_INT						# syscall 5 (read integer)
	syscall
	
	move $s1, $v0 # s1 == linha
	bltz $s1, menor
	bgt $s1, 2, maior
	
    li $v0, PRINT_STR						# solicita ao usuário uma coluna
    la $a0, msg_coluna
    syscall 
	
	li $v0, READ_INT						# syscall 5 (read integer)
	syscall		
   
    move $s2, $v0    # s2 == coluna
	bltz $s2, menor	
    bgt $s2, 2, maior 
	
	li $t4, 2
	lb $t5, jogada
	div $t5, $t4
	mfhi $t3
	li $t6, 1
	beq $t3, $t6, numero_valido_bol
	j numero_valido_x

numero_valido_bol:

	#loop linha 0
	li $t0, 0
	beq $s1, $t0, linha0_bol
	
	#loop linha 1
	li $t0, 1
	beq $s1, $t0, linha1_bol
	
	#loop linha 2
	li $t0, 2
	beq $s1, $t0, linha2_bol

linha0_bol:
	
	#loop coluna 0
	li $t0, 0
	beq $s2, $t0, coluna0_linha0_bol
	
	#loop coluna 1
	li $t0, 1
	beq $s2, $t0, coluna1_linha0_bol
	
	#loop coluna 2
	li $t0, 2
	beq $s2, $t0, coluna2_linha0_bol
	
coluna0_linha0_bol:
    li $t1, 0
	lb $a0, line0($t1)
	lb $t2, vazio
	beq $a0, $t2, validado_c0_l0_bol
	j jaFoi
	
validado_c0_l0_bol:

	la $t0, line0   # Endereço de line0
    li $t1, 'o'     
    sb $t1, 0($t0)  
	j conta_mais
	
coluna1_linha0_bol:
    li $t1, 1
	lb $a0, line0($t1)
	lb $t2, vazio
	beq $a0, $t2, validado_c1_l0_bol
	j jaFoi
	
validado_c1_l0_bol:

	la $t0, line0   # Endereço de line0
    li $t1, 'o'     
    sb $t1, 1($t0)  
	j conta_mais
	
coluna2_linha0_bol:
    li $t1, 2
	lb $a0, line0($t1)
	lb $t2, vazio
	beq $a0, $t2, validado_c2_l0_bol
	j jaFoi
	
validado_c2_l0_bol:

	la $t0, line0   # Endereço de line0
    li $t1, 'o'     
    sb $t1, 2($t0)  
	j conta_mais

linha1_bol:

	#loop coluna 0
	li $t0, 0
	beq $s2, $t0, coluna0_linha1_bol
	
	#loop coluna 1
	li $t0, 1
	beq $s2, $t0, coluna1_linha1_bol
	
	#loop coluna 2
	li $t0, 2
	beq $s2, $t0, coluna2_linha1_bol

coluna0_linha1_bol:

    li $t1, 0
	lb $a0, line1($t1)
	lb $t2, vazio
	beq $a0, $t2, validado_c0_l1_bol
	j jaFoi
	
validado_c0_l1_bol:

	la $t0, line1   # Endereço de line0
    li $t1, 'o'     
    sb $t1, 0($t0)  
	j conta_mais
	
coluna1_linha1_bol:

    li $t1, 1
	lb $a0, line1($t1)
	lb $t2, vazio
	beq $a0, $t2, validado_c1_l1_bol
	j jaFoi
	
validado_c1_l1_bol:

	la $t0, line1   # Endereço de line0
    li $t1, 'o'     
    sb $t1, 1($t0)  
	j conta_mais
	
coluna2_linha1_bol:

    li $t1, 2
	lb $a0, line1($t1)
	lb $t2, vazio
	beq $a0, $t2, validado_c2_l1_bol
	j jaFoi

validado_c2_l1_bol:

	la $t0, line1   # Endereço de line0
    li $t1, 'o'     
    sb $t1, 2($t0)  
	j conta_mais

linha2_bol:

	#loop coluna 0
	li $t0, 0
	beq $s2, $t0, coluna0_linha2_bol
	
	#loop coluna 1
	li $t0, 1
	beq $s2, $t0, coluna1_linha2_bol
	
	#loop coluna 2
	li $t0, 2
	beq $s2, $t0, coluna2_linha2_bol
	
coluna0_linha2_bol:

    li $t1, 0
	lb $a0, line2($t1)
	lb $t2, vazio
	beq $a0, $t2, validado_c0_l2_bol
	j jaFoi
	
validado_c0_l2_bol:

	la $t0, line2   # Endereço de line0
    li $t1, 'o'     
    sb $t1, 0($t0)  
	j conta_mais
	    	
coluna1_linha2_bol:
    li $t1, 1
	lb $a0, line2($t1)
	lb $t2, vazio
	beq $a0, $t2, validado_c1_l2_bol
	j jaFoi
	
validado_c1_l2_bol:

	la $t0, line2   # Endereço de line0
    li $t1, 'o'     
    sb $t1, 1($t0)  
	j conta_mais
	
coluna2_linha2_bol:

    li $t1, 2
	lb $a0, line2($t1)
	lb $t2, vazio
	beq $a0, $t2, validado_c2_l2_bol
    j jaFoi
	
validado_c2_l2_bol:

	la $t0, line2   # Endereço de line0
    li $t1, 'o'     
    sb $t1, 2($t0)  
	j conta_mais
	
numero_valido_x:

	#loop linha 0
	li $t0, 0
	beq $s1, $t0, linha0_x
	
	#loop linha 1
	li $t0, 1
	beq $s1, $t0, linha1_x
	
	#loop linha 2
	li $t0, 2
	beq $s1, $t0, linha2_x

linha0_x:
	
	#loop coluna 0
	li $t0, 0
	beq $s2, $t0, coluna0_linha0_x
	
	#loop coluna 1
	li $t0, 1
	beq $s2, $t0, coluna1_linha0_x
	
	#loop coluna 2
	li $t0, 2
	beq $s2, $t0, coluna2_linha0_x
	
coluna0_linha0_x:

    li $t1, 0
	lb $a0, line0($t1)
	lb $t2, vazio
	beq $a0, $t2, validado_c0_l0_x
	j jaFoi
	
validado_c0_l0_x:

	la $t0, line0   # Endereço de line0
    li $t1, 'x'     
    sb $t1, 0($t0)  
	j conta_mais
	
coluna1_linha0_x:

    li $t1, 1
	lb $a0, line0($t1)
	lb $t2, vazio
	beq $a0, $t2, validado_c1_l0_x
	j jaFoi
	
validado_c1_l0_x:

	la $t0, line0   # Endereço de line0
    li $t1, 'x'     
    sb $t1, 1($t0)  
	j conta_mais
	
coluna2_linha0_x:

    li $t1, 2
	lb $a0, line0($t1)
	lb $t2, vazio
	beq $a0, $t2, validado_c2_l0_x
	j jaFoi
	
validado_c2_l0_x:

	la $t0, line0   # Endereço de line0
    li $t1, 'x'     
    sb $t1, 2($t0)  
	j conta_mais

linha1_x:

	#loop coluna 0
	li $t0, 0
	beq $s2, $t0, coluna0_linha1_x
	
	#loop coluna 1
	li $t0, 1
	beq $s2, $t0, coluna1_linha1_x
	
	#loop coluna 2
	li $t0, 2
	beq $s2, $t0, coluna2_linha1_x

coluna0_linha1_x:

    li $t1, 0
	lb $a0, line1($t1)
	lb $t2, vazio
	beq $a0, $t2, validado_c0_l1_x
	j jaFoi
	
validado_c0_l1_x:

	la $t0, line1   # Endereço de line0
    li $t1, 'x'     
    sb $t1, 0($t0)  
	j conta_mais
	
coluna1_linha1_x:

    li $t1, 1
	lb $a0, line1($t1)
	lb $t2, vazio
	beq $a0, $t2, validado_c1_l1_x
	j jaFoi
	
validado_c1_l1_x:

	la $t0, line1   # Endereço de line0
    li $t1, 'x'     
    sb $t1, 1($t0)  
	j conta_mais
	
coluna2_linha1_x:

    li $t1, 2
	lb $a0, line1($t1)
	lb $t2, vazio
	beq $a0, $t2, validado_c2_l1_x
	j jaFoi

validado_c2_l1_x:

	la $t0, line1   # Endereço de line0
    li $t1, 'x'     
    sb $t1, 2($t0)  
	j conta_mais

linha2_x:

	#loop coluna 0
	li $t0, 0
	beq $s2, $t0, coluna0_linha2_x
	#loop coluna 1
	li $t0, 1
	beq $s2, $t0, coluna1_linha2_x
	#loop coluna 2
	li $t0, 2
	beq $s2, $t0, coluna2_linha2_x
	
coluna0_linha2_x:

    li $t1, 0
	lb $a0, line2($t1)
	lb $t2, vazio
	beq $a0, $t2, validado_c0_l2_x
	j jaFoi
	
validado_c0_l2_x:

	la $t0, line2   # Endereço de line0
    li $t1, 'x'     
    sb $t1, 0($t0)  
	j conta_mais
	    	
coluna1_linha2_x:

    li $t1, 1
	lb $a0, line2($t1)
	lb $t2, vazio
	beq $a0, $t2, validado_c1_l2_x
	j jaFoi
	
validado_c1_l2_x:

	la $t0, line2   # Endereço de line0
    li $t1, 'x'     
    sb $t1, 1($t0)  
	j conta_mais
	
coluna2_linha2_x:

    li $t1, 2
	lb $a0, line2($t1)
	lb $t2, vazio
	beq $a0, $t2, validado_c2_l2_x
    j jaFoi
	
validado_c2_l2_x:

	la $t0, line2   # Endereço de line0
    li $t1, 'x'     
    sb $t1, 2($t0)  
	j conta_mais	
	
conta_mais:

    lb $t0, jogada
	addi $t0, $t0, 1
	sw $t0, jogada
	j $ra
	
maior:

    li $v0, PRINT_STR						# syscall 4 (print string)
	la $a0, msg_maior						# argument (string)
	syscall
	
	li $v0, PRINT_STR
	la $a0, linebreak
	syscall
	
	j rodadas

menor:

    li $v0, PRINT_STR						# syscall 4 (print string)
	la $a0, msg_menor						# argument (string)
	syscall
	
	li $v0, PRINT_STR
	la $a0, linebreak
	syscall
	
	j rodadas

jaFoi:

	li $v0, PRINT_STR						# syscall 4 (print string)
	la $a0, msg_erro						# argument (string)
	syscall
	
	li $v0, PRINT_STR
	la $a0, linebreak
	syscall
	
	j rodadas
	
verifica_vitoria:
   
	lb $s0, x
	lb $s1, bola
	lb $s2, vazio
	li $t1, 1		
	la $t3, line0 
    lb $t4, 0($t3)	
    beq $t4, $s2, verificalinha1
	beq $t4, $s1, linha_loop_bol
	j linha_loop_x
	
linha_loop_bol:

	li $t1, 1
	la $t3, line0
    lb $t4, 1($t3)
	beq $t4, $s1, linha_loop1_bol
	j verificalinha1
	
linha_loop1_bol:

	addi $t1, $t1, 1
	la $t3, line0
    lb $t4, 2($t3)
	beq $t4, $s1, jogador_O_msg
	j verificalinha1

linha_loop_x:
	
	li $t1, 1
	la $t3, line0
    lb $t4, 1($t3)
	beq $t4, $s0, linha_loop1_x
	j verificalinha1
	
linha_loop1_x:

	addi $t1, $t1, 1
	la $t3, line0
    lb $t4, 2($t3)
	beq $t4, $s0, jogador_X_msg
	j verificalinha1


verificalinha1:
	
	la $t3, line1 
    lb $t4, 0($t3)	
    beq $t4, $s2, verificalinha2
	beq $t4, $s1, linha1_loop_bol1
	j linha1_loop_x1	
	
linha1_loop_bol1:

	li $t1, 1
	la $t3, line1
    lb $t4, 1($t3)
	beq $t4, $s1, linha1_loop1_bol
	j verificalinha2
	
linha1_loop1_bol:

	addi $t1, $t1, 1
	la $t3, line1
    lb $t4, 2($t3)
	beq $t4, $s1, jogador_O_msg
	j verificalinha2

linha1_loop_x1:

	li $t1, 1
	la $t3, line1
    lb $t4, 1($t3)
	beq $t4, $s0, linha1_loop1_x
	j verificalinha2
	
linha1_loop1_x:

	addi $t1, $t1, 1
	la $t3, line1
    lb $t4, 2($t3)
	beq $t4, $s0, jogador_X_msg
	j verificalinha2
	
verificalinha2:

	la $t3, line2 
    lb $t4, 0($t3)	
    beq $t4, $s2, verifica_vitoria_col1
	beq $t4, $s1, linha2_loop_bol1
	j linha2_loop_x1
	
linha2_loop_bol1:

	li $t1, 1
	la $t3, line2
    lb $t4, 1($t3)
	beq $t4, $s1, linha2_loop1_bol
	j verifica_vitoria_col1
	
linha2_loop1_bol:

	addi $t1, $t1, 1
	la $t3, line2
    lb $t4, 2($t3)
	beq $t4, $s1, jogador_O_msg
	j verifica_vitoria_col1
	
linha2_loop_x1:

	li $t1, 1
	la $t3, line2
    lb $t4, 1($t3)
	beq $t4, $s0, linha2_loop1_x
	j verifica_vitoria_col1
	
linha2_loop1_x:

	addi $t1, $t1, 1
	la $t3, line2
    lb $t4, 2($t3)
	beq $t4, $s0, jogador_X_msg
	j verifica_vitoria_col1
	
verifica_vitoria_col1:

	lb $s0, x
	lb $s1, bola
	lb $s2, vazio
	li $t1, 1		
	la $t3, line0 
    lb $t4, 0($t3)	
    beq $t4, $s2, verificacol1
	beq $t4, $s1, coluna1_loop_bol
	j coluna1_loop_x

coluna1_loop_bol:

    li $t1, 1
	la $t3, line1
    lb $t4, 0($t3)
	beq $t4, $s1, coluna1_loop2_bol
	j verificacol1
	
coluna1_loop2_bol:

	addi $t1, $t1, 1
	la $t3, line2
    lb $t4, 0($t3)
	beq $t4, $s1, jogador_O_msg
	j verificacol1
   
coluna1_loop_x:

	li $t1, 1
	la $t3, line1
    lb $t4, 0($t3)
	beq $t4, $s0, coluna1_loop2_x
	j verificacol1
	
coluna1_loop2_x:

	addi $t1, $t1, 1
	la $t3, line2
    lb $t4, 0($t3)
	beq $t4, $s0, jogador_X_msg
	j verificacol1
	
verificacol1:
	
	la $t3, line0 
    lb $t4, 1($t3)	
    beq $t4, $s2, verificacol2
	beq $t4, $s1, coluna1_loop_bol1
	j coluna1_loop_x1
	
coluna1_loop_bol1:

    li $t1, 1
	la $t3, line1
    lb $t4, 1($t3)
	beq $t4, $s1, coluna1_loop2_bol1
	j verificacol2
	
coluna1_loop2_bol1:

	addi $t1, $t1, 1
	la $t3, line2
    lb $t4, 1($t3)
	beq $t4, $s1, jogador_O_msg
	j verificacol2
	
coluna1_loop_x1:

    li $t1, 1
	la $t3, line1
    lb $t4, 1($t3)
	beq $t4, $s0, coluna2_loop2_x1
	j verificacol2
	
coluna2_loop2_x1:

	addi $t1, $t1, 1
	la $t3, line2
    lb $t4, 1($t3)
	beq $t4, $s0, jogador_X_msg
	j verificacol2	

verificacol2:

	la $t3, line0 
    lb $t4, 2($t3)	
    beq $t4, $s2, verifica_diagonal
	beq $t4, $s1, coluna2_loop_bol2
	j coluna2_loop_x2

coluna2_loop_bol2:

    li $t1, 1
	la $t3, line1
    lb $t4, 2($t3)
	beq $t4, $s1, coluna2_loop2_bol2
	j verifica_diagonal
	
coluna2_loop2_bol2:

	addi $t1, $t1, 1
	la $t3, line2
    lb $t4, 2($t3)
	beq $t4, $s1, jogador_O_msg
	j verifica_diagonal
	
coluna2_loop_x2:

	li $t1, 1
	la $t3, line1
    lb $t4, 2($t3)
	beq $t4, $s0, coluna2_loop2_x2
	j verifica_diagonal
	
coluna2_loop2_x2:

	addi $t1, $t1, 1
	la $t3, line2
    lb $t4, 2($t3)
	beq $t4, $s0, jogador_X_msg
	j verifica_diagonal
     
verifica_diagonal:

	lb $s0, x
	lb $s1, bola
	lb $s2, vazio
	li $t1, 1		
	la $t3, line0 
    lb $t4, 0($t3)	
    beq $t4, $s2, verifica_diagonal2
	beq $t4, $s1, diagonal_loop1_bol_1
	j diagonal_loop1_x

diagonal_loop1_bol_1:

    li $t1, 1
	la $t3, line1
    lb $t4, 1($t3)
	beq $t4, $s1, diagonal_loop2_bol
	j verifica_diagonal2
	
diagonal_loop2_bol:

	addi $t1, $t1, 1
	la $t3, line2
    lb $t4, 2($t3)
	beq $t4, $s1, jogador_O_msg
	j verifica_diagonal2
   
diagonal_loop1_x:

	li $t1, 1
	la $t3, line1
    lb $t4, 1($t3)
	beq $t4, $s0, diagonal_loop2_x
	j verifica_diagonal2
	
diagonal_loop2_x:

	addi $t1, $t1, 1
	la $t3, line2
    lb $t4, 2($t3)
	beq $t4, $s0, jogador_X_msg
	j verifica_diagonal2
	
verifica_diagonal2:

	la $t3, line0 
    lb $t4, 2($t3)	
    beq $t4, $s2, inicio
	beq $t4, $s1, diagonal_loop1_bol_2
	j diagonal_2_loop1_x	

diagonal_loop1_bol_2:

	li $t1, 1
	la $t3, line1
    lb $t4, 1($t3)
	beq $t4, $s1, diagonal_2_loop2_bol
	j inicio
	
diagonal_2_loop2_bol:

	addi $t1, $t1, 1
	la $t3, line2
    lb $t4, 0($t3)
	beq $t4, $s1, jogador_O_msg
	j inicio
	
diagonal_2_loop1_x:

	li $t1, 1
	la $t3, line1
    lb $t4, 1($t3)
	beq $t4, $s0, diagonal_2_loop2_x
	j inicio
	
diagonal_2_loop2_x:

	addi $t1, $t1, 1
	la $t3, line2
    lb $t4, 0($t3)
	beq $t4, $s0, jogador_X_msg
	j inicio

empate_msg:

	li $v0, PRINT_STR         
    la $a0, linebreak  
	syscall
	
    li $v0, PRINT_STR            
    la $a0, msg_empate       
    syscall
	
	jal print_jogo
    j fim_jogo

jogador_X_msg:

	li $v0, PRINT_STR         
    la $a0, linebreak  
	syscall
	
    li $v0, PRINT_STR       
    la $a0, msg_ganhador_x    
    syscall
	
	jal print_jogo
    j fim_jogo

jogador_O_msg:

	li $v0, PRINT_STR         
    la $a0, linebreak  
	syscall
	
	li $v0, PRINT_STR         
    la $a0, linebreak  
	syscall
	
    li $v0, PRINT_STR         
    la $a0, msg_ganhador_o    
    syscall
	
	jal print_jogo
    j fim_jogo	   	
				
fim_jogo:
	li $v0, END_PROGRAM							# terminate program
	syscall
