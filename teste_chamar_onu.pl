% Teste para CHAMAR ONU
% Condições: Crise de saúde alta + infraestrutura ruim

:- consult('data.pl').

% Configurar dados para ativar chamar onu
configurar_chamar_onu(Pais) :-
    retractall(crise_economica(Pais, _, _, _, _, _)),
    retractall(crise_saude(Pais, _, _, _, _, _)),
    retractall(crise_seguranca(Pais, _, _, _, _, _)),
    retractall(crise_social(Pais, _, _, _, _, _)),
    retractall(infraestrutura(Pais, _)),
    retractall(apoio_populacao(Pais, _)),
    retractall(reservas(Pais, _)),
    
    % Dados para CHAMAR ONU
    assertz(crise_saude(Pais, alto, alta, critica, alto, explosiva)),
    assertz(infraestrutura(Pais, ruim)),
    
    % Outros dados em níveis baixos (para não ativar outras decisões)
    assertz(crise_economica(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_seguranca(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_social(Pais, baixo, estavel, leve, baixo, estavel)),
    assertz(apoio_populacao(Pais, baixo)),
    assertz(reservas(Pais, baixo)),
    
    write('✓ Dados configurados para CHAMAR ONU'), nl.

% Testar se a decisão está disponível
testar_chamar_onu(Pais) :-
    write('=== TESTE: CHAMAR ONU ==='), nl, nl,
    
    (   decisao(Pais, chamar_onu, Meses)
    ->  format('✓ Decisão disponível! Duração: ~w meses~n', [Meses]),
        decisao_prioridade(chamar_onu, Prioridade, Impacto),
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
    write('TESTE: CHAMAR ONU'), nl,
    write('========================================'), nl, nl,
    
    configurar_chamar_onu(Pais),
    nl,
    
    testar_chamar_onu(Pais),
    
    obter_melhor_decisao(Pais),
    
    write('========================================'), nl,
    write('TESTE FINALIZADO'), nl,
    write('========================================'), nl.

% Executar com país padrão
teste :-
    executar_teste(pais_teste).

