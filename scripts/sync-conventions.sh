#!/usr/bin/env bash
# Regenerates skills/spec-kit/*/templates/spec-kit-conventions.md (the seed each skill bundles
# and scaffolds into a target project's docs/spec-kit-conventions.md) from the canonical
# docs/spec-kit-conventions.md in this repo.
#
# The canonical file's header describes this repo's own sync mechanics (mentions this script) -
# that's not meaningful in a downstream project, so the seed gets a simpler header instead. Body
# content (everything from the first "## " heading onward) is copied byte-identical.
#
# Run this after editing docs/spec-kit-conventions.md.
#
# `--check`: don't write anything — verify the 5 seeds already match what a sync would produce.
# Exits 0 if in sync, 1 (with a diff per stale seed) otherwise. Use this when you're not sure a
# sync was run after the last edit to docs/spec-kit-conventions.md.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

CHECK=0
if [ "${1:-}" = "--check" ]; then
  CHECK=1
fi

SRC="docs/spec-kit-conventions.md"
SKILLS=(setup-context c4-model plan-backlog list-backlog about-spec-kit)

if [ ! -f "$SRC" ]; then
  echo "error: canonical file not found: $SRC" >&2
  exit 1
fi

SEED_HEADER='# spec-kit-conventions

> Quy tắc dùng xuyên suốt Spec Kit (naming/ID/versioning, vòng đời `status`, glossary-link,
> ma trận lan truyền thay đổi...). Mỗi skill (`setup-context`, `c4-model`, `plan-backlog`,
> `list-backlog`, `about-spec-kit`) đọc file này trước khi tạo/sửa tài liệu — xem mục "Điều
> kiện tiên quyết" ở `SKILL.md` của từng skill.
'

BODY="$(awk '/^## /{found=1} found' "$SRC")"

EXPECTED_FILE="$(mktemp)"
trap 'rm -f "$EXPECTED_FILE"' EXIT
{ printf '%s\n' "$SEED_HEADER"; printf '%s\n' "$BODY"; } > "$EXPECTED_FILE"

if [ "$CHECK" = 1 ]; then
  stale=0
  for skill in "${SKILLS[@]}"; do
    dest="skills/spec-kit/$skill/templates/spec-kit-conventions.md"
    if [ ! -f "$dest" ] || ! diff -q "$EXPECTED_FILE" "$dest" > /dev/null 2>&1; then
      echo "STALE: $dest"
      diff -u "$dest" "$EXPECTED_FILE" 2>/dev/null || true
      stale=1
    fi
  done
  if [ "$stale" = 1 ]; then
    echo "error: seeds out of sync with $SRC — run scripts/sync-conventions.sh" >&2
    exit 1
  fi
  echo "OK: all ${#SKILLS[@]} seeds match $SRC."
  exit 0
fi

for skill in "${SKILLS[@]}"; do
  dest="skills/spec-kit/$skill/templates/spec-kit-conventions.md"
  mkdir -p "$(dirname "$dest")"
  cp "$EXPECTED_FILE" "$dest"
done

echo "Synced $SRC (body) to ${#SKILLS[@]} skill templates/ folders."
