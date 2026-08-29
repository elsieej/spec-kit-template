# skills/spec-kit

Nguồn duy nhất (source of truth) cho 4 skill của kit này — `setup-context`, `c4-model`,
`plan-backlog`, `backlog-status`. Theo đúng convention `skills/<category>/<name>/SKILL.md` mà
CLI [vercel-labs/skills](https://github.com/vercel-labs/skills) (công cụ mattpocock/skills cũng
dùng) và hệ sinh thái xung quanh nó nhận diện — agent-agnostic, không riêng Claude Code.

## Cài đặt

```bash
npx skills add <owner>/spec-kit-template
```

CLI sẽ đọc skill từ đây, cho chọn skill nào cần, rồi cài vào đúng thư mục skill của coding agent
đang dùng (`.claude/skills/` nếu là Claude Code, hoặc thư mục tương ứng của agent khác).

**Cài qua `npx` một mình KHÔNG đủ để chạy pipeline** — nó chỉ mang theo đúng 4 file `SKILL.md`
(+ `examples.md`), không mang theo `docs/**/template.md`, `CLAUDE.md`, `AGENTS.md`, hay
`RULES.md` mà cả 4 skill tham chiếu cứng. Thiếu các file đó, mỗi skill sẽ tự dừng lại và báo
thiếu (xem mục "Điều kiện tiên quyết" ở đầu mỗi `SKILL.md`) thay vì tự bịa cấu trúc thay thế.
Muốn chạy được pipeline, clone toàn bộ repo `spec-kit-template` này làm scaffold cho dự án
(giữ nguyên `docs/`, `CLAUDE.md`, `AGENTS.md`, `RULES.md`, `CONTEXT.md`) — `npx skills add` chỉ
nên dùng để lấy skill mới nhất, không thay thế được bước clone scaffold này.

## Cập nhật

Khi repo này có bản cập nhật, ở dự án đã cài, chạy:

```bash
npx skills update
```

(hoặc `npx skills update -y` để bỏ qua câu hỏi phạm vi project/global). CLI tự nhớ nguồn +
đường dẫn của từng skill đã cài (`skills-lock.json`), so hash nội dung mới nhất từ repo này và
ghi đè skill nào đổi — không cần chạy lại `add` hay chỉ định lại `<owner>/spec-kit-template`.
Có thể cập nhật riêng lẻ: `npx skills update c4-model plan-backlog`.
