-module(segment).

-export([
	new/2,
	start/1,
	finish/1
]).

-export_type([
	segment/0
]).

-type vector() :: vector:vector().
-opaque segment() :: {vector(), vector()}.

-spec new(vector(), vector()) -> segment().
new(Start, End) ->
	{Start, End}.

-spec start(segment()) -> vector().
start({Start, _}) ->
	Start.

-spec finish(segment()) -> vector().
finish({_, End}) ->
	End.
