-module('etsdb').
-export([new/0, write/3, read/2, match/2, delete/2, destroy/1]).

new() -> ets:new(rec, [bag]).

write(Key, Element, DbRef) ->
    ets:insert(DbRef, {Key, Element}),
    DbRef.

read() ->
    
    
match(_Element, []) -> [];
match(Element, [{Key, Element} | T]) -> [Key | match(Element, T)];
match(Element, [{_Key, _} | T]) -> match(Element, T).

delete(_Key, []) -> [];
delete(Key, [{Key, _} | T]) -> delete(Key, T);
delete(Key, [{Key1, Element} | T]) -> [{Key1, Element} | delete(Key, T)].

destroy(DbRef) -> ets:delete(DbRef).
     
