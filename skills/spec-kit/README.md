# skills/spec-kit

Bản mirror của `.claude/skills/` — tồn tại riêng để repo này cài được qua
`npx skills add <owner>/spec-kit-template` (CLI [vercel-labs/skills](https://github.com/vercel-labs/skills),
cùng công cụ mattpocock/skills dùng), theo đúng convention `skills/<category>/<name>/SKILL.md`
mà hệ sinh thái này dùng chung cho nhiều coding agent, không riêng Claude Code.

**`.claude/skills/` là nguồn duy nhất (source of truth).** Nội dung ở đây phải là bản copy y hệt
— sửa nội dung 1 skill thì sửa ở `.claude/skills/<tên>/` trước, rồi copy lại đúng file(s) sang
đây. Không sửa trực tiếp ở đây rồi quên đồng bộ ngược.

Khi copy toàn bộ template vào 1 dự án mới (xem `README.md` gốc, mục "Cách dùng cho dự án mới"),
Claude Code chỉ đọc `.claude/skills/` — thư mục `skills/` này không cần thiết cho cách dùng đó,
chỉ phục vụ đường cài qua `npx skills add`.
