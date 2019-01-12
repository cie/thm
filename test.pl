:- discontiguous(test/2).

% utils
result(A, B):- if(A, B=true, B=fail).
has_solutions(A) :- findall(dummy, A, Solutions), Solutions \= [].

% main
:- initialization(main).
main:-
  forall(test(Goal, Res),
    (if(result(has_solutions(Goal), Res), Ok=ok, Ok='NOK'), print(Ok), print(' '), print(Goal), nl)
  ),
  halt.
