-module(useless).
-export([add/2, hello/0]).

add(X, Y) -> X + Y.

% comments start with a %
hello() -> io:format("Hello, world!~n").
