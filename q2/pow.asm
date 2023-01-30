# This code is a constituent part of work 2 of the Computer Organization Discipline [ELC1011]
# https://github.com/Jvbrates/T2_OrgC
# This program is free software under GNU GPL V3 or later version
# see http://www.gnu.org/licences
#
# Autor: João Vitor Belmonte Rates(Jvbrates) - UFSM - CT
# e-mail: jvrates%inf.ufsm.br

# 0/4
# Prólogo:
# [Leia o ReadmeQ2.md]
# Este arquivo contém a função recursiva pow, que recebe dois argumentos,
# $f12 <= Um numero tipo double;
# $a0 <= um Expoente inteiro(tipo word) maior que 0;
# E então retorna em $f0 <= $f12^$a0

#*******************************************************************************
#        1         2         3         4         5         6         7         8
#2345678901234567890123456789012345678901234567890123456789012345678901234567890

.text

.globl pow
pow:
addiu $sp, $sp, -8
sw $a0, ($sp)
sw $ra, 4($sp)

jal pow_rec

lw $a0, ($sp)
lw $ra, 4($sp)

addiu $sp, $sp, 8
jr $ra

#-----------------------------------------------------------------------------|

pow_rec:

bne $a0, 1, recursao

mov.d $f0, $f12

jr $ra

recursao:

addi $sp, $sp, -4
sw $ra, ($sp)

addi $a0, $a0, -1


jal pow

mul.d $f0, $f0, $f12

lw $ra, ($sp)
addi $sp, $sp, 4

jr $ra

