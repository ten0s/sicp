-module(test).

-compile(export_all).

draw_all() ->
	Draws = [
		fun draw_wave/0,
		fun draw_wave2/0,
		fun draw_wave4/0,
		fun draw_right_split_wave/0,
		fun draw_corner_split_wave/0,
		fun draw_square_limit_wave/0
	],
	[Draw() || Draw <- Draws].

draw_wave() ->
	draw(painters:wave(), "wave.png").

draw_wave2() ->
	draw(painters:wave2(), "wave2.png").

draw_wave4() ->
	draw(painters:wave4(), "wave4.png").

draw_right_split_wave() ->
	draw(painters:right_split_wave(), "right_split_wave.png").

draw_corner_split_wave() ->
	draw(painters:corner_split_wave(), "corner_split_wave.png").

draw_square_limit_wave() ->
	draw(painters:square_limit_wave(), "square_limit_wave.png").

%% ===================================================================
%% Internal
%% ===================================================================

draw(Painter, Frame, Filename) ->
	{ok, Drawing} = drawing:start(Frame),
	Painter(Drawing, Frame),
	drawing:save(Drawing, Filename),
	drawing:stop(Drawing).

draw(Painter, Filename) ->
	Frame = frame:new(
		vector:new(0.0,0.0),
		vector:new(500.0,0.0),
		vector:new(0.0,500.0)
	),
	draw(Painter, Frame, Filename).

