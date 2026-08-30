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

Chỉ cần 1 bước: cài 5 skill qua `npx skills add <owner>/spec-kit-template` (xem
`skills/spec-kit/README.md` — cả cách cài lẫn cách cập nhật sau này qua `npx skills update`).
Mỗi skill mang theo sẵn template cần thiết, tự tạo `docs/` khi chưa có — bao gồm cả
`docs/spec-kit-conventions.md` (naming/ID, vòng đời `status`, glossary-link, ma trận lan truyền
thay đổi, commit format...), scaffold thành đúng 1 bản trong dự án dù skill nào chạy trước.

Sau khi cài, chạy skill `/about-spec-kit` — skill này liệt kê đủ các bước tiếp theo (chạy skill
nào, theo thứ tự nào) và không bị lặp lại ở đây để tránh 2 nơi cùng mô tả 1 flow dễ lệch nhau.

## Cấu trúc

- `CONTEXT.md` — giới thiệu kit + thành phần chính, đọc trước tiên
- `docs/spec-kit-conventions.md` — bản canonical của quy tắc xuyên suốt kit (naming/ID, vòng
  đời `status`, glossary-link, ma trận lan truyền thay đổi...); mỗi skill trong `skills/spec-kit/`
  bundle 1 bản seed và tự scaffold file này cho dự án đích khi chưa có — sửa ở đây rồi chạy
  `scripts/sync-conventions.sh` để đồng bộ các bản seed
- `docs/glossary` — từ điển thuật ngữ dự án, agent luôn đọc trước khi làm việc
- `skills/spec-kit/` — nguồn của 5 skill (cài qua `npx skills add`, xem
  `skills/spec-kit/README.md`) — mỗi skill mang theo sẵn template cần thiết trong `templates/`
  cạnh chính nó, tự scaffold `docs/` khi dự án chưa có (kể cả `docs/spec-kit-conventions.md`,
  bản dẫn xuất của các quy tắc xuyên suốt kit — bundle sẵn ở cả 5 skill nhưng chỉ scaffold thành
  1 bản trong dự án):
  - `about-spec-kit` — giới thiệu kit là gì, liệt kê skill nào dùng khi nào
  - `setup-context` — hội thoại tự nhiên về dự án rồi tạo thẳng BR-001/UR-001/FR-001
  - `c4-model` — giải thích C4 Model + dẫn dắt tạo docs/system-overview
  - `plan-backlog` — phân rã Epic/Feature/User Story
  - `list-backlog` — đọc frontmatter để trả lời backlog hiện có gì, hoặc cây
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
