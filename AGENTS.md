# AGENTS.md — Hướng dẫn cho Agent khi làm việc với Spec Kit này

## Nguyên tắc chung
1. LUÔN đọc `CONTEXT.md` và `docs/glossary/glossary.md` trước khi xử lý bất kỳ tài liệu nào — `CONTEXT.md` giới thiệu kit + thành phần chính, không phải nơi nháp WHY/WHO/WHAT (dùng skill `setup-context` để ghi thẳng vào BR/UR/FR).
2. KHÔNG bỏ qua tầng ở BR → UR → FR → System Overview: chỉ sinh tài liệu ở tầng N+1 khi tài
   liệu tầng N có `status: approved` (xem bảng vòng đời status ở `CLAUDE.md`). Tầng backlog
   (Epic → Feature → User Story) KHÔNG bị chặn bởi status của tầng
   cha — được phép thêm Feature/User Story mới vào một Epic/Feature đang `draft` bất kỳ lúc nào
   (backlog grooming là việc liên tục), miễn `parent_*` trỏ đúng và `status: deprecated` thì
   không thêm con mới nữa.
3. Mọi tài liệu mới phải điền đủ **toàn bộ** field frontmatter đúng theo `<PREFIX>-template.md`
   của loại tài liệu đó — KHÔNG chỉ `id`/`type`/`status`/`version`/`parent_*`
   (danh sách này không đầy đủ, mỗi loại có thêm field riêng, ví dụ: Epic/Feature/US còn có
   `docs_requirements`, `blocked_by_open_questions`; Feature/US thêm `depends_on`, `priority`;
   User Story thêm `story_points`, `assignee`; SYS-CTX/CTR/CMP/IFC có `source_docs` (SYS-CTR có
   thêm `source_container` ở Epic); OQ có `raised_in_meeting`, `blocks`). Không tự bỏ field nào
   có trong template dù thấy chưa cần ngay lúc tạo — để giá trị rỗng đúng kiểu (`[]`, `null`),
   không xoá field. Template của từng loại là nguồn duy nhất cho danh sách field bắt buộc —
   danh sách ví dụ ở trên chỉ để tránh nhầm với 5 field chung, không thay thế việc đọc
   template.
4. Nếu một **Epic/Feature/User Story/Open Question** liên quan tới `OQ-xxx` khác chưa được trả
   lời (`status: draft`), set `status: blocked` thay vì tiếp tục. BR/UR/FR/SYS-CTX/SYS-CTR/
   SYS-CMP/SYS-IFC/SYS-SIC KHÔNG có trạng thái `blocked` — dùng `related_open_questions` thay vì
   `blocked_by_open_questions`, không tự chặn tiến độ (xem `CLAUDE.md`, Bước E bên dưới).
   **Không tự cascade `blocked` lên Feature/Epic cha** khi 1 User Story con bị block — "liên
   quan tới OQ-xxx" ở trên chỉ áp dụng cho item thực sự liên quan trực tiếp tới OQ đó, không suy
   ra từ việc con của nó bị block. Nếu toàn bộ US con của 1 Feature đều `blocked`, Feature đó vẫn
   giữ nguyên `status` hiện tại (thường là `draft`) — "không còn US nào làm được ngay" không
   đồng nghĩa "Feature bị chặn"; xem skill `backlog-status` để biết cách hiển thị trường hợp này
   khi tổng hợp backlog.
5. Spec-kit này dừng ở User Story — không có tầng Task kỹ thuật, Sprint, hay Release riêng.

## Quy trình theo bước

```mermaid
flowchart TD
    CTX["CONTEXT.md
    (plain text, đọc đầu tiên, nếu có)"]
    G["docs/glossary/glossary.md
    (đọc trước mọi bước)"]

    A["Bước A — System Overview (C4)
    Input: BR/UR/FR (approved)
    Output: c4-context.md + c4-container.md + c4-component-*.md"]
    B["Bước B — Backlog
    Input: BR/UR/FR (approved) + c4-container.md (tồn tại)
    Output: Epic → Feature → User Story"]
    C["Bước C — Thực thi User Story
    Đọc US + parent chain + C4 container/component
    Code đạt Acceptance Criteria → status: approved"]
    E["Bước E — Meeting / Open Question
    MEET-* → có thể tạo OQ-*"]

    CTX --> G --> A
    A --> B --> C
    E -. ghi related_open_questions, không blocked được .-> A
    E -. có thể set status: blocked .-> B
    E -. có thể set status: blocked .-> C
```

### Bước A — Sinh System Overview (C4)
Input: `docs/glossary/glossary.md` (thuật ngữ dự án, đảm bảo đặt tên container/component
đúng ngữ cảnh) và toàn bộ `docs/business-requirement`, `docs/user-requirement`,
`docs/functional-requirement` (status = approved).
Output: `docs/system-overview/c4-context.md`, `c4-container.md`, và 1 `c4-component-*.md`
cho mỗi container có codebase thực sự (xem skill `c4-model`). Không sinh Code diagram (Level 4)
trừ khi được yêu cầu rõ ràng.

Khi giao tiếp giữa 2 container có dữ liệu thật cần thống nhất trước (để 2 container do 2
phiên/agent khác nhau thực thi không lệch schema), tạo thêm
`docs/system-overview/container-interface.md` (`SYS-IFC-xxx`,
mỗi luồng gán 1 mã `CIC-xxx` cục bộ trong file
đó — xem skill `c4-model`) — chỉ chốt schema dữ liệu (field nào bắt buộc/tuỳ chọn, kiểu ở mức
khái niệm — text/số/ngày-giờ/boolean/enum, dữ liệu cần
gửi/lưu, dữ liệu cần nhận lại/đọc), xác định từ Container/
Component diagram đã có, KHÔNG thiết kế API hay DB cụ thể (method HTTP, path, status code, tên
bảng/cột/kiểu SQL) — kể cả với container DB thuần. Đó là Code (Level 4), quyết định ở Bước C.

Nếu nhiều entity dùng chung bởi nhiều CIC/container mà mô tả rời rạc trong từng CIC sẽ bị lặp
hoặc lệch nhau, tạo thêm `docs/system-overview/entity-interface.md` (`SYS-SIC-xxx`,
xem skill `c4-model`) — định nghĩa entity, field (kiểu khái niệm), và quan hệ giữa các entity
(1-nhiều, nhiều-nhiều, đệ quy...) ở mức logic, độc lập công nghệ lưu trữ. Không bắt buộc cho mọi
hệ thống — hệ thống ít entity/quan hệ rời rạc thì field list trong từng CIC là đủ. Tài liệu này
không thay thế `container-interface.md`: đây là nguồn sự thật cho hình dạng entity,
CIC là nguồn sự thật cho thao tác nào gửi/nhận entity đó qua luồng nào.

### Bước B — Sinh Backlog
Input: BR/UR/FR (đã approved) và `docs/system-overview/c4-container.md` đã tồn tại
(không bắt buộc `status: approved`, nhưng phải có bảng "Danh sách container" để tra
`source_container` — xem skill `plan-backlog`).
Output theo thứ tự: Epic → Feature → User Story, mỗi cấp dùng đúng template
trong `docs/backlog/*/`. Liên kết `parent_*` bắt buộc. Epic nằm phẳng trong
`docs/backlog/epics/`; Feature/User Story nằm trong subfolder theo Epic sở hữu (xem
`CLAUDE.md`, mục "Đặt tên, ID và versioning") — không tạo phẳng chung 1 thư mục. Tiêu chí
phân rã từng cấp (Epic/Feature/User Story) và dấu hiệu User Story đủ nhỏ/đủ rõ: xem skill
`plan-backlog`.

**Phụ thuộc giữa Feature/User Story** (khác với `blocked_by_open_questions`): field
`depends_on` trên Feature/US ghi ID của (các) item khác phải `status: approved` trước khi
item này được coi là thực hiện được. Đây không phải trạng thái `blocked` — không cần
`blocked_by_open_questions`, không cần ai quyết định gì, chỉ đơn giản là "chưa tới lượt" và tự
hết khi dependency xong. Không bắt đầu thực hiện (Bước C) một User Story khi `depends_on` của
nó còn ID chưa `approved`.

**Epic ứng với container nào?** Không tự đặt mã container mới ở bước này — số lượng và mã hệ
thống đã được chốt từ Bước A (`c4-container.md`, cột "Mã"). Đối chiếu "Mục tiêu" của Epic với
cột "Trách nhiệm" của từng container trong bảng đó:
- Khớp đúng 1 container → lấy "Mã" của container đó cho `source_container` của Epic.
- Khớp Trách nhiệm của nhiều container **vì các container đó cùng phục vụ 1 mảng giá trị lớn
  duy nhất** (ví dụ container UI + container API của cùng 1 luồng nghiệp vụ full-stack — Trách
  nhiệm của chúng thường diễn đạt lại đúng nghiệp vụ chung, không phải 2 mục tiêu kinh doanh khác
  nhau) → **không tách Epic chỉ vì lý do này**. Chọn container **chủ/đại diện** (thường là
  container người dùng tương tác chính, hoặc container sở hữu nghiệp vụ) làm `source_container`
  — đây là container đại diện, không phải container duy nhất được Epic chạm tới; Feature/US bên
  dưới phản ánh đầy đủ mọi container thực sự tham gia qua "Context cho Agent", không phải qua
  `source_container` của Epic.
- Epic thực sự gộp **nhiều mảng giá trị kinh doanh khác nhau** (không chỉ khác container mà
  khác cả mục tiêu/persona được phục vụ) → tách thành nhiều Epic, mỗi Epic ứng với 1
  `source_container`, cùng trỏ `docs_requirements` về BR gốc.
- Không container nào khớp → `c4-container.md` đang thiếu/lỗi thời, quay lại Bước A cập nhật
  container diagram trước, không tự bịa container ở backlog.

**Ưu tiên xử lý backlog và thuật toán suy `priority` (MoSCoW → P0-P3)**: xem
`docs/spec-kit-conventions.md` mục 4 — nguồn duy nhất cho quy tắc này, dùng chung cho cả agent
chạy full pipeline trong repo này lẫn agent chỉ cài lẻ skill `plan-backlog`.

**Ví dụ minh hoạ** (một luồng xuyên suốt, rút gọn):
`BR-001` "Tăng tỉ lệ chuyển đổi checkout" → `UR-001` "Khách hàng mua sắm online, pain point:
phải nhập lại thông tin thẻ mỗi lần mua" → `FR-001` "Hệ thống phải hỗ trợ thanh toán 1-click
cho thẻ đã lưu" → `EPIC-001` "Checkout nhanh" (`source_container: checkout-api`) → `FEAT-001` "Thanh
toán 1-click" → `US-001` "Là khách hàng đã lưu thẻ, tôi muốn thanh toán 1 chạm để không phải
nhập lại thông tin" (Acceptance Criteria điền đầy đủ, bao phủ edge case ngay lúc tạo). Khi
`US-001` đã `draft`, đủ rõ để làm và không `blocked`, agent (hoặc dev) bắt đầu thực hiện
(Bước C).

### Bước C — Thực thi User Story
**Agent làm việc trong repo spec-kit này KHÔNG được tự viết/sửa code ứng dụng** — kit này
không có code (xem `CLAUDE.md`). Nếu user yêu cầu implement trực tiếp tại đây, dừng lại và
nhắc: việc code nằm ngoài phạm vi spec-kit này. Bước C chỉ mô tả agent thực thi cần đọc gì từ
repo spec-kit này trước khi code, và cập nhật gì lại đây sau khi code xong.

Trước khi code, đọc theo thứ tự:
1. `docs/glossary/glossary.md`
2. File User Story hiện tại — mục "Context cho Agent" nếu có (US tạo trước khi mục này có
   trong template có thể chưa có; khi đó đi thẳng bước 3)
3. `parent_feature` → các FR trong `docs_requirements`
4. `docs/system-overview/c4-container.md` (container liên quan), và `c4-component-<mã
   container>.md` của container đó nếu file này tồn tại (container đơn giản, không có cấu
   trúc nội bộ đáng vẽ, sẽ không có file Component — xem skill `c4-model`)
5. `docs/system-overview/container-interface.md` nếu tồn tại — mục CIC-xxx tương
   ứng luồng giao tiếp qua container liên quan, tránh tự bịa field khác với container ở đầu kia
   đã thống nhất
6. `docs/system-overview/entity-interface.md` nếu tồn tại — entity liên quan (field
   + quan hệ), đặc biệt khi CIC ở bước 5 trỏ về entity trong tài liệu này thay vì liệt kê lại
   field

### Bước E — Xử lý Meeting/Open Question
Khi có input từ cuộc họp: tạo `MEET-*`, nếu phát sinh điều chưa rõ → tạo `OQ-*`
(`status: draft`) và cập nhật `blocked_by_open_questions` + `status: blocked` trên các
Epic/Feature/Story liên quan (SYS-CTX/SYS-CTR không có `blocked` — chỉ ghi
`related_open_questions`, không tự chặn tiến độ, xem `CLAUDE.md`).

`OQ-*` bắt buộc field `raised_in_meeting` trỏ về 1 `MEET-*` có thật — không tạo OQ mà chưa có
meeting note tương ứng. Nếu điều chưa rõ phát sinh ngoài 1 cuộc họp chính thức (trao đổi trực
tiếp, phát hiện lúc review), vẫn tạo `MEET-*` ngắn ghi lại bối cảnh đó trước, rồi mới tạo `OQ-*`
trỏ về nó — không bỏ qua bước này chỉ vì "không phải cuộc họp thật".
Không tự suy đoán câu trả lời cho open question — chỉ ghi nhận. Khi OQ được trả lời: điền
mục "Trả lời" trong `OQ-xxx`, set `status: approved`, rồi gỡ block trên mọi item liệt kê
trong `blocks: []` của OQ đó — đưa `status` của từng item quay về trạng thái **trước khi bị
block** (không mặc định về `draft`; xem `OQ-template.md`). Item bị block có thể là
Epic/Feature/Story.

**Họp làm thay đổi Feature/User Story** — phân biệt 2 trường hợp:
- Thay đổi **chưa chốt**, còn cần quyết định → xử lý như open question bình thường ở trên: tạo
  `OQ-*`, set `blocked_by_open_questions` + `status: blocked` trên item liên quan.
- Thay đổi **đã chốt ngay tại họp** (không cần OQ) → sửa thẳng Feature/User Story bị ảnh hưởng
  (tăng `version`, cập nhật `last_updated`), ghi lý do + liên kết `MEET-xxx` vào mục "Ghi chú"/
  "Ghi chú kỹ thuật" của item đó:
  - Item vẫn `draft` (chưa thực hiện xong) → sửa thẳng nội dung cho khớp.
  - Item đã `approved` (đã thực hiện xong) → KHÔNG sửa ngược item đã hoàn thành (phá
    traceability của việc đã xong); tạo Feature/User Story mới cho phần chênh lệch,
    `parent_*` trỏ về đúng Epic/Feature liên quan.

## Ma trận lan truyền thay đổi

Không có cơ chế tự động (không hook, không CI) — mọi lan truyền dưới đây đều cần agent/người
chủ động rà soát khi thấy 1 tài liệu chuyển sang trạng thái kích hoạt (`draft` trở lại sau
`approved`, `blocked`, container đổi Mã, OQ được trả lời, `depends_on` hoàn tất...). Ghi lại việc
đã rà soát trong message của commit đưa tài liệu về lại `approved` (ví dụ: "reviewed UR-001,
SYS-CTX-001, EPIC-001/002 — no downstream change needed") — kit này không có dashboard/log riêng
để tra lại việc rà soát đã xảy ra hay chưa, git log là nơi duy nhất giữ lại bằng chứng đó. Sơ đồ
này chỉ để tra cứu nhanh "sửa cái này thì phải xem lại cái gì" — không thay thế nội dung chi tiết
ở Bước A–C, E phía trên.

```mermaid
flowchart TD
    BR["BR approved bị sửa<br/>→ status: draft"]
    UR["UR approved bị sửa<br/>→ status: draft"]
    FR["FR approved bị sửa<br/>→ status: draft"]
    CTX["SYS-CTX bị sửa<br/>→ status: draft"]
    CTR["SYS-CTR bị sửa<br/>(thêm/xoá/đổi Mã)"]
    EPIC["Epic"]
    FEAT["Feature"]
    US["User Story"]
    OQ["OQ được trả lời<br/>(status: approved)"]
    DEP["depends_on của 1 item<br/>đã approved hết"]

    BR -->|rà soát| UR
    BR -->|rà soát source_docs chứa BR| CTX
    BR -->|rà soát docs_requirements| EPIC
    UR -->|rà soát| FR
    UR -->|rà soát source_docs chứa UR| CTX
    UR -->|rà soát docs_requirements| FEAT
    FR -->|rà soát source_docs chứa FR| CTX
    FR -->|rà soát docs_requirements| US
    CTX -->|rà soát source_docs: SYS-CTX-xxx| CTR
    CTR -->|Mã đổi → rà soát source_container| EPIC
    CTR -->|Mã đổi → đổi tên file + rà soát tham chiếu| CMPIFC["c4-component-&lt;mã&gt;.md<br/>+ container-interface.md"]
    EPIC -->|rà soát parent_epic| FEAT
    FEAT -->|rà soát parent_feature| US
    OQ -->|trả status về trước khi block| EPIC
    OQ -->|trả status về trước khi block| FEAT
    OQ -->|trả status về trước khi block| US
    DEP -->|đủ điều kiện bắt đầu thực hiện| FEAT
    DEP -->|đủ điều kiện bắt đầu thực hiện| US
```

| Nguồn thay đổi | Cần rà soát/cập nhật | Chi tiết ở đâu |
|---|---|---|
| BR đã `approved` bị sửa nội dung → `status: draft` | UR con (`parent_business_requirement`), SYS-CTX có `source_docs` chứa BR đó, Epic có `docs_requirements` chứa BR đó | Nguyên tắc chung #2; sau khi rà soát xong mới đưa BR về lại `approved` |
| UR đã `approved` bị sửa → `status: draft` | FR con, SYS-CTX (`source_docs`), Feature (`docs_requirements`) | như trên |
| FR đã `approved` bị sửa → `status: draft` | SYS-CTX (`source_docs`), User Story (`docs_requirements`) | như trên |
| SYS-CTX đã `approved` bị sửa → `status: draft` | SYS-CTR có `source_docs: [SYS-CTX-xxx]` | Bước A |
| SYS-CTR đổi (đổi/xoá Mã của 1 container) | Epic có `source_container` trỏ tới Mã đó — cập nhật lại `source_container`, hoặc báo "liên kết gãy" nếu Mã bị xoá. Đồng thời: file `c4-component-<mã cũ>.md` (tên file chứa Mã) cần đổi tên theo Mã mới, mọi tham chiếu tới Mã đó trong `container-interface.md` (cột "Từ"/"Tới" ở mục "Bảng tổng hợp CIC" và các mục CIC chi tiết) cần cập nhật, **và mọi User Story có mục "Context cho Agent" ghi nguyên văn Mã đó** (`docs/backlog/user-stories/**/*.md`, dòng "System overview liên quan: SYS-CTR-xxx (container: <mã>)") cần quét và cập nhật — dễ bỏ sót vì bảng này không nhắc tới US, nhưng Mã container xuất hiện ở **mọi** US tham chiếu container đó, không chỉ 3 nơi trên | Bước B, mục "Epic ứng với container nào?"; Bước A cho file Component/Container Interface Contract |
| Feature/User Story đổi trong cuộc họp | User Story liên quan — còn `draft` thì sửa thẳng, đã `approved` thì tạo item mới cho phần chênh lệch | Bước E, mục "Họp làm thay đổi Feature/User Story" |
| OQ được trả lời (`status: approved`) | Mọi item trong `blocks: []` của OQ đó — trả `status` về trạng thái trước khi bị block | Bước E |
| `depends_on` của 1 item đã `approved` hết | Chính item đó — có thể xét bắt đầu thực hiện (Bước C, vẫn cần review, không tự động) | Bước B, mục "Phụ thuộc giữa Feature/User Story" |
