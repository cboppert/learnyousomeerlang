-module(useless).
-export([add/2, hello/0, greet_and_add_two/1]).

add(X, Y) -> X + Y.

% comments start with a %
hello() -> io:format("Hello, world!~n").

greet_and_add_two(X) ->
   hello(),
   add(X,2).
