-module(complex_rectangular).

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
	{Real, Imaginary}.

make_from_mag_ang(Magnitude, Angle) ->
	{
		Magnitude * math:cos(Angle),
		Magnitude * math:sin(Angle)
	}.

real_part({Real, _}) ->
	Real.

img_part({_, Imaginary}) ->
	Imaginary.

magnitude(Z) ->
	math:sqrt(
		math:pow(real_part(Z), 2) +
		math:pow(img_part(Z), 2)
	).

angle(Z) ->
	math:atan2(
		img_part(Z), real_part(Z)
	).

%% ===================================================================
%% Install
%% ===================================================================

install() ->
	generic:set_method('real_part', ['rectangular'], fun real_part/1),
	generic:set_method('img_part', ['rectangular'], fun img_part/1),
	generic:set_method('magnitude', ['rectangular'], fun magnitude/1),
	generic:set_method('angle', ['rectangular'], fun angle/1),
	generic:set_method('make_from_real_img', 'rectangular',
		fun(X, Y) ->
			generic:attach_tag('rectangular', make_from_real_img(X, Y))
		end
	),
	generic:set_method('make_from_mag_ang', 'rectangular',
		fun(X, Y) ->
			generic:attach_tag('rectangular', make_from_mag_ang(X, Y))
		end
	).
