-module(table).

-export([
	set/2,
	get/1,
	clear/0
]).

-include_lib("stdlib/include/ms_transform.hrl").

-define(TABLE_ID, 'table_0d7e2554').

%% ===================================================================
%% API
%% ===================================================================

set(Key, Value) ->
	{ok, Server} = get_or_create_server(),
	Server ! {set, self(), Key, Value},
	receive
		ok -> ok
	after
		1000 ->
			{error, timeout}
	end.

get(Key) ->
	{ok, Server} = get_or_create_server(),
	Server ! {get, self(), Key},
	receive
		{ok, Value} ->
			{ok, Value};
		{error, no_entry} ->
			{error, no_entry}
	after
		1000 ->
			{error, timeout}
	end.

clear() ->
	case get_or_create_server() of
		{error, not_started} ->
			ok;
		{ok, Server} ->
			Server ! {stop, self()},
			receive
				ok -> ok
			after
				1000 ->
				{error, timeout}
			end
	end.

%% ===================================================================
%% Internal
%% ===================================================================

get_server() ->
	case whereis(?MODULE) of
		undefined ->
			{error, not_started};
		Server ->
			{ok, Server}
	end.

get_or_create_server() ->
	case get_server() of
		{ok, Server} ->
			{ok, Server};
		{error, not_started} ->
			Server = spawn(fun server_init/0),
			{ok, Server}
	end.

server_init() ->
	erlang:register(?MODULE, self()),
	Ets = ets:new(?TABLE_ID, [set, public]),
	server_loop(Ets).

server_loop(Ets) ->
	receive
		{set, ReplyTo, Key, Value} ->
			true = ets:insert(Ets, {Key, Value}),
			ReplyTo ! ok,
			server_loop(Ets);
		{get, ReplyTo, Key} ->
			Result = ets:select(Ets, ets:fun2ms(
				fun({K, V}) when K =:= Key -> V end
			)),
			Reply = case Result of
				[] ->
					{error, no_entry};
				[Value] ->
					{ok, Value}
			end,
			ReplyTo ! Reply,
			server_loop(Ets);
		{stop, ReplyTo} ->
			ReplyTo ! ok
	end.
