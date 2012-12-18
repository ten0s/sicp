-module(rational).

-export([
	make/2,
	numer/1,
	denom/1
]).

%% ===================================================================
%% API
%% ===================================================================

make(Numer, Denom) when is_integer(Numer), is_integer(Denom) ->
	G = gcd(Numer, Denom),
	{round(Numer/G), round(Denom/G)}.

numer({Numer, _}) ->
	Numer.

denom({_, Denom}) ->
	Denom.

%% ===================================================================
%% Internal
%% ===================================================================

gcd(X, 0) ->
	X;
gcd(X, Y) ->
	gcd(Y, X rem Y).
