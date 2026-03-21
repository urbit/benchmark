#!/usr/bin/env python3
"""Generate REFERENCE.md from tests.json.

Usage:
    python3 norm/generate.py
"""

import json
import os
from collections import OrderedDict

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
TESTS_PATH = os.path.join(SCRIPT_DIR, "tests.json")
OUTPUT_PATH = os.path.join(SCRIPT_DIR, "REFERENCE.md")

OPCODE_NAMES = OrderedDict([
    ("autocons", "Auto-cons (distribution)"),
    (0, "Nock 0 — Slot (tree addressing)"),
    (1, "Nock 1 — Constant"),
    (2, "Nock 2 — Evaluate"),
    (3, "Nock 3 — Cell test"),
    (4, "Nock 4 — Increment"),
    (5, "Nock 5 — Equality"),
    (6, "Nock 6 — If-then-else"),
    (7, "Nock 7 — Compose"),
    (8, "Nock 8 — Push"),
    (9, "Nock 9 — Invoke"),
    (10, "Nock 10 — Edit"),
    (11, "Nock 11 — Hint"),
])

SPEC_LINES = {
    "autocons": "`*[a [b c] d]`  →  `[*[a b c] *[a d]]`",
    0:  "`*[a 0 b]`  →  `/[b a]`",
    1:  "`*[a 1 b]`  →  `b`",
    2:  "`*[a 2 b c]`  →  `*[*[a b] *[a c]]`",
    3:  "`*[a 3 b]`  →  `?*[a b]`",
    4:  "`*[a 4 b]`  →  `+*[a b]`",
    5:  "`*[a 5 b c]`  →  `=[*[a b] *[a c]]`",
    6:  "`*[a 6 b c d]`  →  if `*[a b]` = 0 then `*[a c]`, if 1 then `*[a d]`",
    7:  "`*[a 7 b c]`  →  `*[*[a b] c]`",
    8:  "`*[a 8 b c]`  →  `*[[*[a b] a] c]`",
    9:  "`*[a 9 b c]`  →  `*[*[a c] 2 [0 1] 0 b]`",
    10: "`*[a 10 [b c] d]`  →  `#[b *[a c] *[a d]]`",
    11: "`*[a 11 [b c] d]`  →  `*[[*[a c] *[a d]] 0 3]`  \n`*[a 11 b c]`  →  `*[a c]`",
}


def load_tests():
    with open(TESTS_PATH) as f:
        return json.load(f)


def group_by_opcode(tests):
    groups = OrderedDict()
    for t in tests:
        op = t["opcode"]
        groups.setdefault(op, []).append(t)
    return groups


def fmt_result(result):
    if result is None:
        return "**crash**"
    return f"`{result}`"


def fmt_hoon(hoon):
    if hoon is None:
        return ""
    return f"`{hoon}`"


def generate():
    tests = load_tests()
    groups = group_by_opcode(tests)

    lines = []
    lines.append("# Nock Reference Tests")
    lines.append("")
    lines.append("*Auto-generated from `tests.json` — do not edit by hand.*")
    lines.append("")
    lines.append("Each row is a triple of **subject**, **formula**, and expected "
                 "**result**.  A result of **crash** means the expression is "
                 "undefined per the Nock spec and a conforming runtime must not "
                 "produce a value.")
    lines.append("")

    # Table of contents
    lines.append("## Contents")
    lines.append("")
    for op in OPCODE_NAMES:
        anchor = OPCODE_NAMES[op].lower().replace(" ", "-").replace("—", "").replace("(", "").replace(")", "")
        anchor = anchor.replace("--", "-").strip("-")
        lines.append(f"- [{OPCODE_NAMES[op]}](#{anchor})")
    lines.append("")

    for op, name in OPCODE_NAMES.items():
        cases = groups.get(op, [])
        lines.append(f"## {name}")
        lines.append("")
        if op in SPEC_LINES:
            lines.append(f"Spec: {SPEC_LINES[op]}")
            lines.append("")

        lines.append("| # | Description | Subject | Formula | Result | Hoon |")
        lines.append("|---|-------------|---------|---------|--------|------|")

        for i, t in enumerate(cases, 1):
            desc = t["description"]
            # Strip the "Nock N: " or "Auto-cons: " prefix for brevity
            for prefix in [f"Nock {op}: ", "Auto-cons: "]:
                if desc.startswith(prefix):
                    desc = desc[len(prefix):]
                    break
            row = (
                f"| {i} "
                f"| {desc} "
                f"| `{t['subject']}` "
                f"| `{t['formula']}` "
                f"| {fmt_result(t['result'])} "
                f"| {fmt_hoon(t.get('hoon'))} |"
            )
            lines.append(row)

        lines.append("")

    md = "\n".join(lines)
    with open(OUTPUT_PATH, "w") as f:
        f.write(md)

    print(f"Wrote {OUTPUT_PATH} ({len(tests)} test cases)")


if __name__ == "__main__":
    generate()
