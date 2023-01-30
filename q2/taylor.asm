# This code is a constituent part of work 2 of the Computer Organization Discipline [ELC1011]
# https://github.com/Jvbrates/T2_OrgC
# This program is free software under GNU GPL V3 or later version
# see http://www.gnu.org/licences
#
# Autor: João Vitor Belmonte Rates(Jvbrates) - UFSM - CT
# e-mail: jvrates%inf.ufsm.br

# 3/4
# Prólogo:
# [Leia o ReadmeQ2.md]
#
# Este arquivo contém a função recursiva cosseno_taylor, com 7 iterações:
# Está função recebe como parâmetro um valor $f12 (double), que representa o
# angulo ao qual será calculado o cosseno, expresso em radianos.
# Retorna em $f0 (double) o cosseno do angulo

# A função é dividia em duas partes, a principal que define o contador de 
# recursão para 2, calculando então o somatario da função de 2 à 7, e soma com o
# valor da primeira recursão (independente da entrada será 1). Isto possibilita
# que não seja necessário os caller setar o valor do contador de recursividade,
# isto seria uma má pratica visto que o valor inicial do contador é fixo. Possi_
# bilitar a modificação do mesmo seria um erro no design do código

# A função interna (Nested function) rec_taylor, é a recursão em si, e calcula o valor da formula 
# do somatório de taylor para n de 2 à 7. 

#*******************************************************************************
#        1         2         3         4         5         6         7         8
#2345678901234567890123456789012345678901234567890123456789012345678901234567890


.data
.align 3
menuzum: .double -1.0 # Constante -1


.text

.globl cosseno_taylor
cosseno_taylor:
add $sp,$sp, -4

# Aloca memória
add, $sp, $sp, -8

# Armazena $ra e $s0
sw $ra, 4($sp)
sw $s0, ($sp)


li $s0, 1

jal rec_taylor

mov.d $f12,$f0 

l.d $f0, menuzum
div.d $f0, $f0,$f0 # $f0 <= 1

# $f0 = 1 + ["Recursão taylor, para n de 2 à 7"]
add.d $f0, $f0, $f12

# restaura os registradores
lw $ra, 4($sp)
lw $s0, ($sp)

# Dealoca memíria
add $sp, $sp, 8
jr $ra

#-----------------------------------------------------------------------------|

rec_taylor:

# Aloca memória
# [16 - 24] : $ra | (não usado)
# [08 - 16] : $f12 | $f1
# [00 - 08] : $f28 | $f29
addi $sp, $sp, -24

# Armazena os registradores
sw $ra, 16($sp)
s.d $f28, ($sp)
s.d $f12, 8($sp)



# $f0 <= (-1)^$s0
move $a0, $s0
l.d $f12, menuzum
jal pow

# $f28 <= $f0
mov.d $f28, $f0

# $f0 <= (2*$s0)!
add $a0, $a0, $a0 # $a0*=2
jal fatorial

# $f28 <= $f28/$f0 == (-1)^n / (2n)!
div.d $f28, $f28, $f0

# $f12 = x || restaura $f12
l.d $f12, 8($sp)

# $f0 <= == (x)^2n
jal pow

# $f0 <= $f0*$f28
mul.d $f0, $f0, $f28


blt $s0, 7, rec

exit:
# Restaura $f28
l.d $f28, ($sp)
# Restaura $ra
lw $ra,  16($sp)

# Dealoca memória
addi $sp, $sp, 24

jr $ra

#--------------------------------------|
rec:

# Soma contador de recursão
addi $s0, $s0, 1

# Salva o resultado da iteração atual em $f28
mov.d $f28, $f0

# $f0 <= Calcula a próxima iteração
jal rec_taylor

# Soma a próxima iteração com a atual
add.d $f0, $f0, $f28

j exit
