% Teste para demonstrar decisões por impacto
% Mostra como obter diferentes ações para diferentes impactos

:- consult('data.pl').

% Configurar país com múltiplas decisões disponíveis
configurar_pais_multiplas_decisoes(Pais) :-
    retractall(crise_economica(Pais, _, _, _, _, _)),
    retractall(crise_saude(Pais, _, _, _, _, _)),
    retractall(crise_seguranca(Pais, _, _, _, _, _)),
    retractall(crise_social(Pais, _, _, _, _, _)),
    retractall(infraestrutura(Pais, _)),
    retractall(apoio_populacao(Pais, _)),
    retractall(reservas(Pais, _)),
    
    % Configurar para ter múltiplas decisões de diferentes impactos
    % Impacto ALTO: lockdown_parcial
    assertz(crise_saude(Pais, alto, alta, critica, alto, explosiva)),
    assertz(apoio_populacao(Pais, medio)),
    
    % Impacto MÉDIO: intervencao_economica (mas precisa reservas altas)
    assertz(crise_economica(Pais, alto, alta, critica, alto, explosiva)),
    assertz(reservas(Pais, alto)),
    
    % Impacto BAIXO: chamar_onu (mas precisa infra ruim)
    assertz(infraestrutura(Pais, ruim)),
    
    % Outros dados
    assertz(crise_seguranca(Pais, medio, estavel, moderada, medio, estavel)),
    assertz(crise_social(Pais, medio, estavel, moderada, medio, estavel)),
    
    write('✓ Dados configurados para múltiplas decisões'), nl.

% Teste: Obter melhor decisão de cada impacto
testar_por_impacto(Pais) :-
    write('=== TESTE: DECISÕES POR IMPACTO ==='), nl, nl,
    
    % Impacto ALTO
    write('--- Melhor decisão de IMPACTO ALTO ---'), nl,
    (   melhor_decisao_considerando_impacto(Pais, AcaoAlto, MesesAlto, alto)
    ->  format('✓ Ação: ~w (~w meses)~n', [AcaoAlto, MesesAlto])
    ;   write('✗ Nenhuma decisão de impacto ALTO disponível'), nl
    ),
    nl,
    
    % Impacto MÉDIO
    write('--- Melhor decisão de IMPACTO MÉDIO ---'), nl,
    (   melhor_decisao_considerando_impacto(Pais, AcaoMedio, MesesMedio, medio)
    ->  format('✓ Ação: ~w (~w meses)~n', [AcaoMedio, MesesMedio])
    ;   write('✗ Nenhuma decisão de impacto MÉDIO disponível'), nl
    ),
    nl,
    
    % Impacto BAIXO
    write('--- Melhor decisão de IMPACTO BAIXO ---'), nl,
    (   melhor_decisao_considerando_impacto(Pais, AcaoBaixo, MesesBaixo, baixo)
    ->  format('✓ Ação: ~w (~w meses)~n', [AcaoBaixo, MesesBaixo])
    ;   write('✗ Nenhuma decisão de impacto BAIXO disponível'), nl
    ),
    nl.

% Teste: Listar todas as decisões agrupadas por impacto
testar_listagem_por_impacto(Pais) :-
    write('=== LISTAGEM DE DECISÕES POR IMPACTO ==='), nl, nl,
    listar_decisoes_por_impacto(Pais).

% Teste: Obter todas as melhores decisões de uma vez
testar_todas_melhores(Pais) :-
    write('=== MELHORES DECISÕES DE CADA IMPACTO ==='), nl, nl,
    melhor_decisao_por_impacto(Pais, Resultados),
    (   Resultados = []
    ->  write('Nenhuma decisão disponível'), nl
    ;   write('Resultados:'), nl,
        forall(member((Impacto, Acao, Meses), Resultados),
            format('  ~w: ~w (~w meses)~n', [Impacto, Acao, Meses]))
    ),
    nl.

% Executar teste completo
executar_teste(Pais) :-
    write('========================================'), nl,
    write('TESTE: DECISÕES POR IMPACTO'), nl,
    write('========================================'), nl, nl,
    
    configurar_pais_multiplas_decisoes(Pais),
    nl,
    
    write('>>> 1. Melhor decisão geral:'), nl,
    (   melhor_decisao(Pais, Acao, Meses)
    ->  format('Ação: ~w (~w meses)~n', [Acao, Meses])
    ;   write('Nenhuma decisão disponível'), nl
    ),
    nl, nl,
    
    write('>>> 2. Decisões por impacto específico:'), nl,
    testar_por_impacto(Pais),
    
    write('>>> 3. Listagem completa por impacto:'), nl,
    testar_listagem_por_impacto(Pais),
    
    write('>>> 4. Todas as melhores de cada impacto:'), nl,
    testar_todas_melhores(Pais),
    
    write('========================================'), nl,
    write('TESTE FINALIZADO'), nl,
    write('========================================'), nl.

% Executar com país padrão
teste :-
    executar_teste(pais_teste).

