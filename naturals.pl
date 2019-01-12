axiom(zero in naturals).
axiom(X in naturals => succ(X) in naturals).
axiom(0 = zero).
axiom(N = succ(K)) :- integer(N), N > 0, N0 is N-1, prove(N0 = K).
axiom(not(succ(_) = 0)).
%axiom(A + 0 = A).
%axiom(A + succ(B) = succ(A + B)).
