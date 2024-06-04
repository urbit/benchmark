=>  [m=@ n=@]
:-  [1.000 2.000]
!=
|^  ^-  @
(add m n)
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
--
