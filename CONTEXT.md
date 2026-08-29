# CONTEXT.md

File này giới thiệu Spec Kit là gì và các thành phần chính của kit — đọc đầu tiên, trước cả
`docs/business-requirement`. Bối cảnh cụ thể của dự án (WHY/WHO/WHAT) đi thẳng vào
`docs/business-requirement`/`docs/user-requirement`/`docs/functional-requirement`/
`docs/system-overview` qua skill `/setup-context`, không nháp ở đây — file này chỉ giữ lại "Giai đoạn
hiện tại" và "Team & đầu mối liên hệ", hai mục không có chỗ chính thức trong BR/UR/FR. Không
có frontmatter/ID/status như tài liệu trong `docs/` — nội dung ở đây là plain text.

## Spec Kit này là gì

Spec Kit là một khung tài liệu tái sử dụng cho việc phân tích nghiệp vụ → thiết kế kiến trúc
(C4) → backlog (Agile), có agent AI hỗ trợ ở mọi bước. Spec-kit dừng ở User Story. Chi tiết đầy
đủ về quy trình xem `CLAUDE.md`, về hành vi agent xem `AGENTS.md`.

## Để bắt đầu

1. Đọc `docs/glossary/glossary.md` — từ điển thuật ngữ dự án, đọc trước khi xử lý bất kỳ
   tài liệu nào.
2. Chạy skill `/setup-context` — sẽ hỏi bằng hội thoại tự nhiên về dự án bạn muốn làm (không
   phải 3 câu hỏi cố định), từ đó lộ ra vì sao dự án tồn tại, ai dùng, và nhu cầu/kết quả cần
   đạt được (chưa cần nói cách hiện thực), rồi ghi thẳng kết quả vào
   `docs/business-requirement`, `docs/user-requirement`,
   `docs/functional-requirement` (đúng template của từng tầng). Không có bước nháp trung gian —
   trả lời tới đâu, tài liệu chính thức được tạo tới đó, tránh giữ hai bản.
3. Review từng tầng xong mới sang tầng kế tiếp — không nhảy cấp (xem `AGENTS.md`).
4. Chạy skill `/c4-model` để tạo `docs/system-overview` (Context + Container + Component
   Diagram) khi `docs/glossary` đã đọc và BR/UR/FR đã `status: approved` — xem Bước A
   trong `AGENTS.md`.
5. Chạy skill `/plan-backlog` để phân rã thành Epic → Feature → User Story — xem tiêu chí
   phân rã + ví dụ minh hoạ ở `AGENTS.md` (Bước B).
6. Điền "Giai đoạn hiện tại" và "Team & đầu mối liên hệ" bên dưới — hai mục này không thuộc
   BR/UR/FR nên vẫn giữ ở đây.
7. Chi tiết đầy đủ cách dùng kit xem `README.md`.

## Các thành phần chính

- **Glossary** — `docs/glossary/glossary.md`: từ điển thuật ngữ nghiệp vụ + thuật ngữ kỹ
  thuật/văn phong, agent luôn đọc trước khi xử lý tài liệu.
- **Tài liệu hệ thống & kỹ thuật** — `docs/business-requirement`, `docs/user-requirement`,
  `docs/functional-requirement`, `docs/system-overview`: Business/User/Functional Requirement,
  rồi C4 Context + Container + Component. Trả lời WHY → WHO → WHAT → kiến trúc ở mức tổng quan.
- **Tracker quản lý issues** — `docs/backlog`: Epic → Feature → User Story (skill
  `plan-backlog` dẫn dắt phân rã). User Story là đơn vị thực thi cuối cùng trong spec-kit. Mỗi
  Epic ứng với 1 container (`source_container` trong `EPIC-xxx`, tra theo cột "Mã" ở
  `c4-container.md`).
- **Meetings & Open Questions** — `docs/meetings`: biên bản họp và câu hỏi mở; một OQ đang
  mở có thể block bất kỳ Epic/Feature/Story nào phụ thuộc vào nó.
- **Quy trình & naming convention** — `CLAUDE.md`: pipeline tổng thể, quy ước đặt tên/ID/
  versioning cho mọi loại tài liệu.
- **Hướng dẫn agent** — `AGENTS.md`: nguyên tắc chung + quy trình theo từng bước (A, B, C, E).
- **Quy tắc dự án** — `RULES.md`: ngôn ngữ/giọng văn, thuật ngữ, traceability, bảo mật,
  git/commit.

## Giai đoạn hiện tại
<Mới bắt đầu / đang phát triển / đang vận hành / đang migrate từ hệ thống cũ...>

## Team & đầu mối liên hệ
<Ai là product owner / tech lead / stakeholder chính cần hỏi khi có OQ>
