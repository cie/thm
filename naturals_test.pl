:- include(thm).
:- include(test).
:- include(naturals).
'test'(follows((zero in naturals)), true).
'test'(follows((succ(succ(zero)) in naturals)), true).
'test'(follows(0 = zero), true).
'test'(follows(1 = succ(zero)), true).
'test'(follows(2 = succ(succ(zero))), true).
'test'(follows((0 in naturals)), true).
'test'(follows((1 in naturals)), true).
'test'(follows((2 in naturals)), true).
'test'(follows((10 in naturals)), true).
%'test'(follows((1337 in naturals)), true).  % TODO optimize?
'test'(follows((-1337 in naturals)), fail).
'test'(follows(not(0 = zero)), fail).
'test'(follows(not(1 = zero)), true).
'test'(follows(not(1337 = zero)), true).
'test'(follows(1 + zero = 1), true).
'test'(follows(1 + 0 = 1), true).
'test'((follows(1 + succ(zero) = succ(succ(zero) + zero)), follows(1 + 1 = succ(succ(zero))), follows(1 + 1 = 2)), true).
