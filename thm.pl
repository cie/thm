:- initialization(main).

def(x, true).
def(y, false).
axiom(true).
axiom(not(false)).

proven(X is Y) :- def(X, Y).
proven(X is Y) :- def(Y, X).

proven(X) :- axiom(X).
proven(X) :- def(X, D), proven(D).
proven(not(X)) :- proven(X is false).

test(proven(true), true).
test(proven(x), true).
test(proven(false), fail).
test(proven(y), fail).
test(proven(not(y)), true).

if(A, Then, Else) :- A, !, Then; Else.
not(A):- if(A, fail, true).
forall(A, B) :- not((A, not(B))).
result(A, B):- if(A, B=true, B=fail).
main:-
  forall(test(Thm, Res),
    (if(result(Thm, Res), Ok=ok, Ok='NOK'), print(Ok), print(' '), print(Thm), nl)
  ),
  halt.
