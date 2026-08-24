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
| System Overview (Component) | SYS-CMP | SYS-CMP-001 |
| System Overview (Container Interface Contract) | SYS-IFC | SYS-IFC-001 |
| System Overview (Schema/Entity Data Model) | SYS-SIC | SYS-SIC-001 |
| Epic | EPIC | EPIC-001 |
| Feature | FEAT | FEAT-001 |
| User Story | US | US-001 |
| Meeting Notes | MEET | MEET-20260816-01 (ngày + số thứ tự trong ngày) |
| Open Question | OQ | OQ-001 |

Spec-kit này dừng ở User Story — đây là đơn vị thực thi cuối cùng, không có tầng Task kỹ thuật
riêng.

- Tên file theo mẫu: `{PREFIX}-{ID}_{slug-ngan-gon}.md`, ví dụ `EPIC-003_checkout-flow.md`.
- Feature/User Story nằm trong subfolder theo Epic sở hữu, KHÔNG để phẳng chung 1 thư mục —
  tránh thư mục có hàng nghìn file khi backlog lớn (nhiều Epic × nhiều Feature × nhiều US):
  `docs/05-backlog/{features,user-stories}/{EPIC-ID}_{slug-epic}/{PREFIX}-xxx_{slug}.md`,
  trong đó `{EPIC-ID}_{slug-epic}` trùng đúng tên file Epic sở hữu (bỏ đuôi `.md`), ví dụ
  `docs/05-backlog/features/EPIC-003_checkout-flow/FEAT-012_luu-the.md`. Epic vẫn nằm phẳng
  trong `docs/05-backlog/epics/` (số lượng Epic luôn nhỏ, không cần subfolder). Đây chỉ là tổ
  chức vật lý để dễ duyệt — `parent_*` trong frontmatter mới là nguồn sự thật cho quan hệ cha-con.
- Frontmatter của mỗi file có `version` (số nguyên tăng dần) và `last_updated`, **trừ Meeting
  Notes** (`MEET-*`) — biên bản họp là bản ghi sự việc đã xảy ra, không theo vòng đời
  draft/approved nên không có field `status`, nhưng vẫn có `version`/`last_updated` để theo dõi
  khi có sửa/bổ sung sau này. Không xoá nội dung cũ khi sửa lớn — tăng `version`, dùng
  `git log`/`git blame` để xem lịch sử; không tạo file riêng cho mỗi version.
- Vòng đời `status` dùng chung 1 bộ 4 giá trị `draft | approved | blocked | deprecated` cho
  mọi loại tài liệu — chỉ khác nhau ở việc có dùng `blocked` hay không:

  | Nhóm tài liệu | Vòng đời `status` |
  |---|---|
  | BR / UR / FR / SYS-CTX / SYS-CTR / SYS-CMP / SYS-IFC / SYS-SIC (không có `blocked`, dùng `related_open_questions`) | `draft → approved` (→ `deprecated` khi không còn dùng — bị thay thế hoặc lỗi thời) |
  | Epic, Feature, User Story, Open Question (có `blocked`, dùng `blocked_by_open_questions`) | `draft → approved → blocked → deprecated` |

  Ý nghĩa từng giá trị, áp dụng thống nhất cho mọi loại:
  - `draft` — đang soạn hoặc đang thực hiện, CHƯA hoàn tất/CHƯA được chấp nhận là kết quả cuối
    (gộp chung mọi mức "chưa xong" trước đây — chưa bắt đầu, đang làm, đang review).
  - `approved` — đã hoàn tất và được chấp nhận: với BR/UR/FR/SYS-CTX/SYS-CTR/SYS-CMP/SYS-IFC/SYS-SIC là
    nội dung đã chốt, dùng làm nguồn cho tầng sau; với Epic/Feature/User Story/Open Question là
    công việc/mục đó đã xong và được chấp nhận (thay cho `done`/`answered` trước đây).
  - `blocked` — chỉ áp dụng cho Epic/Feature/User Story/Open Question: đang bị chặn bởi ít nhất
    1 Open Question đang mở; hết bị chặn thì trả lại đúng `status` trước khi bị block (`draft`
    hoặc `approved`), không mặc định về `draft`.
  - `deprecated` — không còn dùng nữa (bị thay thế, huỷ, hoặc lỗi thời).

  Sửa nội dung một tài liệu đã `approved` (BR/UR/FR/SYS-CTX/SYS-CTR/SYS-CMP/SYS-IFC/SYS-SIC) thì đưa lại
  về `draft` để review lại trước khi tiếp tục dùng làm nguồn cho tầng sau.

  Mọi tài liệu có `blocked` trong enum của nó đều bắt buộc kèm
  `blocked_by_open_questions: [OQ-xxx]` khi ở trạng thái đó (không được để `blocked` mà thiếu
  field này). BR/UR/FR/SYS-CTX/SYS-CTR/SYS-CMP/SYS-IFC/SYS-SIC không có trạng thái `blocked` — chỉ dùng
  field `related_open_questions` để ghi nhận OQ liên quan (không chặn tiến độ vì tầng sau chỉ
  cần các tầng này ở trạng thái `approved`, không tự sinh khi còn OQ mở). Vì vậy 1 tài liệu ở
  nhóm này hoàn toàn có thể ở `status: approved` trong khi `related_open_questions` vẫn còn ID
  chưa trả lời — đặc tính thiết kế (liên kết mềm để biết còn OQ nào liên quan, không phải gate
  cứng chặn tiến độ), không phải lỗi cần set lại về `draft`.
- Định dạng commit message: `docs(<prefix>): <ID> <mô tả ngắn>`. Ví dụ:
  `docs(us): US-004 add acceptance criteria for refund flow`. Khi 1 skill tạo nhiều tài liệu
  khác loại cùng lúc trong 1 lần chạy (ví dụ `setup-context` tạo BR-001+UR-001+FR-001), gộp
  thành 1 commit, dùng prefix của tài liệu gốc/thấp nhất trong chuỗi và liệt kê mọi ID còn lại
  trong mô tả ngắn, ví dụ `docs(br): BR-001 setup context (+ UR-001, FR-001)`.
- Mọi file backlog phải trỏ ngược lên tài liệu đã sinh ra nó: `parent_*` cho quan hệ cha-con
  trong backlog (`parent_epic` trên Feature, `parent_feature` trên User Story), và
  `docs_requirements` (mảng ID BR/UR/FR) cho liên kết tới tầng 01-03 — để truy vết một User
  Story qua Feature → Epic → BR/UR/FR liên quan.

Đây là nguồn duy nhất cho naming convention trong repo — không tạo file trùng nội dung này ở nơi khác.

## Tham khảo nhanh

- Sơ đồ luồng đầy đủ (docs/01 → backlog): `README.md`.
- Nguyên tắc chung + quy trình agent theo Bước A–C, E + "Ma trận lan truyền thay đổi" (sơ đồ
  mermaid: sửa 1 tài liệu thì cần rà soát gì): `AGENTS.md`.
- Ngôn ngữ/giọng văn, thuật ngữ, traceability, bảo mật, git/commit: `RULES.md`.
- Thuật ngữ nghiệp vụ + kỹ thuật/văn phong: `docs/00-glossary/glossary.md`.
- Bối cảnh dự án cụ thể + các thành phần chính của kit: `CONTEXT.md`.
- Khởi tạo BR/UR/FR bằng câu hỏi WHY/WHO/WHAT: skill `setup-context`.
- Giải thích C4 Model + tạo `docs/04-system-overview`: skill `c4-model`.
- Phân rã Epic → Feature → User Story: skill `plan-backlog`.
- Backlog hiện có gì, hoặc cây Epic→Feature→User Story (đọc trực tiếp frontmatter, không có
  dashboard/index riêng): skill `backlog-status`.

## Làm việc trong repo này

- Không có code ứng dụng, nên không có gì để build/lint/run — công việc hoàn toàn nằm trong các tài liệu Markdown dưới `docs/` cùng các file gốc (`CONTEXT.md`, `AGENTS.md`, `RULES.md`).
- Khi được yêu cầu "thực hiện bước X", quy trình thực tế cần tuân theo là những gì `AGENTS.md` quy định cho bước đó — coi nó là spec vận hành, không phải file này.
- Template trong mỗi `docs/**/template.md` (hoặc `*-template.md`) định nghĩa cấu trúc/frontmatter bắt buộc cho loại tài liệu đó; luôn bắt đầu tài liệu mới từ template của nó.
