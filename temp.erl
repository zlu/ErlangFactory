-module(temp).
-export([f2c/1]).
-export([c2f/1]).
-export([convert/1]).

f2c(F) ->
    5 * (F - 32) / 9.

c2f(C) ->
    9 * C / 5 + 32.

convert({f, Num}) ->
   {c, f2c(Num)};
convert({c, Num}) ->
   {f, c2f(Num)}.

