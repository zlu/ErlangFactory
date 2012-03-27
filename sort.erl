-module(sort).
-export([quick/1, merge/1]).

quick([]) -> [];
quick([Pivot | T]) ->
    quick(more_list:filter(T, Pivot)) ++ [Pivot] ++ quick(more_list:filter2(T, Pivot)).

merge([]) -> [];
merge() -> 
