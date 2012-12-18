-module(arithm).

-export([
	add/2,
	subtract/2,
	multiply/2,
	divide/2,
	equal/2,
	is_zero/1,
	project/1,
	drop/1
]).

%% ===================================================================
%% API
%% ===================================================================

add(X, Y) ->
	generic:apply_generic('add', [X, Y]).

subtract(X, Y) ->
	generic:apply_generic('subtract', [X, Y]).

multiply(X, Y) ->
	generic:apply_generic('multiply', [X, Y]).

divide(X, Y) ->
	generic:apply_generic('divide', [X, Y]).

equal(X, Y) ->
	generic:apply_generic('equal', [X, Y]).

is_zero(X) ->
	generic:apply_generic('is_zero', [X]).

project(X) ->
	generic:apply_generic('project', [X]).

drop(X) ->
	generic:drop(X).
