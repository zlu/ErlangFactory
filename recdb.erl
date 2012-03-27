-module(recdb).
-include("rec.hrl").
-export([new/0, write/3, read/2, match/2, delete/2, destroy/1]).

new() ->
    [].

write(Key, Element, DbRef) ->
    [#person{name = Key, location = Element} | DbRef].

read(_Key, []) -> {error, instance};
read(Key, [#person{name=Key, location = Loc} | _]) -> {ok, Loc}; 
read(Key, [#person{name=_Key1, location = _} | T]) -> read(Key, T). 
    
match(_Key, []) ->
    {error, instance};
match(Element, [#person{name=Name, location = Element} | T]) -> [Name | match(Element, T)]; 
match(Element, [#person{name=_, location = _Element} | T]) -> match(Element, T).
    
delete(_Key, []) ->
    [];
delete(Key, [#person{name=Key, location=_} | T]) -> delete(Key, T);
delete(Key, [#person{name=_Key, location= Loc} | T]) ->
    [#person{name=_Key, location=Loc} | delete(Key, T)].

destroy(_DebRef) ->
    ok.
