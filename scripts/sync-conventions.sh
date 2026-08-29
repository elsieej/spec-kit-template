#!/usr/bin/env bash
# Syncs skills/spec-kit/setup-context/spec-kit-conventions.md (canonical) to the other
# 4 skill folders, byte-identical. Run this after editing spec-kit-conventions.md in any
# one of the 5 skill folders — edit the canonical copy below, then run this script.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

SRC="skills/spec-kit/setup-context/spec-kit-conventions.md"
DESTS=(
  "skills/spec-kit/c4-model/spec-kit-conventions.md"
  "skills/spec-kit/plan-backlog/spec-kit-conventions.md"
  "skills/spec-kit/backlog-status/spec-kit-conventions.md"
  "skills/spec-kit/about-spec-kit/spec-kit-conventions.md"
)

if [ ! -f "$SRC" ]; then
  echo "error: canonical file not found: $SRC" >&2
  exit 1
fi

for dest in "${DESTS[@]}"; do
  cp "$SRC" "$dest"
done

echo "Synced $SRC to ${#DESTS[@]} skill folders."
