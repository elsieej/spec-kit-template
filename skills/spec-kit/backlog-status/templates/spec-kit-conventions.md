# spec-kit-conventions

> Quy tắc dùng xuyên suốt Spec Kit (naming/ID/versioning, vòng đời `status`, glossary-link,
> ma trận lan truyền thay đổi...). Mỗi skill (`setup-context`, `c4-model`, `plan-backlog`,
> `backlog-status`, `about-spec-kit`) đọc file này trước khi tạo/sửa tài liệu — xem mục "Điều
> kiện tiên quyết" ở `SKILL.md` của từng skill.

## 1. Đặt tên, ID và versioning

| Loại | Prefix | Ví dụ |
|---|---|---|
| Business Requirement | BR | BR-001 |
| User Requirement | UR | UR-001 |
| Functional Requirement | FR | FR-001 |
| System Overview (Context) | SYS-CTX | SYS-CTX-001 |
| System Overview (Container) | SYS-CTR | SYS-CTR-001 |
| System Overview (Component) | SYS-CMP | SYS-CMP-001 |
| System Overview (Container Interface Contract) | SYS-IFC | SYS-IFC-001 |
| System Overview (Entity Interface) | SYS-SIC | SYS-SIC-001 |
| Epic | EPIC | EPIC-001 |
| Feature | FEAT | FEAT-001 |
| User Story | US | US-001 |
| Meeting Notes | MEET | MEET-20260816-01 (ngày + số thứ tự trong ngày) |
| Open Question | OQ | OQ-001 |

Spec-kit này dừng ở User Story — không có tầng Task kỹ thuật, Sprint, hay Release riêng.

- Tên file: `{PREFIX}-{ID}_{slug-ngan-gon}.md`, ví dụ `EPIC-003_checkout-flow.md`.
- Feature/User Story nằm trong subfolder theo Epic sở hữu, KHÔNG để phẳng chung 1 thư mục:
  `docs/backlog/{features,user-stories}/{EPIC-ID}_{slug-epic}/{PREFIX}-xxx_{slug}.md`, trong đó
  `{EPIC-ID}_{slug-epic}` trùng đúng tên file Epic sở hữu (bỏ đuôi `.md`), ví dụ
  `docs/backlog/features/EPIC-003_checkout-flow/FEAT-012_luu-the.md`. Epic vẫn nằm phẳng trong
  `docs/backlog/epics/`. `parent_*` trong frontmatter là nguồn sự thật cho quan hệ cha-con, tổ
  chức thư mục chỉ để dễ duyệt.
- Frontmatter có `version` (số nguyên tăng dần) và `last_updated`, **trừ Meeting Notes**
  (`MEET-*`) — biên bản họp không có field `status`, nhưng vẫn có `version`/`last_updated`.
  Không xoá nội dung cũ khi sửa lớn — tăng `version`, dùng `git log`/`git blame` để xem lịch sử;
  không tạo file riêng cho mỗi version.

### Vòng đời `status`

Dùng chung 1 bộ 4 giá trị `draft | approved | blocked | deprecated` cho mọi loại tài liệu:

| Nhóm tài liệu | Vòng đời `status` |
|---|---|
| BR / UR / FR / SYS-CTX / SYS-CTR / SYS-CMP / SYS-IFC / SYS-SIC (không có `blocked`, dùng `related_open_questions`) | `draft → approved` (→ `deprecated` khi lỗi thời) |
| Epic, Feature, User Story, Open Question (có `blocked`, dùng `blocked_by_open_questions`) | `draft → approved → blocked → deprecated` |

- `draft` — đang soạn/đang thực hiện, chưa hoàn tất/chưa chấp nhận là kết quả cuối.
- `approved` — đã hoàn tất và chấp nhận: với BR/UR/FR/SYS-* là nội dung đã chốt, dùng làm nguồn
  cho tầng sau; với Epic/Feature/US/OQ là đã xong và được chấp nhận.
- `blocked` — chỉ Epic/Feature/US/OQ: đang bị chặn bởi ít nhất 1 Open Question đang mở; hết
  block thì trả lại đúng `status` **trước khi bị block** (`draft` hoặc `approved`), không mặc
  định về `draft`.
- `deprecated` — không còn dùng nữa.

Mũi tên `draft → approved → blocked → deprecated` mô tả các giá trị hợp lệ và hướng chuyển có
thể xảy ra, **không bắt buộc đi tuần tự qua từng bước**: 1 item hoàn toàn có thể được **tạo mới
thẳng ở `status: blocked`** (ví dụ phát hiện ngay lúc tạo là phụ thuộc 1 OQ chưa trả lời) — không
bắt buộc từng là `draft` trước đó.

Sửa nội dung một tài liệu đã `approved` (BR/UR/FR/SYS-*) thì đưa lại về `draft` để review lại
trước khi tiếp tục dùng làm nguồn cho tầng sau. Riêng việc **thêm ID vào mảng
`related_open_questions`** của tài liệu đã `approved` KHÔNG tính là "sửa nội dung" — đây là cập
nhật liên kết metadata, không cần đưa về `draft` chỉ vì việc này (khác với sửa nội dung
nghiệp vụ thật sự trong tài liệu).

Mọi tài liệu có `blocked` trong enum bắt buộc kèm `blocked_by_open_questions: [OQ-xxx]` khi ở
trạng thái đó. BR/UR/FR/SYS-* không có `blocked` — chỉ dùng `related_open_questions` để ghi
nhận OQ liên quan, **không tự chặn tiến độ**. Vì vậy 1 tài liệu nhóm này hoàn toàn có thể ở
`status: approved` trong khi `related_open_questions` vẫn còn ID chưa trả lời — đây là **đặc
tính thiết kế** (liên kết mềm, không phải gate cứng), **không phải lỗi** cần sửa lại `draft`.

### Commit

Định dạng: `docs(<prefix>): <ID> <mô tả ngắn>`, ví dụ `docs(us): US-004 add acceptance criteria
for refund flow`. Khi 1 skill tạo nhiều tài liệu khác loại cùng lúc trong 1 lần chạy (ví dụ
`setup-context` tạo BR-001+UR-001+FR-001), gộp thành 1 commit, dùng prefix của tài liệu gốc/thấp
nhất trong chuỗi và liệt kê mọi ID còn lại trong mô tả ngắn, ví dụ
`docs(br): BR-001 setup context (+ UR-001, FR-001)`. Mỗi thay đổi tài liệu là 1 commit riêng,
không gộp nhiều thay đổi không liên quan.

### Traceability

Mọi file backlog phải trỏ ngược lên tài liệu đã sinh ra nó: `parent_*` cho quan hệ cha-con
trong backlog (`parent_epic` trên Feature, `parent_feature` trên User Story), và
`docs_requirements` (mảng ID BR/UR/FR) cho liên kết tới tầng Business/User/Functional
Requirement. Số hop khác nhau theo tầng: Feature → `docs_requirements` trỏ thẳng UR (1 hop).
User Story → `docs_requirements` trỏ FR, phải thêm 1 hop qua `parent_user_requirement` của FR
đó mới tới UR (US → FR → UR, không phải US → UR trực tiếp).

## 2. Nguyên tắc chung khi làm việc với tài liệu

1. LUÔN đọc `docs/glossary/glossary.md` trước khi xử lý bất kỳ tài liệu nào.
2. KHÔNG bỏ qua tầng ở BR → UR → FR → System Overview: chỉ sinh tài liệu tầng N+1 khi tài liệu
   tầng N có `status: approved`. Tầng backlog (Epic → Feature → User Story) KHÔNG bị chặn bởi
   status của tầng cha — được phép thêm Feature/User Story mới vào 1 Epic/Feature đang `draft`
   bất kỳ lúc nào (backlog grooming liên tục), miễn `parent_*` trỏ đúng và item cha chưa
   `deprecated`.
3. Mọi tài liệu mới phải điền đủ **toàn bộ** field frontmatter đúng theo template của loại tài
   liệu đó — không chỉ 5 field chung (`id`/`type`/`status`/`version`/`parent_*`). Không tự bỏ
   field nào có trong template dù thấy chưa cần ngay lúc tạo — để giá trị rỗng đúng kiểu (`[]`,
   `null`), không xoá field. Template của từng loại là nguồn duy nhất cho danh sách field bắt
   buộc.
4. Nếu một Epic/Feature/User Story/Open Question liên quan tới `OQ-xxx` khác chưa trả lời
   (`status: draft`), set `status: blocked` thay vì tiếp tục. **Không tự cascade `blocked` lên
   Feature/Epic cha** khi 1 User Story con bị block — chỉ item thực sự liên quan trực tiếp tới
   OQ đó mới `blocked`. Nếu toàn bộ US con của 1 Feature đều `blocked`, Feature đó vẫn giữ
   nguyên `status` hiện tại.
5. Không tự suy đoán câu trả lời cho open question — chỉ ghi nhận, không đoán số/ngưỡng/hành vi
   cụ thể để né trạng thái `blocked`.

## 3. Ngôn ngữ, thuật ngữ, glossary-link

- **Đối tượng đọc mặc định:** developer/kỹ sư phần mềm — kể cả BR/UR. Ngắn gọn, đi thẳng vấn đề,
  ưu tiên thuật ngữ chuyên ngành, nhất quán thuật ngữ xuyên suốt, khách quan/trung lập, câu mệnh
  lệnh rõ ràng trong checklist/Definition of Done/test case.
- Trước khi viết một thuật ngữ kỹ thuật/riêng dự án vào tài liệu, tra `docs/glossary/glossary.md`
  trước. Có rồi → dùng đúng hình thức đã quy định, không tự sáng tạo cách viết khác. Chưa có →
  thêm 1 dòng vào glossary trước khi dùng trong tài liệu đang viết. Không dịch các thuật ngữ đã
  chuẩn hoá trong ngành (commit, pull request, sprint, backlog, endpoint, container...) trừ khi
  glossary quy định khác. Không viết tắt tự chế.
- **Link tham chiếu glossary**: lần xuất hiện đầu tiên của 1 thuật ngữ **trong thân bài** (không
  tính heading) của tài liệu, nếu thuật ngữ đã có trong glossary → gắn link Markdown tới đúng
  mục. Số cấp `../` theo độ sâu thư mục:
  - File ngay trong `docs/<tầng>/` (BR/UR/FR, C4 Context/Container/Component, Container/Entity
    Interface) — 1 cấp: `[sprint](../glossary/glossary.md#quy-trình--agile)`. File
    `*-template.md` trong `docs/system-overview/templates/` không cần gắn link.
  - File trong 1 subfolder của `docs/backlog/` hoặc `docs/meetings/` (Epic, meeting notes, open
    question) — 2 cấp: `[sprint](../../glossary/glossary.md#quy-trình--agile)`.
  - Feature/User Story trong subfolder theo Epic — 3 cấp:
    `[sprint](../../../glossary/glossary.md#quy-trình--agile)`.
  - Không lặp lại link ở các lần nhắc lại sau trong cùng tài liệu. Thuật ngữ chưa có trong
    glossary → không bắt buộc thêm link.

## 4. Priority backlog (MoSCoW → P0-P3)

"Backlog" không phải 1 file riêng — đó là trạng thái gộp của mọi Epic/Feature/User Story trong
`docs/backlog` đang `draft` và không `blocked`. Ưu tiên xử lý: loại các item đang `blocked`
trước, còn lại sắp theo field `priority` trên Feature/US (`P0` xử lý trước, `P3` sau cùng).

**`priority` khác gì với "Ưu tiên" (MoSCoW) ở UR?** Hai lớp riêng biệt, không dùng thay cho
nhau: MoSCoW ở UR (`Must/Should/Could/Won't have`) là ưu tiên **của yêu cầu**, chốt 1 lần lúc UR
được approve, hiếm khi đổi. `priority` (`P0`-`P3`) trên Feature/User Story là ưu tiên **xử lý
trong backlog**, có thể khác giá trị suy ra từ MoSCoW gốc vì bối cảnh thay đổi (deadline khách
hàng, rủi ro kỹ thuật mới phát sinh...).

Khi tạo mới Feature/US, suy `priority` mặc định từ mức MoSCoW của UR nguồn: `Must have` →
`P0`/`P1`, `Should have` → `P1`/`P2`, `Could have` → `P2`/`P3`, `Won't have` → không đưa vào
backlog. Nếu `docs_requirements` của Feature/US trỏ tới **nhiều UR có mức MoSCoW khác nhau** (qua
FR trung gian) → lấy mức MoSCoW **cao nhất** trong các UR nguồn đó làm cơ sở suy `priority` (ví
dụ 1 UR `Must have` + 1 UR `Should have` → tính như `Must have`, không lấy trung bình hay mức
thấp nhất). Mỗi mức MoSCoW ứng với 2 giá trị `priority` liền kề, không phải 1 — tiêu chí chọn
giữa 2 giá trị đó (đúng 1 trong 3 nhánh, không nhánh nào cần suy đoán thêm):
- Item **chặn** các Feature/US khác (nằm trong `depends_on` của item khác) hoặc thuộc
  container/luồng chính đang triển khai đầu tiên → lấy giá trị cao hơn (`P0` cho `Must have`,
  `P1` cho `Should have`...).
- Item tự nó có `depends_on` trỏ tới item khác, và không có item nào khác `depends_on` nó (không
  chặn ai) → lấy giá trị thấp hơn liền kề — nó "chưa tới lượt", không cần xử lý sớm hơn item chặn
  người khác.
- Item không có quan hệ `depends_on` theo chiều nào → lấy giá trị thấp hơn liền kề theo mặc định;
  chỉ lấy giá trị cao hơn nếu có lý do nghiệp vụ cụ thể khác (deadline khách hàng, rủi ro kỹ
  thuật...) — ghi lý do vào "Ghi chú".

Không bắt buộc ghi lý do khi **chọn lần đầu** giữa 2 giá trị hợp lệ lúc tạo mới — chỉ bắt buộc
khi **sau này đổi** `priority` khác giá trị đã chọn ban đầu (ghi vào "Ghi chú"/"Ghi chú kỹ thuật"
của item đó).

Các dải giá trị `priority` suy ra từ 2 mức MoSCoW liền kề **chồng lấn có chủ đích** (`P1` đạt được
từ cả `Must have` lẫn `Should have`) — không suy ngược được mức MoSCoW gốc chỉ từ 1 mình giá trị
`priority`. Cần biết mức MoSCoW gốc thì lần theo `docs_requirements` tới UR liên quan rồi đọc
đúng dòng tương ứng trong bảng "Nhu cầu người dùng & Ưu tiên" của UR đó (1 UR có thể có nhiều nhu
cầu, mỗi dòng 1 mức MoSCoW riêng — không lấy đại 1 dòng bất kỳ hay trộn nhiều dòng).

**Khi `docs_requirements` trỏ tới nguyên 1 file UR (không tới dòng cụ thể), chọn dòng nào?** Lấy
(các) dòng nhu cầu mà nội dung Feature/US đó thực sự phục vụ — xác định bằng cách khớp nội dung
("Mục tiêu"/"Mô tả chức năng" của Feature/US, hoặc của FR trung gian với US) với diễn giải của
từng dòng trong bảng "Nhu cầu người dùng & Ưu tiên", cùng cách template Functional Requirement tự
phân biệt 1 FR có phục vụ nhiều UR/persona hay không (2 câu hỏi: Input/Output khác nhau? Business
rule khác nhau?) — không phải lấy dòng đầu tiên hay dòng có MoSCoW cao nhất trong toàn UR một
cách máy móc. Nếu Feature/US thực sự phục vụ nhiều dòng nhu cầu cùng lúc, áp dụng đúng quy tắc
"lấy mức MoSCoW cao nhất" ở trên cho đúng tập hợp các dòng đó — không phải toàn bộ UR bất kể dòng
nào liên quan hay không.

Số hop khác nhau giữa Feature và User Story vì `docs_requirements` trỏ tới tầng khác nhau:
Feature → `docs_requirements` trỏ thẳng tới UR, 1 hop. User Story → `docs_requirements` trỏ tới
FR, phải thêm 1 hop qua `parent_user_requirement` của FR đó mới tới UR (US → FR → UR, không phải
US → UR trực tiếp). Mục "Ghi chú" chỉ chắc chắn có thông tin khi `priority` từng bị đổi sau này —
không phải nguồn để tra MoSCoW gốc cho item chưa từng đổi `priority`.

## 5. Bảo mật

Không đưa credential, API key, token, hoặc dữ liệu cá nhân thật vào bất kỳ tài liệu nào (kể cả
ví dụ minh hoạ) — dùng placeholder rõ ràng (`<token>`, `xxx-xxx-xxx`...). Khi trích dẫn từ
meeting notes/nguồn ngoài, rà lại để loại bỏ thông tin nhạy cảm không cần thiết.

## 6. Meeting / Open Question (Bước E)

Khi có input từ cuộc họp: tạo `MEET-*`, nếu phát sinh điều chưa rõ → tạo `OQ-*` (`status: draft`)
và cập nhật `blocked_by_open_questions` + `status: blocked` trên Epic/Feature/Story liên quan
(SYS-CTX/SYS-CTR không có `blocked` — chỉ ghi `related_open_questions`).

`OQ-*` bắt buộc field `raised_in_meeting` trỏ về 1 `MEET-*` có thật — không tạo OQ mà chưa có
meeting note tương ứng. Nếu điều chưa rõ phát sinh ngoài 1 cuộc họp chính thức (trao đổi trực
tiếp, phát hiện lúc review), vẫn tạo `MEET-*` ngắn ghi lại bối cảnh đó trước, rồi mới tạo `OQ-*`
trỏ về nó — không bỏ qua bước này chỉ vì "không phải cuộc họp thật".

Khi OQ được trả lời: điền mục "Trả lời" trong `OQ-xxx`, set `status: approved`, rồi gỡ block
trên mọi item trong `blocks: []` của OQ đó — đưa `status` của từng item về **trạng thái trước
khi bị block** (không mặc định về `draft`).

## 7. Ma trận lan truyền thay đổi

Không có cơ chế tự động (không hook, không CI) — mọi lan truyền dưới đây cần chủ động rà soát
khi 1 tài liệu chuyển sang trạng thái kích hoạt. Ghi lại việc đã rà soát trong message của commit
đưa tài liệu về lại `approved` (ví dụ: "reviewed UR-001, SYS-CTX-001, EPIC-001/002 — no
downstream change needed") — git log là nơi duy nhất giữ bằng chứng đó.

| Nguồn thay đổi | Cần rà soát/cập nhật |
|---|---|
| BR đã `approved` bị sửa → `status: draft` | UR con (`parent_business_requirement`), SYS-CTX có `source_docs` chứa BR đó, Epic có `docs_requirements` chứa BR đó |
| UR đã `approved` bị sửa → `status: draft` | FR con, SYS-CTX (`source_docs`), Feature (`docs_requirements`) |
| FR đã `approved` bị sửa → `status: draft` | SYS-CTX (`source_docs`), User Story (`docs_requirements`) |
| SYS-CTX đã `approved` bị sửa → `status: draft` | SYS-CTR có `source_docs: [SYS-CTX-xxx]` |
| SYS-CTR đổi (đổi/xoá Mã của 1 container) | Epic có `source_container` trỏ tới Mã đó; file `c4-component-<mã cũ>.md` cần đổi tên; mọi tham chiếu Mã đó trong `container-interface.md` (cột "Từ"/"Tới") cần cập nhật |
| Feature/User Story đổi trong cuộc họp | User Story liên quan — còn `draft` thì sửa thẳng, đã `approved` thì tạo item mới cho phần chênh lệch |
| OQ được trả lời (`status: approved`) | Mọi item trong `blocks: []` của OQ đó — trả `status` về trạng thái trước khi bị block |
| `depends_on` của 1 item đã `approved` hết | Chính item đó — có thể xét bắt đầu thực hiện (vẫn cần review, không tự động) |
