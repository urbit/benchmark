=>  [m=@ n=@]
:-  [3 6]
!=
|^  ^-  @
?:  =(0 m)  +(n)
?:  =(0 n)  $(m (dec m), n 1)
$(m (dec m), n $(n (dec n)))
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
