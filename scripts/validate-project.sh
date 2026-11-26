#!/usr/bin/env bash
set -euo pipefail

fail() {
  echo "ERROR: $*" >&2
  exit 1
}

grep -q 'GT-S6500D' README.md || fail "README does not identify GT-S6500D"
grep -q 'cyanogenmod/jenad_defconfig' docs/DEVICE.md || fail "Kernel defconfig path is missing"
grep -q 'CONFIG_MACH_JENA=y' docs/DEVICE.md || fail "Jena kernel config symbol is missing"

echo "DELL OS metadata validation passed."
echo "Note: this is not an Android build and produces no flashable ROM."
