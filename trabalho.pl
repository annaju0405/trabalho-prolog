% Anna Júlia Cúrcio Marques
% Flávio Oliveira Morais Leite
% Dérick Rangel Cordeiro de Oliveira

:- use_module(library(lists)).

% Fatos
mochila(amarela).
mochila(azul).
mochila(branca).
mochila(verde).
mochila(vermelha).

nome(denis).
nome(joao).
nome(lenin).
nome(otavio).
nome(will).

mes(agosto).
mes(dezembro).
mes(janeiro).
mes(maio).
mes(setembro).

jogo('3 ou Mais').
jogo('Caça Palavras').
jogo('Cubo Vermelho').
jogo('Jogo da Forca').
jogo('Prob. de Lógica').

materia(biologia).
materia(geografia).
materia(historia).
materia(matematica).
materia(portugues).

suco(laranja).
suco(limao).
suco(maracuja).
suco(morango).
suco(uva).




modelo(Alunos) :- 
    % criando a lista alunos
    Alunos = [
               aluno(Mochila_1, Nome_1, Mes_1, Jogo_1, Materia_1, Suco_1),
               aluno(Mochila_2, Nome_2, Mes_2, Jogo_2, Materia_2, Suco_2),
               aluno(Mochila_3, Nome_3, Mes_3, Jogo_3, Materia_3, Suco_3),
               aluno(Mochila_4, Nome_4, Mes_4, Jogo_4, Materia_4, Suco_4),
               aluno(Mochila_5, Nome_5, Mes_5, Jogo_5, Materia_5, Suco_5)
             ],
    
    % regras definitivas
    Suco_3 = morango,
    Suco_1 = limao,
    Nome_5 = lenin,
    (Jogo_1 = 'Cubo Vermelho' ; Jogo_5 = 'Cubo Vermelho'),
    (Nome_1 = otavio ; Nome_5 = otavio),
    Jogo_3 = 'Jogo da Forca',
    
    % regras de relação
    member(aluno(_, joao, _, _, historia, _), Alunos),
    member(aluno(_, _, _, 'Prob. de Lógica', _, uva), Alunos),
    member(aluno(_, _, _, _, biologia, morango), Alunos),
    member(aluno(_, _, dezembro, _, matematica, _), Alunos),
    member(aluno(azul, _, janeiro, _, _, _), Alunos),
    member(aluno(_, _, _, _, matematica, maracuja), Alunos),
    
    % regras de localização
    aoLado(aluno(_, _, setembro, _, _, _), aluno(_, _, _, _, _, laranja), Alunos),
    aEsquerda(aluno(azul, _, _, _, _, _), aluno(_, _, maio, _, _, _), Alunos),
    aoLado(aluno(_, will, _, _, _, _), aluno(_, _, _, 'Prob. de Lógica', _, _), Alunos),
    exatamenteEsquerda(aluno(branca, _, _, _, _, _), aluno(_, will, _, _, _, _), Alunos),
    aoLado(aluno(_, _, _, 'Jogo da Forca', _, _), aluno(_, _, _, '3 ou Mais', _, _), Alunos),
    aDireita(aluno(_, _, _, _, _, uva), aluno(azul, _, _, _, _, _), Alunos),
    aoLado(aluno(_, _, janeiro, _, _, _), aluno(_, _, setembro, _, _, _), Alunos),
    exatamenteEsquerda(aluno(_, _, _, _, _,uva), aluno(_, _, _, _, portugues, _), Alunos),
    aoLado(aluno(_, _, _, 'Prob. de Lógica', _, _), aluno(amarela, _, _, _, _, _), Alunos),
    aoLado(aluno(_, _, setembro, _, _, _), aluno(_, _, _, 'Cubo Vermelho', _, _), Alunos),
    aoLado(aluno(_, _, _, 'Jogo da Forca', _, _), aluno(vermelha, _, _, _, _, _), Alunos),
    
    %criando o domínio (mochilas)
    mochila(Mochila_1),
    mochila(Mochila_2),
    mochila(Mochila_3),
    mochila(Mochila_4),
    mochila(Mochila_5),
    %criando o domínio (nomes)
    nome(Nome_1),
    nome(Nome_2),
    nome(Nome_3),
    nome(Nome_4),
    nome(Nome_5),
    %criando o domínio (meses)
    mes(Mes_1),
    mes(Mes_2),
    mes(Mes_3),
    mes(Mes_4),
    mes(Mes_5),
    %criando o domínio (jogos)
    jogo(Jogo_1),
    jogo(Jogo_2),
    jogo(Jogo_3),
    jogo(Jogo_4),
    jogo(Jogo_5),
    %criando o domínio (jogos)
    materia(Materia_1),
    materia(Materia_2),
    materia(Materia_3),
    materia(Materia_4),
    materia(Materia_5),
    %criando o domínio (sucos)
    suco(Suco_1),
    suco(Suco_2),
    suco(Suco_3),
    suco(Suco_4),
    suco(Suco_5),
    
    % tornando único cada valor de um conjunto de domínios
    alldifferent([Mochila_1, Mochila_2, Mochila_3, Mochila_4, Mochila_5]),
    alldifferent([Nome_1, Nome_2, Nome_3, Nome_4, Nome_5]),
    alldifferent([Mes_1, Mes_2, Mes_3, Mes_4, Mes_5]),
    alldifferent([Jogo_1, Jogo_2, Jogo_3, Jogo_4, Jogo_5]),
    alldifferent([Materia_1, Materia_2, Materia_3, Materia_4, Materia_5]),
    alldifferent([Suco_1, Suco_2, Suco_3, Suco_4, Suco_5]).



% recursão do alldifferent
alldifferent([]).
alldifferent([H|T]) :- 
    not(member(H, T)),
    alldifferent(T).

% predicados auxilizares de localização
aoLado(X, Y, Lista) :-
    nextto(X, Y, Lista) ; nextto(Y, X, Lista).

aEsquerda(X, Y, Lista) :-
    nth0(IdX, Lista, X),         
    nth0(IdY, Lista, Y),  
    IdX < IdY.

aDireita(X, Y, Lista) :-
    nth0(IdX, Lista, X), 
    nth0(IdY, Lista, Y),
    IdX > IdY.

exatamenteEsquerda(X, Y, Lista) :-
    nth0(IdX, Lista, X), 
    nth0(IdY, Lista, Y),
    IdX =:= IdY - 1.    


% imprime a lista usando recursão
imprime_lista([]) :- nl, nl, write(' FIM do imprime_lista '), nl.
imprime_lista([H|T]) :-
 nl, write('......................................'), nl,
 write(H), write(' : '),
 imprime_lista(T).


main :-
    statistics(cputime, Inicio),
    modelo(Resultado),
    imprime_lista(Resultado),
	statistics(cputime, Fim),
    Tempo is Fim - Inicio,
    nl,
    format('Tempo de execucao: ~4f segundos~n', [Tempo]).
