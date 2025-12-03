% =====================================================
% FLUXO COMPLETO - EXEMPLO DE USO DO SISTEMA DE DECISÃO
% =====================================================
% Este arquivo demonstra como configurar os dados de um país
% para obter as seguintes decisões específicas:
% 1. lockdown_parcial
% 2. chamar_onu
% 3. reforma_infraestrutura
% 4. intervencao_economica
% =====================================================

% Carregar o arquivo principal com as regras
:- consult('data.pl').

% =====================================================
% CONFIGURAÇÃO DOS DADOS DO PAÍS
% =====================================================
% Para obter todas as 4 decisões desejadas, vamos configurar:

configurar_pais_exemplo :-
    % Limpar dados anteriores (se existirem)
    retractall(crise_economica(_, _, _, _, _, _)),
    retractall(crise_saude(_, _, _, _, _, _)),
    retractall(crise_seguranca(_, _, _, _, _, _)),
    retractall(crise_social(_, _, _, _, _, _)),
    retractall(infraestrutura(_, _)),
    retractall(apoio_populacao(_, _)),
    retractall(reservas(_, _)),
    
    % ============================================
    % 1. INTERVENÇÃO ECONÔMICA
    % Condições necessárias:
    % - Crise econômica: nível ALTO
    % - Crise econômica: tendência ALTA
    % - Crise econômica: severidade ALTA ou CRÍTICA
    % - Reservas: ALTAS
    % ============================================
    assertz(crise_economica(pais_exemplo, alto, alta, critica, alto, explosiva)),
    assertz(reservas(pais_exemplo, alto)),
    
    % ============================================
    % 2. LOCKDOWN PARCIAL
    % Condições necessárias:
    % - Crise de saúde: nível ALTO
    % - Apoio da população: MÉDIO ou ALTO
    % ============================================
    assertz(crise_saude(pais_exemplo, alto, alta, critica, alto, explosiva)),
    assertz(apoio_populacao(pais_exemplo, medio)),
    
    % ============================================
    % 3. CHAMAR ONU
    % Condições necessárias:
    % - Crise de saúde: nível ALTO
    % - Infraestrutura: RUIM
    % ============================================
    % (A crise de saúde já foi definida acima)
    assertz(infraestrutura(pais_exemplo, ruim)),
    
    % ============================================
    % 4. REFORMA DE INFRAESTRUTURA
    % Condições necessárias:
    % - Infraestrutura: RUIM
    % ============================================
    % (A infraestrutura ruim já foi definida acima)
    
    % ============================================
    % DADOS ADICIONAIS NECESSÁRIOS
    % (Preenchemos os outros campos para completar o perfil)
    % ============================================
    assertz(crise_seguranca(pais_exemplo, medio, estavel, moderada, medio, estavel)),
    assertz(crise_social(pais_exemplo, medio, estavel, moderada, medio, estavel)),
    
    write('✓ Dados do país configurados com sucesso!'), nl,
    write('País: pais_exemplo'), nl, nl.

% =====================================================
% VERIFICAÇÃO DAS DECISÕES
% =====================================================

verificar_decisoes :-
    write('==============================================='), nl,
    write('VERIFICAÇÃO DAS DECISÕES PARA: pais_exemplo'), nl,
    write('==============================================='), nl, nl,
    
    % Verificar lockdown_parcial
    (   decisao(pais_exemplo, lockdown_parcial, Meses1)
    ->  write('✓ LOCKDOWN PARCIAL: Disponível (Meses: '), write(Meses1), write(')'), nl
    ;   write('✗ LOCKDOWN PARCIAL: Não disponível'), nl
    ),
    
    % Verificar chamar_onu
    (   decisao(pais_exemplo, chamar_onu, Meses2)
    ->  write('✓ CHAMAR ONU: Disponível (Meses: '), write(Meses2), write(')'), nl
    ;   write('✗ CHAMAR ONU: Não disponível'), nl
    ),
    
    % Verificar reforma_infraestrutura
    (   decisao(pais_exemplo, reforma_infraestrutura, Meses3)
    ->  write('✓ REFORMA INFRAESTRUTURA: Disponível (Meses: '), write(Meses3), write(')'), nl
    ;   write('✗ REFORMA INFRAESTRUTURA: Não disponível'), nl
    ),
    
    % Verificar intervencao_economica
    (   decisao(pais_exemplo, intervencao_economica, Meses4)
    ->  write('✓ INTERVENÇÃO ECONÔMICA: Disponível (Meses: '), write(Meses4), write(')'), nl
    ;   write('✗ INTERVENÇÃO ECONÔMICA: Não disponível'), nl
    ),
    nl.

% =====================================================
% EXIBIR TODAS AS DECISÕES DISPONÍVEIS
% =====================================================

listar_todas_decisoes :-
    write('==============================================='), nl,
    write('TODAS AS DECISÕES DISPONÍVEIS:'), nl,
    write('==============================================='), nl, nl,
    listar_decisoes_com_impacto(pais_exemplo).

% =====================================================
% OBTER A MELHOR DECISÃO
% =====================================================

obter_melhor_decisao :-
    write('==============================================='), nl,
    write('MELHOR DECISÃO (por prioridade):'), nl,
    write('==============================================='), nl, nl,
    (   melhor_decisao(pais_exemplo, Acao, Meses)
    ->  format('Ação: ~w~n', [Acao]),
        format('Duração: ~w meses~n', [Meses])
    ;   write('Nenhuma decisão disponível'), nl
    ),
    nl.

% =====================================================
% AVALIAR O PAÍS
% =====================================================

avaliar_pais_completo :-
    write('==============================================='), nl,
    write('AVALIAÇÃO COMPLETA DO PAÍS:'), nl,
    write('==============================================='), nl, nl,
    (   score_pais_normalizado(pais_exemplo, Score),
        classificar_score(Score, Classificacao)
    ->  format('Score Normalizado: ~2f%%~n', [Score]),
        format('Classificação: ~w~n', [Classificacao])
    ;   write('Erro ao avaliar o país'), nl
    ),
    nl.

% =====================================================
% OBTER DECISÕES ESPECÍFICAS COM DETALHES
% =====================================================

obter_decisoes_especificas :-
    write('==============================================='), nl,
    write('DECISÕES ESPECÍFICAS SOLICITADAS:'), nl,
    write('==============================================='), nl, nl,
    
    % Lockdown Parcial
    (   decisao(pais_exemplo, lockdown_parcial, Meses1),
        decisao_prioridade(lockdown_parcial, Prioridade1, Impacto1)
    ->  write('1. LOCKDOWN PARCIAL:'), nl,
        format('   Prioridade: ~w~n', [Prioridade1]),
        format('   Impacto: ~w~n', [Impacto1]),
        format('   Duração: ~w meses~n', [Meses1]),
        nl
    ;   write('1. LOCKDOWN PARCIAL: Não disponível'), nl, nl
    ),
    
    % Chamar ONU
    (   decisao(pais_exemplo, chamar_onu, Meses2),
        decisao_prioridade(chamar_onu, Prioridade2, Impacto2)
    ->  write('2. CHAMAR ONU:'), nl,
        format('   Prioridade: ~w~n', [Prioridade2]),
        format('   Impacto: ~w~n', [Impacto2]),
        format('   Duração: ~w meses~n', [Meses2]),
        nl
    ;   write('2. CHAMAR ONU: Não disponível'), nl, nl
    ),
    
    % Reforma de Infraestrutura
    (   decisao(pais_exemplo, reforma_infraestrutura, Meses3),
        decisao_prioridade(reforma_infraestrutura, Prioridade3, Impacto3)
    ->  write('3. REFORMA DE INFRAESTRUTURA:'), nl,
        format('   Prioridade: ~w~n', [Prioridade3]),
        format('   Impacto: ~w~n', [Impacto3]),
        format('   Duração: ~w meses~n', [Meses3]),
        nl
    ;   write('3. REFORMA DE INFRAESTRUTURA: Não disponível'), nl, nl
    ),
    
    % Intervenção Econômica
    (   decisao(pais_exemplo, intervencao_economica, Meses4),
        decisao_prioridade(intervencao_economica, Prioridade4, Impacto4)
    ->  write('4. INTERVENÇÃO ECONÔMICA:'), nl,
        format('   Prioridade: ~w~n', [Prioridade4]),
        format('   Impacto: ~w~n', [Impacto4]),
        format('   Duração: ~w meses~n', [Meses4]),
        nl
    ;   write('4. INTERVENÇÃO ECONÔMICA: Não disponível'), nl, nl
    ).

% =====================================================
% FLUXO COMPLETO - EXECUTAR TUDO
% =====================================================

executar_fluxo_completo :-
    write('==============================================='), nl,
    write('INICIANDO FLUXO COMPLETO DE DECISÃO'), nl,
    write('==============================================='), nl, nl,
    
    % 1. Configurar os dados do país
    write('>>> Passo 1: Configurando dados do país...'), nl,
    configurar_pais_exemplo,
    nl,
    
    % 2. Avaliar o país
    write('>>> Passo 2: Avaliando o país...'), nl,
    avaliar_pais_completo,
    
    % 3. Verificar as decisões
    write('>>> Passo 3: Verificando decisões disponíveis...'), nl,
    verificar_decisoes,
    
    % 4. Obter decisões específicas com detalhes
    write('>>> Passo 4: Obtendo decisões específicas...'), nl,
    obter_decisoes_especificas,
    
    % 5. Obter melhor decisão
    write('>>> Passo 5: Identificando melhor decisão...'), nl,
    obter_melhor_decisao,
    
    % 6. Listar todas as decisões
    write('>>> Passo 6: Listando todas as decisões disponíveis...'), nl,
    listar_todas_decisoes,
    
    write('==============================================='), nl,
    write('FLUXO COMPLETO FINALIZADO'), nl,
    write('==============================================='), nl.

% =====================================================
% DOCUMENTAÇÃO DAS CONDIÇÕES
% =====================================================

% Para obter LOCKDOWN PARCIAL:
%   - crise_saude(P, alto, _, _, _, _)
%   - apoio_populacao(P, medio) OU apoio_populacao(P, alto)

% Para obter CHAMAR ONU:
%   - crise_saude(P, alto, _, _, _, _)
%   - infraestrutura(P, ruim)

% Para obter REFORMA DE INFRAESTRUTURA:
%   - infraestrutura(P, ruim)

% Para obter INTERVENÇÃO ECONÔMICA:
%   - crise_economica(P, alto, alta, Severidade, _, _)
%     onde Severidade deve ser 'alta' ou 'critica'
%   - reservas(P, alto)

