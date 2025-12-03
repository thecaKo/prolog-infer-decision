% Teste para PLANO DE ESTABILIZAÇÃO
% Condições: Crise grave (econômica OU saúde OU segurança alta) + apoio alto

:- consult('data.pl').

% Configurar dados para ativar plano de estabilização
configurar_plano_estabilizacao(Pais) :-
    retractall(crise_economica(Pais, _, _, _, _, _)),
    retractall(crise_saude(Pais, _, _, _, _, _)),
    retractall(crise_seguranca(Pais, _, _, _, _, _)),
    retractall(crise_social(Pais, _, _, _, _, _)),
    retractall(infraestrutura(Pais, _)),
    retractall(apoio_populacao(Pais, _)),
    retractall(reservas(Pais, _)),
    
    % Dados para PLANO DE ESTABILIZAÇÃO (crise grave + apoio alto)
    assertz(crise_economica(Pais, alto, alta, critica, alto, explosiva)),
    assertz(apoio_populacao(Pais, alto)),
    
    % Outros dados em níveis médios
    assertz(crise_saude(Pais, medio, estavel, moderada, medio, estavel)),
    assertz(crise_seguranca(Pais, medio, estavel, moderada, medio, estavel)),
    assertz(crise_social(Pais, medio, estavel, moderada, medio, estavel)),
    assertz(infraestrutura(Pais, media)),
    assertz(reservas(Pais, baixo)),
    
    write('✓ Dados configurados para PLANO DE ESTABILIZAÇÃO'), nl.

% Testar se a decisão está disponível
testar_plano_estabilizacao(Pais) :-
    write('=== TESTE: PLANO DE ESTABILIZAÇÃO ==='), nl, nl,
    
    (   decisao(Pais, plano_estabilizacao, Meses)
    ->  format('✓ Decisão disponível! Duração: ~w meses~n', [Meses]),
        decisao_prioridade(plano_estabilizacao, Prioridade, Impacto),
        format('  Prioridade: ~w, Impacto: ~w~n', [Prioridade, Impacto])
    ;   write('✗ Decisão NÃO disponível'), nl
    ),
    nl.

% Obter melhor decisão
obter_melhor_decisao(Pais) :-
    write('=== MELHOR DECISÃO ==='), nl,
    (   melhor_decisao(Pais, Acao, Meses)
    ->  format('Ação: ~w~n', [Acao]),
        format('Duração: ~w meses~n', [Meses])
    ;   write('Nenhuma decisão disponível'), nl
    ),
    nl.

% Executar teste completo
executar_teste(Pais) :-
    write('========================================'), nl,
    write('TESTE: PLANO DE ESTABILIZAÇÃO'), nl,
    write('========================================'), nl, nl,
    
    configurar_plano_estabilizacao(Pais),
    nl,
    
    testar_plano_estabilizacao(Pais),
    
    obter_melhor_decisao(Pais),
    
    write('========================================'), nl,
    write('TESTE FINALIZADO'), nl,
    write('========================================'), nl.

% Executar com país padrão
teste :-
    executar_teste(pais_teste).

