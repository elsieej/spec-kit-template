# CONTEXT.md

File này giới thiệu Spec Kit là gì và các thành phần chính của kit — đọc đầu tiên, trước cả
`docs/00-business-requirement`. Bối cảnh cụ thể của dự án (WHY/WHO/HOW) đi thẳng vào
`docs/00-03` qua skill `/setup-context`, không nháp ở đây — file này chỉ giữ lại "Giai đoạn
hiện tại" và "Team & đầu mối liên hệ", hai mục không có chỗ chính thức trong BR/UR/FR. Không
có frontmatter/ID/status như tài liệu trong `docs/` — nội dung ở đây là plain text.

## Spec Kit này là gì

Spec Kit là một khung tài liệu tái sử dụng cho việc phân tích nghiệp vụ → thiết kế kiến trúc
(C4) → backlog (Agile/Scrum) → thực thi/kiểm thử → release (Gitflow), có agent AI hỗ trợ ở
mọi bước. Chi tiết đầy đủ về quy trình xem `CLAUDE.md`, về hành vi agent xem `AGENTS.md`.

## Để bắt đầu

1. Chạy skill `/setup-context` — sẽ hỏi dẫn dắt qua WHY (vì sao) → WHO (ai dùng) → HOW (làm
   thế nào), rồi ghi thẳng kết quả vào `docs/00-business-requirement`, `01-user-requirement`,
   `02-functional-requirement` (đúng template của từng tầng). Không có bước nháp trung gian —
   trả lời tới đâu, tài liệu chính thức được tạo tới đó, tránh giữ hai bản.
2. Review từng tầng xong mới sang tầng kế tiếp — không nhảy cấp (xem `AGENTS.md`).
3. Chạy skill `/c4-model` để tạo `docs/03-system-overview` (Context + Container Diagram) khi
   `docs/00-02` đã `status: approved` — xem Bước A trong `AGENTS.md`.
4. Chạy skill `/plan-backlog` để phân rã thành Epic → Feature → User Story → Task và kéo vào
   Sprint — xem tiêu chí phân rã + ví dụ minh hoạ ở `AGENTS.md` (Bước B, Bước F).
5. Điền "Giai đoạn hiện tại" và "Team & đầu mối liên hệ" bên dưới — hai mục này không thuộc
   BR/UR/FR nên vẫn giữ ở đây.
6. Chi tiết đầy đủ cách dùng kit xem `README.md`.

## Các thành phần chính

- **Tài liệu hệ thống & kỹ thuật** — `docs/00-03`: Business/User/Functional Requirement, rồi
  C4 Context + Container. Trả lời WHY → WHO → HOW → kiến trúc ở mức tổng quan.
- **Tracker quản lý issues** — `docs/04-backlog`: Epic → Feature → User Story → Task (skill
  `plan-backlog` dẫn dắt phân rã); mức sprint quản lý ở `docs/04-backlog/sprints` (có
  `start_date`/`end_date`, kéo Task từ backlog vào sprint qua Bước F). Liên kết thủ công tới
  GitHub Issues/Jira qua field `external_ref`.
- **Đa repo** — mỗi Epic có thể ứng với một repo triển khai riêng (field `repo` trong
  `EPIC-xxx`); repo triển khai chỉ đọc backlog từ đây, không phải nguồn sự thật (xem
  `AGENTS.md`, "Làm việc đa repo").
- **Meetings & Open Questions** — `docs/05-meetings`: biên bản họp và câu hỏi mở; một OQ đang
  mở có thể block bất kỳ Epic/Feature/Story/Task nào phụ thuộc vào nó.
- **Release** — `docs/06-release`: kế hoạch release theo Gitflow (`release/*` → `main` +
  `develop`) và changelog.
- **Glossary** — `docs/07-glossary/glossary.md`: từ điển thuật ngữ nghiệp vụ + thuật ngữ kỹ
  thuật/văn phong, agent luôn đọc trước khi xử lý tài liệu.
- **Quy trình & naming convention** — `CLAUDE.md`: pipeline tổng thể, quy ước đặt tên/ID/
  versioning cho mọi loại tài liệu.
- **Hướng dẫn agent** — `AGENTS.md`: nguyên tắc chung + quy trình theo từng bước (A–F) + đa repo.
- **Quy tắc dự án** — `RULES.md`: ngôn ngữ/giọng văn, thuật ngữ, traceability, bảo mật,
  git/commit.

## Giai đoạn hiện tại
<Mới bắt đầu / đang phát triển / đang vận hành / đang migrate từ hệ thống cũ...>

## Team & đầu mối liên hệ
<Ai là product owner / tech lead / stakeholder chính cần hỏi khi có OQ>
