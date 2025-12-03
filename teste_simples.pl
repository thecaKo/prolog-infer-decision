% Teste simples para verificar o problema

:- consult('data.pl').

% Configurar dados exatamente como o usuário
setup :-
    retractall(_),
    assertz(crise_saude(meu_pais, alto, alta, critica, alto, explosiva)),
    assertz(apoio_populacao(meu_pais, medio)),
    assertz(crise_economica(meu_pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_seguranca(meu_pais, baixo, estavel, leve, baixo, estavel)),
    assertz(crise_social(meu_pais, baixo, estavel, leve, baixo, estavel)),
    assertz(infraestrutura(meu_pais, boa)),
    assertz(reservas(meu_pais, baixo)).

% Teste passo a passo
teste_completo :-
    setup,
    write('=== TESTE PASSO A PASSO ==='), nl, nl,
    
    % Teste 1: Verificar se perfil_pais funciona
    write('1. Testando perfil_pais...'), nl,
    (   perfil_pais(meu_pais, Perfil)
    ->  write('   ✓ perfil_pais OK'), nl,
        write('2. Testando get_dict(crise_saude)...'), nl,
        (   get_dict(crise_saude, Perfil, CS)
        ->  write('   ✓ get_dict OK'), nl,
            write('3. Testando CS.nivel...'), nl,
            write('   CS.nivel = '), write(CS.nivel), nl,
            write('4. Testando CS.nivel == alto...'), nl,
            (   CS.nivel == alto
            ->  write('   ✓ CS.nivel == alto é verdadeiro'), nl
            ;   write('   ✗ CS.nivel == alto é falso'), nl,
                write('   Tentando com = ao invés de ==...'), nl,
                (   CS.nivel = alto
                ->  write('   ✓ CS.nivel = alto funciona'), nl
                ;   write('   ✗ CS.nivel = alto também falha'), nl
                )
            ),
            write('5. Testando apoio_medio...'), nl,
            (   apoio_medio(meu_pais)
            ->  write('   ✓ apoio_medio OK'), nl
            ;   write('   ✗ apoio_medio falhou'), nl
            )
        ;   write('   ✗ get_dict falhou'), nl
        )
    ;   write('   ✗ perfil_pais falhou'), nl
    ),
    nl,
    
    % Teste 2: Verificar decisão diretamente
    write('6. Testando decisao(meu_pais, lockdown_parcial, M)...'), nl,
    (   decisao(meu_pais, lockdown_parcial, M)
    ->  format('   ✓ Decisão encontrada! M = ~w~n', [M])
    ;   write('   ✗ Decisão NÃO encontrada'), nl
    ),
    nl,
    
    % Teste 3: Listar todas as decisões
    write('7. Todas as decisões disponíveis:'), nl,
    findall((A, M), decisao(meu_pais, A, M), Decisoes),
    length(Decisoes, N),
    format('   Total: ~w decisões~n', [N]),
    forall(member((A, M), Decisoes),
        format('   - ~w (~w meses)~n', [A, M])),
    nl,
    
    % Teste 4: melhor_decisao
    write('8. Testando melhor_decisao...'), nl,
    (   melhor_decisao(meu_pais, A, M)
    ->  format('   Resultado: A = ~w, M = ~w~n', [A, M])
    ;   write('   ✗ melhor_decisao falhou'), nl
    ).

