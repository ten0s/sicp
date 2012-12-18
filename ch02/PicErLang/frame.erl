-module(frame).

-export([
	new/3,
	origin/1,
	edge1/1,
	edge2/1
]).

-export_type([
	frame/0
]).

-type vector() :: vector:vector().
-opaque frame() :: {vector(), vector(), vector()}.

-spec new(vector(), vector(), vector()) -> frame().
new(Origin, Edge1, Edge2) ->
	{Origin, Edge1, Edge2}.

-spec origin(frame()) -> vector().
origin({Origin, _, _}) ->
	Origin.

-spec edge1(frame()) -> vector().
edge1({_, Edge1, _}) ->
	Edge1.

-spec edge2(frame()) -> vector().
edge2({_, _, Edge2}) ->
	Edge2.
