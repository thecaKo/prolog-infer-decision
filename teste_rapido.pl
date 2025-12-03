% Script de teste rápido para validar as correções e decisões

:- consult('data.pl').

% Configuração mínima para testar as 4 decisões
teste_configuracao :-
    retractall(crise_economica(_, _, _, _, _, _)),
    retractall(crise_saude(_, _, _, _, _, _)),
    retractall(crise_seguranca(_, _, _, _, _, _)),
    retractall(crise_social(_, _, _, _, _, _)),
    retractall(infraestrutura(_, _)),
    retractall(apoio_populacao(_, _)),
    retractall(reservas(_, _)),
    
    % Para INTERVENÇÃO ECONÔMICA
    assertz(crise_economica(teste, alto, alta, critica, alto, explosiva)),
    assertz(reservas(teste, alto)),
    
    % Para LOCKDOWN PARCIAL e CHAMAR ONU
    assertz(crise_saude(teste, alto, alta, critica, alto, explosiva)),
    assertz(apoio_populacao(teste, medio)),
    
    % Para CHAMAR ONU e REFORMA INFRAESTRUTURA
    assertz(infraestrutura(teste, ruim)),
    
    % Dados adicionais obrigatórios
    assertz(crise_seguranca(teste, medio, estavel, moderada, medio, estavel)),
    assertz(crise_social(teste, medio, estavel, moderada, medio, estavel)),
    
    write('Configuração criada para país: teste'), nl.

% Testar cada decisão individualmente
teste_decisoes :-
    write('=== TESTE DE DECISÕES ==='), nl, nl,
    
    % Teste 1: Lockdown Parcial
    (   decisao(teste, lockdown_parcial, M1)
    ->  write('✓ Lockdown Parcial: OK (Meses: '), write(M1), write(')'), nl
    ;   write('✗ Lockdown Parcial: FALHOU'), nl
    ),
    
    % Teste 2: Chamar ONU
    (   decisao(teste, chamar_onu, M2)
    ->  write('✓ Chamar ONU: OK (Meses: '), write(M2), write(')'), nl
    ;   write('✗ Chamar ONU: FALHOU'), nl
    ),
    
    % Teste 3: Reforma Infraestrutura
    (   decisao(teste, reforma_infraestrutura, M3)
    ->  write('✓ Reforma Infraestrutura: OK (Meses: '), write(M3), write(')'), nl
    ;   write('✗ Reforma Infraestrutura: FALHOU'), nl
    ),
    
    % Teste 4: Intervenção Econômica
    (   decisao(teste, intervencao_economica, M4)
    ->  write('✓ Intervenção Econômica: OK (Meses: '), write(M4), write(')'), nl
    ;   write('✗ Intervenção Econômica: FALHOU'), nl
    ),
    nl.

% Executar todos os testes
executar_testes :-
    write('========================================'), nl,
    write('INICIANDO TESTES'), nl,
    write('========================================'), nl, nl,
    
    write('>>> Configurando dados de teste...'), nl,
    teste_configuracao,
    nl,
    
    write('>>> Testando decisões...'), nl,
    teste_decisoes,
    
    write('========================================'), nl,
    write('TESTES FINALIZADOS'), nl,
    write('========================================'), nl.

