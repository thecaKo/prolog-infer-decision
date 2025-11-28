crise_economica(Pais, Nivel).
crise_saude(Pais, Nivel).
crise_seguranca(Pais, Nivel).
crise_social(Pais, Nivel).
infraestrutura(Pais, Nivel).
apoio_populacao(Pais, Nivel).
reservas(Pais, Nivel).

crise_grave(P) :-
    crise_economica(P, alto);
    crise_saude(P, alto);
    crise_seguranca(P, alto).

crise_moderada(P) :-
    crise_economica(P, medio);
    crise_saude(P, medio);
    crise_seguranca(P, medio).

crise_leve(P) :-
    crise_economica(P, baixo),
    crise_saude(P, baixo),
    crise_seguranca(P, baixo).

infra_boa(P) :- infraestrutura(P, boa).
infra_media(P) :- infraestrutura(P, media).
infra_ruim(P) :- infraestrutura(P, ruim).

apoio_baixo(P) :- apoio_populacao(P, baixo).
apoio_medio(P) :- apoio_populacao(P, medio).
apoio_alto(P) :- apoio_populacao(P, alto).

reservas_altas(P) :- reservas(P, alto).
reservas_baixas(P) :- reservas(P, baixo).


acao(intervencao_economica).
acao(pacote_emergencial).
acao(reforco_hospitais).
acao(reforco_policial).
acao(acordo_internacional).
acao(reforma_tributaria).
acao(programa_social).
acao(auxilio_financeiro).
acao(controle_de_precos).
acao(reforma_infraestrutura).
acao(campanha_confianca).
acao(lockdown_parcial).
acao(chamar_onu).
acao(deslocar_tropas).
acao(plano_estabilizacao).
acao(contencao_social).


decisao(P, intervencao_economica, 6) :-
    crise_economica(P, alto),
    reservas_altas(P).

decisao(P, pacote_emergencial, 3) :-
    crise_economica(P, alto),
    reservas_baixas(P).

decisao(P, controle_de_precos, 2) :-
    crise_economica(P, medio).


decisao(P, reforco_hospitais, 4) :-
    crise_saude(P, alto),
    infra_media(P).

decisao(P, lockdown_parcial, 1) :-
    crise_saude(P, alto),
    apoio_medio(P).

decisao(P, chamar_onu, 2) :-
    crise_saude(P, alto),
    infra_ruim(P).


decisao(P, reforco_policial, 2) :-
    crise_seguranca(P, alto),
    apoio_alto(P).

decisao(P, deslocar_tropas, 3) :-
    crise_seguranca(P, alto),
    apoio_medio(P).

decisao(P, acordo_internacional, 6) :-
    crise_seguranca(P, medio).


decisao(P, programa_social, 5) :-
    crise_social(P, alto),
    apoio_baixo(P).

decisao(P, contencao_social, 2) :-
    crise_social(P, medio),
    apoio_medio(P).

decisao(P, campanha_confianca, 4) :-
    crise_social(P, medio),
    apoio_alto(P).


decisao(P, reforma_infraestrutura, 12) :-
    infra_ruim(P).


decisao(P, plano_estabilizacao, 6) :-
    crise_grave(P),
    apoio_alto(P).



melhor_decisao(P, Acao, Meses) :-
    findall((A,M), decisao(P,A,M), Lista),
    sort(2, @=<, Lista, [(Acao, Meses)|_]).
