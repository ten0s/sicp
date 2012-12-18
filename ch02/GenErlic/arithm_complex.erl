-module(arithm_complex).

-export([
	make_from_real_img/2,
	make_from_mag_ang/2
]).

-export([install/0]).

%% ===================================================================
%% API
%% ===================================================================

make_from_real_img(Real, Imaginary) ->
	tag(complex:make_from_real_img(Real, Imaginary)).

make_from_mag_ang(Magnitude, Angle) ->
	tag(complex:make_from_mag_ang(Magnitude, Angle)).

%% ===================================================================
%% Install
%% ===================================================================

install() ->
	generic:set_method('make', 'complex',
		fun(X) -> tag(X) end
	),

	generic:set_method('add', ['complex', 'complex'],
		fun(X, Y) -> tag(complex:add(X, Y)) end
	),
	generic:set_method('subtract', ['complex', 'complex'],
		fun(X, Y) -> tag(complex:subtract(X, Y)) end
	),
	generic:set_method('multiply', ['complex', 'complex'],
		fun(X, Y) -> tag(complex:multiply(X, Y)) end
	),
	generic:set_method('divide', ['complex', 'complex'],
		fun(X, Y) -> tag(complex:divide(X, Y)) end
	),
	generic:set_method('real_part', ['complex'], fun complex:real_part/1),
	generic:set_method('img_part', ['complex'], fun complex:img_part/1),
	generic:set_method('magnitude', ['complex'], fun complex:magnitude/1),
	generic:set_method('angle', ['complex'], fun complex:angle/1),
	generic:set_method('equal', ['complex', 'complex'], fun complex:equal/2),
	generic:set_method('is_zero', ['complex'], fun complex:is_zero/0),
	generic:set_method('project', ['complex'], fun project/1).

tag(X) ->
	generic:attach_tag('complex', X).

project(Z) ->
	arithm_real:make(complex:real_part(Z)).
