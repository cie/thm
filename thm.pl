:- initialization(main).
:- op(1000, xfy, and).
:- op(1100, xfy, or).
:- op(700, xfy, in).
:- discontiguous(test/2).
:- dynamic(proven/1).

def(x, true).
def(y, false).
axiom(true).
axiom(not(false)).
axiom((1 in integers)).

proven(X = Y) :- def(X, Y).
proven(X = Y) :- def(Y, X).

proven(X) :- axiom(X).
proven(X) :- def(X, D), proven(D).
proven((X and Y)) :- proven(X), proven(Y).
proven((X or Y)) :- proven(X); proven(Y).

test(proven(true), true).
test(proven(x), true).
test(proven(false), fail).
test(proven(y), fail).
test((Y = false, proven(not(Y))), true).
test(proven((x or y)), true).
test(proven((x and y)), fail).
test(proven((x and x)), true).
test(proven((1 in integers)), true).

if(A, Then, Else) :- A, !, Then; Else.
not(A):- if(A, fail, true).
forall(A, B) :- not((A, not(B))).
result(A, B):- if(A, B=true, B=fail).
assume(A, B) :- if(A, B, (asserta(A), if(B, (retractall(A), true), (retractall(A), fail)))).
test((proven(asdf)), fail).
test(assume(proven(asdf), proven(asdf)), true).
test(assume(proven(asdf), proven(ghjk)), fail).
test((proven(asdf)), fail).

main:-
  forall(test(Thm, Res),
    (if(result(Thm, Res), Ok=ok, Ok='NOK'), print(Ok), print(' '), print(Thm), nl)
  ),
  halt.
