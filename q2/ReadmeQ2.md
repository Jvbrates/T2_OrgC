# ReadmeQ2.md

## Fórmula de Taylor ou função de Taylor:

$W(x)=\sum_{k=1}^\infty\frac{(-k)^{k-1}}{k!}x^k$

## Convenções:

As funções matemáticas que manipulam dados double esperam que a memória esteja previamente alinhada para o intervalo de 8 bytes, portanto cabe a função **main**, ****alinhar os dados a memória entes de iniciar os cálculos. ****

As funções **globais** neste código seguem as convenções padrões;

Funções **contidas** dentro de funções globais (internas, recursivas) não necessitam manter registradores, tipo $s e $a, no retorno. Visto que está responsabilidade fica atrelada as suas respectivas funções globais (caller).

Isto é útil a funções recursivas que necessitam de um contador e ou necessitam alterar o parâmetro $f12 para cada recursão. (Ex.: $x! = x*(x-1)!$ )

“caller”:  Que chama outro procedimento;

“callee”: Chamado por outro procedimento

```nasm
.text
.main #caller

jal procedure # callee
```

### Separações visuais

```nasm
#-----------------------------------------------------------------------------|
```

Separa a função global de sua respectiva interna ou funções globais gravadas no mesmo arquivo.

```nasm
#--------------------------------------|
```

Separa a parte recursiva de uma função de sua parte de parada.
