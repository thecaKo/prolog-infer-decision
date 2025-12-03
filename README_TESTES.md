# Arquivos de Teste - Sistema de Decisão

Este diretório contém arquivos de teste pré-configurados para cada tipo de decisão disponível no sistema.

## 📁 Arquivos Disponíveis

### Decisões Econômicas
- **`teste_intervencao_economica.pl`** - Intervenção Econômica (Prioridade 1)
- **`teste_pacote_emergencial.pl`** - Pacote Emergencial (Prioridade 2)
- **`teste_reforma_tributaria.pl`** - Reforma Tributária (Prioridade 3)

### Decisões de Saúde
- **`teste_reforco_hospitais.pl`** - Reforço de Hospitais (Prioridade 4)
- **`teste_lockdown_parcial.pl`** - Lockdown Parcial (Prioridade 6)
- **`teste_chamar_onu.pl`** - Chamar ONU (Prioridade 9)

### Decisões de Segurança
- **`teste_reforco_policial.pl`** - Reforço Policial (Prioridade 7)
- **`teste_deslocar_tropas.pl`** - Deslocar Tropas (Prioridade 8)
- **`teste_acordo_internacional.pl`** - Acordo Internacional (Prioridade 10)

### Decisões Sociais
- **`teste_campanha_confianca.pl`** - Campanha de Confiança (Prioridade 5)
- **`teste_contencao_social.pl`** - Contenção Social (Prioridade 12)
- **`teste_programa_social.pl`** - Programa Social (Prioridade 15)

### Decisões de Infraestrutura e Estabilização
- **`teste_reforma_infraestrutura.pl`** - Reforma de Infraestrutura (Prioridade 13)
- **`teste_plano_estabilizacao.pl`** - Plano de Estabilização (Prioridade 11)

### Teste Geral
- **`teste_todas_decisoes.pl`** - Executa todos os testes de uma vez

## 🚀 Como Usar

### Executar um Teste Específico

```prolog
% No SWI-Prolog
['teste_lockdown_parcial.pl'].
teste.
```

Ou use a função `executar_teste` com um país específico:

```prolog
['teste_lockdown_parcial.pl'].
executar_teste(meu_pais).
```

### Executar Todos os Testes

```prolog
['teste_todas_decisoes.pl'].
executar_todos_testes.
```

### Usar os Predicados de Configuração

Cada arquivo exporta uma função `configurar_<acao>(Pais)` que você pode usar para configurar os dados:

```prolog
['teste_intervencao_economica.pl'].
configurar_intervencao_economica(brasil).
melhor_decisao(brasil, Acao, Meses).
```

## 📋 Estrutura de Cada Arquivo de Teste

Cada arquivo contém:

1. **`configurar_<acao>(Pais)`** - Configura os dados necessários para ativar a decisão
2. **`testar_<acao>(Pais)`** - Verifica se a decisão está disponível
3. **`obter_melhor_decisao(Pais)`** - Obtém a melhor decisão para o país
4. **`executar_teste(Pais)`** - Executa o teste completo
5. **`teste`** - Executa o teste com país padrão `pais_teste`

## 🔍 Exemplo de Saída

```
========================================
TESTE: LOCKDOWN PARCIAL
========================================

✓ Dados configurados para LOCKDOWN PARCIAL

=== TESTE: LOCKDOWN PARCIAL ===

✓ Decisão disponível! Duração: 1 meses
  Prioridade: 6, Impacto: alto

=== MELHOR DECISÃO ===
Ação: lockdown_parcial
Duração: 1 meses

========================================
TESTE FINALIZADO
========================================
```

## 📝 Notas

- Todos os arquivos carregam automaticamente `data.pl`
- Os dados são limpos antes de cada configuração (`retractall`)
- Cada teste configura apenas os dados necessários para a decisão específica
- Outros dados são configurados em níveis baixos/médios para não ativar outras decisões

## 🎯 Casos de Uso

### Desenvolvimento
Use os arquivos de teste durante o desenvolvimento para verificar se as regras estão funcionando corretamente.

### Demonstração
Use para demonstrar como cada decisão funciona com dados pré-configurados.

### Aprendizado
Use para entender quais condições são necessárias para cada tipo de decisão.

### Debugging
Use para isolar problemas em decisões específicas.

