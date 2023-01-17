# This code is a constituent part of work 2 of the Computer Organization Discipline [ELC1011]
# https://github.com/Jvbrates/TIC_TAC_TOE-MarsMips/
# This program is free software under GNU GPL V3 or later version
# see http://www.gnu.org/licences
#
# Autor: João Vitor Belmonte Rates(Jvbrates) - UFSM - CT
# e-mail: jvrates%inf.ufsm.br

# 0/4
# Prólogo:
# Este arquivo contém a função recursiva pow, que recebe dois argumentos,
# $f0 <= Um numero tipo double;
# $a0 <= um Expoente inteiro(tipo word) maior que 0;
# E então retorna em $f30 <= $f0^$a0

#*******************************************************************************
#        1         2         3         4         5         6         7         8
#2345678901234567890123456789012345678901234567890123456789012345678901234567890

.text

.globl pow
pow:

bne $a0, 1, recursao

mov.d $f30, $f0

jr $ra

recursao:

addi $sp, $sp, -4
sw $ra, ($sp)

addi $a0, $a0, -1


jal pow

mul.d $f30, $f30, $f0

lw $ra, ($sp)
addi $sp, $sp, 4

jr $ra

