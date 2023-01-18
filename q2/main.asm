# This code is a constituent part of work 2 of the Computer Organization Discipline [ELC1011]
# https://github.com/Jvbrates/T2_OrgC
# This program is free software under GNU GPL V3 or later version
# see http://www.gnu.org/licences
#
# Autor: João Vitor Belmonte Rates(Jvbrates) - UFSM - CT
# e-mail: jvrates%inf.ufsm.br

# 4/4
# Prólogo:
# [Leia o ReadmeQ2.md]
#
# Este arquivo contem a função main, que carrega o valor 57.23 graus
# no registrador $f0 double e então converte o valor para radianos,
# após isso calcula o valor do cosseno usando a série de taylor, e
# por fim exibe na tela o resultado

#*******************************************************************************
#        1         2         3         4         5         6         7         8
#2345678901234567890123456789012345678901234567890123456789012345678901234567890


.data
.align 3
valor_calculado: .double 57.23
resultado: .asciiz "Resultado: "


.text


.globl main
main:

l.d $f0, valor_calculado

jal graustorad

mov.d $f0, $f30

jal cosseno_taylor

mov.d $f12, $f30
la $a0, resultado
li $v0, 58
syscall

li $v0, 10
syscall

