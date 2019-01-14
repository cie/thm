:- include(thm).
:- include(test).
:- include(naturals).
'test'(follows((zero in naturals)), true).
'test'(follows((succ(succ(zero)) in naturals)), true).
'test'(follows(0 = zero), true).
'test'(follows(1 = succ(zero)), true).
'test'(follows(2 = succ(succ(zero))), true).
'test'(follows((0 in naturals)), true).
'test'((
  follows(succ(0) in naturals),
  follows(1 = succ(0)),
  follows(1 in naturals)
), true).
'test'((
  follows(succ(0) in naturals),
  follows(1 = succ(0)),
  follows(1 in naturals),
  follows(2 = succ(1)),
  follows(succ(1) in naturals),
  follows(2 in naturals)
), true).
'test'(follows((-1337 in naturals)), fail).
'test'(follows(not(0 = zero)), fail).
'test'((
  follows(1 = succ(0)),
  follows(not(1 = zero))
), true).
'test'((
  follows(1337 = succ(1336)),
  follows(not(1337 = zero))
), true).
'test'(follows(1 + zero = 1), true).
'test'(follows(1 + 0 = 1), true).
'test'((
  follows(1 + succ(0) = succ(1 + 0)),
  follows(1 + 0 = 1),
  follows(1 + succ(0) = succ(1)),
  follows(succ(0) = 1),
  follows(1 + 1 = succ(1)),
  follows(succ(1) = 2),
  follows(1 + 1 = 2)
), true).
