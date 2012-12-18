-module(complex).

-export([
	make_from_real_img/2,
	make_from_mag_ang/2,

	real_part/1,
	img_part/1,
	magnitude/1,
	angle/1,

	add/2,
	subtract/2,
	multiply/2,
	divide/2,
	equal/2,
	is_zero/1
]).

%% ===================================================================
%% API
%% ===================================================================

make_from_real_img(Real, Imaginary) ->
	{ok, Fun} = generic:get_method('make_from_real_img', 'rectangular'),
	Fun(Real, Imaginary).

make_from_mag_ang(Magnitude, Angle) ->
	{ok, Fun} = generic:get_method('make_from_mag_ang', 'polar'),
	Fun(Magnitude, Angle).

real_part(Z) ->
	generic:apply_generic('real_part', [Z]).

img_part(Z) ->
	generic:apply_generic('img_part', [Z]).

magnitude(Z) ->
	generic:apply_generic('magnitude', [Z]).

angle(Z) ->
	generic:apply_generic('angle', [Z]).

add(Z1, Z2) ->
	make_from_real_img(
		real_part(Z1) + real_part(Z2),
		img_part(Z1) + img_part(Z2)
	).

subtract(Z1, Z2) ->
	make_from_real_img(
		real_part(Z1) - real_part(Z2),
		img_part(Z1) - img_part(Z2)
	).

multiply(Z1, Z2) ->
	make_from_mag_ang(
		magnitude(Z1) * magnitude(Z2),
		angle(Z1) + angle(Z2)
	).

divide(Z1, Z2) ->
	make_from_mag_ang(
		magnitude(Z1) / magnitude(Z2),
		angle(Z1) - angle(Z2)
	).

equal(Z1, Z2) ->
	math_utils:equal(
		real_part(Z1), real_part(Z2)
	) andalso
	math_utils:equal(
		img_part(Z1), img_part(Z2)
	).

is_zero(Z) ->
	math_utils:equal(
		real_part(Z), 0
	) andalso
	math_utils:equal(
		img_part(Z), 0
	).
