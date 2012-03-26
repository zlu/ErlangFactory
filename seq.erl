-module('seq').
-export([sum/1]).
-export([sum_interval/2]).
-export([create/1]).
-export([reverse_create/1]).
-export([print/1, even_print/1]).

sum(0) -> 0;
sum(N) -> N + sum(N-1).

sum_interval(N, M) when N =< M ->
    sum(M) - sum(N) + N.

create(N) when N > 0 -> 
    create(N, []).
create(1, Accumulator) -> 
    [1 | Accumulator];
create(N, Accumulator) ->
    create(N-1, [N | Accumulator]).

reverse_create(1) -> 
    [1];
reverse_create(N) -> 
    [N | reverse_create(N-1)].

print(0) ->
    ok;
print(N) ->	    
    print(N-1),
    io:format("~p~n", [N]).

even_print(0) ->
    ok;
even_print(N) when N rem 2 == 0 ->
    even_print(N-1),
    io:format("~p~n", [N]);
even_print(N) when N rem 2 == 1 ->
    even_print(N-1).



