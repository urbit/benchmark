=>  m=@
:-  40
!=
|^  ^-  @
%.  m
|=  n=@ud
=/  t=@ud  1
|-  ^-  @ud
?:  =(n 1)  t
$(n (dec n), t (mul t n))
::
++  add
  ::    unsigned addition
  |=  [a=@ b=@]
  ::  sum
  ^-  @
  ?:  =(0 a)  b
  $(a (dec a), b +(b))
++  dec
  ::    unsigned decrement by one.
  |=  a=@
  ?<  =(0 a)
  =+  b=0
  ::  decremented integer
  |-  ^-  @
  ?:  =(a +(b))  b
  $(b +(b))
++  mul                                                 ::  multiply
  |:  [a=`@`1 b=`@`1]
  ^-  @
  =+  c=0
  |-
  ?:  =(0 a)  c
  $(a (dec a), c (add b c))
--
