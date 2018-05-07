-module(hhfuns).
-compile(export_all).

one() -> 1.
two() -> 2.

add(X, Y) -> X() + Y().

increment([]) -> [];
increment([H|T]) -> [H + 1|increment(T)].

decrement([]) -> [];
decrement([H|T]) -> [H - 1|decrement(T)].

map(_, []) -> [];
map(F, [H|T]) -> [F(H)|map(F, T)].

incr(X) -> X + 1.
decr(X) -> X - 1.

even(L) when is_list(L) -> lists:reverse(even(L, [])).

even([], L) -> L;
even([H|T], L) when H rem 2 =:= 0 -> even(T, [H|L]);
even([H|T], L) when H rem 2 =/= 0 -> even(T, L).

old_men(L) -> old_men(L, []).

old_men([], L) -> L;
old_men([Person = {male, Age}|People], L) when Age > 60 -> old_men(People, [Person|L]);
old_men([_|People], L) -> old_men(People, L).

filter(Pred, L) -> lists:reverse(filter(Pred, L, [])).

filter(_, [], Acc) -> Acc;
filter(Pred, [H|T], Acc) ->
   case Pred(H) of
      true -> filter(Pred, T, [H|Acc]);
      false -> filter(Pred, T, Acc)
   end.

ev(X) -> X rem 2 =:= 0.
old_man({Sex, Age}) ->
   Sex =:= male andalso Age > 60.

% Folds
max([H|T]) -> max2(T, H).

max2([], M) -> M;
max2([H|T], M) when H > M -> max2(T, H);
max2([H|T], M) when H =< M -> max2(T, M).

fold(_, Start, []) -> Start;
fold(Pred, Start, [H|T]) -> fold(Pred, Pred(H, Start), T).
