-module(exceptions).
-compile(export_all).

throws(F) ->
   try F() of
      _ -> ok
   catch
      Throw -> {throw, caught, Throw}
   end.

errors(F) ->
   try F() of
      _ -> ok
   catch
      error:Error -> {error, caught, Error}
   end.

exits(F) ->
   try F() of
      _ -> ok
   catch
      exit:Exit -> {exit, caught, Exit}
   end.

sword(1) -> throw(slice);
sword(2) -> erlang:error(cut_arm);
sword(3) -> exit(cut_leg);
sword(4) -> throw(punch);
sword(5) -> exit(cross_bridge).

talk() -> "blah blah".

black_knight(Attack) when is_function(Attack, 0) ->
   try Attack() of
      _ -> "None shall pass"
   catch
      throw:slice -> "It is but a scratch.";
      error:cut_arm -> "I've had worse";
      exit:cut_leg -> "Come on you pansy";
      _:_ -> "Tis but a flesh wound"
   end.

% Can have more than one expression between try and of
whoa() ->
   try
      talk(),
      _Knight = "None shall pass",
      _Doubles = [N*2 || N <- lists:seq(1,100)],
      throw(up),
      _WillReturnThis = tequila
   of
      tequila -> "Hey this worked"
   catch
      Exception:Reason -> {caught, Exception, Reason}
   end.

% can omit of if don't care what return value is
im_impressed() ->
   try
      talk(),
      _Knight = "None shall pass",
      _Doubles = [N*2 || N <- lists:seq(1,100)],
      throw(up),
      _WillReturnThis = tequila
   catch
      Exception:Reason -> {caught, Exception, Reason}
   end.

% Don't put recursive calls between try and catch
% This is the "protected" part of the try catch,
% thus the VM must always hold a reference and
% LCO won't work
