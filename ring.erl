-module(ring).
-export([create/3, loop/0, start/4, start_send/1]).

create(0, M, Pids) -> 
    io:format("~p~n", [Pids]),
    [StartPid | _] = Pids,
    start(M, Pids, Pids, StartPid);
create(N, M, Pids) -> 
    Pid = spawn(ring, loop, []),
    create(N-1, M, [Pid | Pids]).
    
loop() ->
    receive
	{Msg, [], StartPid} ->
	    io:format("~p~p~n", [self(), StartPid]),
	    StartPid ! Msg;
	{Msg, [NextPid | Rest], StartPid} ->
	    io:format("~p~p~p~p~n", [self(), NextPid, Rest, Msg]),
	    NextPid ! {Msg, Rest, StartPid},
	    loop();
	{quit, []} ->
	    io:format("~p~p~n", [quitting, self()]),
	    true;
	{quit, [NextPid | Rest]} ->
	    io:format("~p~p~n", [quitting, self()]),
	    NextPid ! {quit, Rest},
	    true
    end.

start(0, _, [_|Pids], StartPid) -> StartPid ! {quit, Pids};
start(M, Pids, Pids, StartPid) ->
    start_send(Pids),
    start(M-1, Pids, Pids, StartPid).
    
start_send([StartPid | Rest]) -> 
    StartPid ! {message, Rest, StartPid}.
	   
