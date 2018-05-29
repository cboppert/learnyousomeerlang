-module(road).
-compile(export_all).

main([Filename]) ->
   File = Filename,
   {ok, Bin} = file:read_file(File),
   io:format("~p~n", [optimal_path(parse_map(Bin))]),
   erlang:halt(0).

parse_map(Bin) when is_binary(Bin) ->
   parse_map(binary_to_list(Bin));
parse_map(Str) when is_list(Str) ->
   Values = [list_to_integer(X) || X <- string:tokens(Str, "\r\n\t ")],
   group_vals(Values, []).

group_vals([], Acc) -> lists:reverse(Acc);
group_vals([A,B,X|Rest], Acc) -> group_vals(Rest, [{A,B,X}|Acc]).

shortest_step({A,B,X}, {{DistA,PathA}, {DistB,PathB}}) ->
   OptA1 = {DistA + A, [{a,A}|PathA]},
   OptA2 = {DistA + B + X, [{x,X},{b,B}|PathB]},
   OptB1 = {DistB + B, [{b,B}|PathB]},
   OptB2 = {DistB + A + X, [{x,X}, {a,A}|PathA]},
   {erlang:min(OptA1, OptA2), erlang:min(OptB1, OptB2)}.

optimal_path(Map) ->
   {A,B} = lists:foldl(fun shortest_step/2, {{0,[]}, {0,[]}}, Map),
   {_Dist, Path} = if hd(element(2,A)) =/= {x,0} -> A;
                      hd(element(2,B)) =/= {x,0} -> B
                     end,
   lists:reverse(Path).