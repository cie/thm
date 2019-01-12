:- include(thm).
:- include(test).
:- include(bool).
'test'(follows(true), true).
'test'(follows(false), fail).
'test'((follows(not(false))), true).
'test'(follows((true or false)), true).
'test'(follows((true and false)), fail).
'test'(follows((true and true)), true).
'test'(follows((true and true and true)), true).
