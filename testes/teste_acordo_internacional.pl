% Teste para ACORDO INTERNACIONAL
% Condições: Crise de segurança média ou alta

:- consult('data.pl').

% Configurar dados para ativar acordo internacional
configurar_acordo_internacional(Pais) :-
    retractall(crise_economica(Pais, _, _, _, _, _)),
    retractall(crise_saude(Pais, _, _, _, _, _)),
    retractall(crise_seguranca(Pais, _, _, _, _, _)),
    retractall(crise_social(Pais, _, _, _, _, _)),
    retractall(infraestrutura(Pais, _)),
    retractall(apoio_populacao(Pais, _)),
    retractall(reservas(Pais, _)),
    
    % Dados para ACORDO INTERNACIONAL
    assertz(crise_seguranca(Pais, medio, estavel, moderada, medio, estavel)),
    
    % Outros dados em níveis baixos/médios
    assertz(crise_economica(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_saude(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_social(Pais, medio, estavel, moderada, medio, estavel)),
    assertz(infraestrutura(Pais, boa)),
    assertz(apoio_populacao(Pais, medio)),
    assertz(reservas(Pais, baixo)),
    
    write('✓ Dados configurados para ACORDO INTERNACIONAL'), nl.

% Testar se a decisão está disponível
testar_acordo_internacional(Pais) :-
    write('=== TESTE: ACORDO INTERNACIONAL ==='), nl, nl,
    
    (   decisao(Pais, acordo_internacional, Meses)
    ->  format('✓ Decisão disponível! Duração: ~w meses~n', [Meses]),
        decisao_prioridade(acordo_internacional, Prioridade, Impacto),
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
    write('TESTE: ACORDO INTERNACIONAL'), nl,
    write('========================================'), nl, nl,
    
    configurar_acordo_internacional(Pais),
    nl,
    
    testar_acordo_internacional(Pais),
    
    obter_melhor_decisao(Pais),
    
    write('========================================'), nl,
    write('TESTE FINALIZADO'), nl,
    write('========================================'), nl.

% Executar com país padrão
teste :-
    executar_teste(pais_teste).

