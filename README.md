# SPEC KIT — Template quy trình phát triển phần mềm

Bộ khung tài liệu tái sử dụng cho việc phân tích nghiệp vụ → thiết kế kiến trúc (C4) →
backlog (Agile/Scrum) → thực thi/kiểm thử → release (Gitflow), có agent AI hỗ trợ ở mọi bước.

## Sơ đồ luồng

```
CONTEXT.md  (giới thiệu kit + thành phần chính — đọc trước tiên)
        │
        ▼  (skill /setup-context hỏi WHY→WHO→HOW, ghi thẳng vào 3 tầng dưới đây)
docs/00-business-requirement   (WHY)
        │
        ▼
docs/01-user-requirement       (WHO)
        │
        ▼
docs/02-functional-requirement (HOW)
        │
        ▼
docs/03-system-overview        (C4: Context + Container)  ← skill /c4-model
        │
        ▼
docs/04-backlog
   Epic → Feature → User Story → Task
        │
        ▼
docs/04-backlog/sprints  (Sprint Planning: kéo Task ready vào sprint, có start/end date)
        │
        ▼
   Execution + Testing (agent đọc Task để code)
        │
        ▼
docs/06-release  (theo Gitflow: release/* → main + develop)
        │
        └──▶ lặp lại: quay về Sprint Planning cho sprint kế tiếp, tới khi dự án kết thúc

── Đa repo (nếu triển khai code ở repo khác repo spec-kit này) ──
Mỗi Epic ứng với 1 container/repo triển khai (`source_container` + `repo` trong EPIC-xxx) → xem AGENTS.md

── Luồng ngoài (tác động ngược bất kỳ lúc nào) ──
docs/05-meetings/notes            → có thể tạo open-questions
docs/05-meetings/open-questions   → có thể block Epic/Feature/Story/Task
docs/07-glossary                  → context nền, agent luôn đọc trước khi làm việc
CLAUDE.md                         → quy ước đặt tên + versioning xuyên suốt
```

## Cách dùng cho dự án mới

1. Copy toàn bộ folder này vào repo dự án (giữ nguyên cấu trúc `docs/` + các file gốc).
2. Đọc `CONTEXT.md` — giới thiệu kit và các thành phần chính.
3. Chạy skill `/setup-context` — hỏi dẫn dắt WHY → WHO → HOW, ghi thẳng vào `BR-001`, `UR-001`,
   `FR-001` (`docs/00-02`), không qua bước nháp trung gian. Review từng tầng xong (set
   `status: approved`) mới sang tầng sau — không nhảy cấp (xem `AGENTS.md`).
4. Chạy skill `/c4-model` để tạo `docs/03-system-overview` (Context + Container Diagram) —
   xem Bước A trong `AGENTS.md`.
5. Chạy skill `/plan-backlog` để phân rã thành Epic → Feature → User Story → Task và kéo vào
   Sprint — xem tiêu chí phân rã + ví dụ minh hoạ ở `AGENTS.md` (Bước B, Bước F).
6. Khi cần sinh nội dung khác, giao cho agent kèm chỉ dẫn: "Đọc `AGENTS.md` rồi thực hiện
   bước X".
7. Mọi thay đổi tài liệu = 1 commit git với message theo `CLAUDE.md` (mục "Đặt tên, ID và versioning").

## Cấu trúc

- `CONTEXT.md` — giới thiệu kit + thành phần chính, đọc trước tiên
- `.claude/skills/setup-context` — skill hỏi WHY/WHO/HOW rồi tạo thẳng BR-001/UR-001/FR-001
- `.claude/skills/c4-model` — skill giải thích C4 Model + dẫn dắt tạo docs/03-system-overview
- `.claude/skills/plan-backlog` — skill phân rã Epic/Feature/User Story/Task + kéo vào Sprint
- `.claude/skills/backlog-status` — skill đọc frontmatter để trả lời sprint nào đang active,
  backlog hiện có gì, hoặc cây Epic→Feature→User Story→Task (không có dashboard/file trạng
  thái riêng, luôn tính lại từ frontmatter)
- `docs/00-03` — 3 tầng yêu cầu + system overview (C4 Context/Container)
- `docs/04-backlog` — Epic/Feature/User Story/Task (Epic phẳng, Feature/US/Task nằm trong
  subfolder theo Epic — xem `CLAUDE.md`), `sprints/` — Sprint Planning (start/end date)
- `docs/05-meetings` — biên bản họp + open questions (luồng ngoài)
- `docs/06-release` — kế hoạch release theo Gitflow
- `docs/07-glossary` — từ điển thuật ngữ dự án
- `CLAUDE.md` — quy trình pipeline + naming convention/ID/versioning
- `AGENTS.md` — hướng dẫn cho agent: nguyên tắc chung + quy trình theo từng bước (A–F) + làm việc đa repo
- `RULES.md` — tập hợp quy tắc dự án: ngôn ngữ/giọng văn, thuật ngữ, traceability, bảo mật, git/commit
