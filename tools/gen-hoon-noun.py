#!/usr/bin/env python3
"""Build the .noun jamfile for a compiler benchmark.

The `hoon` and `prelude` benchmarks compile a Hoon source file with the Hoon
compiler, so their subject is a cell of [compiler source]: the compiler core in
which +ride is defined, paired with the text to compile.  A subject that large
cannot be written out as text, so it is built with `urbit eval`, which
evaluates Hoon against the ivory pill without booting a ship -- the compiler
that lands in the subject is that pill's, and it is what the recorded hashes
pin down.

Usage:  tools/gen-hoon-noun.py desk/bar/src/hoon-135.hoon desk/bar/hoon.noun
        tools/gen-hoon-noun.py --mug desk/bar/src/hoon-135.hoon

`--mug` runs the benchmark rather than jamming it, reporting the two hashes
recorded in desk/bar/tests.json along with a check that the benchmark's product
is exactly what +ride yields for the same source.
"""

import argparse
import os
import subprocess
import sys
import tempfile

URBIT = os.environ.get('URBIT', 'urbit')

#  the benchmark, as Hoon.  `src` is spliced in as a hexadecimal literal
#  rather than read from disk, since `urbit eval` cannot scry.
#
BENCHMARK = '''=/  src=@t  `@t`{src}
=/  ben
  =>  [cmp=..ride src=src]
  :-  .
  !=  (ride:cmp %noun src)
{body}
'''

MUG = '''=/  out  ~>(%bout .*(-.ben +.ben))
:*  noun-mug=(mug ben)
    result-mug=(mug out)
    matches=.=(out (ride %noun src))
==
'''


def hoon_hex(byts):
    """Render bytes as a Hoon @ux literal, dot-separated every four digits."""
    hex_c = format(int.from_bytes(byts, 'little'), 'x')
    lead = len(hex_c) % 4 or 4
    return '0x' + '.'.join([hex_c[:lead]]
                           + [hex_c[i:i + 4] for i in range(lead, len(hex_c), 4)])


def benchmark(src_path, body):
    with open(src_path, 'rb') as f:
        return BENCHMARK.format(src=hoon_hex(f.read()), body=body)


def evaluate(hoon, out_path=None):
    """Run `urbit eval`, jamming the product to out_path if given.

    The jam is framed as a newt packet: a zero byte, then the length as four
    bytes little-endian.  libuv truncates a large write to a pipe when the
    process exits, so the output must go to a regular file.
    """
    args = [URBIT, 'eval'] + (['--jam', '--newt'] if out_path else [])
    with tempfile.NamedTemporaryFile('w', suffix='.hoon') as inp:
        inp.write(hoon)
        inp.flush()
        with open(inp.name, 'rb') as stdin:
            if not out_path:
                return subprocess.run(args, stdin=stdin, check=True,
                                      stdout=subprocess.PIPE).stdout.decode()
            with tempfile.NamedTemporaryFile('rb') as raw:
                subprocess.run(args, stdin=stdin, stdout=raw.file, check=True)
                raw.file.flush()
                framed = open(raw.name, 'rb').read()

    length = int.from_bytes(framed[1:5], 'little')
    jam = framed[5:]
    if framed[:1] != b'\x00' or len(jam) != length:
        sys.exit('eval: truncated output, %d of %d bytes' % (len(jam), length))
    with open(out_path, 'wb') as f:
        f.write(jam)
    return '%s: %d bytes' % (out_path, length)


def main():
    par = argparse.ArgumentParser(description=__doc__)
    par.add_argument('source', help='Hoon source file to compile')
    par.add_argument('noun', nargs='?', help='.noun jamfile to write')
    par.add_argument('--mug', action='store_true',
                     help='run the benchmark and report mugs instead')
    arg = par.parse_args()
    if arg.mug == bool(arg.noun):
        par.error('give either a .noun path or --mug')
    print(evaluate(benchmark(arg.source, 'ben' if arg.noun else MUG), arg.noun))


if __name__ == '__main__':
    main()
