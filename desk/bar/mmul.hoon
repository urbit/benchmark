=>  size=@
:-  10
!=
%.  size
|=  size=@
^-  *
::  multiply two procedurally generated size x size matrices.
::  a[i][j] = i*size + j + 1 (1-indexed sequential)
::  b[i][j] = size*size - (i*size + j) (reverse sequential)
::
|^
=+  a=(gen size |=([i=@ j=@] (add +(j) (mul i size))))
=+  b=(gen size |=([i=@ j=@] (sub (mul size size) (add j (mul i size)))))
(mmul a b)
::
++  mmul
  |=  [a=* b=*]
  ^-  *
  =+  bt=(trn b)
  (turn a |=(row=* (turn bt |=(col=* (dot row col)))))
::
++  gen
  |=  [n=@ f=$-([@ @] @)]
  ^-  *
  =+  i=0
  |-
  ?:  =(i n)  ~
  :_  $(i +(i))
  =+  j=0
  |-  ^-  *
  ?:  =(j n)  ~
  :_  $(j +(j))
  (f [i j])
::
++  turn
  |=  [a=* b=$-(* *)]
  ^-  *
  ?~  a  ~
  [(b -.a) $(a +.a)]
::
++  trn
  |=  m=*
  ^-  *
  ?~  m  ~
  ?~  -.m  ~
  [(heads m) $(m (tails m))]
::
++  heads
  |=  m=*
  ^-  *
  ?~  m  ~
  [-.-.m $(m +.m)]
::
++  tails
  |=  m=*
  ^-  *
  ?~  m  ~
  [?~(-.m ~ +.-.m) $(m +.m)]
::
++  dot
  |=  [a=* b=*]
  ^-  @
  ?~  a  0
  ?~  b  0
  %+  add  (mul `@`-.a `@`-.b)
  $(a +.a, b +.b)
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
--
