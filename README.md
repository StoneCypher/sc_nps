base_project
============

This is a checkout template for Erlang applications, with rebar and plt stuff in place already a la Concrete, and some other customizations, like having my name already in place and always needing `proper` and so on.

If this text is still here, then I haven't finished the update steps below yet after a checkout.

To check out transparently over a repo, go into the base project directory and type `git checkout-index -a -f --prefix=/c/projects/reponame/`.  ***It is important to not lose the trailing slash.***

1. Go fix the filename of the `.app.src` in source, and update the appname inside.
1. Clear the whargarbls in this file
1. Update any deps needed
1. Compile and test before updating
1. Write the descriptive text above
1. Set the project name in the polemic at the end





tl;dr
-----

`rebar g-d co eu doc`





Current Library Status: *Usable*
--------------------------------

This library is considered to be (`whargarbl` ready | not ready and why)

`whargarbl` Unit testing and stochastic testing and doc notes.

Improvements will be gladly accepted.



Author
------

* [John Haugeland](mailto:stonecypher@gmail.com) of [http://fullof.bs/](http://fullof.bs/).



Copyright
---------

Copyright (c) 2014 John Haugeland.  All rights reserved.



Polemic :neckbeard:
-------------------

`whargarbl` is MIT licensed, because viral licenses and newspeak language modification are evil.  Free is ***only*** free when it's free for everyone.
