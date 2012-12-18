-module(painter).

-export([
	from_segments/1,
	transform_painter/4
]).

-type vector() :: vector:vector().
-type segment() :: segment:segment().
-type drawing() :: drawing:drawing().
-type frame() :: frame:frame().

-opaque painter() :: fun((drawing(), frame()) -> ok).

-spec from_segments([segment()]) -> painter().
from_segments(Segments) ->
	fun(Drawing, Frame) ->
		lists:foreach(
			fun(Segment) ->
				MapFun = frame_coord_map(Frame),
				Start = MapFun(segment:start(Segment)),
				Finish = MapFun(segment:finish(Segment)),
				drawing:draw_line(Drawing, Start, Finish)
			end,
			Segments
		)
	end.

-spec frame_coord_map(frame()) -> fun((vector()) -> vector()).
frame_coord_map(Frame) ->
	fun(Vector) ->
		vector:add(
			frame:origin(Frame),
			vector:add(
				vector:scale(vector:x(Vector), frame:edge1(Frame)),
				vector:scale(vector:y(Vector), frame:edge2(Frame))
			)
		)
	end.

-spec transform_frame(frame(), vector(), vector(), vector()) -> frame().
transform_frame(Frame, Origin, Edge1, Edge2) ->
	Map = frame_coord_map(Frame),
	NewOrigin = Map(Origin),
	frame:new(
		NewOrigin,
		vector:sub(Map(Edge1), NewOrigin),
		vector:sub(Map(Edge2), NewOrigin)
	).

-spec transform_painter(painter(), vector(), vector(), vector()) -> painter().
transform_painter(Painter, Origin, Edge1, Edge2) ->
	fun(Drawing, Frame) ->
		NewFrame = transform_frame(Frame, Origin, Edge1, Edge2),
		Painter(Drawing, NewFrame)
	end.
