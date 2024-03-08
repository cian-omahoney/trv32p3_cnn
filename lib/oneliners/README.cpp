
// File generated by noodle version U-2022.12#33f3808fcb#221128, Fri Mar  8 12:09:14 2024
// Copyright 2014-2022 Synopsys, Inc. All rights reserved.
// noodle -Pc -Iisg +wisg -D__tct_patch__=0 -Wall +NOrlt -D__chess__ -D__programmers_view__ trv32p3_cnn

// File: README.cpp
// Empty file, except for always included processor model.

/*
ONE-LINERS README
--------------------------------------------------------------------------------

This directory contains a plenitude of extremely short functions, each testing
one fundamental concept used in the compiler.  Although each concept is checked
systematically it is not exhaustive, and the total sum of all tests does not
and cannot cover more complex situations.  So passing these tests is by itself
no guarantee for successful compilation of large(r) programs.

Several tests are designed so that they can be tested already without any
software stack support (without any stack related chess_properties).

The tests are generated feature-aware, that is w.r.t. all specifed types
(built-in and user-defined application types), storages known to be able to
hold these, and operations on them.  Sometimes certain tests are commented
out using //! meaning there is known to be insufficient support for it (yet).
(This can be unrelated to the test itself.)
In particular, it is required that appropriate argument registers are declared.


It should be verified that tests that are automatically skipped (commented out
with //!) are indeed intentionally not supported.
In particular files  register_moves.cpp  and  register_spilling.cpp  may skip
tests based on connection analysis.  Check these!

Conversely, it is not required that all these tests pass -- some features might
on purpose have been eliminated.  A simple feedback mechanism allows to manually
skip generation of certain tests: the file ``oneliners.skip'', if it exists
(in the processor lib directory), can contain function patterns, one per line.
The function pattern is an ECMAScript regular expression [*] which is matched
against the (complete) function identifier, to determine if the function should
be excluded.  A comment to be printed before the skipped function can be
added on the same line, after the function pattern, separated by whitespace.
E.g.,

functionpattern reason why skipped

will result in
  //@@ reason why skipped
  //@... functionname(...) { ... }
if functionname matches the functionpattern.

[*] Also see: https://en.cppreference.com/w/cpp/regex/ecmascript

Even tests that pass should be visually inspected that the compiler indeed
found the intended solution, and not some convoluted alternative.  Of course,
sometimes, when no direct solution is provided in the core, the tools are
supposed to work-around those limitations as best as possible.

It is adviced to allow Chess to "continue on error" (option -k or preference).
Indeed, comparing the sets of tests that succeed, versus those that fail,
will often point in the direction of a common cause.

In ChessDE, temporarily closing the "Project explorer" window can speed-up
compilation significantly (updating the GUI takes relatively long, compared to
compiling the individual functions).  It can be made visible again via the
"View" menu.
Also for speed scheduling option -o1 is set (try only 1 heuristic), as well as
disabling Dwarf2 generation (no -g).


More tests will be added.
Currently these tests target the compiler only.
In particular they do not verify the correctness of the architecture, but just
the completeness of its C programmability.

Any feed-back is welcome.
In particular, some tests might be generated that surpass easily determined
limitations -- please report these, so that they might be avoided (reducing
the need to manually skip them).

--------------------------------------------------------------------------------
*/
