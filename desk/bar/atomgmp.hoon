=>  m=@
:-  0
!=
|^  ^-  ^
=+  [m=(dec (bex 128)) n=(bex 127)]
:*  (add m n)
    (sub m n)
    (mul m n)
    (div m n)
    (mod m n)
==
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
++  div
  |=  [a=@ b=@]
  ^-  @
  ?<  =(0 b)
  =+  c=0
  |-
  ?:  (lth a b)  c
  $(a (sub a b), c +(c))
::
++  mod
  |=  [a=@ b=@]
  ^-  @
  ?<  =(0 b)
  (sub a (mul b (div a b)))
::
++  bex
  |=  a=@
  ^-  @
  ?:  =(0 a)  1
  (mul 2 $(a (dec a)))
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
--
