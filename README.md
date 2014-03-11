sc_nps
======

Net Promoter Score implementation in Erlang.  MIT licensed.

Wut
---

[Net Promoter Score](http://en.wikipedia.org/wiki/Net_Promoter) is something that people from Bain Capital invented.  Over some arbitrary scale, typically the eleven integer points [0-10] inclusive, ask someone whether they would recommend you, and in essay form whether they'd like to volunteer extra detail.  9 and 10 are considered "promoters" (positive,) 7 and 8 are considered "passive" (neutral,) and 0 through 6 are considered "detractors" (negative,) despite the actual presented scale being nominal, on the grounds that only the fanatic supporters should be counted, and that "eh, i guess" as a would you recommend them actually does harm.  Then there are some studies, and you get the idea.

The actual calculation is the percentage of positives minus the percentage of negatives, exaggerating all contrasts.  As such the result range is positive through negative one hundred, `float()`.

The point is, dashboards want this, so here's an implementation.

... wut
-------

Fine.

```erlang
1> c("/projects/sc_nps/src/sc_nps.erl").      
{ok,sc_nps}

2> c("/projects/sc_nps/src/sc_nps_tests.erl").
{ok,sc_nps_tests}

3> eunit:test(sc_nps).
  All 6 tests passed.
ok

4> sc_nps:score([10,10,10,9,10,9]).
100.0

5> sc_nps:score([5,1,6,2,0,3]).    
-100.0

6> sc_nps:score([7,8,7]).      
0.0

7> sc_nps:score([10,0]). 
0.0

8> sc_nps:score([10,7,0]).
0.0

9> sc_nps:score([10,10,0]).
33.33333333333333

10> sc_nps:score([10,0,0]). 
-33.33333333333333

11> sc_nps:score([10,0,0,0]).
-50.0

12> sc_nps:score([10,0,0,0,0]).
-60.0

13> sc_nps:score([10,0,0,0,0,0]).
-66.66666666666669
```

Like that.

The numbers still seem arbitrary
--------------------------------

Actually I agree, but at least I should make the computation more transparent, because it's fundamentally kind of weird.

First off, how they're computed is as matches on atoms.

```erlang
14> sc_nps:rank(10).
promoter

15> sc_nps:rank(8). 
passive

16> sc_nps:rank(6).
detractor

17> [ sc_nps:rank(X) || X <- lists:seq(0,10) ].
[detractor,detractor,detractor,detractor,detractor,
 detractor,detractor,passive,passive,promoter,promoter]
```

Then, the end score is (roughly) `pct_positive() - pct_negative()`.  If half are positive and half negative, it's 0.  If 75% are positive and 25% are negative, it's 50.  If 25% are positive and 75% are negative, it's -50.  Etc.  Neutrals don't get directly counted in, but they reduce both of the other percentages, so they still affect the score by decreasing its magnitude towards zero.

Let's see some actual calculations.  First, pure positive.

```erlang
18> sc_nps:rank(10).                           
promoter

19> sc_nps:score([10]).
100.0

20> sc_nps:score([10,10]).
100.0
```

Then let's take neutrals into account.

```erlang
21> sc_nps:rank(8).                            
passive

22> sc_nps:score([8]).    
0.0

23> sc_nps:score([8,8]).
0.0

24> sc_nps:score([10,8]).
50.0
```

Note the neutral's decrease of the 10, which previously scored 100, towards 50.  Now let's take negatives into account.

```erlang
25> sc_nps:rank(6).      
detractor

26> sc_nps:score([6]).   
-100.0

27> sc_nps:score([6,8]).
-50.0

28> sc_nps:score([6,10]).
0.0

29> sc_nps:score([6,8,10]).
0.0

30> sc_nps:score([6,8,10,10]).
25.0
```

And that's the best I can do.  If you need more, [try this weird marketroid explainomercial](http://www.netpromotersystem.com/about/measuring-your-net-promoter-score.aspx).  It's actually way more detailed and straightforward than the Wikipedia article is.
