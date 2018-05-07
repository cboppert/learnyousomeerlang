-module(tree).
-export([empty/0, insert/3, lookup/2]).

empty() -> {node, 'nil'}.

insert(K, V, {node, 'nil'}) ->
   {node, {K, V, {node, 'nil'}, {node, 'nil'}}};
insert(NewK, NewV, {node, {K, V, Smaller, Larger}}) when NewK < K ->
   {node, {K, V, insert(NewK, NewV, Smaller), Larger}};
insert(NewK, NewV, {node, {K, V, Smaller, Larger}}) when NewK >= K ->
   {node, {K, V, Smaller, insert(NewK, NewV, Larger)}};
insert(K, V, {node, {K, _, Smaller, Larger}}) ->
   {node, {K, V, Smaller, Larger}}.

lookup(_, {node, 'nil'}) -> not_found;
lookup(K, {node, {K, V, _, _}}) -> V;
lookup(K, {node, {NodeKey, _, Smaller, _}}) when K < NodeKey ->
   lookup(K, Smaller);
lookup(K, {node, {NodeKey, _, _, Larger}}) when K >= NodeKey ->
   lookup(K, Larger).
