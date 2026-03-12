/+  tiny
::
=>  tiny
::
=>  |%
    ++  turn
      |*  [a=(list) b=gate]
      ?~  a  ~
      [i=(b i.a) t=$(a t.a)]
    --
::
:-  .
!=
%.  10
|=  size=@
^-  (list (list @))
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
  |=  [a=(list (list @)) b=(list (list @))]
  ^-  (list (list @))
  =+  bt=(trn b)
  %+  turn  a
  |=  row=(list @)
  ^-  (list @)
  %+  turn  bt
  |=  col=(list @)
  ^-  @
  (dot row col)
::
++  gen
  |=  [n=@ f=$-([@ @] @)]
  ^-  (list (list @))
  =+  i=0
  |-
  ?:  =(i n)  ~
  :_  $(i +(i))
  =+  j=0
  |-  ^-  (list @)
  ?:  =(j n)  ~
  :_  $(j +(j))
  (f [i j])
::
++  trn
  |=  m=(list (list @))
  ^-  (list (list @))
  ?~  m  ~
  ?~  i.m  ~
  [(heads m) $(m (tails m))]
::
++  heads
  |=  m=(list (list @))
  ^-  (list @)
  ?~  m  ~
  [?~(i.m 0 i.i.m) $(m t.m)]
::
++  tails
  |=  m=(list (list @))
  ^-  (list (list @))
  ?~  m  ~
  [?~(i.m ~ t.i.m) $(m t.m)]
::
++  dot
  |=  [a=(list @) b=(list @)]
  ^-  @
  ?~  a  0
  ?~  b  0
  (add (mul i.a i.b) $(a t.a, b t.b))
--
