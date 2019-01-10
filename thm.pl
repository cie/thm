:- op(1100, xfy, or).
:- op(1000, xfy, and).
:- op(700, xfy, in).
:- discontiguous(test/2).
:- discontiguous(prove/1).
:- discontiguous(axiom/1).
:- dynamic(seen/1).

trivial(X) :- axiom(X).
trivial(X) :- seen(X).

prove(X) :- trivial(X).

follows(X) :- seen(X), !; prove(X), !, assume(seen(X))
%; write(X), write(' failed'), nl, fail
.   

% true, false, not
axiom(true).
axiom(not(false)).
'test'(follows(true), true).
'test'(follows(false), fail).
'test'((follows(not(false))), true).

% =
axiom(X = X).
prove(X = Y) :- trivial(Y = X). % axiom(X = Y if Y = X)
'test'(follows(6 = 6), true).
'test'(follows(asdf = asdf), true).

% and, or
prove((X and Y)) :- prove(X), prove(Y).
prove((X or Y)) :- prove(X); prove(Y).
'test'(follows((true or false)), true).
'test'(follows((true and false)), fail).
'test'(follows((true and true)), true).
'test'(follows((true and true and true)), true).

% forall
prove(B) :- trivial(forall(A, B)), prove(A).

% in
prove(A in B) :- trivial(A = C), C \= A, prove(C in B).

% naturals
axiom((zero in naturals)).
axiom(forall(X in naturals, succ(X) in naturals)).
'test'(follows((zero in naturals)), true).
'test'(follows((succ(succ(zero)) in naturals)), true).
axiom(0 = zero).
axiom(N = succ(K)) :- integer(N), N > 0, N0 is N-1, prove(N0 = K).
'test'(follows(0 = zero), true).
'test'(follows(1 = succ(zero)), true).
'test'(follows(2 = succ(succ(zero))), true).
'test'(follows((2 in naturals)), true).
'test'(follows((10 in naturals)), true).
'test'(follows((1337 in naturals)), true).
'test'(follows((-1337 in naturals)), fail).


% utils
if(A, Then, Else) :- A, !, Then; Else.
not(A):- if(A, fail, true).
forall(A, B) :- not((A, not(B))).
result(A, B):- if(A, B=true, B=fail).
has_solutions(A) :- findall(dummy, A, Solutions), Solutions \= [].
assume(A) :- if(A, true, (asserta(A); retractall(A), fail)).
%:- dynamic(asdfg/1).
%'test'(asdfg(asdf), fail).
%'test'((assume(asdfg(asdf)), asdfg(asdf)), true).
%'test'((assume(asdfg(asdf)), asdfg(ghjk)), fail).
%'test'((asdfg(asdf)), fail).

% main
:- initialization(main).
main:-
  forall(test(Goal, Res),
    (if(result(has_solutions(Goal), Res), Ok=ok, Ok='NOK'), print(Ok), print(' '), print(Goal), nl)
  ),
  halt.
