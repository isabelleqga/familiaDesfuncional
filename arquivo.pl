% Fatos iniciais
child(redhair, widow).
child(i, dad).
child(onrun, dad).
child(baby, i).

male(i).
male(dad).
male(onrun).
male(baby).

female(redhair).
female(widow).

spouse(i, widow).
spouse(widow, i).
spouse(dad, redhair).
spouse(redhair, dad).


% Regras
son(X, Y) :- 
male(X), % X é homem
(
(child(X,Y)) ; % X é filho de Y
(spouse(Y, Z), child(X,Z)) ; % X é filho do spouse de Y
(child(C, Y), spouse(C,X)) ; % X é casado com o filho de Y
(child(D,Z), spouse(D,X), spouse(Y,Z)) % X é casado com o filho do spouse de Y
).

daughter(X, Y) :- 
female(X), % X é mulher
(
(child(X,Y)) ; % X é filha de Y
(spouse(Y, Z), child(X,Z)) ; % X é filha do spouse de Y
(child(C, Y), spouse(C,X)) ; % X é casada com o filho de Y
(child(D,Z), spouse(D,X), spouse(Y,Z)) % X é casada com o filho do spouse de Y
).

father(X, Y) :- 
male(X), % X é homem
(son(Y,X) ; daughter(Y,X)). % Y é filhx de X

mother(X, Y) :- 
female(X), % X é mulher
(son(Y,X) ; daughter(Y,X)). % Y é filhx de X

brother(X, Y) :- 
son(X, A), % X é filho de A
(son(Y,A); daughter(Y,A)), % Y é filhx de A
not(X = Y). % X é diferente de Y

sister(X, Y) :- 
daughter(X, A), % X é filha de A
(son(Y,A); daughter(Y,A)), % Y é filhx de A
not(X = Y). % X é diferente de Y

uncle(X, Y) :- 
male(X), brother(X,A), % X é homem e é irmão de A
(son(Y,A); daughter(Y,A)). % Y é filhx de A

aunt(X, Y) :- 
female(X), sister(X,A), % X é mulher e é irmã de A
(son(Y,A); daughter(Y,A)). % Y é filhx de A

grandchild(X, Y) :- 
(son(X, A); daughter(X, A)), % X é filhx de A
(son(A, Y); daughter(A, Y)). % A é filhx de Y

grandfather(X, Y) :- 
male(X), % X é homem
grandchild(Y,X). % Y é netx de X

grandmother(X, Y) :- 
female(X), % X é mulher
grandchild(Y,X). % Y é netx de X

uncles(Resp) :-
setof((X,Y), uncle(X,Y), Resp).

aunts(Resp) :-
setof((X,Y), aunt(X,Y), Resp).


