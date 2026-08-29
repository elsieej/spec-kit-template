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
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

SRC="docs/spec-kit-conventions.md"
SKILLS=(setup-context c4-model plan-backlog backlog-status about-spec-kit)

if [ ! -f "$SRC" ]; then
  echo "error: canonical file not found: $SRC" >&2
  exit 1
fi

SEED_HEADER='# spec-kit-conventions

> Quy tắc dùng xuyên suốt Spec Kit (naming/ID/versioning, vòng đời `status`, glossary-link,
> ma trận lan truyền thay đổi...). Mỗi skill (`setup-context`, `c4-model`, `plan-backlog`,
> `backlog-status`, `about-spec-kit`) đọc file này trước khi tạo/sửa tài liệu — xem mục "Điều
> kiện tiên quyết" ở `SKILL.md` của từng skill.
'

BODY="$(awk '/^## /{found=1} found' "$SRC")"

for skill in "${SKILLS[@]}"; do
  dest="skills/spec-kit/$skill/templates/spec-kit-conventions.md"
  mkdir -p "$(dirname "$dest")"
  { printf '%s\n' "$SEED_HEADER"; printf '%s\n' "$BODY"; } > "$dest"
done

echo "Synced $SRC (body) to ${#SKILLS[@]} skill templates/ folders."
