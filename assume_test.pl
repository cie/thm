:- include(thm).
:- include(test).
:- dynamic(asdfg/1).
'test'(asdfg(asdf), fail).
'test'((assume(asdfg(asdf)), asdfg(asdf)), true).
'test'((assume(asdfg(asdf)), asdfg(ghjk)), fail).
'test'((asdfg(asdf)), fail).


