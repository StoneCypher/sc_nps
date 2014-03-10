
-module(sc_nps_tests).
-compile(export_all).

-include_lib("proper/include/proper.hrl").
-include_lib("eunit/include/eunit.hrl").





rank_test_() ->

    EveryAnswer = [detractor,detractor,detractor,detractor,detractor,detractor,detractor,passive,passive,promoter,promoter],

    { "Rank tests", [

        {"Full range", ?_assert( EveryAnswer =:= [ sc_nps:rank(X) || X <- lists:seq(0,10) ] ) }

    ]}.
