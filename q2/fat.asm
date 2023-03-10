# This file contains the factorial function                                   |
# It get an integer value in $a0 and return a double value in $f0


.text

#addi $sp, $sp, -4
li $a0, 5
# double fatorial( int fat);

.globl fa_torial
fa_torial:


bgt  $a0, 1, recursao
# 1! = 1, 0! = 1
fat0:
li $t0, 1
mtc1 $t0, $f0
mtc1 $zero, $f31
cvt.d.w $f0, $f0

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
addi $a0, $a0, -1  # $f0 = (x-1)!
jal fatorial

# Calcula o fatorial x! = x.(x-1)!
mul.d $f0, $f0, $f28

#restaura $f28
l.d $f28, ($sp)

#restaura $ra
lw $ra, 12($sp)

# Dealoca a Stack
addi  $sp, $sp, 16


jr $ra

