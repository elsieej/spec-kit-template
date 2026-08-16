# CLAUDE.md

File này cung cấp hướng dẫn cho Claude Code (claude.ai/code) khi làm việc với code trong
repository này. Đây là repo dạng tài liệu (Spec Kit) — không có code ứng dụng, không
build/lint/test. Giới thiệu đầy đủ về kit xem `README.md`/`CONTEXT.md`. File này chỉ giữ phần
không nơi nào khác có: quy ước đặt tên/ID/versioning, và vài ghi chú vận hành.

## Đặt tên, ID và versioning

| Loại | Prefix | Ví dụ |
|---|---|---|
| Business Requirement | BR | BR-001 |
| User Requirement | UR | UR-001 |
| Functional Requirement | FR | FR-001 |
| System Overview (Context) | SYS-CTX | SYS-CTX-001 |
| System Overview (Container) | SYS-CTR | SYS-CTR-001 |
| Epic | EPIC | EPIC-001 |
| Feature | FEAT | FEAT-001 |
| User Story | US | US-001 |
| Task | TASK | TASK-001 |
| Sprint | SPRINT | SPRINT-001 |
| Meeting Notes | MEET | MEET-20260816-01 (ngày + số thứ tự trong ngày) |
| Open Question | OQ | OQ-001 |
| Release | REL | REL-v1.2.0 |

- Tên file theo mẫu: `{PREFIX}-{ID}_{slug-ngan-gon}.md`, ví dụ `EPIC-003_checkout-flow.md`.
- Frontmatter của mỗi file có `version` (số nguyên tăng dần), `status`, và `last_updated`. Không xoá nội dung cũ khi sửa lớn — tăng `version`, dùng `git log`/`git blame` để xem lịch sử; không tạo file riêng cho mỗi version.
- Vòng đời `status` KHÔNG dùng chung một enum cho mọi loại tài liệu — mỗi nhóm có vòng đời
  riêng, khớp đúng với enum ghi trong comment frontmatter của template loại đó:

  | Nhóm tài liệu | Vòng đời `status` |
  |---|---|
  | BR / UR / FR / SYS-CTX / SYS-CTR | `draft → in-review → approved` (→ `changed` nếu tài liệu đã `approved` bị sửa nội dung, cần re-review trước khi tiếp tục dùng làm nguồn cho tầng sau) |
  | Epic / Feature | `draft → ready → in-progress → blocked → done` |
  | User Story / Task | `draft → ready → in-progress → in-review → blocked → done` |
  | Sprint | `planned → active → blocked → done` |
  | Release | `planned → in-progress → blocked → released` |
  | Open Question | `open → answered → closed` |

  Mọi tài liệu có `blocked` trong enum của nó đều bắt buộc kèm
  `blocked_by_open_questions: [OQ-xxx]` khi ở trạng thái đó (không được để `blocked` mà thiếu
  field này). BR/UR/FR không có trạng thái `blocked` — chỉ dùng field `related_open_questions`
  để ghi nhận OQ liên quan (không chặn tiến độ vì tầng sau chỉ cần các tầng này ở trạng thái
  `approved`, không tự sinh khi còn OQ mở).
- Định dạng commit message: `docs(<prefix>): <ID> [SPRINT-xxx] <mô tả ngắn>`, gắn `SPRINT-xxx`
  đang active nếu thay đổi phát sinh trong sprint đó (ví dụ do họp sprint — xem `AGENTS.md`,
  Bước E); bỏ phần `[SPRINT-xxx]` nếu chưa có sprint nào đang chạy. Ví dụ:
  `docs(us): US-004 [SPRINT-003] add acceptance criteria for refund flow`.
- Nếu cần sửa gấp một tài liệu đã `approved`/`done` ngoài chu kỳ sprint bình thường (phát sinh
  từ họp khẩn), dùng prefix `hotfix` thay `docs`: `hotfix(<prefix>): <ID> <mô tả ngắn>` — tương
  ứng nhánh `hotfix/*` theo Gitflow (xem `AGENTS.md`, Bước D).
- Mọi file backlog phải có field `parent_*` trỏ ngược lên tài liệu đã sinh ra nó, để truy vết một Task qua User Story → Feature → Epic → Business Requirement.

Đây là nguồn duy nhất cho naming convention trong repo — không tạo file trùng nội dung này ở nơi khác.

## Tham khảo nhanh

- Sơ đồ luồng đầy đủ (docs/00 → release, kèm sprint/đa-repo): `README.md`.
- Nguyên tắc chung + quy trình agent theo Bước A–F + "Làm việc đa repo" (kèm sơ đồ mermaid): `AGENTS.md`.
- Ngôn ngữ/giọng văn, thuật ngữ, traceability, bảo mật, git/commit: `RULES.md`.
- Thuật ngữ nghiệp vụ + kỹ thuật/văn phong: `docs/07-glossary/glossary.md`.
- Bối cảnh dự án cụ thể + các thành phần chính của kit: `CONTEXT.md`.
- Khởi tạo BR/UR/FR bằng câu hỏi WHY/WHO/HOW: skill `setup-context`.
- Giải thích C4 Model + tạo `docs/03-system-overview`: skill `c4-model`.
- Phân rã Epic → Feature → User Story → Task, kéo vào Sprint: skill `plan-backlog`.
- Sprint nào đang active + backlog hiện có gì (đọc trực tiếp frontmatter, không có dashboard
  riêng): skill `backlog-status`.

## Làm việc trong repo này

- Không có code ứng dụng, nên không có gì để build/lint/run — công việc hoàn toàn nằm trong các tài liệu Markdown dưới `docs/` cùng các file gốc (`CONTEXT.md`, `AGENTS.md`, `RULES.md`).
- Khi được yêu cầu "thực hiện bước X", quy trình thực tế cần tuân theo là những gì `AGENTS.md` quy định cho bước đó — coi nó là spec vận hành, không phải file này.
- Template trong mỗi `docs/**/template.md` (hoặc `*-template.md`) định nghĩa cấu trúc/frontmatter bắt buộc cho loại tài liệu đó; luôn bắt đầu tài liệu mới từ template của nó.
