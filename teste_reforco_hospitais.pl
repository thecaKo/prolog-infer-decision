% Teste para REFORÇO DE HOSPITAIS
% Condições: Crise de saúde alta + infraestrutura média ou ruim

:- consult('data.pl').

% Configurar dados para ativar reforço de hospitais
configurar_reforco_hospitais(Pais) :-
    retractall(crise_economica(Pais, _, _, _, _, _)),
    retractall(crise_saude(Pais, _, _, _, _, _)),
    retractall(crise_seguranca(Pais, _, _, _, _, _)),
    retractall(crise_social(Pais, _, _, _, _, _)),
    retractall(infraestrutura(Pais, _)),
    retractall(apoio_populacao(Pais, _)),
    retractall(reservas(Pais, _)),
    
    % Dados para REFORÇO DE HOSPITAIS
    assertz(crise_saude(Pais, alto, alta, critica, alto, explosiva)),
    assertz(infraestrutura(Pais, media)),
    
    % Outros dados em níveis baixos/médios
    assertz(crise_economica(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_seguranca(Pais, medio, estavel, moderada, medio, estavel)),
    assertz(crise_social(Pais, medio, estavel, moderada, medio, estavel)),
    assertz(apoio_populacao(Pais, baixo)),
    assertz(reservas(Pais, baixo)),
    
    write('✓ Dados configurados para REFORÇO DE HOSPITAIS'), nl.

% Testar se a decisão está disponível
testar_reforco_hospitais(Pais) :-
    write('=== TESTE: REFORÇO DE HOSPITAIS ==='), nl, nl,
    
    (   decisao(Pais, reforco_hospitais, Meses)
    ->  format('✓ Decisão disponível! Duração: ~w meses~n', [Meses]),
        decisao_prioridade(reforco_hospitais, Prioridade, Impacto),
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
    write('TESTE: REFORÇO DE HOSPITAIS'), nl,
    write('========================================'), nl, nl,
    
    configurar_reforco_hospitais(Pais),
    nl,
    
    testar_reforco_hospitais(Pais),
    
    obter_melhor_decisao(Pais),
    
    write('========================================'), nl,
    write('TESTE FINALIZADO'), nl,
    write('========================================'), nl.

% Executar com país padrão
teste :-
    executar_teste(pais_teste).

