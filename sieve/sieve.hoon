/+  tiny
::
=>  tiny
::
:-  .
!.  !=
%.  100.000
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
  |=  [a=bloq [b=step c=step d=@] e=@]
  ^-  @
  %+  add
    (can a b^e c^d ~)
  =/  f  [a (add b c)]
  (lsh f (rsh f e))
::
--
