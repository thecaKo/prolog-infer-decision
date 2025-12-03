% Teste para LOCKDOWN PARCIAL
% Condições: Crise de saúde alta + apoio médio ou alto

:- consult('data.pl').

% Configurar dados para ativar lockdown parcial
configurar_lockdown_parcial(Pais) :-
    retractall(crise_economica(Pais, _, _, _, _, _)),
    retractall(crise_saude(Pais, _, _, _, _, _)),
    retractall(crise_seguranca(Pais, _, _, _, _, _)),
    retractall(crise_social(Pais, _, _, _, _, _)),
    retractall(infraestrutura(Pais, _)),
    retractall(apoio_populacao(Pais, _)),
    retractall(reservas(Pais, _)),
    
    % Dados para LOCKDOWN PARCIAL
    assertz(crise_saude(Pais, alto, alta, critica, alto, explosiva)),
    assertz(apoio_populacao(Pais, medio)),
    
    % Outros dados em níveis baixos (para não ativar outras decisões)
    assertz(crise_economica(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_seguranca(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_social(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(infraestrutura(Pais, boa)),
    assertz(reservas(Pais, baixo)),
    
    write('✓ Dados configurados para LOCKDOWN PARCIAL'), nl.

% Testar se a decisão está disponível
testar_lockdown_parcial(Pais) :-
    write('=== TESTE: LOCKDOWN PARCIAL ==='), nl, nl,
    
    (   decisao(Pais, lockdown_parcial, Meses)
    ->  format('✓ Decisão disponível! Duração: ~w meses~n', [Meses]),
        decisao_prioridade(lockdown_parcial, Prioridade, Impacto),
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
    write('TESTE: LOCKDOWN PARCIAL'), nl,
    write('========================================'), nl, nl,
    
    configurar_lockdown_parcial(Pais),
    nl,
    
    testar_lockdown_parcial(Pais),
    
    obter_melhor_decisao(Pais),
    
    write('========================================'), nl,
    write('TESTE FINALIZADO'), nl,
    write('========================================'), nl.

% Executar com país padrão
teste :-
    executar_teste(pais_teste).

