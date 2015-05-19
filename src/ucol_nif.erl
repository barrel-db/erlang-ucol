%%% -*- erlang -*-
%%%
%%% This file is part of ucol_nif released under the Apache 2 license.
%%% See the NOTICE for more information.

-module(ucol_nif).

-export([init/0]).
-export([compare/2, compare/3]).

-on_load(init/0).

-type collate_options() :: [nocase].
-export_type([collate_options/0]).

init() ->
    PrivDir = case code:priv_dir(?MODULE) of
        {error, _} ->
            EbinDir = filename:dirname(code:which(?MODULE)),
            AppPath = filename:dirname(EbinDir),
            filename:join(AppPath, "priv");
        Path ->
            Path
    end,
    NumScheds = erlang:system_info(schedulers),
    SoPath = filename:join([PrivDir, ?MODULE]),
    erlang:load_nif(SoPath, NumScheds).

%% @doc compare 2 binaries, result is -1 for lt, 0 for eq and 1 for gt.
-spec compare(binary(), binary()) -> 0 | -1 | 1.
compare(A, B) ->
    compare(A, B, []).

-spec compare(binary(), binary(), collate_options()) -> 0 | -1 | 1.
compare(A, B, Options) when is_binary(A), is_binary(B) ->
    HasNoCase = case lists:member(nocase, Options) of
        true -> 1; % Case insensitive
        false -> 0 % Case sensitive
    end,
    do_compate(A, B, HasNoCase).

%% @private

do_compate(BinaryA, BinaryB, 0) ->
    ucol_nif(BinaryA, BinaryB, 0);
do_compate(BinaryA, BinaryB, 1) ->
    ucol_nif(BinaryA, BinaryB, 1).

ucol_nif(_BinaryA, _BinaryB, _HasCase) ->
    exit(ucol_nif_not_loaded).


-ifdef(TEST).

-include_lib("eunit/include/eunit.hrl").

compare_test() ->
    ?assertEqual(ucol_nif:compare(<<"foo">>, <<"bar">>), 1),
    ?assertEqual(ucol_nif:compare(<<"A">>, <<"aai">>), -1).

-endif.
