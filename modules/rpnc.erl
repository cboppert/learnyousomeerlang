-module(rpnc).
-export([calculate/1, rpn_test/0]).

calculate(Expression) -> calculate(string:tokens(Expression, " "), []).

calculate([], [H|[]]) -> H;
calculate(["+"|T], [N1,N2|StackTail]) -> calculate(T, [N2 + N1|StackTail]);
calculate(["-"|T], [N1,N2|StackTail]) -> calculate(T, [N2 - N1|StackTail]);
calculate(["*"|T], [N1,N2|StackTail]) -> calculate(T, [N2 * N1|StackTail]);
calculate(["/"|T], [N1,N2|StackTail]) -> calculate(T, [N2 / N1|StackTail]);
calculate(["^"|T], [N1,N2|StackTail]) -> calculate(T, [math:pow(N2,N1)|StackTail]);
calculate(["ln"|T], [N|StackTail]) -> calculate(T, [math:log(N)|StackTail]);
calculate(["log"|T], [N|StackTail]) -> calculate(T, [math:log10(N)|StackTail]);
calculate([X|T], Stack) -> calculate(T, [read(X)|Stack]).

% Because erlang can only convert to integer or float, not both
read(N) ->
   case string:to_float(N) of
      {error,no_float} -> list_to_integer(N);
      {F,_} -> F
   end.

rpn_test() ->
   5 = calculate("2 3 +"),
   87 = calculate("90 3 -"),
   -4 = calculate("10 4 3 + 2 * -"),
   -2.0 = calculate("10 4 3 + 2 * - 2 /").
