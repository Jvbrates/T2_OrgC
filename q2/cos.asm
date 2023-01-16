# Coment this file

.data
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

.globl  graustorad
graustorad:

l.d $f28, PI

mul.d $f30, $f0, $f28

l.d  $f28, Divisor

div.d $f30, $f30, $f28


jr $ra