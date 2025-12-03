% Teste para executar TODAS as decisões disponíveis
% Carrega e executa todos os testes de uma vez

:- consult('data.pl').

% Executar todos os testes
executar_todos_testes :-
    write('========================================'), nl,
    write('EXECUTANDO TODOS OS TESTES'), nl,
    write('========================================'), nl, nl,
    
    % Teste 1: Intervenção Econômica
    write('>>> Carregando teste_intervencao_economica.pl...'), nl,
    consult('teste_intervencao_economica.pl'),
    executar_teste(pais_teste),
    nl, nl,
    
    % Teste 2: Pacote Emergencial
    write('>>> Carregando teste_pacote_emergencial.pl...'), nl,
    consult('teste_pacote_emergencial.pl'),
    executar_teste(pais_teste),
    nl, nl,
    
    % Teste 3: Lockdown Parcial
    write('>>> Carregando teste_lockdown_parcial.pl...'), nl,
    consult('teste_lockdown_parcial.pl'),
    executar_teste(pais_teste),
    nl, nl,
    
    % Teste 4: Chamar ONU
    write('>>> Carregando teste_chamar_onu.pl...'), nl,
    consult('teste_chamar_onu.pl'),
    executar_teste(pais_teste),
    nl, nl,
    
    % Teste 5: Reforma Infraestrutura
    write('>>> Carregando teste_reforma_infraestrutura.pl...'), nl,
    consult('teste_reforma_infraestrutura.pl'),
    executar_teste(pais_teste),
    nl, nl,
    
    % Teste 6: Reforço Policial
    write('>>> Carregando teste_reforco_policial.pl...'), nl,
    consult('teste_reforco_policial.pl'),
    executar_teste(pais_teste),
    nl, nl,
    
    % Teste 7: Programa Social
    write('>>> Carregando teste_programa_social.pl...'), nl,
    consult('teste_programa_social.pl'),
    executar_teste(pais_teste),
    nl, nl,
    
    % Teste 8: Plano Estabilização
    write('>>> Carregando teste_plano_estabilizacao.pl...'), nl,
    consult('teste_plano_estabilizacao.pl'),
    executar_teste(pais_teste),
    nl, nl,
    
    write('========================================'), nl,
    write('TODOS OS TESTES FINALIZADOS'), nl,
    write('========================================'), nl.

% Executar apenas um teste específico
executar_teste_especifico(NomeArquivo) :-
    format('Carregando ~w...~n', [NomeArquivo]),
    consult(NomeArquivo),
    executar_teste(pais_teste).

