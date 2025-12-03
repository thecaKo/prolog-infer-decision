% Script de diagnóstico para verificar por que decisões não estão sendo ativadas

:- consult('data.pl').

% Configurar os mesmos dados do usuário
configurar_dados_usuario :-
    retractall(_),
    assertz(crise_saude(meu_pais, alto, alta, critica, alto, explosiva)),
    assertz(apoio_populacao(meu_pais, medio)),
    assertz(crise_economica(meu_pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_seguranca(meu_pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_social(meu_pais, baixo, estavel, leve, baixo, estavel)),
    assertz(infraestrutura(meu_pais, boa)),
    assertz(reservas(meu_pais, baixo)),
    write('✓ Dados configurados'), nl.

% Verificar cada condição de lockdown_parcial
diagnosticar_lockdown_parcial :-
    write('=== DIAGNÓSTICO: lockdown_parcial ==='), nl, nl,
    
    % Verificar perfil_pais
    write('1. Verificando perfil_pais...'), nl,
    (   perfil_pais(meu_pais, Perfil)
    ->  write('   ✓ perfil_pais funciona'), nl,
        write('2. Verificando get_dict...'), nl,
        (   get_dict(crise_saude, Perfil, CS)
        ->  write('   ✓ get_dict funciona'), nl,
            write('3. Verificando CS.nivel == alto...'), nl,
            (   CS.nivel == alto
            ->  write('   ✓ CS.nivel é alto'), nl
            ;   write('   ✗ CS.nivel NÃO é alto (é: '), write(CS.nivel), write(')'), nl
            )
        ;   write('   ✗ get_dict falhou'), nl
        )
    ;   write('   ✗ perfil_pais falhou'), nl
    ),
    nl,
    
    % Verificar apoio_medio
    write('4. Verificando apoio_medio...'), nl,
    (   apoio_medio(meu_pais)
    ->  write('   ✓ apoio_medio funciona'), nl
    ;   write('   ✗ apoio_medio falhou'), nl
    ),
    nl,
    
    % Verificar decisão diretamente
    write('5. Verificando decisao(meu_pais, lockdown_parcial, M)...'), nl,
    (   decisao(meu_pais, lockdown_parcial, M)
    ->  format('   ✓ decisão encontrada! M = ~w~n', [M])
    ;   write('   ✗ decisão NÃO encontrada'), nl
    ),
    nl,
    
    % Verificar todas as decisões disponíveis
    write('6. Todas as decisões disponíveis:'), nl,
    findall((A, M), decisao(meu_pais, A, M), Decisoes),
    (   Decisoes = []
    ->  write('   ✗ Nenhuma decisão disponível'), nl
    ;   write('   ✓ Decisões encontradas:'), nl,
        forall(member((A, M), Decisoes),
            format('      - ~w (~w meses)~n', [A, M]))
    ),
    nl.

% Executar diagnóstico completo
executar_diagnostico :-
    write('========================================'), nl,
    write('DIAGNÓSTICO DE DECISÕES'), nl,
    write('========================================'), nl, nl,
    
    configurar_dados_usuario,
    nl,
    
    diagnosticar_lockdown_parcial,
    
    write('========================================'), nl,
    write('DIAGNÓSTICO FINALIZADO'), nl,
    write('========================================'), nl.

