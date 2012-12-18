-module(complex_polar).

-export([
	make_from_real_img/2,
	make_from_mag_ang/2,
	real_part/1,
	img_part/1,
	magnitude/1,
	angle/1
]).

-export([install/0]).

%% ===================================================================
%% API
%% ===================================================================

make_from_real_img(Real, Imaginary) ->
	{
		math:sqrt(Real * Real + Imaginary * Imaginary),
		math:atan2(Imaginary, Real)
	}.

make_from_mag_ang(Magnitude, Angle) ->
	{Magnitude, Angle}.

real_part(Z) ->
	magnitude(Z) * math:cos(angle(Z)).

img_part(Z) ->
	magnitude(Z) * math:sin(angle(Z)).

magnitude({Magnitude, _}) ->
	Magnitude.

angle({_, Angle}) ->
	Angle.

%% ===================================================================
%% Install
%% ===================================================================

install() ->
	generic:set_method('real_part', ['polar'], fun real_part/1),
	generic:set_method('img_part', ['polar'], fun img_part/1),
	generic:set_method('magnitude', ['polar'], fun magnitude/1),
	generic:set_method('angle', ['polar'], fun angle/1),
	generic:set_method('make_from_real_img', 'polar',
		fun(X, Y) ->
			generic:attach_tag('polar', make_from_real_img(X, Y))
		end
	),
	generic:set_method('make_from_mag_ang', 'polar',
		fun(X, Y) ->
			generic:attach_tag('polar', make_from_mag_ang(X, Y))
		end
	).
