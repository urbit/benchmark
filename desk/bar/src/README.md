#  Vendored Hoon sources

Input for the `hoon` and `prelude` compiler benchmarks; see the repository
README.  Neither file is built by the desk — each is read as raw text by the
benchmark that compiles it.

| File | Kelvin | Origin |
| --- | --- | --- |
| `hoon-135.hoon` | %135 | [urbit/urbit](https://github.com/urbit/urbit) `pkg/arvo/sys/hoon.hoon` @ `64bc785` |
| `hoon-138.hoon` | %138 | [zorp-corp/nockchain](https://github.com/zorp-corp/nockchain) `hoon/common/hoon.hoon` @ `5228bfb` |

Replacing either file means regenerating the matching `.noun` and refreshing
its hashes in `tests.json`:

```
tools/gen-hoon-noun.py desk/bar/src/hoon-135.hoon desk/bar/hoon.noun
tools/gen-hoon-noun.py --mug desk/bar/src/hoon-135.hoon
```
