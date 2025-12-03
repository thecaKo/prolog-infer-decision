% Script de teste para validar a função de validação de dados
% Demonstra como melhor_decisao retorna mensagens quando faltam dados

:- consult('data.pl').

% Teste 1: Tentar chamar melhor_decisao sem nenhum dado
teste_sem_dados :-
    write('=== TESTE 1: Sem nenhum dado ==='), nl,
    retractall(crise_economica(_, _, _, _, _, _)),
    retractall(crise_saude(_, _, _, _, _, _)),
    retractall(crise_seguranca(_, _, _, _, _, _)),
    retractall(crise_social(_, _, _, _, _, _)),
    retractall(infraestrutura(_, _)),
    retractall(apoio_populacao(_, _)),
    retractall(reservas(_, _)),
    nl,
    write('Tentando chamar melhor_decisao(pais_teste, A, M)...'), nl,
    melhor_decisao(pais_teste, A, M),
    format('Resultado: A = ~w, M = ~w~n', [A, M]).

% Teste 2: Faltando apenas crise_economica
teste_sem_crise_economica :-
    write('=== TESTE 2: Faltando crise_economica ==='), nl,
    retractall(_),
    
    % Preencher todos EXCETO crise_economica
    assertz(crise_saude(pais_teste, alto, alta, critica, alto, explosiva)),
    assertz(crise_seguranca(pais_teste, medio, estavel, moderada, medio, estavel)),
    assertz(crise_social(pais_teste, medio, estavel, moderada, medio, estavel)),
    assertz(infraestrutura(pais_teste, ruim)),
    assertz(apoio_populacao(pais_teste, medio)),
    assertz(reservas(pais_teste, alto)),
    nl,
    write('Tentando chamar melhor_decisao(pais_teste, A, M)...'), nl,
    melhor_decisao(pais_teste, A, M),
    format('Resultado: A = ~w, M = ~w~n', [A, M]).

% Teste 3: Faltando apenas crise_saude
teste_sem_crise_saude :-
    write('=== TESTE 3: Faltando crise_saude ==='), nl,
    retractall(_),
    
    % Preencher todos EXCETO crise_saude
    assertz(crise_economica(pais_teste, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_seguranca(pais_teste, medio, estavel, moderada, medio, estavel)),
    assertz(crise_social(pais_teste, medio, estavel, moderada, medio, estavel)),
    assertz(infraestrutura(pais_teste, ruim)),
    assertz(apoio_populacao(pais_teste, medio)),
    assertz(reservas(pais_teste, alto)),
    nl,
    write('Tentando chamar melhor_decisao(pais_teste, A, M)...'), nl,
    melhor_decisao(pais_teste, A, M),
    format('Resultado: A = ~w, M = ~w~n', [A, M]).

% Teste 4: Faltando apenas infraestrutura
teste_sem_infraestrutura :-
    write('=== TESTE 4: Faltando infraestrutura ==='), nl,
    retractall(_),
    
    % Preencher todos EXCETO infraestrutura
    assertz(crise_economica(pais_teste, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_saude(pais_teste, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_seguranca(pais_teste, medio, estavel, moderada, medio, estavel)),
    assertz(crise_social(pais_teste, medio, estavel, moderada, medio, estavel)),
    assertz(apoio_populacao(pais_teste, medio)),
    assertz(reservas(pais_teste, alto)),
    nl,
    write('Tentando chamar melhor_decisao(pais_teste, A, M)...'), nl,
    melhor_decisao(pais_teste, A, M),
    format('Resultado: A = ~w, M = ~w~n', [A, M]).

% Teste 5: Com todos os dados preenchidos (deve funcionar)
teste_com_todos_dados :-
    write('=== TESTE 5: Com todos os dados preenchidos ==='), nl,
    retractall(_),
    
    % Preencher TODOS os dados
    assertz(crise_economica(pais_teste, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_saude(pais_teste, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_seguranca(pais_teste, medio, estavel, moderada, medio, estavel)),
    assertz(crise_social(pais_teste, medio, estavel, moderada, medio, estavel)),
    assertz(infraestrutura(pais_teste, ruim)),
    assertz(apoio_populacao(pais_teste, medio)),
    assertz(reservas(pais_teste, alto)),
    nl,
    write('Tentando chamar melhor_decisao(pais_teste, A, M)...'), nl,
    (   melhor_decisao(pais_teste, A, M)
    ->  format('✓ Sucesso! A = ~w, M = ~w~n', [A, M])
    ;   write('✗ Falhou (não deveria)'), nl
    ).

% Executar todos os testes
executar_todos_testes :-
    write('========================================'), nl,
    write('TESTES DE VALIDAÇÃO DE DADOS'), nl,
    write('========================================'), nl, nl,
    
    catch(teste_sem_dados, _, write('Teste 1 executado'), nl),
    nl, nl,
    
    catch(teste_sem_crise_economica, _, write('Teste 2 executado'), nl),
    nl, nl,
    
    catch(teste_sem_crise_saude, _, write('Teste 3 executado'), nl),
    nl, nl,
    
    catch(teste_sem_infraestrutura, _, write('Teste 4 executado'), nl),
    nl, nl,
    
    teste_com_todos_dados,
    nl,
    
    write('========================================'), nl,
    write('TESTES FINALIZADOS'), nl,
    write('========================================'), nl.

