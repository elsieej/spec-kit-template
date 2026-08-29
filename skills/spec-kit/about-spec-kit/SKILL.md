---
name: about-spec-kit
description: >
  Giới thiệu Spec Kit là gì, các thành phần chính, và nên chạy skill nào khi nào (setup-context
  → c4-model → plan-backlog → backlog-status). Dùng skill này khi user hỏi "spec kit này là
  gì", "kit này dùng sao", "bắt đầu thế nào", "có những skill nào", hoặc ngay sau khi cài skill
  lần đầu và chưa biết bắt đầu từ đâu.
---

# about-spec-kit

## Spec Kit là gì

Spec Kit là một khung tài liệu tái sử dụng cho việc phân tích nghiệp vụ → thiết kế kiến trúc
(C4) → backlog (Agile), có agent AI hỗ trợ ở mọi bước. Spec-kit dừng ở User Story — đây là đơn
vị thực thi cuối cùng, không có tầng Task kỹ thuật, Sprint, hay Release riêng.

Quy tắc dùng xuyên suốt kit (naming/ID, vòng đời `status`, glossary-link, ma trận lan truyền
thay đổi...) nằm ở [spec-kit-conventions.md](spec-kit-conventions.md), đi kèm sẵn cạnh
`SKILL.md` này (và cả 4 skill còn lại) — đọc khi cần chi tiết hơn phần tóm tắt dưới đây.

## Có những skill nào, dùng khi nào

| Skill | Dùng khi | Output |
|---|---|---|
| `setup-context` | Chưa có `docs/business-requirement` nào, muốn bắt đầu dự án mới | `BR-001`, `UR-001`, `FR-001` |
| `c4-model` | BR/UR/FR đã `status: approved`, cần kiến trúc hệ thống | `docs/system-overview` (C4 Context/Container/Component + Interface Contract) |
| `plan-backlog` | BR/UR/FR đã approved và `c4-container.md` đã có, cần chia việc | `docs/backlog` (Epic → Feature → User Story) |
| `backlog-status` | Muốn biết backlog hiện có gì, hoặc cây Epic→Feature→User Story | Không tạo file — chỉ đọc và tổng hợp |
| `about-spec-kit` (skill này) | Chưa rõ kit này là gì hoặc bắt đầu từ đâu | Không tạo file — chỉ giải thích |

## Để bắt đầu 1 dự án mới

1. Chạy skill `/setup-context` — hội thoại tự nhiên về dự án muốn làm (không phải 3 câu hỏi cố
   định WHY/WHO/WHAT đọc nguyên văn), ghi thẳng vào `BR-001`/`UR-001`/`FR-001`, không qua bước
   nháp trung gian.
2. Review từng tầng xong (set `status: approved`) mới sang tầng sau — không nhảy cấp (xem
   `spec-kit-conventions.md` mục 2, nguyên tắc chung #2).
3. Chạy skill `/c4-model` để tạo `docs/system-overview` (Context + Container + Component
   Diagram, và Container/Entity Interface Contract khi cần).
4. Chạy skill `/plan-backlog` để phân rã thành Epic → Feature → User Story.
5. Chạy skill `/backlog-status` bất kỳ lúc nào để xem backlog hiện có gì hoặc cây phân cấp.
6. Mọi thay đổi tài liệu = 1 commit git riêng, định dạng xem `spec-kit-conventions.md` mục
   "Commit".

## Các thành phần chính

- **Glossary** (`docs/glossary/glossary.md`) — từ điển thuật ngữ nghiệp vụ + kỹ thuật/văn
  phong, luôn đọc trước khi xử lý tài liệu (agent tự scaffold khi `setup-context` chạy lần đầu).
- **Tài liệu hệ thống & kỹ thuật** — `docs/business-requirement`, `docs/user-requirement`,
  `docs/functional-requirement`, `docs/system-overview`: Business/User/Functional Requirement,
  rồi C4 Context + Container + Component. Trả lời WHY → WHO → WHAT → kiến trúc tổng quan.
- **Tracker quản lý issues** — `docs/backlog`: Epic → Feature → User Story. Mỗi Epic ứng với 1
  container (`source_container`, tra theo cột "Mã" ở `c4-container.md`).
- **Meetings & Open Questions** — `docs/meetings`: biên bản họp và câu hỏi mở; một OQ đang mở có
  thể block bất kỳ Epic/Feature/Story nào phụ thuộc vào nó.
- **spec-kit-conventions.md** — quy tắc xuyên suốt (naming/ID, `status`, glossary-link, ma trận
  lan truyền thay đổi, commit format...), đi kèm sẵn cạnh mỗi `SKILL.md`.

Spec-kit này **không có** tầng Task kỹ thuật, Sprint, hay Release — User Story là đơn vị nhỏ
nhất và cuối cùng agent/dev cần để bắt đầu thực hiện (viết code).
