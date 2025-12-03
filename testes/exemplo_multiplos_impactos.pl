% Exemplo mostrando como configurar dados para ter decisões de diferentes impactos
% Demonstra por que algumas configurações não retornam decisões de todos os impactos

:- consult('data.pl').

% Exemplo 1: Configuração que só tem decisão de impacto ALTO
% (como no seu teste)
configurar_apenas_alto(Pais) :-
    retractall(crise_economica(Pais, _, _, _, _, _)),
    retractall(crise_saude(Pais, _, _, _, _, _)),
    retractall(crise_seguranca(Pais, _, _, _, _, _)),
    retractall(crise_social(Pais, _, _, _, _, _)),
    retractall(infraestrutura(Pais, _)),
    retractall(apoio_populacao(Pais, _)),
    retractall(reservas(Pais, _)),
    assertz(crise_saude(Pais, alto, alta, critica, alto, explosiva)),
    assertz(apoio_populacao(Pais, medio)),
    assertz(crise_economica(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_seguranca(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_social(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(infraestrutura(Pais, boa)),
    assertz(reservas(Pais, baixo)),
    write('✓ Configurado: apenas decisões de impacto ALTO disponíveis'), nl.

% Exemplo 2: Configuração com decisões de TODOS os impactos
configurar_todos_impactos(Pais) :-
    retractall(crise_economica(Pais, _, _, _, _, _)),
    retractall(crise_saude(Pais, _, _, _, _, _)),
    retractall(crise_seguranca(Pais, _, _, _, _, _)),
    retractall(crise_social(Pais, _, _, _, _, _)),
    retractall(infraestrutura(Pais, _)),
    retractall(apoio_populacao(Pais, _)),
    retractall(reservas(Pais, _)),
    
    % Para impacto ALTO: lockdown_parcial
    assertz(crise_saude(Pais, alto, alta, critica, alto, explosiva)),
    assertz(apoio_populacao(Pais, medio)),
    
    % Para impacto MÉDIO: intervencao_economica
    assertz(crise_economica(Pais, alto, alta, critica, alto, explosiva)),
    assertz(reservas(Pais, alto)),
    
    % Para impacto BAIXO: reforco_hospitais (crise saúde alta + infra média/ruim)
    assertz(infraestrutura(Pais, media)),
    
    % Outros dados
    assertz(crise_seguranca(Pais, medio, estavel, moderada, medio, estavel)),
    assertz(crise_social(Pais, medio, estavel, moderada, medio, estavel)),
    
    write('✓ Configurado: decisões de ALTO, MÉDIO e BAIXO disponíveis'), nl.

% Exemplo 3: Configuração com impacto MÉDIO e BAIXO (sem ALTO)
configurar_medio_baixo(Pais) :-
    retractall(crise_economica(Pais, _, _, _, _, _)),
    retractall(crise_saude(Pais, _, _, _, _, _)),
    retractall(crise_seguranca(Pais, _, _, _, _, _)),
    retractall(crise_social(Pais, _, _, _, _, _)),
    retractall(infraestrutura(Pais, _)),
    retractall(apoio_populacao(Pais, _)),
    retractall(reservas(Pais, _)),
    
    % Para impacto MÉDIO: intervencao_economica
    assertz(crise_economica(Pais, alto, alta, critica, alto, explosiva)),
    assertz(reservas(Pais, alto)),
    
    % Para impacto BAIXO: reforco_hospitais
    assertz(crise_saude(Pais, alto, alta, critica, alto, explosiva)),
    assertz(infraestrutura(Pais, media)),
    
    % Outros dados (sem crise saúde alta + apoio médio para evitar lockdown)
    assertz(apoio_populacao(Pais, baixo)),
    assertz(crise_seguranca(Pais, medio, estavel, moderada, medio, estavel)),
    assertz(crise_social(Pais, medio, estavel, moderada, medio, estavel)),
    
    write('✓ Configurado: decisões de MÉDIO e BAIXO disponíveis'), nl.

% Mostrar configuração dos predicados
mostrar_configuracao(Pais) :-
    write('--- CONFIGURAÇÃO DOS PREDICADOS ---'), nl,
    nl,
    
    % Crise Econômica
    (   crise_economica(Pais, EN, ET, ES, EI, EV)
    ->  format('  crise_economica(~w, ~w, ~w, ~w, ~w, ~w)~n', [Pais, EN, ET, ES, EI, EV])
    ;   format('  crise_economica(~w, _) - NÃO CONFIGURADO~n', [Pais])
    ),
    
    % Crise de Saúde
    (   crise_saude(Pais, SN, ST, SS, SI, SV)
    ->  format('  crise_saude(~w, ~w, ~w, ~w, ~w, ~w)~n', [Pais, SN, ST, SS, SI, SV])
    ;   format('  crise_saude(~w, _) - NÃO CONFIGURADO~n', [Pais])
    ),
    
    % Crise de Segurança
    (   crise_seguranca(Pais, SeN, SeT, SeS, SeI, SeV)
    ->  format('  crise_seguranca(~w, ~w, ~w, ~w, ~w, ~w)~n', [Pais, SeN, SeT, SeS, SeI, SeV])
    ;   format('  crise_seguranca(~w, _) - NÃO CONFIGURADO~n', [Pais])
    ),
    
    % Crise Social
    (   crise_social(Pais, SoN, SoT, SoS, SoI, SoV)
    ->  format('  crise_social(~w, ~w, ~w, ~w, ~w, ~w)~n', [Pais, SoN, SoT, SoS, SoI, SoV])
    ;   format('  crise_social(~w, _) - NÃO CONFIGURADO~n', [Pais])
    ),
    
    % Infraestrutura
    (   infraestrutura(Pais, Infra)
    ->  format('  infraestrutura(~w, ~w)~n', [Pais, Infra])
    ;   format('  infraestrutura(~w, _) - NÃO CONFIGURADO~n', [Pais])
    ),
    
    % Apoio População
    (   apoio_populacao(Pais, Apoio)
    ->  format('  apoio_populacao(~w, ~w)~n', [Pais, Apoio])
    ;   format('  apoio_populacao(~w, _) - NÃO CONFIGURADO~n', [Pais])
    ),
    
    % Reservas
    (   reservas(Pais, Reservas)
    ->  format('  reservas(~w, ~w)~n', [Pais, Reservas])
    ;   format('  reservas(~w, _) - NÃO CONFIGURADO~n', [Pais])
    ),
    nl.

% Testar configuração
testar_configuracao(Pais, NomeConfig) :-
    write('========================================'), nl,
    format('TESTE: ~w~n', [NomeConfig]),
    write('========================================'), nl, nl,
    
    mostrar_configuracao(Pais),
    
    findall((A, M, I), (decisao(Pais, A, M), decisao_prioridade(A, _, I)), Decisoes),
    (   Decisoes = []
    ->  write('  Nenhuma decisão disponível'), nl
    ;   forall(member((A, M, I), Decisoes),
            format('  - ~w (~w meses) - Impacto: ~w~n', [A, M, I]))
    ),
    nl,
    
    write('--- MELHOR DECISÃO POR IMPACTO ---'), nl,
    (   melhor_decisao_considerando_impacto(Pais, A1, M1, alto)
    ->  format('  ALTO: ~w (~w meses)~n', [A1, M1])
    ;   write('  ALTO: nenhuma disponível'), nl
    ),
    (   melhor_decisao_considerando_impacto(Pais, A2, M2, medio)
    ->  format('  MÉDIO: ~w (~w meses)~n', [A2, M2])
    ;   write('  MÉDIO: nenhuma disponível'), nl
    ),
    (   melhor_decisao_considerando_impacto(Pais, A3, M3, baixo)
    ->  format('  BAIXO: ~w (~w meses)~n', [A3, M3])
    ;   write('  BAIXO: nenhuma disponível'), nl
    ),
    nl.

% Executar todos os exemplos
executar_exemplos :-
    write('========================================'), nl,
    write('EXEMPLOS: DECISÕES POR IMPACTO'), nl,
    write('========================================'), nl, nl,
    
    write('>>> Exemplo 1: Apenas impacto ALTO'), nl,
    configurar_apenas_alto(pais1),
    testar_configuracao(pais1, 'Apenas ALTO'),
    nl, nl,
    
    write('>>> Exemplo 2: Todos os impactos'), nl,
    configurar_todos_impactos(pais2),
    testar_configuracao(pais2, 'Todos os Impactos'),
    nl, nl,
    
    write('>>> Exemplo 3: MÉDIO e BAIXO'), nl,
    configurar_medio_baixo(pais3),
    testar_configuracao(pais3, 'MÉDIO e BAIXO'),
    nl,
    
    write('========================================'), nl,
    write('EXEMPLOS FINALIZADOS'), nl,
    write('========================================'), nl.

% Executar
teste :-
    executar_exemplos.

