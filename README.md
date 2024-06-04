#   Nock Benchmarks

Benchmark code evaluations for comparing Nock evaluation performance.

Benchmarks include:

- `.nock` files containing cells of `[subject formula]`
- `.noun` jamfiles of the Nock code.
- `.hoon` source files for the Nock code (optional).

Generally speaking, benchmarks should be self-contained; they should not call out to additional libraries or include dependencies on even `/sys/hoon`.  However, we do supply `tiny.nock` as a compiled version of `/lib/tiny` from Hoon 139K.  This may be preferred for cases (like `ackermann`) which would otherwise require included more than six arms.

##  Benchmarks

### Supplied

- [Ackermann function](https://en.wikipedia.org/wiki/Ackermann_function), `ackermann`
- [Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes), `sieve`
- [Naïve decrement](https://moronlab.blogspot.com/2010/01/decrement-in-reck.html), `dec`
- Naïve addition (similar), `add`
- Operations on direct atoms ($x < 2^{31}$), `atomcat`
- Operations on indirect atoms ($x > 2^{31}$), `atomdog`
- Operations on bignums ($x > 2^{63}$), `atomgmp`
- Addressing, `bigslot`
- [Fibonacci sequence (recursive generating function)](https://en.wikipedia.org/wiki/Fibonacci_sequence#Generating_function), `fibonacci`
- Factorial (tail-recursive), `factorial`

### Desired

- [Fibonacci sequence (Binet's formula)](https://en.wikipedia.org/wiki/Fibonacci_sequence#Relation_to_the_golden_ratio), `fibformula` (requires FP core)
- [Mandelbrot set](https://en.wikipedia.org/wiki/Mandelbrot_set), `mandelbrot` (easier with FP core)
- [Matrix multiplication](https://en.wikipedia.org/wiki/Matrix_multiplication), `mmul`
- [MD5 hash](https://en.wikipedia.org/wiki/MD5), `md5`
- [SHA-512 hash](https://en.wikipedia.org/wiki/SHA-2), `sha512`

##  Reporting

Nock benchmarks supply the subject and the formula as a cell; no arguments are externally specified.  In the Urbit Dojo, a benchmark may be run directly as:

```
=nok -build-file /=benchmark=/bar/ackermann/hoon
~>  %bout  .*(-.nok +.nok)
```

For cases for which a computation may run unreasonably long, the `%jinx` hint may be used to time-limit the computation:  `~>  %jinx.[~s100]`.

A benchmark report should include the following data:

1. Hardware (CPU chipset):  `cat /proc/cpuinfo`, then report `model name` and number of cores (`siblings`)
2. Host OS:  `hostnamectl`, then report `Operating System` and `Kernel`.
3. Runtime version:  `urbit --version`, then report major version.  (With Vere and Ares developer builds, report the commit hash or release candidate number, etc.)
4. Statistics:  run a given calculation many times, and report $n$, $\max(t)$, $\min(t)$, and mean $\bar{t}$.  Include any critical details about the computation (such as range of input arguments).

