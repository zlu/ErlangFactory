-module(echo).
-export([start/0, stop/0, print/1, loop/0]).

loop() ->
    receive
	{print, Msg} ->
	    io:format("~p~n", [Msg]),
	    loop();
	stop ->
	    true
    end.

start() ->
    register(echo, spawn(echo, loop, [])),
    ok.
    
stop() ->
    echo ! stop,
    ok.

print(Term) ->
    echo ! {print, Term},
    ok.

