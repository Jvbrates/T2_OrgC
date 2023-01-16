# This file contains the factorial function                                   |
# It get an integer value in $a0 and return a double value in $f30


.text


li $a0, 5
# double fatorial( int fat);
.globl fatorial
fatorial:

addi $sp, $sp, -8
sw $ra, ($sp)
sw $s0, 4($sp)


divu $s0, $sp, 8
mfhi $s0
beqz $s0, no_need_align

# Alinhando a memoria a 8 bytes necessários para lidar com double
addi $sp, $sp, -4

no_need_align:
jal rec_fat

beqz $s0, no_need_realign

addi $sp, $sp, 4

no_need_realign:
lw $ra, ($sp)
lw $s0, 4($sp)
addiu $sp, $sp, 8

jr $ra

#-----------------------------------------------------------------------------|

rec_fat:


bgt  $a0, 1, recursao
# 1! = 1, 0! = 1
fat0:
li $t0, 1
mtc1 $t0, $f30
mtc1 $zero, $f31
cvt.d.w $f30, $f30

jr $ra

recursao:
#Armazena $f28 na stack, e $ra
addi $sp, $sp, -16 # não posso usar sp+12 
# pois a memoria deve estar alinha a 8 bytes, devido a precisão Dupla
sw $ra, 12($sp)
s.d $f28, ($sp)


#Move $a0 (X) para $f28 em notacão de inteiro
mtc1 $zero, $f29
mtc1 $a0, $f28

#Converte inteiro para double
cvt.d.w $f28, $f28

#Calcula o fatorial anterior
addi $a0, $a0, -1  # $f30 = (x-1)!
jal rec_fat

# Calcula o fatorial x! = x.(x-1)!
mul.d $f30, $f30, $f28

#restaura $f28
l.d $f28, ($sp)

#restaura $ra
lw $ra, 12($sp)

# Dealoca a Stack
addi  $sp, $sp, 16


jr $ra

