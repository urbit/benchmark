# Nock Reference Tests

*Auto-generated from `tests.json` — do not edit by hand.*

Each row is a triple of **subject**, **formula**, and expected **result**.  A result of **crash** means the expression is undefined per the Nock spec and a conforming runtime must not produce a value.

## Contents

- [Auto-cons (distribution)](#auto-cons-distribution)
- [Nock 0 — Slot (tree addressing)](#nock-0-slot-tree-addressing)
- [Nock 1 — Constant](#nock-1-constant)
- [Nock 2 — Evaluate](#nock-2-evaluate)
- [Nock 3 — Cell test](#nock-3-cell-test)
- [Nock 4 — Increment](#nock-4-increment)
- [Nock 5 — Equality](#nock-5-equality)
- [Nock 6 — If-then-else](#nock-6-if-then-else)
- [Nock 7 — Compose](#nock-7-compose)
- [Nock 8 — Push](#nock-8-push)
- [Nock 9 — Invoke](#nock-9-invoke)
- [Nock 10 — Edit](#nock-10-edit)
- [Nock 11 — Hint](#nock-11-hint)

## Auto-cons (distribution)

Spec: `*[a [b c] d]`  →  `[*[a b c] *[a d]]`

| # | Description | Subject | Formula | Result | Hoon |
|---|-------------|---------|---------|--------|------|
| 1 | distribution over a cell of formulas | `42` | `[[4 0 1] [0 1]]` | `[43 42]` | `[.+(.) .]` |
| 2 | nested distribution | `[1 2]` | `[[0 2] [0 3] [0 1]]` | `[1 2 1 2]` | `[- + .]` |

## Nock 0 — Slot (tree addressing)

Spec: `*[a 0 b]`  →  `/[b a]`

| # | Description | Subject | Formula | Result | Hoon |
|---|-------------|---------|---------|--------|------|
| 1 | axis 1 returns the whole subject | `42` | `[0 1]` | `42` | `.` |
| 2 | axis 2 returns the head | `[1 2]` | `[0 2]` | `1` | `-` |
| 3 | axis 3 returns the tail | `[1 2]` | `[0 3]` | `2` | `+` |
| 4 | axis 4 returns the head of the head | `[[1 2] [3 4]]` | `[0 4]` | `1` | `-.-` |
| 5 | axis 5 returns the tail of the head | `[[1 2] [3 4]]` | `[0 5]` | `2` | `+.-` |
| 6 | axis 6 returns the head of the tail | `[[1 2] [3 4]]` | `[0 6]` | `3` | `-.+` |
| 7 | axis 7 returns the tail of the tail | `[[1 2] [3 4]]` | `[0 7]` | `4` | `+.+` |
| 8 | deep addressing (axis 12) | `[[[1 2] [3 4]] [[5 6] [7 8]]]` | `[0 12]` | `5` | `-.-.+` |
| 9 | deep addressing (axis 15) | `[[[1 2] [3 4]] [[5 6] [7 8]]]` | `[0 15]` | `8` | `+.+.+` |
| 10 | axis 0 crashes (undefined) | `42` | `[0 0]` | **crash** |  |
| 11 | addressing into atom crashes | `[1 2]` | `[0 6]` | **crash** |  |

## Nock 1 — Constant

Spec: `*[a 1 b]`  →  `b`

| # | Description | Subject | Formula | Result | Hoon |
|---|-------------|---------|---------|--------|------|
| 1 | constant atom | `42` | `[1 0]` | `0` |  |
| 2 | constant atom, subject ignored | `42` | `[1 57]` | `57` |  |
| 3 | constant cell | `0` | `[1 [1 2]]` | `[1 2]` |  |
| 4 | constant deep cell | `0` | `[1 [[1 2] [3 4]]]` | `[[1 2] 3 4]` |  |
| 5 | subject has no effect on result | `[[99 100] [101 102]]` | `[1 0]` | `0` |  |

## Nock 2 — Evaluate

Spec: `*[a 2 b c]`  →  `*[*[a b] *[a c]]`

| # | Description | Subject | Formula | Result | Hoon |
|---|-------------|---------|---------|--------|------|
| 1 | evaluate with computed subject and formula | `42` | `[2 [0 1] [1 [4 0 1]]]` | `43` |  |
| 2 | evaluate constant subject and formula | `0` | `[2 [1 [1 2]] [1 [1 3]]]` | `3` |  |
| 3 | evaluate with subject from slot | `[[4 0 1] 99]` | `[2 [0 3] [0 2]]` | `100` |  |
| 4 | nested evaluate | `42` | `[2 [1 0] [1 [4 0 1]]]` | `1` |  |

## Nock 3 — Cell test

Spec: `*[a 3 b]`  →  `?*[a b]`

| # | Description | Subject | Formula | Result | Hoon |
|---|-------------|---------|---------|--------|------|
| 1 | cell test on cell yields 0 (yes) | `[1 2]` | `[3 [0 1]]` | `0` | `.?([1 2])` |
| 2 | cell test on atom yields 1 (no) | `42` | `[3 [0 1]]` | `1` | `.?(42)` |
| 3 | cell test on computed cell | `0` | `[3 [1 [1 2]]]` | `0` |  |
| 4 | cell test on computed atom | `0` | `[3 [1 42]]` | `1` |  |

## Nock 4 — Increment

Spec: `*[a 4 b]`  →  `+*[a b]`

| # | Description | Subject | Formula | Result | Hoon |
|---|-------------|---------|---------|--------|------|
| 1 | increment atom | `42` | `[4 0 1]` | `43` | `.+(42)` |
| 2 | increment zero | `0` | `[4 0 1]` | `1` | `.+(0)` |
| 3 | increment computed value | `[1 2]` | `[4 0 3]` | `3` | `.+(+:[1 2])` |
| 4 | double increment via composition | `0` | `[4 4 0 1]` | `2` | `.+(.+(0))` |
| 5 | increment cell crashes | `[1 2]` | `[4 0 1]` | **crash** |  |

## Nock 5 — Equality

Spec: `*[a 5 b c]`  →  `=[*[a b] *[a c]]`

| # | Description | Subject | Formula | Result | Hoon |
|---|-------------|---------|---------|--------|------|
| 1 | equal atoms yield 0 (yes) | `42` | `[5 [0 1] [0 1]]` | `0` | `.=(42 42)` |
| 2 | unequal atoms yield 1 (no) | `42` | `[5 [0 1] [1 43]]` | `1` | `.=(42 43)` |
| 3 | equal cells yield 0 | `[[1 2] [1 2]]` | `[5 [0 2] [0 3]]` | `0` | `.=([1 2] [1 2])` |
| 4 | unequal cells yield 1 | `[[1 2] [3 4]]` | `[5 [0 2] [0 3]]` | `1` | `.=([1 2] [3 4])` |
| 5 | atom vs cell yields 1 | `[42 [1 2]]` | `[5 [0 2] [0 3]]` | `1` | `.=(42 [1 2])` |

## Nock 6 — If-then-else

Spec: `*[a 6 b c d]`  →  if `*[a b]` = 0 then `*[a c]`, if 1 then `*[a d]`

| # | Description | Subject | Formula | Result | Hoon |
|---|-------------|---------|---------|--------|------|
| 1 | branch on 0 takes the true arm | `42` | `[6 [1 0] [1 1] [1 2]]` | `1` | `?:(& 1 2)` |
| 2 | branch on 1 takes the false arm | `42` | `[6 [1 1] [1 1] [1 2]]` | `2` | `?:(| 1 2)` |
| 3 | branch with computed test (cell test) | `[1 2]` | `[6 [3 [0 1]] [1 99] [0 2]]` | `99` | `?:(.?([1 2]) 99 -:[1 2])` |
| 4 | branch with computed test (atom case) | `42` | `[6 [3 [0 1]] [1 99] [0 1]]` | `42` |  |
| 5 | non-boolean test crashes | `42` | `[6 [1 2] [1 1] [1 2]]` | **crash** |  |

## Nock 7 — Compose

Spec: `*[a 7 b c]`  →  `*[*[a b] c]`

| # | Description | Subject | Formula | Result | Hoon |
|---|-------------|---------|---------|--------|------|
| 1 | compose two increments | `42` | `[7 [4 0 1] [4 0 1]]` | `44` | `=>(42 =>(+(.) +(.) ))` |
| 2 | compose slot then increment | `[1 2]` | `[7 [0 2] [4 0 1]]` | `2` |  |
| 3 | compose constant then slot | `42` | `[7 [1 [1 2]] [0 2]]` | `1` |  |
| 4 | triple composition | `0` | `[7 [4 0 1] [7 [4 0 1] [4 0 1]]]` | `3` |  |

## Nock 8 — Push

Spec: `*[a 8 b c]`  →  `*[[*[a b] a] c]`

| # | Description | Subject | Formula | Result | Hoon |
|---|-------------|---------|---------|--------|------|
| 1 | push value, read it from head | `42` | `[8 [4 0 1] [0 2]]` | `43` | `=+(+(.) .)` |
| 2 | push value, read original subject from tail | `42` | `[8 [4 0 1] [0 3]]` | `42` |  |
| 3 | push and compare with original | `42` | `[8 [1 0] [5 [0 2] [0 3]]]` | `1` |  |
| 4 | push constant, use in formula | `[1 2]` | `[8 [1 99] [0 2]]` | `99` |  |
| 5 | push and auto-cons from augmented subject | `42` | `[8 [4 0 1] [[0 2] [0 3]]]` | `[43 42]` |  |

## Nock 9 — Invoke

Spec: `*[a 9 b c]`  →  `*[*[a c] 2 [0 1] 0 b]`

| # | Description | Subject | Formula | Result | Hoon |
|---|-------------|---------|---------|--------|------|
| 1 | invoke arm in a simple core | `0` | `[9 2 [1 [[4 0 3] 42]]]` | `43` |  |
| 2 | invoke identity arm | `0` | `[9 2 [1 [[0 3] 99]]]` | `99` |  |
| 3 | invoke with modified payload via Nock 10 | `0` | `[9 2 [10 [3 [1 7]] [1 [[4 0 3] 42]]]]` | `8` |  |
| 4 | invoke on pre-built core from subject | `[[4 0 3] 0]` | `[9 2 [0 1]]` | `1` |  |

## Nock 10 — Edit

Spec: `*[a 10 [b c] d]`  →  `#[b *[a c] *[a d]]`

| # | Description | Subject | Formula | Result | Hoon |
|---|-------------|---------|---------|--------|------|
| 1 | edit head of a cell | `[1 2]` | `[10 [2 [1 3]] [0 1]]` | `[3 2]` |  |
| 2 | edit tail of a cell | `[1 2]` | `[10 [3 [1 3]] [0 1]]` | `[1 3]` |  |
| 3 | edit axis 1 replaces entire noun | `[1 2]` | `[10 [1 [1 99]] [0 1]]` | `99` |  |
| 4 | deep edit at axis 4 | `[[1 2] [3 4]]` | `[10 [4 [1 99]] [0 1]]` | `[[99 2] 3 4]` |  |
| 5 | deep edit at axis 7 | `[[1 2] [3 4]]` | `[10 [7 [1 99]] [0 1]]` | `[[1 2] 3 99]` |  |

## Nock 11 — Hint

Spec: `*[a 11 [b c] d]`  →  `*[[*[a c] *[a d]] 0 3]`  
`*[a 11 b c]`  →  `*[a c]`

| # | Description | Subject | Formula | Result | Hoon |
|---|-------------|---------|---------|--------|------|
| 1 | static hint is transparent | `42` | `[11 1 [4 0 1]]` | `43` | `~>(1 .+(42))` |
| 2 | static hint with different tag | `[1 2]` | `[11 37 [0 2]]` | `1` |  |
| 3 | dynamic hint evaluates and discards clue | `42` | `[11 [1 [1 0]] [4 0 1]]` | `43` |  |
| 4 | dynamic hint clue does not affect result | `[1 2]` | `[11 [1 [4 0 2]] [0 3]]` | `2` |  |
