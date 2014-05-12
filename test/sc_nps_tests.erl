
-module(sc_nps_tests).
-compile(export_all).

-include_lib("proper/include/proper.hrl").
-include_lib("eunit/include/eunit.hrl").





rank_test_() ->

    EveryAnswer = [detractor,detractor,detractor,detractor,detractor,detractor,detractor,passive,passive,promoter,promoter],

    { "Rank tests", [

        {"Full range", ?_assert( EveryAnswer =:= [ sc_nps:rank(X) || X <- lists:seq(0,10) ] ) }

    ]}.





score_test_() ->

    { "Score tests", [

        {"Perfect score",     ?_assert(  100.0 =:= sc_nps:score([10,10]) ) },
        {"Good score",        ?_assert(   50.0 =:= sc_nps:score([10, 8]) ) },
        {"Neutral score",     ?_assert(    0.0 =:= sc_nps:score([10, 0]) ) },
        {"Bad score",         ?_assert(  -50.0 =:= sc_nps:score([ 8, 0]) ) },
        {"Rock bottom score", ?_assert( -100.0 =:= sc_nps:score([ 0, 0]) ) }

    ]}.
