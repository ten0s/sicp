-module(pennies).

-compile(export_all).

result() ->
	Combinations = pennies:makeup(100, [50, 25, 10, 5, 1]),
	io:format("~w~n", [Combinations]).

makeup(Amount, Coins) ->
	Combinations = makeup(Amount, Coins, [], []),
	FixedCombinations = lists:map(fun lists:reverse/1, Combinations),
	lists:reverse(FixedCombinations).

makeup(Amount, [Max|Rest], Stack, Acc) ->
	Rem = Amount - Max,
	NewAcc =
		if
			Rem =:= 0 -> [[Max|Stack]|Acc];
			Rem < 0 -> Acc;
			Rem > 0 -> makeup(Rem, [Max|Rest], [Max|Stack], Acc)
		end,
	makeup(Amount, Rest, Stack, NewAcc);
makeup(_Amount, [], _Stack, Acc) ->
	Acc.
