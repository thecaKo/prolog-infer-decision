% Teste para CAMPANHA DE CONFIANÇA
% Condições: Crise social média + apoio alto

:- consult('data.pl').

% Configurar dados para ativar campanha de confiança
configurar_campanha_confianca(Pais) :-
    retractall(crise_economica(Pais, _, _, _, _, _)),
    retractall(crise_saude(Pais, _, _, _, _, _)),
    retractall(crise_seguranca(Pais, _, _, _, _, _)),
    retractall(crise_social(Pais, _, _, _, _, _)),
    retractall(infraestrutura(Pais, _)),
    retractall(apoio_populacao(Pais, _)),
    retractall(reservas(Pais, _)),
    
    % Dados para CAMPANHA DE CONFIANÇA
    assertz(crise_social(Pais, medio, estavel, moderada, medio, estavel)),
    assertz(apoio_populacao(Pais, alto)),
    
    % Outros dados em níveis baixos/médios
    assertz(crise_economica(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_saude(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_seguranca(Pais, medio, estavel, moderada, medio, estavel)),
    assertz(infraestrutura(Pais, boa)),
    assertz(reservas(Pais, baixo)),
    
    write('✓ Dados configurados para CAMPANHA DE CONFIANÇA'), nl.

% Testar se a decisão está disponível
testar_campanha_confianca(Pais) :-
    write('=== TESTE: CAMPANHA DE CONFIANÇA ==='), nl, nl,
    
    (   decisao(Pais, campanha_confianca, Meses)
    ->  format('✓ Decisão disponível! Duração: ~w meses~n', [Meses]),
        decisao_prioridade(campanha_confianca, Prioridade, Impacto),
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
    write('TESTE: CAMPANHA DE CONFIANÇA'), nl,
    write('========================================'), nl, nl,
    
    configurar_campanha_confianca(Pais),
    nl,
    
    testar_campanha_confianca(Pais),
    
    obter_melhor_decisao(Pais),
    
    write('========================================'), nl,
    write('TESTE FINALIZADO'), nl,
    write('========================================'), nl.

% Executar com país padrão
teste :-
    executar_teste(pais_teste).

