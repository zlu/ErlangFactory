-module('db').
-export([new/0, write/3, read/2, match/2, delete/2, destroy/1]).

new() -> [].

write(Key, Element, []) -> [{Key, Element}];
write(Key, Element, [{Key, _E} | T]) -> [{Key, Element} | T];
write(Key, Element, [{Key1, V} | T]) -> [{Key1, V} | write(Key, Element, T)].

read(_Key, []) -> {error, instance};
read(Key, [{Key, V} | _]) -> {ok, V};
read(Key, [{_, _} | T]) -> read(Key, T).

match(_Element, []) -> [];
match(Element, [{Key, Element} | T]) -> [Key | match(Element, T)];
match(Element, [{_Key, _} | T]) -> match(Element, T).

delete(_Key, []) -> [];
delete(Key, [{Key, _} | T]) -> delete(Key, T);
delete(Key, [{Key1, Element} | T]) -> [{Key1, Element} | delete(Key, T)].

destroy(_DbRef) -> ok.
     
