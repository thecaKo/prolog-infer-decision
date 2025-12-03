# Guia de Uso - Sistema de Decisão em Prolog

## 📋 Resumo Rápido: Como Obter Resultados Diferentes

### 🎯 Para obter uma decisão específica como "melhor decisão":

1. **Identifique a prioridade da decisão desejada** (veja tabela abaixo)
2. **Configure os dados para ativar essa decisão** (atender suas condições)
3. **Configure os dados para NÃO ativar decisões de prioridade menor** (1-5 são mais importantes que 6-16)

### 📊 Hierarquia de Prioridades (Menor = Mais Importante)

```
Prioridade 1-5  → Decisões de CRISE GRAVE (econômica, saúde, tributária)
Prioridade 6-10 → Decisões de CRISE MÉDIA (lockdown, segurança, ONU)
Prioridade 11-16 → Decisões de ESTABILIZAÇÃO (infraestrutura, programas sociais)
```

### 🔑 Regra de Ouro

**A melhor decisão = a decisão com MENOR número de prioridade entre todas as disponíveis**

- Se você tem decisões com prioridades [1, 6, 9, 13] → Melhor = prioridade 1
- Se você tem decisões com prioridades [6, 9, 13] → Melhor = prioridade 6
- Se você só tem prioridade 13 → Melhor = prioridade 13

### ⚡ Exemplos Rápidos

| Quero esta decisão | O que fazer |
|-------------------|-------------|
| **intervencao_economica** | Crise econômica alta + reservas altas |
| **lockdown_parcial** | Crise de saúde alta + apoio médio/alto + sem crises econômicas graves |
| **chamar_onu** | Crise de saúde alta + infraestrutura ruim + sem outras crises ativas |
| **reforma_infraestrutura** | Infraestrutura ruim + todas outras crises baixas |

> 💡 **Dica:** Consulte a seção "Como Obter Resultados Diferentes" abaixo para exemplos de código completos!

---

## Problemas Corrigidos

Os seguintes problemas foram corrigidos no arquivo `data.pl`:

1. **Linha 211**: Corrigido uso de variável anônima `_` para `P` na regra de `reforma_infraestrutura`
2. **Linhas 72-75 e 77-80**: Adicionados parênteses para melhorar a precedência dos operadores `;` (OU)

## Como Usar o Sistema

### Pré-requisitos

- SWI-Prolog instalado

### Executar o Fluxo Completo

1. Abra o SWI-Prolog:
```bash
swipl
```

2. Carregue o arquivo de exemplo:
```prolog
['exemplo_fluxo_completo.pl'].
```

3. Execute o fluxo completo:
```prolog
executar_fluxo_completo.
```

### Executar Passos Individuais

#### 1. Configurar dados do país
```prolog
configurar_pais_exemplo.
```

#### 2. Verificar decisões específicas
```prolog
verificar_decisoes.
```

#### 3. Obter decisões específicas com detalhes
```prolog
obter_decisoes_especificas.
```

#### 4. Avaliar o país
```prolog
avaliar_pais_completo.
```

#### 5. Obter a melhor decisão
```prolog
obter_melhor_decisao.
```

#### 6. Listar todas as decisões
```prolog
listar_todas_decisoes.
```

## Condições para Cada Decisão

### 1. LOCKDOWN PARCIAL
**Condições necessárias:**
- Crise de saúde: nível = `alto`
- Apoio da população: `medio` OU `alto`

**Prioridade:** 6 | **Impacto:** alto | **Duração:** 1 mês

### 2. CHAMAR ONU
**Condições necessárias:**
- Crise de saúde: nível = `alto`
- Infraestrutura: `ruim`

**Prioridade:** 9 | **Impacto:** baixo | **Duração:** 2 meses

### 3. REFORMA DE INFRAESTRUTURA
**Condições necessárias:**
- Infraestrutura: `ruim`

**Prioridade:** 13 | **Impacto:** baixo | **Duração:** 12 meses

### 4. INTERVENÇÃO ECONÔMICA
**Condições necessárias:**
- Crise econômica: nível = `alto`
- Crise econômica: tendência = `alta`
- Crise econômica: severidade = `alta` OU `critica`
- Reservas: `alto`

**Prioridade:** 1 | **Impacto:** medio | **Duração:** 6 meses

## Estrutura dos Dados

### Crise Econômica/Saúde/Segurança/Social
```prolog
crise_economica(Pais, Nivel, Tendencia, Severidade, Impacto, Variacao).
```

**Valores possíveis:**
- **Nível:** `baixo`, `medio`, `alto`
- **Tendência:** `queda`, `estavel`, `alta`
- **Severidade:** `leve`, `moderada`, `alta`, `critica`
- **Impacto:** `baixo`, `medio`, `alto`
- **Variação:** `decrescente`, `estavel`, `ascendente`, `explosiva`

### Infraestrutura
```prolog
infraestrutura(Pais, Nivel).
```

**Valores possíveis:** `boa`, `media`, `ruim`

### Apoio da População
```prolog
apoio_populacao(Pais, Nivel).
```

**Valores possíveis:** `baixo`, `medio`, `alto`

### Reservas
```prolog
reservas(Pais, Nivel).
```

**Valores possíveis:** `baixo`, `alto`

## Consultas Úteis

### Verificar se uma decisão específica está disponível
```prolog
decisao(pais_exemplo, lockdown_parcial, Meses).
```

### Ver todas as decisões disponíveis
```prolog
findall((A, M), decisao(pais_exemplo, A, M), Decisoes).
```

### Obter perfil completo do país
```prolog
perfil_pais(pais_exemplo, Perfil).
```

### Calcular score do país
```prolog
score_pais_normalizado(pais_exemplo, Score).
```

## Exemplos Práticos de Código - Copiar e Colar

### Exemplo 1: Configurar País para Obter "Lockdown Parcial" como Melhor Decisão

```prolog
% Limpar dados anteriores
retractall(crise_economica(_, _, _, _, _, _)),
retractall(crise_saude(_, _, _, _, _, _)),
retractall(crise_seguranca(_, _, _, _, _, _)),
retractall(crise_social(_, _, _, _, _, _)),
retractall(infraestrutura(_, _)),
retractall(apoio_populacao(_, _)),
retractall(reservas(_, _)),

% Configurar para lockdown_parcial (prioridade 6)
assertz(crise_saude(meu_pais, alto, alta, critica, alto, explosiva)),
assertz(apoio_populacao(meu_pais, medio)),

% Outras crises em níveis baixos (para não ativar outras decisões)
assertz(crise_economica(meu_pais, baixo, estavel, leve, baixo, estavel)),
assertz(crise_seguranca(meu_pais, baixo, estavel, leve, baixo, estavel)),
assertz(crise_social(meu_pais, baixo, estavel, leve, baixo, estavel)),
assertz(infraestrutura(meu_pais, boa)),
assertz(reservas(meu_pais, baixo)),

% Verificar
melhor_decisao(meu_pais, Acao, Meses).
% Resultado: Acao = lockdown_parcial, Meses = 1
```

### Exemplo 2: Configurar País para Obter "Chamar ONU" como Melhor Decisão

```prolog
% Limpar dados
retractall(_),

% Configurar para chamar_onu (prioridade 9)
assertz(crise_saude(meu_pais, alto, alta, critica, alto, explosiva)),
assertz(infraestrutura(meu_pais, ruim)),

% Outros dados em níveis baixos
assertz(crise_economica(meu_pais, baixo, estavel, leve, baixo, estavel)),
assertz(crise_seguranca(meu_pais, baixo, estavel, leve, baixo, estavel)),
assertz(crise_social(meu_pais, baixo, estavel, leve, baixo, estavel)),
assertz(apoio_populacao(meu_pais, baixo)),
assertz(reservas(meu_pais, baixo)),

% Verificar
melhor_decisao(meu_pais, Acao, Meses).
% Resultado: Acao = chamar_onu, Meses = 2
```

### Exemplo 3: Configurar País para Obter "Reforma Infraestrutura" como Melhor Decisão

```prolog
% Limpar dados
retractall(_),

% Configurar para reforma_infraestrutura (prioridade 13)
assertz(infraestrutura(meu_pais, ruim)),

% Todas as crises em níveis baixos
assertz(crise_economica(meu_pais, baixo, estavel, leve, baixo, estavel)),
assertz(crise_saude(meu_pais, baixo, estavel, leve, baixo, estavel)),
assertz(crise_seguranca(meu_pais, baixo, estavel, leve, baixo, estavel)),
assertz(crise_social(meu_pais, baixo, estavel, leve, baixo, estavel)),
assertz(apoio_populacao(meu_pais, baixo)),
assertz(reservas(meu_pais, baixo)),

% Verificar
melhor_decisao(meu_pais, Acao, Meses).
% Resultado: Acao = reforma_infraestrutura, Meses = 12
```

### Exemplo 4: Configurar País para Obter "Intervenção Econômica" como Melhor Decisão

```prolog
% Limpar dados
retractall(_),

% Configurar para intervencao_economica (prioridade 1 - maior prioridade)
assertz(crise_economica(meu_pais, alto, alta, critica, alto, explosiva)),
assertz(reservas(meu_pais, alto)),

% Outras crises em níveis baixos/médios
assertz(crise_saude(meu_pais, baixo, estavel, leve, baixo, estavel)),
assertz(crise_seguranca(meu_pais, medio, estavel, moderada, medio, estavel)),
assertz(crise_social(meu_pais, medio, estavel, moderada, medio, estavel)),
assertz(infraestrutura(meu_pais, boa)),
assertz(apoio_populacao(meu_pais, medio)),

% Verificar
melhor_decisao(meu_pais, Acao, Meses).
% Resultado: Acao = intervencao_economica, Meses = 6
```

### Exemplo 5: Ver Todas as Decisões Disponíveis e Escolher Manualmente

```prolog
% Configurar país com múltiplas crises
retractall(_),

assertz(crise_economica(meu_pais, alto, alta, critica, alto, explosiva)),
assertz(crise_saude(meu_pais, alto, alta, critica, alto, explosiva)),
assertz(crise_seguranca(meu_pais, medio, estavel, moderada, medio, estavel)),
assertz(crise_social(meu_pais, medio, estavel, moderada, medio, estavel)),
assertz(infraestrutura(meu_pais, ruim)),
assertz(apoio_populacao(meu_pais, medio)),
assertz(reservas(meu_pais, alto)),

% Listar todas as decisões disponíveis com detalhes
listar_decisoes_com_impacto(meu_pais).

% Ou obter lista programática
findall((Prioridade, Acao, Meses, Impacto),
    (decisao(meu_pais, Acao, Meses),
     decisao_prioridade(Acao, Prioridade, Impacto)),
    TodasDecisoes).
```

### Exemplo 6: Função Auxiliar para Configurar e Testar

```prolog
% Criar função reutilizável
testar_cenario(NomePais, CeNivel, CeTend, CeSev, CsNivel, Infra, Apoio, Reservas) :-
    retractall(crise_economica(NomePais, _, _, _, _, _)),
    retractall(crise_saude(NomePais, _, _, _, _, _)),
    retractall(infraestrutura(NomePais, _)),
    retractall(apoio_populacao(NomePais, _)),
    retractall(reservas(NomePais, _)),
    
    assertz(crise_economica(NomePais, CeNivel, CeTend, CeSev, alto, explosiva)),
    assertz(crise_saude(NomePais, CsNivel, alta, critica, alto, explosiva)),
    assertz(infraestrutura(NomePais, Infra)),
    assertz(apoio_populacao(NomePais, Apoio)),
    assertz(reservas(NomePais, Reservas)),
    assertz(crise_seguranca(NomePais, medio, estavel, moderada, medio, estavel)),
    assertz(crise_social(NomePais, medio, estavel, moderada, medio, estavel)),
    
    melhor_decisao(NomePais, Acao, Meses),
    format('Melhor decisão para ~w: ~w (~w meses)~n', [NomePais, Acao, Meses]).

% Usar:
% testar_cenario(pais1, alto, alta, critica, alto, ruim, medio, alto).
% testar_cenario(pais2, baixo, estavel, leve, alto, ruim, alto, baixo).
```

## Exemplo de Configuração Manual Simples

Se você quiser criar seus próprios dados:

```prolog
% Definir dados do país
assertz(crise_economica(meu_pais, alto, alta, critica, alto, explosiva)),
assertz(crise_saude(meu_pais, alto, alta, critica, alto, explosiva)),
assertz(crise_seguranca(meu_pais, medio, estavel, moderada, medio, estavel)),
assertz(crise_social(meu_pais, medio, estavel, moderada, medio, estavel)),
assertz(infraestrutura(meu_pais, ruim)),
assertz(apoio_populacao(meu_pais, medio)),
assertz(reservas(meu_pais, alto)).

% Consultar decisões
decisao(meu_pais, Acao, Meses).
```

## Como `melhor_decisao` Funciona - Algoritmo Detalhado

### 🔄 Fluxo de Execução (Diagrama)

```
┌─────────────────────────────────────────────────────────────┐
│  melhor_decisao(Pais, Acao, Meses)                          │
└─────────────────────────────────────────────────────────────┘
                        │
                        ▼
┌─────────────────────────────────────────────────────────────┐
│  PASSO 1: Verificar se há decisões disponíveis              │
│  \+ decisao(Pais, _, _) → Se não há, retorna "nenhuma"     │
└─────────────────────────────────────────────────────────────┘
                        │ (se há decisões)
                        ▼
┌─────────────────────────────────────────────────────────────┐
│  PASSO 2: Coletar todas as decisões disponíveis             │
│  findall((Prioridade, A, M), ...)                           │
│                                                              │
│  Para cada decisão ativa:                                   │
│    - Busca a prioridade numérica                            │
│    - Cria tupla (Prioridade, Acao, Meses)                   │
│                                                              │
│  Resultado: Lista de tuplas                                 │
│  Ex: [(1, intervencao, 6), (6, lockdown, 1), ...]         │
└─────────────────────────────────────────────────────────────┘
                        │
                        ▼
┌─────────────────────────────────────────────────────────────┐
│  PASSO 3: Ordenar por prioridade (menor = melhor)           │
│  sort(Lista, ListaOrdenada)                                 │
│                                                              │
│  Ordenação numérica crescente:                              │
│  [1, 6, 9, 13] → já está ordenado                          │
│  [13, 1, 9, 6] → ordena para [1, 6, 9, 13]                │
└─────────────────────────────────────────────────────────────┘
                        │
                        ▼
┌─────────────────────────────────────────────────────────────┐
│  PASSO 4: Retornar a primeira decisão da lista              │
│  ListaOrdenada = [(_, Acao, Meses) | _]                    │
│                                                              │
│  Pega o primeiro elemento (menor prioridade)                │
│  Extrai apenas Acao e Meses                                 │
└─────────────────────────────────────────────────────────────┘
                        │
                        ▼
                    RESULTADO
```

### Passo a Passo do Cálculo (Detalhado)

Quando você consulta `melhor_decisao(P, Acao, Meses)`, o sistema executa os seguintes passos:

#### Passo 1: Coleta todas as decisões disponíveis
```prolog
findall((Prioridade, A, M),
    (decisao(P, A, M), decisao_prioridade(A, Prioridade, _)),
    Lista)
```

**O que acontece:**
- `decisao(P, A, M)` verifica todas as regras de decisão e retorna cada ação `A` e meses `M` que se aplicam ao país `P`
- Para cada decisão encontrada, `decisao_prioridade(A, Prioridade, _)` busca a prioridade numérica
- `findall` cria uma lista de tuplas: `[(Prioridade, Acao, Meses), ...]`

**Exemplo de lista gerada:**
```prolog
[(1, intervencao_economica, 6),
 (6, lockdown_parcial, 1),
 (9, chamar_onu, 2),
 (13, reforma_infraestrutura, 12)]
```

#### Passo 2: Ordena por prioridade
```prolog
sort(Lista, ListaOrdenada)
```

**O que acontece:**
- O `sort/2` ordena a lista de tuplas lexicograficamente
- Como a prioridade é o primeiro elemento da tupla, ordena por prioridade numérica
- **IMPORTANTE:** Menor número = maior prioridade (1 é mais importante que 6)

**Exemplo de lista ordenada:**
```prolog
[(1, intervencao_economica, 6),
 (6, lockdown_parcial, 1),
 (9, chamar_onu, 2),
 (13, reforma_infraestrutura, 12)]
```

#### Passo 3: Retorna a primeira decisão
```prolog
ListaOrdenada = [(_, Acao, Meses) | _]
```

**O que acontece:**
- Pega o primeiro elemento da lista ordenada (menor prioridade = maior importância)
- Extrai a ação e os meses, ignorando a prioridade com `_`

### Exemplo Completo de Execução (Passo a Passo Numérico)

**Cenário:** País com múltiplas crises ativas

#### Estado Inicial dos Dados:
```prolog
crise_economica(pais, alto, alta, critica, alto, explosiva)
reservas(pais, alto)
crise_saude(pais, alto, alta, critica, alto, explosiva)
apoio_populacao(pais, medio)
infraestrutura(pais, ruim)
```

#### Passo 1: Verificar Regras de Decisão

O sistema verifica cada regra `decisao/3`:

| Regra | Condições | Resultado |
|-------|-----------|-----------|
| `decisao(pais, intervencao_economica, 6)` | ✓ Crise econômica alta + tendência alta + severidade crítica + reservas altas | ✅ **ATIVADA** |
| `decisao(pais, lockdown_parcial, 1)` | ✓ Crise de saúde alta + apoio médio | ✅ **ATIVADA** |
| `decisao(pais, chamar_onu, 2)` | ✓ Crise de saúde alta + infraestrutura ruim | ✅ **ATIVADA** |
| `decisao(pais, reforma_infraestrutura, 12)` | ✓ Infraestrutura ruim | ✅ **ATIVADA** |
| `decisao(pais, pacote_emergencial, 3)` | ✗ Requer reservas baixas (temos altas) | ❌ Não ativada |
| Outras regras... | ... | ❌ Não ativadas |

#### Passo 2: Coletar Prioridades

Para cada decisão ativada, busca a prioridade:

```prolog
decisao_prioridade(intervencao_economica, 1, medio)  → Prioridade = 1
decisao_prioridade(lockdown_parcial, 6, alto)        → Prioridade = 6
decisao_prioridade(chamar_onu, 9, baixo)            → Prioridade = 9
decisao_prioridade(reforma_infraestrutura, 13, baixo) → Prioridade = 13
```

#### Passo 3: Criar Lista de Tuplas

```prolog
Lista = [
    (1, intervencao_economica, 6),
    (6, lockdown_parcial, 1),
    (9, chamar_onu, 2),
    (13, reforma_infraestrutura, 12)
]
```

#### Passo 4: Ordenar por Prioridade

O `sort/2` ordena as tuplas lexicograficamente (primeiro elemento = prioridade):

```prolog
ListaOrdenada = [
    (1, intervencao_economica, 6),      ← MENOR PRIORIDADE = MELHOR
    (6, lockdown_parcial, 1),
    (9, chamar_onu, 2),
    (13, reforma_infraestrutura, 12)
]
```

#### Passo 5: Extrair Primeiro Elemento

```prolog
ListaOrdenada = [(1, intervencao_economica, 6) | _]
```

Ignora a prioridade com `_` e extrai:
- **Acao = intervencao_economica**
- **Meses = 6**

#### Resultado Final:
```prolog
melhor_decisao(pais, intervencao_economica, 6).
```

> 💡 **Por que intervencao_economica?** Porque tem prioridade 1, que é MENOR (mais importante) que as outras (6, 9, 13).

### Exemplo Alternativo: Se Removermos a Crise Econômica

Se configurarmos o país **sem** crise econômica grave:

```prolog
% Sem intervencao_economica (já que não há crise econômica alta com reservas)
% Ainda temos:
% - lockdown_parcial (prioridade 6)
% - chamar_onu (prioridade 9)
% - reforma_infraestrutura (prioridade 13)

ListaOrdenada = [
    (6, lockdown_parcial, 1),        ← AGORA É A MELHOR
    (9, chamar_onu, 2),
    (13, reforma_infraestrutura, 12)
]

melhor_decisao(pais, lockdown_parcial, 1).
```

> 💡 **Conclusão:** Para obter `lockdown_parcial` como melhor, precisamos garantir que não há decisões com prioridade < 6 disponíveis!

### Casos Especiais

#### Sem decisões disponíveis
```prolog
melhor_decisao(P, nenhuma, 0) :-
    \+ decisao(P, _, _).
```
- Se nenhuma regra de decisão se aplicar ao país, retorna `nenhuma` com 0 meses

#### Múltiplas decisões com mesma prioridade
- O `sort/2` mantém ordem estável, retornando a primeira encontrada
- Na prática, todas as 16 decisões têm prioridades diferentes

## Como Obter Resultados Diferentes

### Estratégia 1: Modificar os Dados para Ativar Decisões Específicas

Cada decisão tem condições específicas. Para obter uma decisão diferente como "melhor", você precisa:

1. **Desativar decisões de maior prioridade** (ou não atender suas condições)
2. **Ativar a decisão desejada** (atender suas condições)

#### Exemplo 1: Fazer "Lockdown Parcial" ser a melhor decisão

**Objetivo:** Ter `lockdown_parcial` como melhor decisão (prioridade 6)

**Estratégia:** 
- Não ativar `intervencao_economica` (prioridade 1)
- Não ativar `pacote_emergencial` (prioridade 2)
- Não ativar `reforma_tributaria` (prioridade 3)
- Não ativar `reforco_hospitais` (prioridade 4)
- Não ativar `campanha_confianca` (prioridade 5)
- **Ativar** `lockdown_parcial` (prioridade 6)

```prolog
% Configuração para lockdown_parcial ser a melhor:
retractall(crise_economica(_, _, _, _, _, _)),
retractall(infraestrutura(_, _)),
retractall(apoio_populacao(_, _)),
retractall(crise_social(_, _, _, _, _, _)),

% Ativar lockdown_parcial
assertz(crise_saude(meu_pais, alto, _, _, _, _)),
assertz(apoio_populacao(meu_pais, medio)),

% Dados obrigatórios
assertz(crise_economica(meu_pais, baixo, estavel, leve, baixo, estavel)),
assertz(crise_seguranca(meu_pais, baixo, estavel, leve, baixo, estavel)),
assertz(crise_social(meu_pais, medio, estavel, moderada, medio, estavel)),
assertz(infraestrutura(meu_pais, boa)),
assertz(reservas(meu_pais, baixo)).

% Agora melhor_decisao retornará lockdown_parcial
melhor_decisao(meu_pais, Acao, Meses).  % Acao = lockdown_parcial
```

#### Exemplo 2: Fazer "Chamar ONU" ser a melhor decisão

**Objetivo:** Ter `chamar_onu` como melhor decisão (prioridade 9)

**Estratégia:** Desativar todas as decisões de prioridade 1-8

```prolog
retractall(_),

% Ativar chamar_onu (requer crise_saude alto + infra ruim)
assertz(crise_saude(meu_pais, alto, alta, alta, alto, explosiva)),
assertz(infraestrutura(meu_pais, ruim)),

% NÃO ativar outras decisões - usar valores baixos
assertz(crise_economica(meu_pais, baixo, estavel, leve, baixo, estavel)),
assertz(crise_seguranca(meu_pais, baixo, estavel, leve, baixo, estavel)),
assertz(crise_social(meu_pais, baixo, estavel, leve, baixo, estavel)),
assertz(apoio_populacao(meu_pais, baixo)),
assertz(reservas(meu_pais, baixo)).

% melhor_decisao retornará chamar_onu
melhor_decisao(meu_pais, Acao, Meses).  % Acao = chamar_onu
```

### Estratégia 2: Usar Funções de Decisão por Impacto

Em vez de `melhor_decisao`, use funções que filtram por critério:

```prolog
% Melhor decisão de baixo impacto
decisao_com_impacto_baixo(meu_pais, Acao, Meses).

% Melhor decisão de médio impacto
decisao_com_impacto_medio(meu_pais, Acao, Meses).

% Melhor decisão de alto impacto
decisao_com_impacto_alto(meu_pais, Acao, Meses).

% Melhor decisão com impacto mínimo específico
melhor_decisao_impacto_minimo(meu_pais, medio, Acao, Meses).
```

### Estratégia 3: Consultar Decisões Específicas Diretamente

Se você quer uma decisão específica, consulte diretamente:

```prolog
% Verificar se uma decisão específica está disponível
decisao(meu_pais, lockdown_parcial, Meses).

% Ver todas as decisões disponíveis
findall((A, M), decisao(meu_pais, A, M), TodasDecisoes).
```

## Exemplos Práticos de Cenários

### Cenário A: País em Crise Econômica Grave
```prolog
assertz(crise_economica(pais_a, alto, alta, critica, alto, explosiva)),
assertz(reservas(pais_a, alto)),
% ... outros dados em níveis normais

% Resultado: melhor_decisao = intervencao_economica
```

### Cenário B: País com Crise de Saúde e Infraestrutura Ruim
```prolog
assertz(crise_saude(pais_b, alto, alta, critica, alto, explosiva)),
assertz(infraestrutura(pais_b, ruim)),
assertz(apoio_populacao(pais_b, medio)),
% ... outras crises baixas

% Resultado: melhor_decisao = lockdown_parcial (se apoio médio/alto)
% OU melhor_decisao = chamar_onu (se infraestrutura ruim for mais crítica)
```

### Cenário C: País Estável com Infraestrutura Ruim
```prolog
% Todas as crises em nível baixo
assertz(crise_economica(pais_c, baixo, estavel, leve, baixo, estavel)),
assertz(crise_saude(pais_c, baixo, estavel, leve, baixo, estavel)),
assertz(crise_seguranca(pais_c, baixo, estavel, leve, baixo, estavel)),
assertz(crise_social(pais_c, baixo, estavel, leve, baixo, estavel)),

% Mas infraestrutura ruim
assertz(infraestrutura(pais_c, ruim)),

% Resultado: melhor_decisao = reforma_infraestrutura
```

### Cenário D: Múltiplas Crises Simultâneas
```prolog
% Todas as crises ativas
assertz(crise_economica(pais_d, alto, alta, critica, alto, explosiva)),
assertz(crise_saude(pais_d, alto, alta, critica, alto, explosiva)),
assertz(crise_seguranca(pais_d, alto, alta, critica, alto, explosiva)),
assertz(crise_social(pais_d, alto, alta, critica, alto, explosiva)),
assertz(infraestrutura(pais_d, ruim)),
assertz(apoio_populacao(pais_d, alto)),
assertz(reservas(pais_d, alto)),

% Resultado: melhor_decisao = intervencao_economica
% (maior prioridade entre todas as decisões disponíveis)
```

## Tabela de Prioridades das Decisões

| Prioridade | Decisão | Impacto | Quando é a melhor? |
|------------|---------|---------|-------------------|
| 1 | intervencao_economica | médio | Crise econômica grave + reservas altas |
| 2 | pacote_emergencial | baixo | Crise econômica grave + reservas baixas |
| 3 | reforma_tributaria | médio | Crise econômica + infraestrutura ruim |
| 4 | reforco_hospitais | baixo | Crise de saúde + infraestrutura média/ruim |
| 5 | campanha_confianca | baixo | Crise social média + apoio alto |
| 6 | lockdown_parcial | alto | Crise de saúde + apoio médio/alto |
| 7 | reforco_policial | baixo | Crise de segurança + apoio alto |
| 8 | deslocar_tropas | médio | Crise de segurança + apoio médio |
| 9 | chamar_onu | baixo | Crise de saúde + infraestrutura ruim |
| 10 | acordo_internacional | baixo | Crise de segurança média/alta |
| 11 | plano_estabilizacao | médio | Crise grave + apoio alto |
| 12 | contencao_social | baixo | Crise social média + apoio médio |
| 13 | reforma_infraestrutura | baixo | Infraestrutura ruim |
| 14 | auxilio_financeiro | baixo | (não implementado no código atual) |
| 15 | programa_social | baixo | Crise social alta + apoio baixo |
| 16 | controle_de_precos | médio | (não implementado no código atual) |

## Validação de Dados Obrigatórios

O sistema agora valida se todos os dados necessários estão preenchidos antes de calcular a melhor decisão. Se faltar algum dado, você receberá uma mensagem amigável indicando o que está faltando.

### Dados Obrigatórios

Antes de chamar `melhor_decisao(P, A, M)`, você DEVE preencher:

1. `crise_economica(P, Nivel, Tendencia, Severidade, Impacto, Variacao)`
2. `crise_saude(P, Nivel, Tendencia, Severidade, Impacto, Variacao)`
3. `crise_seguranca(P, Nivel, Tendencia, Severidade, Impacto, Variacao)`
4. `crise_social(P, Nivel, Tendencia, Severidade, Impacto, Variacao)`
5. `infraestrutura(P, Nivel)`
6. `apoio_populacao(P, Nivel)`
7. `reservas(P, Nivel)`

### Exemplo de Validação

```prolog
% Tentar chamar sem preencher nenhum dado
melhor_decisao(brasil, A, M).
% Saída: Impossível amigão: ainda falta crise_economica, crise_saude, crise_seguranca, crise_social, infraestrutura, apoio_populacao, reservas
% A consulta falha (não retorna valores)

% Preencher apenas alguns dados
assertz(crise_economica(brasil, alto, alta, critica, alto, explosiva)),
assertz(crise_saude(brasil, alto, alta, critica, alto, explosiva)),

melhor_decisao(brasil, A, M).
% Saída: Impossível amigão: ainda falta crise_seguranca, crise_social, infraestrutura, apoio_populacao, reservas
% (Mostra TODOS os dados faltantes de uma vez!)

% Preencher todos os dados
assertz(crise_seguranca(brasil, medio, estavel, moderada, medio, estavel)),
assertz(crise_social(brasil, medio, estavel, moderada, medio, estavel)),
assertz(infraestrutura(brasil, ruim)),
assertz(apoio_populacao(brasil, medio)),
assertz(reservas(brasil, alto)),

% Agora funciona
melhor_decisao(brasil, A, M).
% A = intervencao_economica, M = 6
```

> 💡 **Importante:** A validação agora mostra **TODOS** os dados faltantes de uma vez, não apenas o primeiro! Isso facilita muito o preenchimento completo dos dados.

### Testar Validação

Para testar a validação, use o arquivo `teste_validacao.pl`:

```prolog
['teste_validacao.pl'].
executar_todos_testes.
```

## Notas Importantes

- O sistema usa predicados dinâmicos (`:- dynamic`), então você pode adicionar/remover fatos durante a execução
- Para limpar dados anteriores, use `retractall/1`
- **OBRIGATÓRIO:** Todos os 7 dados devem estar preenchidos antes de chamar `melhor_decisao`
- Se faltar algum dado, você receberá a mensagem: `Impossível amigão: ainda falta <nome_do_dado>`
- A melhor decisão é determinada pela **menor prioridade** (1 = maior prioridade, 16 = menor prioridade)
- O score do país é normalizado em uma escala de 0-100%
- Se múltiplas decisões têm a mesma prioridade (raro), o `sort/2` mantém a ordem de encontrada

