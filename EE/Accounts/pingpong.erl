%%% File    : pingpong.erl
%%% Author  :  <simon@erlang-consulting.com>, <martin@erlang-consulting.com>
%%% Description : Sends a message N times between two processes
%%% Created : Dec 2005 by  Simon Aurell and Martin Carlson

-module(pingpong).

%% Interface
-export([start/0, stop/0, send/1]).

%% Internal Exports
-export([init_a/0, init_b/0]).

start() ->
    register(a, spawn(pingpong, init_a, [])),
    register(b, spawn(pingpong, init_b, [])),
    ok.

stop() ->
    a ! stop,
    b ! stop.

send(N) ->
    a ! {msg, message, N},
    ok.

init_a() ->
    loop_a().

init_b() ->
    loop_b().

loop_a() ->
    receive
        stop ->
            ok;
        {msg, _Msg, 0} ->
            loop_a();
        {msg, Msg, N} ->
            io:format("ping...~n"),
            timer:sleep(500),
            b ! {msg, Msg, N -1},
            loop_a()
    after
        15000 ->
            io:format("Ping got bored, exiting.~n"),
            exit(timeout)
    end.

loop_b() ->
    receive
        stop ->
            ok;
        {msg, _Msg, 0} ->
            loop_b();
        {msg, Msg, N} ->
            io:format("pong!~n"),
            timer:sleep(500),
            a ! {msg, Msg, N -1},
            loop_b()
    after
        15000 ->
            io:format("Pong got bored, exiting.~n"),
            exit(timeout)
    end.

