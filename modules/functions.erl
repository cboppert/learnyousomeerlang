-module(functions).
-compile(export_all). % replace with export later

head([H|_]) -> H.

second([_,S,_]) -> S.

same(X,X) -> true;
same(_,_) -> false.

valid_time({Date = {Y,M,D}, Time = {H, Min, S}}) ->
   io:format("The Date tuple (~p) says today is: ~p/~p/~p,~n", [Date, Y, M, D]),
   io:format("The Time tuple (~p) says the time is: ~p:~p:~p~n", [Time, H, Min, S]);
valid_time(_) ->
   io:format("Bad date data.~n").

% to drive
old_enough(A) when A >= 16 -> true;
old_enough(_) -> false.


% Neat comma is andalso, semicolon is orelse
% can use andalso or orelse instead which allows for nesting
% but doesn't catch for errors
right_age(A) when A >= 16, A =< 104 -> true;
right_age(_) -> false.

wrong_age(A) when A < 16; A > 104 -> true;
wrong_age(_) -> false.
