% Teste para INTERVENÇÃO ECONÔMICA
% Condições: Crise econômica alta + tendência alta + severidade alta/crítica + reservas altas

:- consult('data.pl').

% Configurar dados para ativar intervenção econômica
configurar_intervencao_economica(Pais) :-
    retractall(crise_economica(Pais, _, _, _, _, _)),
    retractall(crise_saude(Pais, _, _, _, _, _)),
    retractall(crise_seguranca(Pais, _, _, _, _, _)),
    retractall(crise_social(Pais, _, _, _, _, _)),
    retractall(infraestrutura(Pais, _)),
    retractall(apoio_populacao(Pais, _)),
    retractall(reservas(Pais, _)),
    
    % Dados para INTERVENÇÃO ECONÔMICA
    assertz(crise_economica(Pais, alto, alta, critica, alto, explosiva)),
    assertz(reservas(Pais, alto)),
    
    % Outros dados em níveis baixos/médios (para não ativar outras decisões)
    assertz(crise_saude(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_seguranca(Pais, medio, estavel, moderada, medio, estavel)),
    assertz(crise_social(Pais, medio, estavel, moderada, medio, estavel)),
    assertz(infraestrutura(Pais, boa)),
    assertz(apoio_populacao(Pais, medio)),
    
    write('✓ Dados configurados para INTERVENÇÃO ECONÔMICA'), nl.

% Testar se a decisão está disponível
testar_intervencao_economica(Pais) :-
    write('=== TESTE: INTERVENÇÃO ECONÔMICA ==='), nl, nl,
    
    (   decisao(Pais, intervencao_economica, Meses)
    ->  format('✓ Decisão disponível! Duração: ~w meses~n', [Meses]),
        decisao_prioridade(intervencao_economica, Prioridade, Impacto),
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
    write('TESTE: INTERVENÇÃO ECONÔMICA'), nl,
    write('========================================'), nl, nl,
    
    configurar_intervencao_economica(Pais),
    nl,
    
    testar_intervencao_economica(Pais),
    
    obter_melhor_decisao(Pais),
    
    write('========================================'), nl,
    write('TESTE FINALIZADO'), nl,
    write('========================================'), nl.

% Executar com país padrão
teste :-
    executar_teste(pais_teste).

