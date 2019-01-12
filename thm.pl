:- op(1150, xfy, '=>').
:- op(1100, xfy, or).
:- op(1000, xfy, and).
:- op(700, xfy, in).
:- op(900, fy, not).
:- discontiguous(prove/1).
:- discontiguous(axiom/1).
:- dynamic(seen/1).
:- dynamic(trying/1).
:- dynamic(using/1).

% utils
if(A, Then, Else) :- A, !, Then; Else.
assume(A) :- if(A, true, (asserta(A); retractall(A), fail)).

trivial(X) :- axiom(X).
trivial(X) :- seen(X).

%prove(_) :- statistics(global_shifts, N), write(N), (N > 10 -> !, fail).
%prove(X) :- write(X), fail.
prove(X) :- axiom(X).

follows(X) :- seen(X), !; prove(X), !, assume(seen(X))
%; write(X), write(' failed'), nl, fail
.   

% =
axiom(X = X).
prove(X = Y) :- trivial(Y = X). % axiom(X = Y if Y = X)
% substitute sub-expressions by =
prove(X) :- substitute_trivials(X, X2), \+ trying(X2), assume(trying(X)), prove(X2).
substitute_trivials(X, X2) :- X =.. [_, _, _], substitute_arg(X, X2).
substitute_trivials(not(X), not(X2)) :- X =.. [_, _, _], substitute_arg(X, X2).
substitute_arg(X, X2) :- X =.. [F | Args], substitute_member(Args, Args2), X2 =.. [F | Args2].
substitute_member([H | T], [H2 | T]) :- trivially_equal(H, H2), H \= H2.
substitute_member([H | T], [H | T2]) :- substitute_member(T, T2).
%trivially_equal(A, B) :- write(A=B), fail.
trivially_equal(A, B) :- trivial(A = B).%, \+ using(A = B), assume(using(A = B)).
trivially_equal(B, A) :- trivial(A = B).%, \+ using(A = B), assume(using(A = B)).

% and, or
prove((X and Y)) :- prove(X), prove(Y).
prove((X or Y)) :- prove(X); prove(Y).

% =>
prove(B) :- trivial(A => B), prove(A).
%prove(A => B) :- prove(not(B and not(A)))prove(A). % TODO

