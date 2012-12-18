-module(arithm_integer).

-export([
	make/1
]).

-export([install/0]).

%% ===================================================================
%% API
%% ===================================================================

make(X) when is_integer(X) ->
	tag(X).

%% ===================================================================
%% Install
%% ===================================================================

install() ->
	generic:set_method('make', 'integer',
		fun(X) when is_integer(X) -> tag(X) end
	),

	generic:set_method('raise', 'integer',
		fun(X) -> arithm_rational:make(X, 1) end
	),

	generic:set_method('add', ['integer', 'integer'],
		fun(X, Y) -> tag(X + Y) end
	),
	generic:set_method('subtract', ['integer', 'integer'],
		fun(X, Y) -> tag(X - Y) end
	),
	generic:set_method('multiply', ['integer', 'integer'],
		fun(X, Y) -> tag(X * Y) end
	),
	generic:set_method('divide', ['integer', 'integer'],
		fun(X, Y) -> tag(X / Y) end
	),
	generic:set_method('equal', ['integer', 'integer'],
		fun(X, Y) -> X =:= Y end
	),
	generic:set_method('is_zero', ['integer'],
		fun(X) -> X =:= 0 end
	),
	generic:set_method('project', ['integer'],
		fun(X) -> X end
	).

tag(X) ->
	generic:attach_tag('integer', X).
