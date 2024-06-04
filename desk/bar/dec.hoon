=>  m=@
:-  1.000.000
!=
|^  ^-  @
(dec m)
::
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
