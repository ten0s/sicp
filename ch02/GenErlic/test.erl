-module(test).

-compile(export_all).

-include_lib("eunit/include/eunit.hrl").

-define(setup(F), {setup, fun setup/0, fun teardown/1, F}).

setup() ->
	complex_polar:install(),
	complex_rectangular:install(),

	arithm_integer:install(),
	arithm_rational:install(),
	arithm_real:install(),
	arithm_complex:install().

teardown(_) ->
	%table:clear().
	ok.

complex_test_() ->
	?setup(
		fun(_) ->
			Z1 = complex:make_from_real_img(1, 2),
			Z2 = complex:make_from_mag_ang(complex:magnitude(Z1), complex:angle(Z1)),
			Z3 = complex:add(Z1, Z2),
			Z0 = complex:make_from_real_img(0, 0),
			[
				?_assertEqual(1, complex:real_part(Z1)),
				?_assertEqual(2, complex:img_part(Z1)),

				?_assert(math_utils:equal(1, complex:real_part(Z2))),
				?_assert(math_utils:equal(2, complex:img_part(Z2))),

				?_assert(math_utils:equal(2, complex:real_part(Z3))),
				?_assert(math_utils:equal(4, complex:img_part(Z3))),

				?_assert(complex:equal(Z1, Z2)),
				?_assertNot(complex:equal(Z1, Z3)),

				?_assert(complex:is_zero(Z0)),
				?_assertNot(complex:is_zero(Z1))
			]
		end
	).

arithm_complex_test_() ->
	?setup(
		fun(_) ->
			Z1 = arithm_complex:make_from_real_img(1, 2),
			Z2 = arithm_complex:make_from_mag_ang(complex:magnitude(Z1), complex:angle(Z1)),
			Z3 = arithm:add(Z1, Z2),
			Z0 = arithm_complex:make_from_real_img(0, 0),
			[
				?_assertEqual(1, complex:real_part(Z1)),
				?_assertEqual(2, complex:img_part(Z1)),

				?_assert(math_utils:equal(1, complex:real_part(Z2))),
				?_assert(math_utils:equal(2, complex:img_part(Z2))),

				?_assert(math_utils:equal(2, complex:real_part(Z3))),
				?_assert(math_utils:equal(4, complex:img_part(Z3))),

				?_assert(complex:equal(Z1, Z2)),
				?_assertNot(complex:equal(Z1, Z3)),

				?_assert(complex:is_zero(Z0)),
				?_assertNot(complex:is_zero(Z1))
			]
		end
	).

arithm_number_test_() ->
	?setup(
		fun(_) ->
			Three = arithm:add(1, 2),
			False = arithm:equal(3, 4),
			True = arithm:equal(1, 1),
			Zero = arithm:is_zero(0),
			NotZero = arithm:is_zero(0.00001),
			[
				?_assertEqual(3, Three),
				?_assertNot(False),
				?_assert(True),
				?_assert(Zero),
				?_assertNot(NotZero)
			]
		end
	).

arithm_rational_test_() ->
	?setup(
		fun(_) ->
			Z0 = arithm_rational:make(0, 1),
			Z1 = arithm_rational:make(1, 1),
			Z2 = arithm_rational:make(4, 2),
			Z3 = arithm:add(Z1, Z0),

			NotEqual = arithm:equal(Z1, Z2),
			Equal = arithm:equal(Z1, Z3),

			Zero = arithm:is_zero(Z0),
			NotZero = arithm:is_zero(Z1),
		[
			?_assertNot(NotEqual),
			?_assert(Equal),
			?_assert(Zero),
			?_assertNot(NotZero)
		]
		end
	).

arithm_types_tower_test_() ->
	?setup(
		fun(_) ->
			Z1 = arithm_complex:make_from_real_img(1.0, 2.0),
			Z2 = arithm:add(Z1, 3),
			Z3 = arithm:add(3.0, Z1),
			Equal = arithm:equal(Z2, Z3),

			R1 = arithm_rational:make(2, 3),
			R2 = arithm:add(R1, 1),

			F = arithm:add(1.0, R1),

			_Z4 = arithm:add(R1, Z1),
			_R4 = arithm:add(1.0, 2),

			[
				?_assert(Equal),
				?_assertEqual(5, arithm_rational:numer(R2)),
				?_assertEqual(3, arithm_rational:denom(R2)),
				?_assert(math_utils:equal(1.666666, F))
			]
		end
	).

arithm_project_test_() ->
	?setup(
		fun(_) ->
			Z = arithm_complex:make_from_real_img(1.5, 0),
			R = arithm_real:make(1.5),
			Rat = arithm_rational:make(3,2),
			I = arithm_integer:make(2),

			ZR = arithm:project(Z),
			RI = arithm:project(R),
			RatI = arithm:project(Rat),
			II = arithm:project(I),

			[
				?_assertEqual(1.5, ZR),
				?_assertEqual(1, RI),
				?_assertEqual(1, RatI),
				?_assertEqual(2, II)
			]
		end
	).

arithm_drop_test_() ->
	?setup(
		fun(_) ->
			Int = arithm_integer:make(1),
			One = arithm:drop(Int),

			Rat = arithm_rational:make(3,2),
			RatEqual = arithm:equal(Rat, arithm:drop(Rat)),

			Rat2 = arithm_rational:make(2,1),
			Two = arithm:drop(Rat2),

			Real = arithm_real:make(2.5),
			RealEqual = arithm:equal(Real, arithm:drop(Real)),

			Real2 = arithm_real:make(3.0),
			Three = arithm:drop(Real2),

			Z1 = arithm_complex:make_from_real_img(2, 3),
			ZEqual = arithm:equal(Z1, arithm:drop(Z1)),

			Z2 = arithm_complex:make_from_real_img(3.5, 0),
			ThreePointFive = arithm:drop(Z2),

			Z3 = arithm_complex:make_from_real_img(4, 0),
			Four = arithm:drop(Z3),

			[
				?_assertEqual(1, One),
				?_assert(RatEqual),
				?_assertEqual(2, Two),
				?_assert(RealEqual),
				?_assertEqual(3, Three),
				?_assert(ZEqual),
				?_assertEqual(3.5, ThreePointFive),
				?_assertEqual(4, Four)
			]
		end
	).
