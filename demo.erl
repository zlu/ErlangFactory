-module(demo).
-export([double/1]).

double(X) ->
    times(X, 2).

times(X, N) ->
    X * N.


