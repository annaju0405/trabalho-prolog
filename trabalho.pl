:- use_module(library(lists)).

main :-
    modelo(S),
    imprime(S).

modelo(S) :-
    % Estrutura:
    % [Pos, Mochila, Nome, Mes, Jogo, Materia, Suco]

    S = [
        [1, M1, N1, Mes1, J1, Mat1, Su1],
        [2, M2, N2, Mes2, J2, Mat2, Su2],
        [3, M3, N3, Mes3, J3, Mat3, Su3],
        [4, M4, N4, Mes4, J4, Mat4, Su4],
        [5, M5, N5, Mes5, J5, Mat5, Su5]
    ],

    % Pistas fortes
    Su1 = limao,
    Su3 = morango,
    N5  = lenin,

    Mat2 = matematica,
    Mes2 = dezembro,
    Su2  = maracuja,

    Mat3 = biologia,
    M3   = azul,
    Mes3 = janeiro,

    M2 = branca,
    N3 = will,

    N4  = joao,
    Mat4 = historia,

    Su4 = uva,
    J4  = prob_logica,

    Mat5 = portugues,
    Mes4 = setembro,
    J5 = cubo_vermelho,
    Su5 = laranja,
    M5 = amarela,
    Mes5 = maio,

    % Usa permutation no que sobrou
    permutation([verde, vermelha], [M1, M4]),
    permutation([otavio, denis], [N1, N2]),
    permutation([agosto], [Mes1]),
    permutation([caca_palavras, tres_ou_mais, jogo_da_forca], [J1, J2, J3]),
    permutation([geografia], [Mat1]),

    valida(S),
    !.

valida(S) :-
    % 1. Setembro está ao lado de laranja
    ao_lado([_, _, _, setembro, _, _, _], [_, _, _, _, _, _, laranja], S),

    % 2. João gosta de História
    member([_, _, joao, _, _, historia, _], S),

    % 3. Mochila azul está à esquerda de maio
    a_esquerda([_, azul, _, _, _, _, _], [_, _, _, maio, _, _, _], S),

    % 4. Will está ao lado de Prob. de Lógica
    ao_lado([_, _, will, _, _, _, _], [_, _, _, _, prob_logica, _, _], S),

    % 5. Mochila branca exatamente à esquerda de Will
    nextto([_, branca, _, _, _, _, _], [_, _, will, _, _, _, _], S),

    % 6. Terceira posição = morango
    member([3, _, _, _, _, _, morango], S),

    % 7. Uva = Prob. de Lógica
    member([_, _, _, _, prob_logica, _, uva], S),

    % 8. Jogo da Força ao lado de 3 ou Mais
    ao_lado([_, _, _, _, jogo_da_forca, _, _], [_, _, _, _, tres_ou_mais, _, _], S),

    % 9. Uva está à direita da mochila azul
    a_direita([_, _, _, _, _, _, uva], [_, azul, _, _, _, _, _], S),

    % 10. Biologia = morango
    member([_, _, _, _, _, biologia, morango], S),

    % 11. Janeiro ao lado de setembro
    ao_lado([_, _, _, janeiro, _, _, _], [_, _, _, setembro, _, _, _], S),

    % 12. Uva exatamente à esquerda de Português
    nextto([_, _, _, _, _, _, uva], [_, _, _, _, _, portugues, _], S),

    % 13. Matemática = dezembro
    member([_, _, _, dezembro, _, matematica, _], S),

    % 14. Prob. de Lógica ao lado da mochila amarela
    ao_lado([_, _, _, _, prob_logica, _, _], [_, amarela, _, _, _, _, _], S),

    % 15. Mochila azul = janeiro
    member([_, azul, _, janeiro, _, _, _], S),

    % 16. Setembro ao lado de Cubo Vermelho
    ao_lado([_, _, _, setembro, _, _, _], [_, _, _, _, cubo_vermelho, _, _], S),

    % 17. Primeira posição = limão
    member([1, _, _, _, _, _, limao], S),

    % 18. Matemática = maracujá
    member([_, _, _, _, _, matematica, maracuja], S),

    % 19. Lenin na quinta posição
    member([5, _, lenin, _, _, _, _], S).

ao_lado(X, Y, Lista) :-
    nextto(X, Y, Lista);
    nextto(Y, X, Lista).

a_esquerda(X, Y, Lista) :-
    nth1(PX, Lista, X),
    nth1(PY, Lista, Y),
    PX < PY.

a_direita(X, Y, Lista) :-
    nth1(PX, Lista, X),
    nth1(PY, Lista, Y),
    PX > PY.

imprime([]).
imprime([H|T]) :-
    write(H), nl,
    imprime(T).
