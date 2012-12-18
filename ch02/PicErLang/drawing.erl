-module(drawing).

-export([
	start/1,
	stop/1,
	draw_line/3,
	save/2,

	loop/3
]).
-export_type([
	drawing/0
]).

-opaque drawing() :: any().

-type frame() :: frame:frame().
-type vector() :: vector:vector().

-spec start(frame()) -> {ok, drawing()}.
start(Frame) ->
	Origin = frame:origin(Frame),
	Edge1 = frame:edge1(Frame),
	Edge2 = frame:edge2(Frame),
	Width = round(vector:x(vector:add(Origin, vector:add(Edge1, Edge2)))) + 1,
	Height = round(vector:y(vector:add(Origin, vector:add(Edge1, Edge2)))) + 1,
	Image = egd:create(Width, Height),

	DrawingPid = erlang:spawn(?MODULE, loop, [Image, Width, Height]),
	{ok, DrawingPid}.

-spec stop(drawing()) -> ok.
stop(DrawingPid) ->
	DrawingPid ! {stop},
	ok.

-spec draw_line(drawing(), vector(), vector()) -> ok.
draw_line(DrawingPid, P1, P2) ->
	DrawingPid ! {draw_line, P1, P2},
	ok.

-spec save(drawing(), file:filename()) -> ok.
save(DrawingPid, Filename) ->
	DrawingPid ! {save, Filename},
	ok.

loop(Image, Width, Height) ->
	receive
		{stop} ->
			egd:destroy(Image);
		{draw_line, P1, P2} ->
			X1 = round(vector:x(P1)),
			Y1 = Height - round(vector:y(P1)) - 1,
			X2 = round(vector:x(P2)),
			Y2 = Height - round(vector:y(P2)) - 1,
			egd:line(Image, {X1, Y1}, {X2, Y2}, egd:color(black)),
			loop(Image, Width, Height);
		{save, Filename} ->
			Binary = egd:render(Image, png),
			egd:save(Binary, Filename),
			loop(Image, Width, Height)
	end.
