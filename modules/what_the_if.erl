-module(what_the_if).
-export([heh_fine/0, oh_god/1, help_me/1, insert/2, beach/1]).

heh_fine() ->
   if 1 =:= 1 ->
         works
   end,
   if 1 =:= 2; 1 =:= 1 ->
         works
   end,
   if 1 =:= 2, 1 =:= 1 ->
         fails
   end.

oh_god(N) ->
   if N =:= 2 -> might_succeed;
      true -> always_does
   end.

% equal to ==
% exactly equal to =:= (good for ints/floats, anything else?)
help_me(Animal) ->
   Talk = if Animal == cat -> "meow";
             Animal == dog -> "woof";
             Animal == cow -> "moo";
             Animal == rat -> "squeak";
             true -> "the sound of my people"
         end,
   {Animal, "says " ++ Talk ++ "!"}.

% Avoid else (catch all) clause and cover all ground
% if X > Y -> a();   is better than if X > Y -> a();
%    X =< Y -> b()                     true -> b()
% end                               end

insert(X, []) ->
   [X];
insert(X, Set) ->
   case lists:member(X, Set) of
      true -> Set;
      false -> [X|Set]
   end.

beach(Temp) ->
   case Temp of
      {c, N} when N >= 20, N =< 45 ->
         'favorable';
      {k, N} when N >= 293, N =< 318 ->
         'scientifically favorable';
      {f, N} when N >= 70, N =< 100 ->
         'US favorable';
      _ ->
         'unfavorable'
   end.
