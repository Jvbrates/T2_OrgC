# This code is a constituent part of work 2 of the Computer Organization Discipline [ELC1011]
# https://github.com/Jvbrates/TIC_TAC_TOE-MarsMips/
# This program is free software under GNU GPL V3 or later version
# see http://www.gnu.org/licences
#
# Autor: João Vitor Belmonte Rates(Jvbrates) - UFSM - CT
# e-mail: jvrates%inf.ufsm.br

# 2/4
# Prólogo:
# Este arquivo contém a duas funções:
# graustorad, converte um valor dado em graus para radianos.
# radtograus, convertte um valor dado em radianos para graus.
# Ambas funções recebem como entrada double em $f0 e
# retornam o resultado em doubble $f30

# É importante perceber que devido a constante PI ser um valor
# irracional, as conversões serão aproximadas e como consequencia
# x != graustorad( radtograus(x) ). O resultado será "aproximado"


#*******************************************************************************
#        1         2         3         4         5         6         7         8
#2345678901234567890123456789012345678901234567890123456789012345678901234567890


.data

# A diretiva .align 3 alinha o segmento de dados para trabalhar com espaços 
# de 8bytes (double)
.align 3
PI: .double 3.1415926535897931
Divisor: .double 180.0


.text
j graustorad 

.globl radtograus
radtograus:

l.d $f28, Divisor

mul.d $f30, $f0, $f28

l.d $f28, PI

div.d $f30, $f30, $f28


jr $ra

#-----------------------------------------------------------------------------|

.globl  graustorad
graustorad:

l.d $f28, PI

mul.d $f30, $f0, $f28

l.d  $f28, Divisor

div.d $f30, $f30, $f28


jr $ra
