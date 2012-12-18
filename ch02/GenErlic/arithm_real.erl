-module(arithm_real).

-export([
	make/1
]).

-export([install/0]).

%% ===================================================================
%% API
%% ===================================================================

make(X) when is_integer(X) ->
	make(X * 1.0);
make(X) when is_float(X) ->
	tag(X).

%% ===================================================================
%% Install
%% ===================================================================

install() ->
	generic:set_method('make', 'real',
		fun(X) -> tag(X) end
	),

	generic:set_method('raise', 'real',
		fun(X) ->
			arithm_complex:make_from_real_img(X, 0)
		end
	),

	generic:set_method('add', ['real', 'real'],
		fun(X, Y) -> tag(X + Y) end
	),
	generic:set_method('subtract', ['real', 'real'],
		fun(X, Y) -> tag(X - Y) end
	),
	generic:set_method('multiply', ['real', 'real'],
		fun(X, Y) -> tag(X * Y) end
	),
	generic:set_method('divide', ['real', 'real'],
		fun(X, Y) -> tag(X / Y) end
	),
	generic:set_method('equal', ['real', 'real'],
		fun(X, Y) -> math_utils:equal(X, Y) end
	),
	generic:set_method('is_zero', ['real'],
		fun(X) -> math_utils:equal(X, 0) end
	),
	generic:set_method('project', ['real'],
		fun(X) -> math_utils:floor(X) end
	).

tag(X) ->
	generic:attach_tag('real', X).
