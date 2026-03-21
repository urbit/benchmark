#!/usr/bin/env python3
"""Validate tests.json against a Nock runtime via `urbit eval`.

Usage:
    python3 norm/validate.py [--urbit /path/to/urbit] [--verbose]

Each test is evaluated as:
    echo '.*(<subject> <formula>)' | urbit eval

A test with result null expects the runtime to crash (bail).
"""

import argparse
import json
import os
import re
import subprocess
import sys

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
TESTS_PATH = os.path.join(SCRIPT_DIR, "tests.json")
ANSI_RE = re.compile(r"\x1b\[[0-9;]*m")


def find_urbit():
    """Find the urbit binary, checking common locations."""
    candidates = [
        os.path.expanduser("~/bin/urbit"),
        "urbit",
    ]
    for c in candidates:
        full = os.path.expanduser(c)
        if os.path.isfile(full) and os.access(full, os.X_OK):
            return full
    return None


def eval_nock(urbit_bin, subject, formula, timeout=30):
    """Evaluate .*(subject formula) and return (result_str, crashed)."""
    expr = f".*({subject} {formula})"
    try:
        proc = subprocess.run(
            [urbit_bin, "eval"],
            input=expr,
            capture_output=True,
            text=True,
            timeout=timeout,
        )
    except subprocess.TimeoutExpired:
        return None, True

    if "bail" in proc.stderr:
        return None, True

    raw = ANSI_RE.sub("", proc.stdout).strip()
    if not raw:
        return None, True

    return raw, False


def main():
    parser = argparse.ArgumentParser(description="Validate Nock reference tests")
    parser.add_argument(
        "--urbit", default=None,
        help="Path to urbit binary (default: ~/bin/urbit or $PATH)"
    )
    parser.add_argument(
        "--verbose", "-v", action="store_true",
        help="Print each test as it runs"
    )
    args = parser.parse_args()

    urbit_bin = args.urbit or find_urbit()
    if not urbit_bin:
        print("error: urbit binary not found; pass --urbit /path/to/urbit",
              file=sys.stderr)
        sys.exit(1)

    with open(TESTS_PATH) as f:
        tests = json.load(f)

    passed = 0
    failed = 0
    errors = []

    for i, t in enumerate(tests):
        actual, crashed = eval_nock(urbit_bin, t["subject"], t["formula"])
        expected = t["result"]

        if expected is None:
            ok = crashed
        else:
            ok = (not crashed) and (actual == expected)

        if ok:
            passed += 1
            tag = "\033[32mPASS\033[0m"
        else:
            failed += 1
            tag = "\033[31mFAIL\033[0m"
            errors.append((i, t, expected, actual, crashed))

        if args.verbose or not ok:
            print(f"  [{tag}] {i:2d}. {t['description']}")
            if not ok:
                exp_str = "crash" if expected is None else expected
                act_str = "crash" if crashed else actual
                print(f"         expected: {exp_str}")
                print(f"         actual:   {act_str}")

    total = passed + failed
    color = "\033[32m" if failed == 0 else "\033[31m"
    print(f"\n{color}{passed}/{total} passed\033[0m", end="")
    if failed:
        print(f"  ({failed} failed)")
    else:
        print()

    sys.exit(0 if failed == 0 else 1)


if __name__ == "__main__":
    main()
