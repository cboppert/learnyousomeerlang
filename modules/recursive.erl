-module(recursive).
-export([fac/1, len/1, tail_fac/1, duplicate/2, reverse/1, sublist/2, zip/2]).

fac(0) -> 1;
fac(N) when N > 0 -> N * fac(N - 1).

len([]) -> 0;
len([_|T]) -> 1 + length(T).

% Erlang has tail recursion by default (I think?) but here it
% is anyways
tail_fac(N) -> tail_fac(N, 0).

tail_fac(0, Acc) -> Acc;
tail_fac(N, Acc) when N > 0 -> tail_fac(N - 1, N + Acc).

duplicate(N, Term) -> duplicate(N, Term, []).

duplicate(0, _, L) -> L;
duplicate(N, Term, L) when N > 0 -> duplicate(N - 1, Term, [Term|L]).

% Use lists:reverse in practice (highly optimized BIF built in C)
reverse(L) when is_list(L) -> reverse(L, []).

reverse([], NL) -> NL;
reverse([H|T], NL) -> reverse(T, [H|NL]).

sublist(L, N) when is_list(L), N > 0 -> reverse(sublist(L, N, [])).

sublist([], _, NL) -> NL;
sublist(_, 0, NL) -> NL;
sublist([H|T], N, NL) -> sublist(T, N - 1, [H|NL]).

zip(L1, L2) when is_list(L1), is_list(L2) ->
   lists:reverse(zip(L1, L2, [])).

zip([], _, Z) -> Z;
zip(_, [], Z) -> Z;
zip([H1|T1], [H2|T2], Z) -> zip(T1, T2, [{H1, H2}|Z]).

% Ope, nope, no tail recursion by default, just tail call optimisation
