% Teste para PROGRAMA SOCIAL
% Condições: Crise social alta + apoio baixo

:- consult('data.pl').

% Configurar dados para ativar programa social
configurar_programa_social(Pais) :-
    retractall(crise_economica(Pais, _, _, _, _, _)),
    retractall(crise_saude(Pais, _, _, _, _, _)),
    retractall(crise_seguranca(Pais, _, _, _, _, _)),
    retractall(crise_social(Pais, _, _, _, _, _)),
    retractall(infraestrutura(Pais, _)),
    retractall(apoio_populacao(Pais, _)),
    retractall(reservas(Pais, _)),
    
    % Dados para PROGRAMA SOCIAL
    assertz(crise_social(Pais, alto, alta, critica, alto, explosiva)),
    assertz(apoio_populacao(Pais, baixo)),
    
    % Outros dados em níveis baixos/médios
    assertz(crise_economica(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_saude(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_seguranca(Pais, medio, estavel, moderada, medio, estavel)),
    assertz(infraestrutura(Pais, boa)),
    assertz(reservas(Pais, baixo)),
    
    write('✓ Dados configurados para PROGRAMA SOCIAL'), nl.

% Testar se a decisão está disponível
testar_programa_social(Pais) :-
    write('=== TESTE: PROGRAMA SOCIAL ==='), nl, nl,
    
    (   decisao(Pais, programa_social, Meses)
    ->  format('✓ Decisão disponível! Duração: ~w meses~n', [Meses]),
        decisao_prioridade(programa_social, Prioridade, Impacto),
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
    write('TESTE: PROGRAMA SOCIAL'), nl,
    write('========================================'), nl, nl,
    
    configurar_programa_social(Pais),
    nl,
    
    testar_programa_social(Pais),
    
    obter_melhor_decisao(Pais),
    
    write('========================================'), nl,
    write('TESTE FINALIZADO'), nl,
    write('========================================'), nl.

% Executar com país padrão
teste :-
    executar_teste(pais_teste).

