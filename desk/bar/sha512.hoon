=>  m=@
:-  0
!=
|^  ^-  @
::  SHA-512 of 'abc' (3 bytes)
::  expected: 0xddaf.35a1.9361.7aba.cc41.7349.ae20.4131.
::              12e6.fa4e.89a9.7ea2.0a9e.eee6.4b55.d39a.
::              2192.992a.274f.c1a8.36ba.3c23.a3fe.ebbd.
::              454d.4423.643c.e80e.2a9a.c94f.a54c.a49f
::
%.  [3 0x63.6261]
|=  [len=@ ruz=@]
^-  @
=>  .(ruz (cut 3 [0 len] ruz))
=+  [few==>(fe .(a 6)) wac=|=([a=@ b=@] (cut 6 [a 1] b))]
=+  [sum=sum.few ror=ror.few net=net.few inv=inv.few]
=+  ral=(lsh [0 3] len)
=+  ^=  ful
    %+  can  0
    :~  [ral ruz]
        [8 128]
        [(mod (sub 1.920 (mod (add 8 ral) 1.024)) 1.024) 0]
        [128 (~(net fe 7) ral)]
    ==
=+  lex=(met 10 ful)
=+  ^=  kbx  0x6c44.198c.4a47.5817.5fcb.6fab.3ad6.faec.
               597f.299c.fc65.7e2a.4cc5.d4be.cb3e.42b6.
               431d.67c4.9c10.0d4c.3c9e.be0a.15c9.bebc.
               32ca.ab7b.40c7.2493.28db.77f5.2304.7d84.
               1b71.0b35.131c.471b.113f.9804.bef9.0dae.
               0a63.7dc5.a2c8.98a6.06f0.67aa.7217.6fba.
               f57d.4f7f.ee6e.d178.eada.7dd6.cde0.eb1e.
               d186.b8c7.21c0.c207.ca27.3ece.ea26.619c.
               c671.78f2.e372.532b.bef9.a3f7.b2c6.7915.
               a450.6ceb.de82.bde9.90be.fffa.2363.1e28.
               8cc7.0208.1a64.39ec.84c8.7814.a1f0.ab72.
               78a5.636f.4317.2f60.748f.82ee.5def.b2fc.
               682e.6ff3.d6b2.b8a3.5b9c.ca4f.7763.e373.
               4ed8.aa4a.e341.8acb.391c.0cb3.c5c9.5a63.
               34b0.bcb5.e19b.48a8.2748.774c.df8e.eb99.
               1e37.6c08.5141.ab53.19a4.c116.b8d2.d0c8.
               106a.a070.32bb.d1b8.f40e.3585.5771.202a.
               d699.0624.5565.a910.d192.e819.d6ef.5218.
               c76c.51a3.0654.be30.c24b.8b70.d0f8.9791.
               a81a.664b.bc42.3001.a2bf.e8a1.4cf1.0364.
               9272.2c85.1482.353b.81c2.c92e.47ed.aee6.
               766a.0abb.3c77.b2a8.650a.7354.8baf.63de.
               5338.0d13.9d95.b3df.4d2c.6dfc.5ac4.2aed.
               2e1b.2138.5c26.c926.27b7.0a85.46d2.2ffc.
               1429.2967.0a0e.6e70.06ca.6351.e003.826f.
               d5a7.9147.930a.a725.c6e0.0bf3.3da8.8fc2.
               bf59.7fc7.beef.0ee4.b003.27c8.98fb.213f.
               a831.c66d.2db4.3210.983e.5152.ee66.dfab.
               76f9.88da.8311.53b5.5cb0.a9dc.bd41.fbd4.
               4a74.84aa.6ea6.e483.2de9.2c6f.592b.0275.
               240c.a1cc.77ac.9c65.0fc1.9dc6.8b8c.d5b5.
               efbe.4786.384f.25e3.e49b.69c1.9ef1.4ad2.
               c19b.f174.cf69.2694.9bdc.06a7.25c7.1235.
               80de.b1fe.3b16.96b1.72be.5d74.f27b.896f.
               550c.7dc3.d5ff.b4e2.2431.85be.4ee4.b28c.
               1283.5b01.4570.6fbe.d807.aa98.a303.0242.
               ab1c.5ed5.da6d.8118.923f.82a4.af19.4f9b.
               59f1.11f1.b605.d019.3956.c25b.f348.b538.
               e9b5.dba5.8189.dbbc.b5c0.fbcf.ec4d.3b2f.
               7137.4491.23ef.65cd.428a.2f98.d728.ae22
=+  ^=  hax  0x5be0.cd19.137e.2179.1f83.d9ab.fb41.bd6b.
               9b05.688c.2b3e.6c1f.510e.527f.ade6.82d1.
               a54f.f53a.5f1d.36f1.3c6e.f372.fe94.f82b.
               bb67.ae85.84ca.a73b.6a09.e667.f3bc.c908
=+  i=0
|-  ^-  @
?:  =(i lex)
  (run 6 hax net)
=+  ^=  wox
    =+  dux=(cut 10 [i 1] ful)
    =+  wox=(run 6 dux net)
    =+  j=16
    |-  ^-  @
    ?:  =(80 j)
      wox
    =+  :*  l=(wac (sub j 15) wox)
            m=(wac (sub j 2) wox)
            n=(wac (sub j 16) wox)
            o=(wac (sub j 7) wox)
        ==
    =+  x=:(mix (ror 0 1 l) (ror 0 8 l) (rsh [0 7] l))
    =+  y=:(mix (ror 0 19 m) (ror 0 61 m) (rsh [0 6] m))
    =+  z=:(sum n x o y)
    $(wox (con (lsh [6 j] z) wox), j +(j))
=+  j=0
=+  :*  a=(wac 0 hax)
        b=(wac 1 hax)
        c=(wac 2 hax)
        d=(wac 3 hax)
        e=(wac 4 hax)
        f=(wac 5 hax)
        g=(wac 6 hax)
        h=(wac 7 hax)
    ==
|-  ^-  @
?:  =(80 j)
  %=  ^$
    i  +(i)
    hax  %+  rep  6
         :~  (sum a (wac 0 hax))
             (sum b (wac 1 hax))
             (sum c (wac 2 hax))
             (sum d (wac 3 hax))
             (sum e (wac 4 hax))
             (sum f (wac 5 hax))
             (sum g (wac 6 hax))
             (sum h (wac 7 hax))
         ==
  ==
=+  l=:(mix (ror 0 28 a) (ror 0 34 a) (ror 0 39 a))   ::  S0
=+  m=:(mix (dis a b) (dis a c) (dis b c))            ::  maj
=+  n=(sum l m)                                       ::  t2
=+  o=:(mix (ror 0 14 e) (ror 0 18 e) (ror 0 41 e))   ::  S1
=+  p=(mix (dis e f) (dis (inv e) g))                 ::  ch
=+  q=:(sum h o p (wac j kbx) (wac j wox))            ::  t1
$(j +(j), a (sum q n), b a, c b, d c, e (sum d q), f e, g f, h g)
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
::
++  lte
  |=  [a=@ b=@]
  ^-  ?
  |(=(a b) (lth a b))
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
++  con
  |=  [a=@ b=@]
  ^-  @
  ?:  =(0 a)  b
  ?:  =(0 b)  a
  =+  c=?|(!=(0 (mod a 2)) !=(0 (mod b 2)))
  (add ?:(c 1 0) (mul 2 $(a (div a 2), b (div b 2))))
::
++  dis
  |=  [a=@ b=@]
  ^-  @
  ?:  =(0 a)  0
  ?:  =(0 b)  0
  =+  c=?&(!=(0 (mod a 2)) !=(0 (mod b 2)))
  (add ?:(c 1 0) (mul 2 $(a (div a 2), b (div b 2))))
::
++  mix
  |=  [a=@ b=@]
  ^-  @
  ?:  =(0 a)  b
  ?:  =(0 b)  a
  %+  add
    (mod (add (mod a 2) (mod b 2)) 2)
  (mul 2 $(a (div a 2), b (div b 2)))
::
++  met
  |=  [a=@ b=@]
  ^-  @
  ?:  =(0 b)  0
  =+  c=(bex (bex a))
  |-  ^-  @
  ?:  (lth b c)  1
  +($(b (div b c)))
::
++  end
  |=  [a=$@(@ [@ @]) b=@]
  =/  [bl=@ s=@]  ?^(a a [a 1])
  (mod b (bex (mul (bex bl) s)))
::
++  cut
  |=  [a=@ [b=@ c=@] d=@]
  (end [a c] (rsh [a b] d))
::
++  can
  |=  [a=@ b=*]
  ^-  @
  ?~  b  0
  (add (end [a `@`-.-.b] `@`+.-.b) (lsh [a `@`-.-.b] $(b +.b)))
::
++  rep
  |=  [a=$@(@ [@ @]) b=*]
  =/  [bl=@ s=@]  ?^(a a [a 1])
  =|  i=@
  |-  ^-  @
  ?~  b  0
  %+  add  $(i +(i), b +.b)
  (lsh [bl (mul s i)] (end [bl s] `@`-.b))
::
++  rip
  |=  [a=$@(@ [@ @]) b=@]
  ^-  *
  ?:  =(0 b)  ~
  [(end a b) $(b (rsh a b))]
::
++  turn
  |=  [a=* b=$-(* *)]
  ^-  *
  ?~  a  ~
  [(b -.a) $(a +.a)]
::
++  run                                                 ::  +turn into atom
  |=  [a=$@(@ [@ @]) b=@ c=$-(@ @)]
  (rep a (turn (rip a b) c))
::
++  fe                                                  ::  modulo bloq
  |_  a=@
  ++  inv  |=(b=@ (sub (dec (bex (bex a))) (sit b)))
  ++  net  |=  b=@  ^-  @
           =>  .(b (sit b))
           ?:  (lte a 3)  b
           =+  c=(dec a)
           %+  con
             (lsh c $(a c, b (cut c [0 1] b)))
           $(a c, b (cut c [1 1] b))
  ++  rol  |=  [b=@ c=@ d=@]  ^-  @
           =+  e=(sit d)
           =+  f=(bex (sub a b))
           =+  g=(mod c f)
           (sit (con (lsh [b g] e) (rsh [b (sub f g)] e)))
  ++  ror  |=  [b=@ c=@ d=@]  ^-  @
           =+  e=(sit d)
           =+  f=(bex (sub a b))
           =+  g=(mod c f)
           (sit (con (rsh [b g] e) (lsh [b (sub f g)] e)))
  ++  sum  |=([b=@ c=@] (sit (add b c)))
  ++  sit  |=(b=@ (end a b))
  --
--
