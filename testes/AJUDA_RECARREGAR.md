# Ajuda: Recarregar Arquivo no SWI-Prolog

## Problema

Se você receber o erro:
```
ERROR: Unknown procedure: listar_decisoes_por_impacto/1
```

Isso significa que o arquivo `data.pl` não foi carregado ou precisa ser recarregado.

## Solução

### Opção 1: Carregar o arquivo novamente

```prolog
['data.pl'].
```

### Opção 2: Usar consult/1

```prolog
consult('data.pl').
```

### Opção 3: Recarregar tudo

```prolog
make.
```

## Verificar se a função está disponível

Após carregar, você pode verificar se a função está disponível:

```prolog
listing(listar_decisoes_por_impacto).
```

Se mostrar a definição da função, está tudo certo!

## Exemplo Completo

```prolog
% 1. Carregar o arquivo
['data.pl'].

% 2. Configurar dados
assertz(crise_economica(pais2, alto, alta, critica, alto, explosiva)),
assertz(crise_saude(pais2, alto, alta, critica, alto, explosiva)),
assertz(crise_seguranca(pais2, medio, estavel, moderada, medio, estavel)),
assertz(crise_social(pais2, medio, estavel, moderada, medio, estavel)),
assertz(infraestrutura(pais2, media)),
assertz(apoio_populacao(pais2, medio)),
assertz(reservas(pais2, alto)).

% 3. Usar a função
listar_decisoes_por_impacto(pais2).
```

## Funções Disponíveis Após Carregar

- `listar_decisoes_por_impacto(Pais)` - Lista decisões agrupadas por impacto
- `melhor_decisao_considerando_impacto(Pais, Acao, Meses, Impacto)` - Melhor decisão de um impacto específico
- `melhor_decisao_por_impacto(Pais, Resultados)` - Melhores decisões de cada impacto
- `melhor_decisao(Pais, Acao, Meses)` - Melhor decisão geral

