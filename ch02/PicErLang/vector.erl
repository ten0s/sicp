-module(vector).

-export([
	new/2,
	x/1,
	y/1,
	add/2,
	sub/2,
	scale/2
]).

-export_type([
	vector/0
]).

-opaque vector() :: {float(), float()}.

-spec new(float(), float()) -> vector().
new(X, Y) ->
	{X, Y}.

-spec x(vector()) -> float().
x({X, _}) ->
	X.

-spec y(vector()) -> float().
y({_, Y}) ->
	Y.

-spec add(vector(), vector()) -> vector().
add(V1, V2) ->
	new(x(V1) + x(V2), y(V1) + y(V2)).

-spec sub(vector(), vector()) -> vector().
sub(V1, V2) ->
	new(x(V1) - x(V2), y(V1) - y(V2)).

-spec scale(float(), vector()) -> vector().
scale(S, V) ->
	new(S * x(V), S * y(V)).
