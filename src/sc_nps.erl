
% http://www.netpromoter.com/why-net-promoter/know/

-module(sc_nps).





-export([

    rank/1,
    score/1

]).





rank(X) when is_integer(X), X >= 0, X =< 6 -> detractor;
rank(7)                                    -> passive;
rank(8)                                    -> passive;
rank(9)                                    -> promoter;
rank(10)                                   -> promoter.





score(List) ->

    Total  = length(List),
    Ranked = sc:histo_bucket(List),

    { Total, Ranked }.
