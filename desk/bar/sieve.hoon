=>  m=@
:-  100.000
!=
%.  m
|=  n-max=@
^-  @ub
::  0 means prime, 1 means not a prime,
::  from least to most significant
::
|^
=/  out=@ub  0b11
=/  cursor=@  2
|-  ^-  @ub
=*  outer-loop  $
?:  =(cursor n-max)
  out
?:  =(1 (cut 0 [cursor 1] out))
  outer-loop(cursor +(cursor))
=/  index=@  (mul cursor cursor)
|-  ^-  @ub
=*  inner-loop  $
?:  (gth index n-max)
  outer-loop(cursor +(cursor))
inner-loop(index (add index cursor), out (sew 0 [index 1 1] out))
::
++  sew
  |=  [a=@ [b=@ c=@ d=@] e=@]
  ^-  @
  %+  add
    (can a [b e] [c d] ~)
  =/  f  [a (add b c)]
  (lsh f (rsh f e))
::
++  dec
  |=  a=@
  ?<  =(0 a)
  =+  b=0
  |-  ^-  @
  ?:  =(a +(b))  b
  $(b +(b))
::
++  add
  |=  [a=@ b=@]
  ^-  @
  ?:  =(0 a)  b
  $(a (dec a), b +(b))
::
++  sub
  |=  [a=@ b=@]
  ^-  @
  ?:  =(0 b)  a
  $(a (dec a), b (dec b))
::
++  mul
  |=  [a=@ b=@]
  ^-  @
  =+  c=0
  |-
  ?:  =(0 a)  c
  $(a (dec a), c (add b c))
::
++  gth
  |=  [a=@ b=@]
  ^-  ?
  !(lte a b)
::
++  lte
  |=  [a=@ b=@]
  ^-  ?
  |(=(a b) (lth a b))
::
++  lth
  |=  [a=@ b=@]
  ^-  ?
  ?&  !=(a b)
      |-
      ?:  =(0 a)  &
      ?:  =(0 b)  |
      $(a (dec a), b (dec b))
  ==
::
++  bex
  |=  a=@
  ^-  @
  ?:  =(0 a)  1
  (mul 2 $(a (dec a)))
::
++  lsh
  |=  [a=$@(@ [@ @]) b=@]
  =/  [bl=@ s=@]  ?^(a a [a 1])
  (mul b (bex (mul (bex bl) s)))
::
++  rsh
  |=  [a=$@(@ [@ @]) b=@]
  =/  [bl=@ s=@]  ?^(a a [a 1])
  (div b (bex (mul (bex bl) s)))
::
++  div
  |=  [a=@ b=@]
  ^-  @
  ?<  =(0 b)
  =+  c=0
  |-
  ?:  (lth a b)  c
  $(a (sub a b), c +(c))
::
++  cut
  |=  [a=@ [b=@ c=@] d=@]
  (end [a c] (rsh [a b] d))
::
++  end
  |=  [a=$@(@ [@ @]) b=@]
  =/  [bl=@ s=@]  ?^(a a [a 1])
  (mod b (bex (mul (bex bl) s)))
::
++  mod
  |=  [a=@ b=@]
  ^-  @
  ?<  =(0 b)
  (sub a (mul b (div a b)))
::
++  can
  |=  [a=@ b=*]
  ^-  @
  ?~  b  0
  (add (end [a `@`-.-.b] `@`+.-.b) (lsh [a `@`-.-.b] $(b +.b)))
--
