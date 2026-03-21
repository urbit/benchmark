# Nock Reference Tests

Machine-legible test vectors for validating Nock 4K runtime implementations.  Each test is a triple of subject, formula, and expected result covering all twelve opcodes (0–11) and auto-cons.

## Files

- `tests.json` — Canonical test data.  Each entry has fields:
  - `opcode` — integer 0–11 or `"autocons"`
  - `description` — human-readable explanation
  - `subject` — Nock noun (as a string in standard notation)
  - `formula` — Nock formula (as a string)
  - `result` — expected product (as a string), or `null` for crash
  - `hoon` — equivalent Hoon expression (optional, may be `null`)
- `REFERENCE.md` — Generated Markdown table (do not edit by hand).
- `generate.py` — Regenerates `REFERENCE.md` from `tests.json`.
- `validate.py` — Validates every test against a live Nock runtime.

## Usage

### Generate the reference table

```
python3 norm/generate.py
```

### Validate against a runtime

```
python3 norm/validate.py --urbit ~/bin/urbit --verbose
```

The validator runs each test as `.*(subject formula)` via `urbit eval` and compares the output.  Tests with `result: null` expect the runtime to bail (crash).

By default the script looks for `~/bin/urbit` or `urbit` on `$PATH`.

### Crash convention

A `null` result means the expression is undefined per the Nock 4K spec.  The reduction rules have no matching pattern, so a conforming runtime must crash (not produce a value).  Common examples:

- `*[a 0 0]` — axis 0 is undefined
- `+[a b]` — increment of a cell
- `*[a 6 b c d]` where `*[a b]` is not 0 or 1

### Noun printing

Results use right-associative flattening: `[a [b c]]` is printed as `[a b c]`.  This matches Urbit's canonical noun printer.

## Spec

These tests target [Nock 4K](https://nock.is/content/specification/index.html).
