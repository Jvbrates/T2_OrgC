# This code is a constituent part of work 2 of the Computer Organization Discipline [ELC1011]
# https://github.com/Jvbrates/TIC_TAC_TOE-MarsMips/
# This program is free software under GNU GPL V3 or later version
# see http://www.gnu.org/licences
#
# Autor: João Vitor Belmonte Rates(Jvbrates) - UFSM - CT
# e-mail: jvrates%inf.ufsm.br

# $a0 = x = 0x12341234 
# $a1 = y = 0x90357274
# $s0 <- iterator
# $s1 <- RESTOH (Resto)
# $s2 <- RESTOL (Quociente|Dividendo)
# $s3 <- DIVISOR

### MACRO 
.macro debug (%Q, %R)
	.data
Q: .asciiz "Quociente: "
R: .asciiz "Resto: "
Nl: .asciiz "\n"
	.text
	
	move $t0, $a0 # Save $a0
	
	li $v0, 4
	la $a0, Q
	syscall
	
	li $v0, 34
	move $a0, %R
	syscall
	
	li $v0, 4
	la $a0, Nl
	syscall
	
	li $v0, 4
	la $a0, R
	syscall
	
	li $v0, 34
	move $a0, %Q
	syscall
	
	li $v0, 4
	la $a0, Nl
	syscall
	
	
	move $a0, $t0
	.end_macro

.data
mask_1: .word 01
mask_0: .word -2

.text

main: 

#Load X
lui $a0, 0x1234
ori $a0, 0x1234

#Load Y
lui $a1, 0x9035
ori $a1, 0x7274


# $s0 = 1
addi $s0, $s0, 0
add $s1, $zero, $zero
add $s2, $zero, $a0

# RestoH = 0
add $s1, $zero, $zero
# RestoL = Dividendo = x
move $s2, $a0
# Divisor <- $a1 = y
move $s3, $a1

# SHIFT RESTO LEFT
move $a0, $s1
move $a1, $s2
jal sll64
move $s1, $v0
move $s2, $v1


loop:
#      |resto < divisor
bltu $s1, $s3, menor 
# Resto = Resto-divisor
sub $s1, $s1, $s3


# SHIFT LEFT RESTO
move $a0, $s1
move $a1, $s2
jal sll64
move $s1, $v0
move $s2, $v1
# RESTO[0] = 1
addi $s2, $s2, 1


j continua


menor:

# SHIFT LEFT RESTO
move $a0, $s1
move $a1, $s2
jal sll64
move $s1, $v0
move $s2, $v1
# RESTO[0] = 0; Não necessita de implementação

continua:
addi $s0, $s0, 1

#debug($s1, $s2)
bne $s0, 32, loop

# Restoh >> 1
srl $s1, $s1, 1

#resto = RestoL
#Quociente = RestoH

debug($s1, $s2)

move $a0, $s1
move $a1, $s2



li $v0, 17
syscall