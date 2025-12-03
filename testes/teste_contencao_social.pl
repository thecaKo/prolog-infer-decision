% Teste para CONTENÇÃO SOCIAL
% Condições: Crise social média + apoio médio

:- consult('data.pl').

% Configurar dados para ativar contenção social
configurar_contencao_social(Pais) :-
    retractall(crise_economica(Pais, _, _, _, _, _)),
    retractall(crise_saude(Pais, _, _, _, _, _)),
    retractall(crise_seguranca(Pais, _, _, _, _, _)),
    retractall(crise_social(Pais, _, _, _, _, _)),
    retractall(infraestrutura(Pais, _)),
    retractall(apoio_populacao(Pais, _)),
    retractall(reservas(Pais, _)),
    
    % Dados para CONTENÇÃO SOCIAL
    assertz(crise_social(Pais, medio, estavel, moderada, medio, estavel)),
    assertz(apoio_populacao(Pais, medio)),
    
    % Outros dados em níveis baixos/médios
    assertz(crise_economica(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_saude(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_seguranca(Pais, medio, estavel, moderada, medio, estavel)),
    assertz(infraestrutura(Pais, boa)),
    assertz(reservas(Pais, baixo)),
    
    write('✓ Dados configurados para CONTENÇÃO SOCIAL'), nl.

% Testar se a decisão está disponível
testar_contencao_social(Pais) :-
    write('=== TESTE: CONTENÇÃO SOCIAL ==='), nl, nl,
    
    (   decisao(Pais, contencao_social, Meses)
    ->  format('✓ Decisão disponível! Duração: ~w meses~n', [Meses]),
        decisao_prioridade(contencao_social, Prioridade, Impacto),
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
    write('TESTE: CONTENÇÃO SOCIAL'), nl,
    write('========================================'), nl, nl,
    
    configurar_contencao_social(Pais),
    nl,
    
    testar_contencao_social(Pais),
    
    obter_melhor_decisao(Pais),
    
    write('========================================'), nl,
    write('TESTE FINALIZADO'), nl,
    write('========================================'), nl.

% Executar com país padrão
teste :-
    executar_teste(pais_teste).

