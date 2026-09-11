#   Nock Benchmarks

Benchmark code evaluations for comparing Nock evaluation performance.

Benchmarks include:

- `.hoon` source files for the Nock code.
- `.nock` files containing cells of `[subject formula]`.
- `.noun` jamfiles of the Nock code.
- `tests.json` with expected results for verification.

All benchmarks are self-contained as nouns; nothing is supplied externally at run time.  Most `.hoon` files inline every arm they need using the `|^` core pattern, with no dependency on `/sys/hoon` (see `ackermann.hoon` as the gold standard).  The two compiler benchmarks are the exception:  compiling Hoon is the whole point of them, so they carry the compiler in their subject.  See [Compiler benchmarks](#compiler-benchmarks).

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

- [Matrix multiplication](https://en.wikipedia.org/wiki/Matrix_multiplication), `mmul`
- [SHA-512 hash](https://en.wikipedia.org/wiki/SHA-2), `sha512`

- Hoon compiler on the full `/sys/hoon.hoon`, `hoon`
- Hoon compiler on the abbreviated Nockchain prelude, `prelude`

### Compiler benchmarks

`hoon` and `prelude` compile Hoon source with the Hoon compiler — the compiler's own source, in the first case.  Their subject is not an atom but a cell of `[compiler source]`:  the compiler core, in which `+ride` is defined, paired with the text to be compiled.  The formula parses that text and compiles it against the `%noun` type, yielding a `[type nock]` pair.

The compiler comes from whatever subject the `.hoon` file is built against, so a ship of a different kelvin bakes a different compiler into the benchmark.  The shipped jamfiles hold Hoon %135 from Vere 4.3's ivory pill, and the hashes in `tests.json` pin that down; `tools/gen-hoon-noun.py --mug` rechecks them, and checks that the benchmark's product is exactly what `+ride` yields for the same source.

- `hoon` compiles `/sys/hoon.hoon` from [urbit/urbit](https://github.com/urbit/urbit), Hoon %135, 437 KB.
- `prelude` compiles `hoon/common/hoon.hoon` from [zorp-corp/nockchain](https://github.com/zorp-corp/nockchain), Hoon %138, 416 KB.

Both sources are vendored under `desk/bar/src/`.  These two benchmarks are much heavier than the rest — about 16 s and 18 s respectively under Vere 4.3 on an Apple M4 Max, against milliseconds for most of the suite — and they lean on the parser, the type system, and the `~+` memoization cache rather than on arithmetic.  They also lean on jets, unlike the rest of the suite:  the compiler in the subject is a jet-matched core, and a runtime that fails to match it is slower by orders of magnitude — the same compile took forty times as long unjetted under `urbit eval`, and on a ship of a mismatched kelvin had not finished after half an hour.

Since the subject embeds the entire compiler, these two ship only the `.noun` jamfile (about 1 MB each); the printed `.nock` text form would run to tens of megabytes, and is omitted.  Their products are likewise too large to write into `tests.json`, so the expected result is recorded as a `+mug` hash under `result_mug` rather than `result`.

To rebuild the jamfiles, or to check a product against the recorded hash:

```
tools/gen-hoon-noun.py desk/bar/src/hoon-135.hoon desk/bar/hoon.noun
tools/gen-hoon-noun.py --mug desk/bar/src/hoon-135.hoon
```

That script drives `urbit eval`, which evaluates Hoon against the ivory pill and so needs no ship; set `URBIT` if the binary is not on your path.

### Desired

- [Fibonacci sequence (Binet's formula)](https://en.wikipedia.org/wiki/Fibonacci_sequence#Relation_to_the_golden_ratio), `fibformula` (requires FP core)
- [Mandelbrot set](https://en.wikipedia.org/wiki/Mandelbrot_set), `mandelbrot` (easier with FP core)
- [MD5 hash](https://en.wikipedia.org/wiki/MD5), `md5`

##  Nock Reference Tests

The `norm/` directory contains a comprehensive test suite of Nock 4K opcodes (0–11 plus autocons).  See [`norm/README.md`](norm/README.md) and [`norm/REFERENCE.md`](norm/REFERENCE.md) for details.

##  Running

Nock benchmarks supply the subject and the formula as a cell; no arguments are externally specified.  In the Urbit Dojo, a benchmark may be run directly as:

```
=nok -build-file /=benchmark=/bar/ackermann/hoon
~>  %bout  .*(-.nok +.nok)
```

For cases for which a computation may run unreasonably long, the `%jinx` hint may be used to time-limit the computation:  `~>  %jinx.[~s100]`.

##  Reporting

A benchmark report should include the following data:

1. Hardware (CPU chipset):  `cat /proc/cpuinfo`, then report `model name` and number of cores (`siblings`)
2. Host OS:  `hostnamectl`, then report `Operating System` and `Kernel`.
3. Runtime version:  `urbit --version`, then report major version.  (With Vere and Ares developer builds, report the commit hash or release candidate number, etc.)
4. Statistics:  run a given calculation many times, and report $n$, $\max(t)$, $\min(t)$, and mean $\bar{t}$.  Include any critical details about the computation (such as range of input arguments).

