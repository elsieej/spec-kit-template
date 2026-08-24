---
name: c4-model
description: >
  Giải thích phương pháp C4 Model (Context, Container, Component, Code — c4model.com) và
  dẫn dắt tạo docs/04-system-overview/c4-context.md + c4-container.md + c4-component-*.md
  đúng tầng, đúng audience, cùng interface-contracts.md (schema giao tiếp giữa container, khi
  cần) đúng phạm vi (schema, không phải API/Code). Dùng khi user hỏi "C4 model là gì", "vẽ
  context/container/component diagram", "system overview", "kiến trúc hệ thống", "interface
  contract giữa các container", hoặc khi BR/UR/FR đã approved và cần sinh system overview.
---

# c4-model

## C4 Model là gì

C4 (nguồn: https://c4model.com/) là cách vẽ kiến trúc phần mềm qua 4 tầng, zoom dần từ tổng
quan xuống chi tiết — mỗi tầng phục vụ một loại người đọc khác nhau, không nhồi hết vào 1 sơ
đồ:

| Tầng | Trả lời câu hỏi | Đọc bởi | Trong kit này |
|---|---|---|---|
| 1. System Context | Hệ thống tương tác với ai, hệ thống ngoài nào? | Mọi người (kỹ thuật + phi kỹ thuật) | `c4-context.md` |
| 2. Container | Hệ thống gồm những container nào (web app/API/DB/service...), giao tiếp ra sao? | Kỹ thuật (architect/dev/ops) | `c4-container.md` |
| 3. Component | Bên trong 1 container có những component/module nào? | Dev trong team sở hữu container đó | `c4-component-<mã-container>.md`, 1 file/container |
| 4. Code | Class/function cụ thể | Dev đang code trực tiếp | Không tạo — để code + IDE tự giải thích |

Kit này tạo Level 1–3 theo mặc định: Context + Container cho toàn hệ thống, và 1 file
Component riêng cho mỗi container có codebase thực sự (bỏ qua container không có component
nội bộ để mô hình hoá, ví dụ DB thuần hoặc dịch vụ bên thứ ba dùng nguyên trạng). Level 4
(Code) không tạo — để code + IDE tự giải thích, tránh diagram chi tiết đến mức không ai
maintain nổi, nhanh lỗi thời hơn cả code.

Ngoài 4 Level trên (đây KHÔNG phải 1 Level mới, chỉ là phụ lục dữ liệu đi kèm Container/
Component): khi giao tiếp giữa 2 container có dữ liệu thật cần thống nhất trước, tạo thêm
`interface-contracts.md` — xem mục "Quy trình tạo Interface Contract" bên dưới.

## Khi nào dùng skill này

- User hỏi C4 model là gì / vì sao kit tách riêng Context và Container.
- `docs/01-business-requirement`, `02-user-requirement`, `03-functional-requirement` liên
  quan đã `status: approved`, cần sinh system overview.

## Quy trình tạo Context Diagram (Level 1)

1. Đọc `docs/00-glossary/glossary.md` (thuật ngữ dự án, dùng nhất quán khi đặt tên hệ thống/
   container/component), rồi toàn bộ `docs/01-03` đã approved (đặc biệt UR để lấy
   Actor/Persona, FR để lấy hệ thống ngoài cần tích hợp). Khi viết nội dung ở Context/
   Container/Component/Interface Contract, thuật ngữ đã có trong glossary → gắn link Markdown
   tới đúng mục ở lần xuất hiện đầu tiên trong mỗi tài liệu (xem `RULES.md` mục 2).
2. Viết 1–2 câu mô tả hệ thống trung tâm.
3. Điền `docs/04-system-overview/c4-context.md`: bảng Actors/Personas, bảng Hệ thống ngoài
   liên quan (mục đích tích hợp + hướng dữ liệu in/out), diagram mermaid `graph TD`.
4. **Không** đưa chi tiết kỹ thuật (tên container, công nghệ, API) vào tầng này — đó là việc
   của Container Diagram. Audience tầng này gồm cả người phi kỹ thuật.

## Quy trình tạo Container Diagram (Level 2)

1. Bắt đầu từ Context Diagram đã có (`source_docs: [SYS-CTX-001]`).
2. Liệt kê từng container, mỗi container gán 1 **mã** (slug ngắn, duy nhất trong bảng, vd
   `checkout-web`, `checkout-api`, `db`), kèm loại (web app/mobile/service/DB...) và trách
   nhiệm. Không liệt kê công nghệ/stack cụ thể — Container Diagram dừng ở mức giao tiếp/
   interface abstract (container nào tồn tại, giao tiếp với nhau ra sao), chọn công nghệ là
   quyết định triển khai ở Bước C. Bảng này là dữ liệu gốc mà mọi việc lập kế hoạch sau này sẽ
   đọc lại và tham chiếu đúng theo mã — không nơi nào khác tự đặt mã container mới.
3. Nếu chưa rõ hệ thống nên tách thành bao nhiêu container độc lập (mô hình còn mơ hồ, ranh
   giới trách nhiệm giữa các phần chưa rõ): hỏi trực tiếp user, ví dụ "hệ thống này gồm bao
   nhiêu service/app độc lập?" — không tự suy đoán ranh giới. Nếu user chưa có tên cụ thể cho
   container, có thể tự đề xuất tên gợi ý theo trách nhiệm (ví dụ `checkout-service`,
   `notification-service`) nhưng phải để user xác nhận trước khi ghi chính thức vào bảng. **Ghi
   nguyên văn** câu hỏi đã hỏi + câu trả lời/xác nhận thật của user vào mục "Xác nhận với user"
   trong `c4-container.md` (xem template) — không chỉ khẳng định suông "đã đề xuất và được xác
   nhận" mà không có gì đối chiếu được; bằng chứng nằm ngay trong tài liệu, không phụ thuộc git
   log hay trí nhớ phiên làm việc.
4. Vẽ giao tiếp giữa các container: từ đâu → tới đâu, giao thức (REST/HTTPS, gRPC, message
   queue...), mô tả ngắn. Nếu 1 container gọi trực tiếp tới hệ thống ngoài đã liệt kê ở
   `c4-context.md` (payment gateway, hệ thống bên thứ ba...) — thêm 1 hàng riêng cho giao tiếp
   đó vào cùng bảng "Giao tiếp" này (không chỉ nhắc ở Context Diagram) — đây là bảng duy nhất mà
   "Quy trình tạo Interface Contract" bên dưới quét qua để tìm cặp cần chốt schema.
5. Với mỗi container có codebase thực sự (không phải DB thuần/dịch vụ bên thứ ba dùng nguyên
   trạng), tiếp tục sang Quy trình tạo Component Diagram bên dưới. Không tự vẽ Code diagram
   (Level 4) trừ khi user yêu cầu rõ ràng.

## Quy trình tạo Component Diagram (Level 3)

1. Với mỗi container thuộc diện cần Component diagram (xem bước 5 ở trên), tạo file
   `docs/04-system-overview/c4-component-<mã-container>.md` (`<mã-container>` là "Mã" của
   container đó trong `c4-container.md`), `source_docs: [SYS-CTR-xxx]` trỏ về container cha.
2. Liệt kê từng component/module bên trong container, mỗi component gán tên ngắn gọn kèm
   trách nhiệm chính — ở mức đủ để dev trong team sở hữu container hiểu bố cục mà không cần
   đọc code trước. Không xuống tới class/function cụ thể (đó là Level 4, không thuộc phạm vi
   skill này).
3. Vẽ giao tiếp giữa các component trong cùng container (gọi hàm, event nội bộ...) bằng
   diagram mermaid `graph TD`.
4. Trước khi kết luận "container quá đơn giản, bỏ qua Component diagram": phải thử liệt kê
   candidate component trước (kể cả khi kết quả là 1-2 component) — không kết luận "quá đơn
   giản" mà không có danh sách này. Nếu sau khi liệt kê, container thực sự chỉ có 1-2 component
   không có cấu trúc nội bộ đáng vẽ → không tạo file Component, nhưng vẫn ghi trong
   `c4-container.md` danh sách candidate đã xét qua và lý do gộp/bỏ qua (không chỉ ghi kết luận
   suông) — tránh việc bỏ qua vì muốn giảm số file thay vì vì container thực sự đơn giản.
5. Trước khi ghi chính thức vào file Component: liệt kê danh sách component vừa xác định (tên +
   trách nhiệm 1 dòng) và **thực sự dừng lại chờ user xác nhận** — cùng mức xác nhận nhẹ như
   bước 3 ở Container Diagram (không phải hỏi lại từng chi tiết, chỉ để user chỉnh trước khi ghi
   thành dữ liệu gốc mà `Context cho Agent` của User Story sau này sẽ trỏ tới). Không được coi
   im lặng là đồng ý, và không được tự liệt kê rồi tự đi tiếp ghi file luôn trong cùng lượt —
   đây chính là chỗ 1 component không ai yêu cầu (ví dụ tự thêm 1 cơ chế retry/queue nội bộ) dễ
   lọt vào dữ liệu gốc mà không ai bắt lại, vì các bước tự-rà-soát ở `setup-context`/
   `plan-backlog` không quét tới tầng C4 (xem 2 skill đó). **Ghi nguyên văn** danh sách candidate
   đã trình bày + phản hồi thật của user vào mục "Xác nhận với user" trong file Component (xem
   template) — không chỉ khẳng định suông "đã đề xuất và PO xác nhận". Đây không phải cơ chế
   mới: `setup-context` đã dùng đúng cách này cho BR/UR/FR từ trước — bằng chứng nằm trong tài
   liệu, đọc lại được độc lập mà không cần git log (không phải lúc nào cũng có, ví dụ trong môi
   trường test/sandbox không có git) hay trí nhớ phiên làm việc.
6. Dừng ở Level 3. Không tự vẽ Code diagram trừ khi user yêu cầu rõ ràng.

## Quy trình tạo Interface Contract (schema giao tiếp)

Không phải 1 Level của C4 — là phụ lục dữ liệu đi kèm Container/Component, trả lời câu hỏi
"dữ liệu thật trao đổi giữa 2 container là gì" mà bảng "Giao tiếp" trong `c4-container.md` (chỉ
có cột giao thức + mô tả ngắn) không đủ chỗ trả lời.

1. Chỉ tạo khi có dữ liệu thật cần 2 container thống nhất trước khi Bước C thực thi độc lập
   (ví dụ 2 User Story ở 2 container khác nhau cùng chạm 1 giao tiếp). Không bắt buộc tạo cho
   mọi hệ thống.
1b. **"Cặp container" ở đây cũng áp dụng cho container nội bộ ↔ hệ thống ngoài** đã liệt kê ở
   bảng "Hệ thống ngoài liên quan" trong `c4-context.md` (ví dụ payment gateway, hệ thống chấm
   công bên thứ ba) — không chỉ 2 container nội bộ tự thoả thuận với nhau. Điều kiện: giao tiếp
   đó đã có 1 hàng riêng trong bảng "Giao tiếp" của `c4-container.md` (xem Container Diagram
   bước 4) — nếu chưa có, thêm vào đó trước, vì đây là bảng duy nhất bước 3 bên dưới quét qua.
   Khác biệt duy nhất so với cặp container nội bộ:
   với hệ thống ngoài, mục đích của phần schema là **ghi lại kỳ vọng tích hợp cần xác nhận với
   bên thứ ba** (dữ liệu team mình cần gửi/nhận theo hiểu biết hiện tại), không phải 1 hợp đồng
   2 bên nội bộ tự chốt — nếu chưa xác nhận được với bên thứ ba, ghi rõ "chưa xác nhận với
   <hệ thống ngoài>" thay vì để trống hoặc bỏ qua không ghi gì (bỏ qua là sai, vì đây chính là
   dữ liệu Bước C cần để không tự bịa hợp đồng tích hợp).
2. Tạo `docs/04-system-overview/interface-contracts.md` (`SYS-IFC-xxx`, dùng
   `interface-contracts-template.md`), `source_docs` trỏ về `c4-container.md`/
   `c4-component-*.md` liên quan.
3. Với mỗi cặp container giao tiếp trong bảng "Giao tiếp" của `c4-container.md` cần chốt trước:
   liệt kê theo từng thao tác (kèm US liên quan nếu có) — dữ liệu cần gửi đi/lưu và dữ liệu cần
   nhận lại/đọc, mỗi field kèm kiểu ở mức khái niệm (text/số/ngày-giờ/boolean/enum — liệt kê
   giá trị hợp lệ nếu là enum) và bắt buộc/tuỳ chọn. Áp dụng **như nhau** cho mọi cặp container,
   kể cả khi 1 bên là container DB thuần (không có Component diagram) — xác định dữ liệu cần
   trao đổi từ vai trò của container đó trong Context/Container/Component, không thiết kế riêng
   cho DB.
4. **KHÔNG thiết kế API hay DB cụ thể** — không viết method HTTP, path, status code, hình dạng
   response chi tiết, hay tên bảng/cột/**kiểu cột SQL/ngôn ngữ cụ thể** (`varchar(255)`,
   `timestamptz`, `int32`...), index. Đó đều là Code (Level 4), quyết định ở Bước C khi thực thi
   User Story, không phải việc của tài liệu này. Kiểu dữ liệu khái niệm (text/số/ngày-giờ/
   boolean/enum) vẫn phải ghi — không phải ngoại lệ của quy tắc này, chỉ kiểu cụ thể của DB/
   ngôn ngữ mới ngoài phạm vi. Chỉ chốt schema dữ liệu, để 2 container độc lập triển khai không
   lệch nhau.

## Lỗi thường gặp cần tránh

- Nhồi chi tiết kỹ thuật vào Context Diagram — sai audience, người phi kỹ thuật không đọc nổi.
- Vẽ Code diagram (Level 4) cho toàn bộ hệ thống khi chưa ai yêu cầu — tốn công, nhanh lỗi
  thời.
- Tạo Component diagram hình thức cho container quá đơn giản (không có cấu trúc nội bộ đáng
  vẽ) — xem bước 4 ở Quy trình tạo Component Diagram.
- Bỏ qua Context Diagram, nhảy thẳng vào Container — mất bối cảnh actor/hệ thống ngoài mà
  Container Diagram cần tham chiếu.
- Không cập nhật diagram khi kiến trúc đổi — review lại Container/Component Diagram mỗi khi có Epic mới
  ảnh hưởng kiến trúc (bump `version`, không tạo file mới cho mỗi lần sửa).
- Nhồi method HTTP/path/status code, hoặc tên bảng/cột/kiểu SQL cụ thể vào
  `interface-contracts.md` — đó đều là Code (Level 4), ngoài phạm vi tài liệu này (xem mục
  "Quy trình tạo Interface Contract").
- Liệt kê component rồi tự ghi file luôn mà không thực sự dừng lại chờ xác nhận (bước 5 ở Quy
  trình tạo Component Diagram) — dễ để lọt 1 component không ai yêu cầu vào dữ liệu gốc mà
  không cơ chế nào ở tầng sau bắt lại được.
