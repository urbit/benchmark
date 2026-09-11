::  hoon: compile /sys/hoon.hoon, the Hoon compiler's own source
::
::    The subject is [compiler source]:  the Hoon compiler core, in which
::    +ride is defined, paired with the text of the source to compile.  The
::    formula parses that text and compiles it against the %noun type, so the
::    product is a [type nock] pair.
::
::    The compiler comes from the subject this file is built against, so a
::    ship of a different kelvin will bake a different compiler into the
::    benchmark.  The shipped hoon.noun holds Hoon %135 from Vere 4.3's ivory
::    pill; desk/bar/tests.json records its hashes.
::
::    Source: urbit/urbit pkg/arvo/sys/hoon.hoon, Hoon %135.
::
/*  src  %hoon  /bar/src/hoon-135/hoon
=>  [cmp=..ride src=`@t`src]
:-  .
!=  (ride:cmp %noun src)
