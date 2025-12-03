% Teste para PACOTE EMERGENCIAL
% Condições: Crise econômica alta + reservas baixas

:- consult('data.pl').

% Configurar dados para ativar pacote emergencial
configurar_pacote_emergencial(Pais) :-
    retractall(crise_economica(Pais, _, _, _, _, _)),
    retractall(crise_saude(Pais, _, _, _, _, _)),
    retractall(crise_seguranca(Pais, _, _, _, _, _)),
    retractall(crise_social(Pais, _, _, _, _, _)),
    retractall(infraestrutura(Pais, _)),
    retractall(apoio_populacao(Pais, _)),
    retractall(reservas(Pais, _)),
    
    % Dados para PACOTE EMERGENCIAL
    assertz(crise_economica(Pais, alto, alta, critica, alto, explosiva)),
    assertz(reservas(Pais, baixo)),
    
    % Outros dados em níveis baixos/médios
    assertz(crise_saude(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_seguranca(Pais, medio, estavel, moderada, medio, estavel)),
    assertz(crise_social(Pais, medio, estavel, moderada, medio, estavel)),
    assertz(infraestrutura(Pais, boa)),
    assertz(apoio_populacao(Pais, medio)),
    
    write('✓ Dados configurados para PACOTE EMERGENCIAL'), nl.

% Testar se a decisão está disponível
testar_pacote_emergencial(Pais) :-
    write('=== TESTE: PACOTE EMERGENCIAL ==='), nl, nl,
    
    (   decisao(Pais, pacote_emergencial, Meses)
    ->  format('✓ Decisão disponível! Duração: ~w meses~n', [Meses]),
        decisao_prioridade(pacote_emergencial, Prioridade, Impacto),
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
    write('TESTE: PACOTE EMERGENCIAL'), nl,
    write('========================================'), nl, nl,
    
    configurar_pacote_emergencial(Pais),
    nl,
    
    testar_pacote_emergencial(Pais),
    
    obter_melhor_decisao(Pais),
    
    write('========================================'), nl,
    write('TESTE FINALIZADO'), nl,
    write('========================================'), nl.

% Executar com país padrão
teste :-
    executar_teste(pais_teste).

