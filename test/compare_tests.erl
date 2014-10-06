%%% -*- erlang -*-
%%%
%%% This file is part of ucol_nif released under the Apache 2 license.
%%% See the NOTICE for more information.

-module(compare_tests).


-include_lib("eunit/include/eunit.hrl").

compare_test() ->
    ?assertEqual(ucol_nif:compare(<<"foo">>, <<"bar">>), 1),
    ?assertEqual(ucol_nif:compare(<<"A">>, <<"aai">>), -1).
