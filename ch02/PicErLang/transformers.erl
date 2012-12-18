-module(transformers).

-export([
	beside/2,
	beside/3,
	below/2,
	below/3,

	identity/1,
	rotate90/1,
	rotate180/1,
	flip_vert/1,
	flip_horiz/1,
	flipped_pairs/1,
	flipped_pairs2/1,

	right_split/2,
	up_split/2,
	corner_split/2,
	square_limit/2,
	square_limit2/2
]).

-type painter() :: painter:painter().
-type transformer() :: fun((painter()) -> painter()).

-spec beside(painter(), painter()) -> painter().
beside(Painter1, Painter2) ->
	beside(Painter1, Painter2, 0.5).

-spec beside(painter(), painter(), pos_integer()) -> painter().
beside(Painter1, Painter2, S) ->
	fun(Drawing, Frame) ->
		Origin = frame:origin(Frame),
		Horiz = frame:edge1(Frame),
		Vert = frame:edge2(Frame),
		Painter1(
			Drawing,
			frame:new(
				Origin,
				vector:scale(S, Horiz),
				Vert
			)
		),
		Painter2(
			Drawing,
			frame:new(
				vector:add(Origin, vector:scale(S, Horiz)),
				vector:scale(1-S, Horiz),
				Vert
			)
		)
	end.

-spec below(painter(), painter()) -> painter().
below(Painter1, Painter2) ->
	below(Painter1, Painter2, 0.5).

-spec below(painter(), painter(), pos_integer()) -> painter().
below(Painter1, Painter2, S) ->
	fun(Drawing, Frame) ->
		Origin = frame:origin(Frame),
		Horiz = frame:edge1(Frame),
		Vert = frame:edge2(Frame),
		Painter1(
			Drawing,
			frame:new(
				vector:add(Origin, vector:scale(S, Vert)),
				Horiz,
				vector:scale(1-S, Vert)
			)
		),
		Painter2(
			Drawing,
			frame:new(
				Origin,
				Horiz,
				vector:scale(S, Vert)
			)
		)
	end.

-spec identity(painter()) -> painter().
identity(Painter) ->
	Painter.

%% rotate90(Painter) ->
%% 	fun(Drawing, Frame) ->
%% 		Origin = frame:origin(Frame),
%% 		Horiz = frame:edge1(Frame),
%% 		Vert = frame:edge2(Frame),
%% 		Painter(
%% 			Drawing,
%% 			frame:new(
%% 				vector:add(Origin, Horiz),
%% 				Vert,
%% 				vector:scale(-1, Horiz)
%% 			)
%% 		)
%% 	end.

-spec rotate90(painter()) -> painter().
rotate90(Painter) ->
	painter:transform_painter(
		Painter,
		vector:new(1.0,0.0),
		vector:new(1.0,1.0),
		vector:new(0.0,0.0)
	).

-spec rotate180(painter()) -> painter().
rotate180(Painter) ->
	rotate90(rotate90(Painter)).

-spec flip_vert(painter()) -> painter().
flip_vert(Painter) ->
	painter:transform_painter(
		Painter,
		vector:new(0.0,1.0),
		vector:new(1.0,1.0),
		vector:new(0.0,0.0)
	).

-spec flip_horiz(painter()) -> painter().
flip_horiz(Painter) ->
	painter:transform_painter(
		Painter,
		vector:new(1.0,0.0),
		vector:new(0.0,0.0),
		vector:new(1.0,1.0)
	).

-spec flipped_pairs(painter()) -> painter().
flipped_pairs(Painter) ->
	Painter2 = beside(Painter, flip_vert(Painter)),
	below(Painter2, Painter2).

-spec right_split(painter(), pos_integer()) -> painter().
right_split(Painter, 0) ->
	Painter;
right_split(Painter, N) ->
	Smaller = right_split(Painter, N-1),
	beside(Painter, below(Smaller, Smaller)).

-spec up_split(painter(), pos_integer()) -> painter().
up_split(Painter, 0) ->
	Painter;
up_split(Painter, N) ->
	Smaller = up_split(Painter, N-1),
	below(Painter, beside(Smaller, Smaller)).

-spec corner_split(painter(), pos_integer()) -> painter().
corner_split(Painter, 0) ->
	Painter;
corner_split(Painter, N) ->
	Up = up_split(Painter, N-1),
	Right = right_split(Painter, N-1),
	TopLeft = beside(Up, Up),
	BottomRight = below(Right, Right),
	Corner = corner_split(Painter, N-1),
	beside(
		below(Painter, TopLeft),
		below(BottomRight, Corner)
	).

-spec square_limit(painter(), pos_integer()) -> painter().
square_limit(Painter, N) ->
	Quarter = corner_split(Painter, N),
	Half = beside(flip_horiz(Quarter), Quarter),
	below(flip_vert(Half), Half).

-spec square_of_four(
	transformer(), transformer(),
	transformer(), transformer()
) -> painter().
square_of_four(TL, TR, BL, BR) ->
	fun(Painter) ->
		Top = beside(TL(Painter), TR(Painter)),
		Bottom = beside(BL(Painter), BR(Painter)),
		below(Top, Bottom)
	end.

flipped_pairs2(Painter) ->
	Combine4 = square_of_four(
		fun identity/1, fun flip_vert/1,
		fun identity/1, fun flip_vert/1
	),
	Combine4(Painter).

square_limit2(Painter, N) ->
	Combine4 = square_of_four(
		fun flip_horiz/1, fun identity/1,
		fun rotate180/1, fun flip_vert/1
	),
	Combine4(corner_split(Painter, N)).
