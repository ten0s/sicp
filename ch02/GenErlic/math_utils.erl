-module(math_utils).

-export([
	equal/2,
	equal/3,
	floor/1
]).

-spec equal(number(), number()) -> boolean().
equal(X, Y) when is_integer(X) andalso is_integer(Y) ->
	X =:= Y;
equal(X, Y) when is_number(X) andalso is_number(Y) ->
	equal(X, Y, 5).

-spec equal(number(), number(), pos_integer()) -> boolean().
equal(X, Y, Eps) when is_number(X) andalso is_number(Y) andalso is_integer(Eps) ->
	Mult = round(math:pow(10, Eps)),
	XM = round(X * Mult),
	YM = round(Y * Mult),
	XM =:= YM.

-spec floor(number()) -> integer().
floor(Float) when is_float(Float) ->
	list_to_integer(
		lists:takewhile(
			fun(C) -> C =/= $. end,
			float_to_list(Float)
		)
	).
