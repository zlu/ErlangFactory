-module(more_list).
-export([filter/2, filter2/2, reverse/1, concatenate/1, concate/2, cone/1, conc/1]).

filter([], _Int) -> [];
filter([H | T], Int) when H =< Int -> [H | filter(T, Int)]; 
filter([H | T], Int) when H > Int -> filter(T, Int). 

filter2([], _Int) -> [];
filter2([H | T], Int) when H > Int -> [H | filter2(T, Int)]; 
filter2([H | T], Int) when H =< Int -> filter2(T, Int).
 
reverse(List) -> reverse(List, []).
reverse([], Accumulator) -> Accumulator;
reverse([H | T], Accumulator) -> reverse(T, [H | Accumulator]).

concatenate([]) -> [];
concatenate([H | T]) -> concate(H, T).

concate([H | T], Rest) -> [H | concate(T, Rest)];
concate([], Rest) -> concatenate(Rest).

cone([]) -> [];
cone([[H | T] | T1]) -> [H | cone([T | T1)];
cone([[] | T]) -> cone(T).

conc([]) -> [];
conc([L|LS]) -> conc(L, conc(LS));
conc([H|T], Tail) -> [H | conc(T, Tail)];
conc([], Tail) -> Tail.

