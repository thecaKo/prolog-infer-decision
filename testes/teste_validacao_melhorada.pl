% Teste da validação melhorada que mostra TODOS os dados faltantes

:- consult('data.pl').

% Teste: Tentar chamar melhor_decisao sem nenhum dado
teste_sem_nenhum_dado :-
    write('=== TESTE: Sem nenhum dado ==='), nl,
    retractall(crise_economica(_, _, _, _, _, _)),
    retractall(crise_saude(_, _, _, _, _, _)),
    retractall(crise_seguranca(_, _, _, _, _, _)),
    retractall(crise_social(_, _, _, _, _, _)),
    retractall(infraestrutura(_, _)),
    retractall(apoio_populacao(_, _)),
    retractall(reservas(_, _)),
    nl,
    write('Chamando melhor_decisao(brasil, A, M)...'), nl,
    melhor_decisao(brasil, A, M).

% Teste: Preencher apenas alguns dados
teste_com_dados_parciais :-
    write('=== TESTE: Com dados parciais ==='), nl,
    retractall(_),
    
    % Preencher apenas alguns
    assertz(crise_economica(brasil, alto, alta, critica, alto, explosiva)),
    assertz(crise_saude(brasil, alto, alta, critica, alto, explosiva)),
    % Faltando: crise_seguranca, crise_social, infraestrutura, apoio_populacao, reservas
    
    nl,
    write('Chamando melhor_decisao(brasil, A, M)...'), nl,
    melhor_decisao(brasil, A, M).

% Teste: Com todos os dados preenchidos
teste_com_todos_dados :-
    write('=== TESTE: Com todos os dados ==='), nl,
    retractall(_),
    
    assertz(crise_economica(brasil, alto, alta, critica, alto, explosiva)),
    assertz(crise_saude(brasil, alto, alta, critica, alto, explosiva)),
    assertz(crise_seguranca(brasil, medio, estavel, moderada, medio, estavel)),
    assertz(crise_social(brasil, medio, estavel, moderada, medio, estavel)),
    assertz(infraestrutura(brasil, ruim)),
    assertz(apoio_populacao(brasil, medio)),
    assertz(reservas(brasil, alto)),
    
    nl,
    write('Chamando melhor_decisao(brasil, A, M)...'), nl,
    (   melhor_decisao(brasil, A, M)
    ->  format('✓ Sucesso! A = ~w, M = ~w~n', [A, M])
    ;   write('✗ Falhou'), nl
    ).

% Executar todos os testes
executar_testes :-
    write('========================================'), nl,
    write('TESTES DE VALIDAÇÃO MELHORADA'), nl,
    write('========================================'), nl, nl,
    
    catch(teste_sem_nenhum_dado, _, write('Teste 1 executado'), nl),
    nl, nl,
    
    catch(teste_com_dados_parciais, _, write('Teste 2 executado'), nl),
    nl, nl,
    
    teste_com_todos_dados,
    nl,
    
    write('========================================'), nl,
    write('TESTES FINALIZADOS'), nl,
    write('========================================'), nl.

