%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% File: mutex.erl
%%% @doc Design Patterns Exercise 2, A Mutex Semaphore
%%% @author trainers@erlang-solutions.com
%%% @copyright 1999-2011 Erlang Solutions Ltd.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-module(mutex).
%% Client Exports
-export([start/0, signal/0, wait/0]).
%% Internal Exports
-export([init/0]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Client Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% @doc Will start the mutex semaphore
-spec start() -> true.
start() ->
    register(mutex, spawn(mutex, init, [])).

%% @doc Initializes the state machine.
-spec init() -> no_return().
init() ->
    process_flag(trap_exit, true),
    free().

%% @doc Will free the semaphore currently held by the process
-spec signal() -> ok.
signal() ->
    mutex ! {signal, self()},
    ok.

%% @doc Will keep the process busy until the semaphore is available.
-spec wait() -> ok.
wait() ->
    mutex ! {wait, self()},
    receive
        ok -> ok 
    end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Finite State Machine
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% The state where the semaphore is available
-spec free() -> no_return().
free() ->
    receive
        {wait, Pid} ->
              Pid ! ok,
              busy(Pid)
    end.

%% The semaphore is taken by Pid. Pid is the only process which
%% may release it.
-spec busy(pid()) -> no_return().
busy(Pid) ->
    receive 
        {signal, Pid} -> free()
    end.

