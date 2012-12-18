-module(painters).

-compile(export_all).

outline() ->
	Segments = [
		segment:new(vector:new(0.0,0.0), vector:new(1.0,0.0)),
		segment:new(vector:new(1.0,0.0), vector:new(1.0,1.0)),
		segment:new(vector:new(1.0,1.0), vector:new(0.0,1.0)),
		segment:new(vector:new(0.0,1.0), vector:new(0.0,0.0))
	],
	painter:from_segments(Segments).

y() ->
	Segments = [
		segment:new(vector:new(0.2,1.0), vector:new(0.5,0.5)),
		segment:new(vector:new(0.8,1.0), vector:new(0.5,0.5)),
		segment:new(vector:new(0.5,0.5), vector:new(0.5,0.0))
	],
	painter:from_segments(Segments).

x() ->
	Segments = [
		segment:new(vector:new(0.0,0.0), vector:new(1.0,1.0)),
		segment:new(vector:new(0.0,1.0), vector:new(1.0,0.0))
	],
	painter:from_segments(Segments).

diamond() ->
	Segments = [
		segment:new(vector:new(0.5,0.0), vector:new(1.0,0.5)),
		segment:new(vector:new(1.0,0.5), vector:new(0.5,1.0)),
		segment:new(vector:new(0.5,1.0), vector:new(0.0,0.5)),
		segment:new(vector:new(0.0,0.5), vector:new(0.5,0.0))
	],
	painter:from_segments(Segments).

wave() ->
	Segments = [
		segment:new(vector:new(0.0,0.8), vector:new(0.2,0.6)),
		segment:new(vector:new(0.2,0.6), vector:new(0.3,0.7)),
		segment:new(vector:new(0.3,0.7), vector:new(0.4,0.7)),
		segment:new(vector:new(0.4,0.7), vector:new(0.35,0.85)),
		segment:new(vector:new(0.35,0.85), vector:new(0.4,1.0)),
		segment:new(vector:new(0.4,1.0), vector:new(0.6,1.0)),
		segment:new(vector:new(0.6,1.0), vector:new(0.65,0.85)),
		segment:new(vector:new(0.65,0.85), vector:new(0.6,0.7)),
		segment:new(vector:new(0.6,0.7), vector:new(0.7,0.7)),
		segment:new(vector:new(0.7,0.7), vector:new(1.0,0.5)),
		segment:new(vector:new(1.0,0.5), vector:new(1.0,0.4)),
		segment:new(vector:new(1.0,0.4), vector:new(0.7,0.6)),
		segment:new(vector:new(0.7,0.6), vector:new(0.6,0.5)),
		segment:new(vector:new(0.6,0.5), vector:new(0.8,0.0)),
		segment:new(vector:new(0.8,0.0), vector:new(0.6,0.0)),
		segment:new(vector:new(0.6,0.0), vector:new(0.5,0.3)),
		segment:new(vector:new(0.5,0.3), vector:new(0.4,0.0)),
		segment:new(vector:new(0.4,0.0), vector:new(0.2,0.0)),
		segment:new(vector:new(0.2,0.0), vector:new(0.4,0.5)),
		segment:new(vector:new(0.4,0.5), vector:new(0.3,0.6)),
		segment:new(vector:new(0.3,0.6), vector:new(0.2,0.5)),
		segment:new(vector:new(0.2,0.5), vector:new(0.0,0.7)),
		segment:new(vector:new(0.0,0.7), vector:new(0.0,0.8))
	],
	painter:from_segments(Segments).

wave2() ->
	transformers:beside(wave(), transformers:flip_vert(wave())).

wave4() ->
	transformers:flipped_pairs(wave()).

right_split_wave() ->
	transformers:right_split(wave(), 4).

corner_split_wave() ->
	transformers:corner_split(wave(), 4).

square_limit_wave() ->
	transformers:square_limit(wave(), 4).
