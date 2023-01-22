# Este arquivo contém funções que  fazer shift left logical 
# logical em um par de registradores 32-bits que servem com um unico de 64-bits

# Entradas | $s4 $a0 $a1
#             ↓   ↓   ↓
# Saidas   | $s4 $v0 $v1

# Serão usados os registradores $t como auxiliares,
# portanto, não será necessário salvar registradores na stack


.data

mask_MSB: .word 0x80000000
mask_LSB: .word 1

.text
.globl sll64
sll64:


lw $t2, mask_MSB
and $t2, $t2, $a0

beqz $t2, no_need

ori $s4, $s4, 1

no_need:

#----------

move $t1, $a1
sll $t0, $a0, 1

#----------
lw $t2, mask_MSB

and $t3, $t1, $t2

beqz $t3, no_lower

ori $t0, $t0, 1 # add 1 to lsb

no_lower:

sll $t1, $a1, 1

# Set returns

move $v0, $t0
move $v1, $t1

jr $ra

#------------------------------------------------#
