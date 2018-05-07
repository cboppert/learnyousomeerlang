-module(qs).
-export([lomuto/1, lys/1, lcq/1]).

% Lomuto with first element chosen as pivot instead of last
lomuto([]) -> [];
lomuto([H|T]) -> lomuto(H, T, [], []).

lomuto(P, [], [], []) when is_number(P) -> [P];
lomuto(P, [], [LoH|LoT], []) when is_number(P) -> lomuto(LoH, LoT, [], []) ++ [P];
lomuto(P, [], [], [HiH|HiT]) when is_number(P) -> [P] ++ lomuto(HiH, HiT, [], []);
lomuto(P, [], [LoH|LoT], [HiH|HiT]) when is_number(P) -> lomuto(LoH, LoT, [], []) ++ [P] ++ lomuto(HiH, HiT, [], []);
lomuto(P, [H|T], Lo, Hi) when is_number(P),
                              is_number(H),
                              H > P -> lomuto(P, T, Lo, [H|Hi]);
lomuto(P, [H|T], Lo, Hi) when is_number(P),
                              is_number(H),
                              H =< P -> lomuto(P, T, [H|Lo], Hi).

% Learn you some erlang (Both 9 lines but this seems more readable)
% Now 10 with the guard
lys([]) -> [];
lys([P|Rest]) when is_number(P) ->
   {Smaller, Larger} = partition(P, Rest, [], []),
   lys(Smaller) ++ [P] ++ lys(Larger).

partition(_, [], Smaller, Larger) -> {Smaller, Larger};
partition(P, [H|T], Smaller, Larger) when is_number(P),
                                          is_number(H) ->
   if H =< P -> partition(P, T, [H|Smaller], Larger);
      H > P -> partition(P, T, Smaller, [H|Larger])
   end.

% List comprehensions!
lcq([]) -> [];
lcq([P|R]) -> lcq([Smaller || Smaller <- R, Smaller =< P])
              ++ [P] ++
              lcq([Larger || Larger <- R, Larger > P]).
