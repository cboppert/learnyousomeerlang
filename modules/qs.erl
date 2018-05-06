-module(qs).
-export([lomuto/1]).

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
