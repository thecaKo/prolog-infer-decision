% Teste para REFORMA DE INFRAESTRUTURA
% Condições: Infraestrutura ruim

:- consult('data.pl').

% Configurar dados para ativar reforma de infraestrutura
configurar_reforma_infraestrutura(Pais) :-
    retractall(crise_economica(Pais, _, _, _, _, _)),
    retractall(crise_saude(Pais, _, _, _, _, _)),
    retractall(crise_seguranca(Pais, _, _, _, _, _)),
    retractall(crise_social(Pais, _, _, _, _, _)),
    retractall(infraestrutura(Pais, _)),
    retractall(apoio_populacao(Pais, _)),
    retractall(reservas(Pais, _)),
    
    % Dados para REFORMA DE INFRAESTRUTURA
    assertz(infraestrutura(Pais, ruim)),
    
    % Todas as crises em níveis baixos (para não ativar outras decisões)
    assertz(crise_economica(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_saude(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_seguranca(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_social(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(apoio_populacao(Pais, baixo)),
    assertz(reservas(Pais, baixo)),
    
    write('✓ Dados configurados para REFORMA DE INFRAESTRUTURA'), nl.

% Testar se a decisão está disponível
testar_reforma_infraestrutura(Pais) :-
    write('=== TESTE: REFORMA DE INFRAESTRUTURA ==='), nl, nl,
    
    (   decisao(Pais, reforma_infraestrutura, Meses)
    ->  format('✓ Decisão disponível! Duração: ~w meses~n', [Meses]),
        decisao_prioridade(reforma_infraestrutura, Prioridade, Impacto),
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
    write('TESTE: REFORMA DE INFRAESTRUTURA'), nl,
    write('========================================'), nl, nl,
    
    configurar_reforma_infraestrutura(Pais),
    nl,
    
    testar_reforma_infraestrutura(Pais),
    
    obter_melhor_decisao(Pais),
    
    write('========================================'), nl,
    write('TESTE FINALIZADO'), nl,
    write('========================================'), nl.

% Executar com país padrão
teste :-
    executar_teste(pais_teste).

