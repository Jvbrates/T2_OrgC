# This code is a constituent part of work 2 of the Computer Organization Discipline [ELC1011]
# https://github.com/Jvbrates/TIC_TAC_TOE-MarsMips/
# This program is free software under GNU GPL V3 or later version
# see http://www.gnu.org/licences
#
# Autor: João Vitor Belmonte Rates(Jvbrates) - UFSM - CT
# e-mail: jvrates%inf.ufsm.br

# 1/4
# Prólogo:
# Este arquivo contém a função recursiva fatorial, que recebe como argumento:
# $a0, um inteiro(tipo word) e retorna o seu valor fatorial em $f30 (tipo double)
# $double f30 <= ( int $a0)!

#*******************************************************************************
#        1         2         3         4         5         6         7         8
#2345678901234567890123456789012345678901234567890123456789012345678901234567890

.text

# No trecho de código mais externo a função certifica-se de que $sp está
# alinhado para capacitar o armazanamento de um regitrador de precisão dupla,
# isto é, $sp%8==0, caso necessário ela subtrai -4 de $sp (-4 pois este é o 
# valor que $sp estará movido devido ao armazenamento de words). Após alinhar a
# memória, a função rec_fat é chamada, está que realmente calcula o valor 
# fatorial. Por fim antes de retornar, A função restaura o valor de $sp

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

