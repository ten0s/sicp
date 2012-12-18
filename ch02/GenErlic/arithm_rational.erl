-module(arithm_rational).

-export([
	make/2,
	numer/1,
	denom/1
]).

-export([install/0]).

%% ===================================================================
%% API
%% ===================================================================

make(Numer, Denom) when is_integer(Numer), is_integer(Denom) ->
	tag(rational:make(Numer, Denom)).

numer(R) ->
	generic:apply_generic('numer', [R]).

denom(R) ->
	generic:apply_generic('denom', [R]).

%% ===================================================================
%% Install
%% ===================================================================

install() ->
	generic:set_method('make', 'rational',
		fun(X) -> tag(X) end
	),
	generic:set_method('raise', 'rational',
		fun(X) ->
			Numer = rational:numer(X),
			Denom = rational:denom(X),
			arithm_real:make(Numer / Denom)
		end
	),

	generic:set_method('add', ['rational', 'rational'],
		fun(X, Y) -> tag(add(X, Y)) end
	),
	generic:set_method('subtract', ['rational', 'rational'],
		fun(X, Y) -> tag(subtract(X, Y)) end
	),
	generic:set_method('multiply', ['rational', 'rational'],
		fun(X, Y) -> tag(multiply(X, Y)) end
	),
	generic:set_method('divide', ['rational', 'rational'],
		fun(X, Y) -> tag(divide(X, Y)) end
	),
	generic:set_method('equal', ['rational', 'rational'], fun equal/2),
	generic:set_method('is_zero', ['rational'], fun is_zero/1),
	generic:set_method('project', ['rational'], fun project/1),

	generic:set_method('numer', ['rational'], fun rational:numer/1),
	generic:set_method('denom', ['rational'], fun rational:denom/1).

tag(X) ->
	generic:attach_tag('rational', X).

%% ===================================================================
%% Private
%% ===================================================================

add(X, Y) ->
	rational:make(
		rational:numer(X) * rational:denom(Y)
		+
		rational:numer(Y) * rational:denom(X)
		,
		rational:denom(X) * rational:denom(Y)
	).

subtract(X, Y) ->
	rational:make(
		rational:numer(X) * rational:denom(Y)
		-
		rational:numer(Y) * rational:denom(X)
		,
		rational:denom(X) * rational:denom(Y)
	).

multiply(X, Y) ->
	rational:make(
		rational:numer(X) * rational:numer(Y)
		,
		rational:denom(X) * rational:denom(Y)
	).

divide(X, Y) ->
	rational:make(
		rational:numer(X) * rational:denom(Y)
		,
		rational:denom(X) * rational:numer(Y)
	).

equal(X, Y) ->
	rational:numer(X) =:= rational:numer(Y) andalso
	rational:denom(X) =:= rational:denom(Y).

is_zero(X) ->
	rational:numer(X) =:= 0.

project(X) ->
	math_utils:floor(rational:numer(X) / rational:denom(X)).
