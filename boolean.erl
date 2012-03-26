-module(boolean).
-export([b_not/1]).
-export([b_and/2]).
-export([b_or/2]).

b_not(true) ->
    false;
b_not(false) ->
    true.

b_and(true, true) ->
    true;
b_and(_, _) ->
    false.

b_or(false, false) ->
    false;
b_or(_, _) ->
    true.









