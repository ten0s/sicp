-module(generic).

-export([
	apply_generic/2,
	attach_tag/2,
	detach_tag/2,
	type_tag/1,
	contents/1,
	get_coersion/2,
	set_coersion/3,
	get_method/2,
	set_method/3,
	drop/1
]).

%% ===================================================================
%% API
%% ===================================================================

apply_generic(Method, Objs) ->
	TypeTags = lists:map(fun type_tag/1, Objs),
	case get_method(Method, TypeTags) of
		{ok, MethodFun} ->
			Contents = lists:map(fun contents/1, Objs),
			apply(MethodFun, Contents);
		{error, no_entry} ->
			case negotiate_types(TypeTags, Objs) of
				{ok, NewObjs} ->
					apply_generic(Method, NewObjs);
				{error, no_mapping} ->
					error({no_mapping, {Method, TypeTags}})
			end
	end.

attach_tag(_, Integer) when is_integer(Integer) ->
	Integer;
attach_tag(_, Real) when is_float(Real) ->
	Real;
attach_tag(TypeTag, Contents) ->
	{TypeTag, Contents}.

detach_tag(_, Integer) when is_integer(Integer) ->
	Integer;
detach_tag(_, Real) when is_float(Real) ->
	Real;
detach_tag(TypeTag, Object) ->
	{TypeTag, Contents} = Object,
	Contents.

get_coersion(Key1, Key2) ->
	table:get({coersion, Key1, Key2}).

set_coersion(Key1, Key2, Fun) ->
	table:set({coersion, Key1, Key2}, Fun).

get_method(Key1, Key2) ->
	table:get({method, Key1, Key2}).

set_method(Key1, Key2, Fun) ->
	table:set({method, Key1, Key2}, Fun).


%% ===================================================================
%% Internal
%% ===================================================================

type_tag(Integer) when is_integer(Integer) ->
	'integer';
type_tag(Real) when is_float(Real) ->
	'real';
type_tag({TypeTag, _Contents}) ->
	TypeTag.

contents(Integer) when is_integer(Integer) ->
	Integer;
contents(Real) when is_float(Real) ->
	Real;
contents({_TypeTag, Contents}) ->
	Contents.

negotiate_types(Types, Objs) ->
	case raise_left_type(Types, Objs) of
		{ok, NewObjs} ->
			{ok, NewObjs};
		{error, no_mapping} ->
			raise_right_type(Types, Objs)
	end.

raise_left_type([Type, Type], Objs) ->
	{ok, Objs};
raise_left_type([Type1, Type2], [Obj1, Obj2]) ->
	case get_method('raise', Type1) of
		{ok, RaiseFun} ->
			NewObj = RaiseFun(contents(Obj1)),
			NewType = type_tag(NewObj),
			raise_left_type([NewType, Type2], [NewObj, Obj2]);
		{error, no_entry} ->
			{error, no_mapping}
	end.

raise_right_type([Type, Type], Objs) ->
	{ok, Objs};
raise_right_type([Type1, Type2], [Obj1, Obj2]) ->
	case get_method('raise', Type2) of
		{ok, RaiseFun} ->
			NewObj = RaiseFun(contents(Obj2)),
			NewType = type_tag(NewObj),
			raise_right_type([Type1, NewType], [Obj1, NewObj]);
		{error, no_entry} ->
			{error, no_mapping}
	end.

drop(X) ->
	XType = generic:type_tag(X),
	case XType =:= 'integer' of
		true -> X;
		false ->
			X1 = apply_generic('project', [X]),
			X1Type = generic:type_tag(X1),
			{ok, RaiseFun} = generic:get_method('raise', X1Type),
			X2 = RaiseFun(X1),
			case apply_generic('equal', [X, X2]) of
				true -> drop(X1);
				false -> X
			end
	end.
