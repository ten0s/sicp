-module(bank_account).

-compile(export_all).

-define(MAX_ALLOWED_INCORRECT_PASSWORDS, 7).

%% ===================================================================
%% API
%% ===================================================================

make_account(Password, Balance) ->
	Server = spawn(?MODULE, server, [Password, ?MAX_ALLOWED_INCORRECT_PASSWORDS, Balance]),
	fun(Message, Args) ->
		Server ! {Message, self(), Args},
		receive
			Whatever ->
				Whatever
		after
			1000 ->
				{error, timeout}
		end
	end.

withdraw(Account, Password, Amount) ->
	Account(withdraw, [Password, Amount]).

deposit(Account, Password, Amount) ->
	Account(deposit, [Password, Amount]).

%% ===================================================================
%% Internal
%% ===================================================================

server(Password, AllowedIncorrectPasswords, Balance) ->
	receive
		{withdraw, ReplyTo, [Passw, Amount]} ->
			{Result, NewAllowedIncorrectPasswords, NewBalance} =
				check_passw(
					Password, Passw, AllowedIncorrectPasswords, Balance,
					fun server_withdraw/2, [Balance, Amount]
				),
			ReplyTo ! Result,
			server(Password, NewAllowedIncorrectPasswords, NewBalance);
		{deposit, ReplyTo, [Passw, Amount]} ->
			{Result, NewAllowedIncorrectPasswords, NewBalance} =
				check_passw(
					Password, Passw, AllowedIncorrectPasswords, Balance,
					fun server_deposit/2, [Balance, Amount]
				),
			ReplyTo ! Result,
			server(Password, NewAllowedIncorrectPasswords, NewBalance)
	after
		60000 ->
			stopped
	end.

check_passw(Password, Passwd, AllowedIncorrectPasswords, Balance, Fun, Args) ->
	case Password =:= Passwd of
		true ->
			{Result, NewBalance} = apply(Fun, Args),
			{Result, AllowedIncorrectPasswords, NewBalance};
		false ->
			NewAllowedIncorrectPasswords = AllowedIncorrectPasswords - 1,
			case NewAllowedIncorrectPasswords =< 0 of
				true -> server_call_police();
				false -> noop
			end,
			{{error, incorrect_password}, NewAllowedIncorrectPasswords, Balance}
	end.

server_withdraw(Balance, Amount) ->
	case Balance >= Amount of
		true ->
			NewBalance = Balance - Amount,
			{{ok, NewBalance}, NewBalance};
		false ->
			{{error, insufficient_funds}, Balance}
	end.

server_deposit(Balance, Amount) ->
	NewBalance = Balance + Amount,
	{{ok, NewBalance}, NewBalance}.

server_call_police() ->
	io:format("Call the police!~n").
