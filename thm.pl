:- initialization(main).

def(x, true).
axiom(true).

proven(X) :- axiom(X).
proven(X) :- def(X, D), proven(D).

main:-
  proven(x), print(ok), halt; print(not_ok), halt.
