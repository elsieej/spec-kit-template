# SPEC KIT — Template quy trình phát triển phần mềm

Bộ khung tài liệu tái sử dụng cho việc phân tích nghiệp vụ → thiết kế kiến trúc (C4) →
backlog (Agile), có agent AI hỗ trợ ở mọi bước. Spec-kit dừng ở User Story.

## Sơ đồ luồng

```
CONTEXT.md  (giới thiệu kit + thành phần chính — đọc trước tiên)
        │
        ▼
docs/00-glossary  (từ điển thuật ngữ — context nền, agent luôn đọc trước khi làm việc)
        │
        ▼  (skill /setup-context hỏi WHY→WHO→WHAT, ghi thẳng vào 3 tầng dưới đây)
docs/01-business-requirement   (WHY)
        │
        ▼
docs/02-user-requirement       (WHO)
        │
        ▼
docs/03-functional-requirement (WHAT)
        │
        ▼
docs/04-system-overview        (C4: Context + Container + Component)  ← skill /c4-model
        │
        ▼
docs/05-backlog
   Epic → Feature → User Story
        │
        ▼
   Execution + Testing (agent đọc User Story để code) — xem AGENTS.md, Bước C
        │
        └──▶ lặp lại: quay về Bước B (Backlog) khi cần thêm Feature/User Story mới

── Luồng ngoài (tác động ngược bất kỳ lúc nào) ──
docs/06-meetings/notes            → có thể tạo open-questions
docs/06-meetings/open-questions   → có thể block Epic/Feature/Story
CLAUDE.md                         → quy ước đặt tên + versioning xuyên suốt
```

## Cách dùng cho dự án mới

1. Copy toàn bộ folder này vào repo dự án (giữ nguyên cấu trúc `docs/` + các file gốc).
2. Copy `docs/00-glossary/template.md` thành `docs/00-glossary/glossary.md` (giữ nguyên nội
   dung mặc định, điền dần thuật ngữ nghiệp vụ khi viết BR/UR/FR — xem `RULES.md`). Đọc
   `CONTEXT.md` — giới thiệu kit và các thành phần chính — và `glossary.md` vừa tạo.
3. Chạy skill `/setup-context` — hỏi dẫn dắt WHY → WHO → WHAT, ghi thẳng vào `BR-001`, `UR-001`,
   `FR-001` (`docs/01-03`), không qua bước nháp trung gian. Review từng tầng xong (set
   `status: approved`) mới sang tầng sau — không nhảy cấp (xem `AGENTS.md`).
4. Chạy skill `/c4-model` để tạo `docs/04-system-overview` (Context + Container + Component
   Diagram) — xem Bước A trong `AGENTS.md`.
5. Chạy skill `/plan-backlog` để phân rã thành Epic → Feature → User Story — xem tiêu chí
   phân rã + ví dụ minh hoạ ở `AGENTS.md` (Bước B).
6. Khi cần sinh nội dung khác, giao cho agent kèm chỉ dẫn: "Đọc `AGENTS.md` rồi thực hiện
   bước X".
7. Mọi thay đổi tài liệu = 1 commit git với message theo `CLAUDE.md` (mục "Đặt tên, ID và versioning").

## Cấu trúc

- `CONTEXT.md` — giới thiệu kit + thành phần chính, đọc trước tiên
- `docs/00-glossary` — từ điển thuật ngữ dự án, agent luôn đọc trước khi làm việc
- `.claude/skills/setup-context` — skill hỏi WHY/WHO/WHAT rồi tạo thẳng BR-001/UR-001/FR-001
- `.claude/skills/c4-model` — skill giải thích C4 Model + dẫn dắt tạo docs/04-system-overview
- `.claude/skills/plan-backlog` — skill phân rã Epic/Feature/User Story
- `.claude/skills/backlog-status` — skill đọc frontmatter để trả lời backlog hiện có gì, hoặc
  cây Epic→Feature→User Story (không có dashboard/file trạng thái riêng, luôn tính lại từ
  frontmatter)
- `docs/01-04` — 3 tầng yêu cầu + system overview (C4 Context/Container/Component +
  container-interface-contracts, mã CIC, khi có dữ liệu thật cần thống nhất trước giữa 2 container)
- `docs/05-backlog` — Epic/Feature/User Story (Epic phẳng, Feature/US nằm trong subfolder
  theo Epic — xem `CLAUDE.md`)
- `docs/06-meetings` — biên bản họp + open questions (luồng ngoài)
- `CLAUDE.md` — quy trình pipeline + naming convention/ID/versioning
- `AGENTS.md` — hướng dẫn cho agent: nguyên tắc chung + quy trình theo từng bước (A, B, C, E)
- `RULES.md` — tập hợp quy tắc dự án: ngôn ngữ/giọng văn, thuật ngữ, traceability, bảo mật, git/commit
