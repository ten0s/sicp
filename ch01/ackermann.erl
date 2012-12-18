-module(ackermann).

-export([a/2]).

-spec a(integer(), integer()) -> integer().
a(_, 0) -> 0;
a(0, Y) -> 2*Y;
a(_, 1) -> 2;
a(X, Y) ->
	a(X-1, a(X, Y-1)).

