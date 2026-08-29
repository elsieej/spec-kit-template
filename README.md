# SPEC KIT — Template quy trình phát triển phần mềm

Bộ khung tài liệu tái sử dụng cho việc phân tích nghiệp vụ → thiết kế kiến trúc (C4) →
backlog (Agile), có agent AI hỗ trợ ở mọi bước. Spec-kit dừng ở User Story.

## Sơ đồ luồng

```
CONTEXT.md  (giới thiệu kit + thành phần chính — đọc trước tiên)
        │
        ▼
docs/glossary  (từ điển thuật ngữ — context nền, agent luôn đọc trước khi làm việc)
        │
        ▼  (skill /setup-context hội thoại tự nhiên về dự án, ghi thẳng vào 3 tầng dưới đây)
docs/business-requirement   (WHY)
        │
        ▼
docs/user-requirement       (WHO)
        │
        ▼
docs/functional-requirement (WHAT)
        │
        ▼
docs/system-overview        (C4: Context + Container + Component)  ← skill /c4-model
        │
        ▼
docs/backlog
   Epic → Feature → User Story
        │
        ▼
   Execution + Testing (agent đọc User Story để code) — xem AGENTS.md, Bước C
        │
        └──▶ lặp lại: quay về Bước B (Backlog) khi cần thêm Feature/User Story mới

── Luồng ngoài (tác động ngược bất kỳ lúc nào) ──
docs/meetings/notes            → có thể tạo open-questions
docs/meetings/open-questions    → có thể block Epic/Feature/Story
CLAUDE.md                       → quy ước đặt tên + versioning xuyên suốt
```

## Cách dùng cho dự án mới

1. Cài 4 skill qua `npx skills add <owner>/spec-kit-template` (xem `skills/spec-kit/README.md`).
2. Copy `docs/glossary/template.md` thành `docs/glossary/glossary.md` (giữ nguyên nội
   dung mặc định, điền dần thuật ngữ nghiệp vụ khi viết BR/UR/FR — xem `RULES.md`). Đọc
   `CONTEXT.md` — giới thiệu kit và các thành phần chính — và `glossary.md` vừa tạo.
3. Chạy skill `/setup-context` — hội thoại tự nhiên về dự án muốn làm (không phải 3 câu hỏi cố
   định), ghi thẳng vào `BR-001`, `UR-001`, `FR-001` (`docs/business-requirement`,
   `docs/user-requirement`, `docs/functional-requirement`), không qua bước nháp trung
   gian. Review từng tầng xong (set
   `status: approved`) mới sang tầng sau — không nhảy cấp (xem `AGENTS.md`).
4. Chạy skill `/c4-model` để tạo `docs/system-overview` (Context + Container + Component
   Diagram) — xem Bước A trong `AGENTS.md`.
5. Chạy skill `/plan-backlog` để phân rã thành Epic → Feature → User Story — xem tiêu chí
   phân rã + ví dụ minh hoạ ở `AGENTS.md` (Bước B).
6. Khi cần sinh nội dung khác, giao cho agent kèm chỉ dẫn: "Đọc `AGENTS.md` rồi thực hiện
   bước X".
7. Mọi thay đổi tài liệu = 1 commit git với message theo `CLAUDE.md` (mục "Đặt tên, ID và versioning").

## Cấu trúc

- `CONTEXT.md` — giới thiệu kit + thành phần chính, đọc trước tiên
- `docs/glossary` — từ điển thuật ngữ dự án, agent luôn đọc trước khi làm việc
- `skills/spec-kit/` — nguồn của 4 skill (cài qua `npx skills add`, xem
  `skills/spec-kit/README.md`):
  - `setup-context` — hội thoại tự nhiên về dự án rồi tạo thẳng BR-001/UR-001/FR-001
  - `c4-model` — giải thích C4 Model + dẫn dắt tạo docs/system-overview
  - `plan-backlog` — phân rã Epic/Feature/User Story
  - `backlog-status` — đọc frontmatter để trả lời backlog hiện có gì, hoặc cây
    Epic→Feature→User Story (không có dashboard/file trạng thái riêng, luôn tính lại từ
    frontmatter)
- `docs/business-requirement`, `docs/user-requirement`, `docs/functional-requirement`,
  `docs/system-overview` — 3 tầng yêu cầu + system overview (C4 Context/Container/Component +
  container-interface, mã CIC, khi có dữ liệu thật cần thống nhất trước giữa 2 container
  + entity-interface, entity/quan hệ dữ liệu, khi nhiều CIC/container dùng chung entity — mọi
  template của tầng system overview nằm trong `docs/system-overview/templates/`, tách biệt
  khỏi tài liệu thật)
- `docs/backlog` — Epic/Feature/User Story (Epic phẳng, Feature/US nằm trong subfolder
  theo Epic — xem `CLAUDE.md`)
- `docs/meetings` — biên bản họp + open questions (luồng ngoài)
- `CLAUDE.md` — quy trình pipeline + naming convention/ID/versioning
- `AGENTS.md` — hướng dẫn cho agent: nguyên tắc chung + quy trình theo từng bước (A, B, C, E)
- `RULES.md` — tập hợp quy tắc dự án: ngôn ngữ/giọng văn, thuật ngữ, traceability, bảo mật, git/commit
