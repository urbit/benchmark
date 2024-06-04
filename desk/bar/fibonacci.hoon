=>  m=@
:-  10
!=
|^  ^-  @
%.  m
|=  n=@ud
^-  @ud
?:  =(n 1)  1
?:  =(n 2)  1
(add $(n (dec n)) $(n (dec (dec n))))
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
