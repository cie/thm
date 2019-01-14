:- op(1150, xfy, '=>').
:- op(1100, xfy, or).
:- op(1000, xfy, and).
:- op(700, xfy, in).
:- op(900, fy, not).
:- discontiguous(axiom/1).
:- dynamic(seen/1).
:- dynamic(trying/1).
:- dynamic(using/1).
:- use_module(library(occurs)).

% utils
if(A, Then, Else) :- A, !, Then; Else.
assume(A) :- if(A, true, (asserta(A); retractall(A), fail)).
substitute(A, A, B, B).
substitute(X, A, B, X2) :-
  X =.. [F | Args],
  substitute_member(Args, U, V, Args2), 
  substitute(U, A, B, V),
  X2 =.. [F | Args2].
substitute_member([A | T], A, B, [B | T]).
substitute_member([H | T], A, B, [H | T2]) :- substitute_member(T, A, B, T2).

% proof
trivial(X) :- axiom(X).
trivial(X) :- seen(X).
follows(X) :- seen(X), !; prove(X, 2), !, assume(seen(X))
; write(X), write(' failed'), nl, fail
.   

% =
axiom(X = X).

%prove(X, _) :- write(X), fail.

% axiom
prove(X, _) :- axiom(X).
prove(X = Y, _) :- trivial(Y = X). % axiom(X = Y <=> Y = X)

% =
prove(X, _) :- trivial(Y), (trivial(A = B); trivial(B = A)), A \== B, substitute(X, A, B, Y).

% and, or
prove((X and Y), D) :- prove(X, D), prove(Y, D).
prove((X or Y), D) :- prove(X, D); prove(Y, D).

% =>
prove(B, D) :- trivial(A => B), prove(A, D).
%prove(A => B) :- prove(not(B and not(A)))prove(A). % TODO

