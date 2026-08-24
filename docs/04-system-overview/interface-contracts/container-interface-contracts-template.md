---
id: SYS-IFC-001
type: interface_contract
status: draft        # draft | approved | deprecated
version: 1
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
source_docs: []       # SYS-CTR-xxx và/hoặc SYS-CMP-xxx của (các) container liên quan
related_open_questions: []
---

# SYS-IFC-001 — Container Interface Contract (<Tên hệ thống>)

> Chỉ tạo file này khi có dữ liệu thật cần 2 container thống nhất trước khi thực thi độc lập
> (xem skill `c4-model`). Tài liệu này CHỈ chốt schema dữ liệu (mỗi field: tên, kiểu ở mức khái
> niệm — text/số/ngày-giờ/boolean/enum (liệt kê giá trị hợp lệ nếu là enum), bắt buộc/tuỳ chọn,
> dữ liệu cần gửi/lưu, dữ liệu cần nhận lại/đọc) — KHÔNG thiết kế API hay DB cụ thể (method
> HTTP, path, status code, tên bảng/cột/**kiểu cột SQL/ngôn ngữ cụ thể** như `varchar(255)`,
> `timestamptz`, `int32`, index...). Đó là Code (Level 4), quyết định ở Bước C khi thực thi User
> Story, không phải việc của tài liệu này — kể cả với container DB thuần: chỉ ghi dữ liệu nào
> cần lưu được/đọc lại được kèm kiểu khái niệm, không thiết kế schema bảng. Cấu trúc phong phú
> hơn (mục 2, 3, 6) KHÔNG nới ranh giới này — mỗi mục bên dưới đều nói rõ phần nào của nó thuộc
> Bước C.

## 1. Mục đích & phạm vi

- Cho 2 bên ở 2 đầu 1 luồng giao tiếp (2 team nội bộ, hoặc team mình ↔ bên thứ ba) thống nhất
  trước: ai gọi ai, bằng thao tác nghiệp vụ nào, gửi dữ liệu gì, nhận lại dữ liệu gì — trước khi
  Bước C thực thi User Story ở 2 container độc lập.
- Chỉ đào sâu đúng các hàng đã duyệt trong bảng "Giao tiếp" của `c4-container.md`
  (`SYS-CTR-xxx`) — **không tự thêm/bớt luồng giao tiếp**. `c4-container.md` là nguồn sự thật
  cho ranh giới giao tiếp; tài liệu này chỉ trả lời "dữ liệu thật trao đổi qua luồng đó là gì"
  mà bảng kia (chỉ có cột giao thức + mô tả ngắn) không đủ chỗ trả lời.
- Không chọn giao thức/định dạng, không thiết kế API/DB, không đặt số liệu vận hành (rate limit,
  timeout, kích thước tối đa) — xem mục 7.
- Nếu `docs/04-system-overview/interface-contracts/schema-interface-contracts.md` (`SYS-SIC-xxx`) tồn tại và đã định
  nghĩa entity mà 1 CIC gửi/nhận, CIC đó trỏ về entity ở tài liệu kia (`xem SYS-SIC-001 §3.x`)
  thay vì tự liệt kê lại toàn bộ field — tránh 2 nguồn field cho cùng 1 entity dễ lệch nhau.

## 2. Quy ước chung (nêu 1 lần, không lặp ở từng CIC)

Chỉ ghi kỳ vọng nghiệp vụ/kiến trúc áp dụng cho nhiều CIC, để mục 4 không lặp lại. **Danh sách
chủ đề dưới đây là danh sách đóng** — chủ đề không nằm trong bảng này thì không viết ở đây,
thuộc Bước C (xem mục 7). Xoá dòng nào dự án không dùng, không thêm dòng mới.

| Chủ đề | Ghi ở mức này (ĐÚNG) | Ngoài phạm vi (SAI — Bước C) |
|---|---|---|
| **Phân nhóm lỗi** | Bên gọi cần phân biệt được mấy nhóm lỗi và xử lý khác nhau ra sao (vd: lỗi nghiệp vụ — nêu rõ luật nào bị vi phạm; lỗi tạm thời — cho phép gọi lại) | Mã lỗi/status code cụ thể, hình dạng response lỗi |
| **Idempotency** | Thao tác ghi nào có thể bị gọi lại (mất kết nối giữa chừng) và bên nhận phải nhận diện, bỏ qua bản trùng thay vì tạo bản sao; **field nghiệp vụ nào xác định 1 bản là trùng** (vd `task_id` + `send_at`) | Cách truyền khoá (header/tham số cụ thể), thuật toán checksum |
| **Thao tác chạy lâu** | Thao tác nào không trả kết quả ngay: bên gọi gửi yêu cầu → nhận 1 định danh lần chạy → hỏi lại trạng thái cho tới khi xong/thất bại; dữ liệu trạng thái cần đọc được là gì | Endpoint poll, chu kỳ poll, hàng đợi/công nghệ dùng |
| **Định danh & phiên bản dữ liệu** | Định danh của 1 đối tượng là duy nhất và không đổi sau khi tạo; field nào là định danh, field nào là bản hiển thị | Dạng định danh cụ thể (UUID/ULID/số tăng dần), cách đánh version của interface |

Chủ đề KHÔNG viết ở đây (thuộc Bước C, kể cả khi tài liệu tham khảo nào đó có): xác thực và cách
mang token, phân trang/lọc, rate limit, giao thức và định dạng dữ liệu, cơ chế truyền/khôi phục
file lớn, timeout/SLA.

## 3. Bảng tổng hợp CIC

Mỗi luồng giao tiếp gán 1 mã **CIC** (Container Interface Contract) — mã cục bộ trong tài liệu
này, giống cách `c4-container.md` gán "Mã" cho từng container. CIC không phải 1 loại tài liệu
mới, không tạo file riêng cho mỗi CIC.

Quy tắc đánh mã:

- 1 mã cho mỗi **hàng (cạnh có hướng)** trong bảng "Giao tiếp" của `c4-container.md` cần chốt
  trước — nếu 2 container gọi nhau cả 2 chiều và bảng đó ghi thành 2 hàng thì thành 2 mã CIC.
- Đánh số `CIC-001` tăng dần theo thứ tự hàng trong bảng "Giao tiếp".
- Mã đã cấp là **cố định**: luồng bị bỏ thì đánh dấu ngừng dùng ngay tại dòng của nó, KHÔNG đánh
  số lại các CIC còn lại (mã đã bị tham chiếu ở nơi khác).
- Mã dùng để tham chiếu ngắn gọn ở nơi khác (ví dụ 1 User Story chạm đúng 1 luồng).

Bảng này KHÔNG có cột giao thức: giao thức đã ghi ở bảng "Giao tiếp" của `c4-container.md` và đó
là nguồn sự thật — nhắc lại ở đây vừa dễ lệch, vừa kéo tài liệu về phía thiết kế API. Không thêm
cột đó lại.

| Mã | Từ | Tới | Loại | Đồng bộ / Bất đồng bộ | Component khởi tạo | Component xử lý |
|---|---|---|---|---|---|---|
| CIC-001 | `<container A>` | `<container B>` | nội bộ \| hệ thống ngoài | | | |

- **Loại**: `nội bộ` (2 container trong hệ thống, kể cả container DB thuần) hoặc `hệ thống ngoài`
  (bên kia là hệ thống đã liệt kê ở "Hệ thống ngoài liên quan" trong `c4-context.md`) — quyết
  định cách viết ở mục 4, xem ghi chú ở đó.
- **Component khởi tạo / xử lý**: lấy đúng tên component trong `c4-component-<mã container>.md`
  nếu container đó có file Component; container DB thuần hoặc hệ thống ngoài (không có
  Component diagram) → ghi `—`. Không tự đặt tên component mới ở tài liệu này.

## 4. Chi tiết từng CIC

1 mục con cho mỗi mã ở bảng mục 3.

### CIC-001 — `<container A>` → `<container B>`

- Loại: `nội bộ` | `hệ thống ngoài`
- Nguồn: `c4-container.md` (hàng `<container A>` → `<container B>`), `<FR-xxx nếu có>`

| Thao tác (US liên quan) | Mục đích | Dữ liệu cần gửi đi / lưu | Dữ liệu cần nhận lại / đọc | Đồng bộ / Bất đồng bộ | Ràng buộc nghiệp vụ |
|---|---|---|---|---|---|
| `<Thao tác>` (US-xxx) | | | | | |

Cách điền:

- **Thao tác**: tên nghiệp vụ, đọc lên hiểu ngay ("Tạo task mới", "Lưu task mới") — KHÔNG phải
  tên kỹ thuật của endpoint.
- **Dữ liệu cần gửi đi / lưu** và **Dữ liệu cần nhận lại / đọc**: mỗi field ghi tên + kiểu ở mức
  khái niệm (text/số/ngày-giờ/boolean/enum — liệt kê giá trị hợp lệ nếu là enum) + bắt buộc/tuỳ
  chọn. Với container DB thuần: "gửi đi" nghĩa là ghi/lưu, "nhận lại" nghĩa là đọc — vẫn chỉ ghi
  dữ liệu nào cần lưu được/đọc lại được, không thiết kế bảng.
- **Ràng buộc nghiệp vụ**: 1 câu tiếng Việt về luật ràng buộc thao tác này, hoặc trỏ về đúng
  dòng ở mục 2 (vd "áp dụng quy ước idempotency"). Không có thì ghi `—`.
- Nếu **Loại = `hệ thống ngoài`**: mục đích ở đây là ghi lại **kỳ vọng tích hợp cần xác nhận với
  bên thứ ba** theo hiểu biết hiện tại, không phải hợp đồng 2 team nội bộ tự chốt. Phần chưa
  xác nhận được vẫn phải ghi, kèm chữ "**chưa xác nhận với `<hệ thống ngoài>`**" ngay tại field
  đó — bỏ trống hoặc bỏ qua vì "chưa chắc" là SAI, vì đây chính là dữ liệu Bước C cần để không
  tự bịa hợp đồng tích hợp (xem ví dụ 3 ở mục 5). Nếu việc chưa xác nhận đủ quan trọng để chặn
  Bước C → tạo `OQ-*` (xem `AGENTS.md` Bước E) và ghi vào `related_open_questions`, thay vì chỉ
  ghi "chưa xác nhận" rồi để đó.

## 5. Ví dụ (ĐÚNG phạm vi vs SAI phạm vi)

### Cặp container thường ↔ container thường (vd CIC-001 `todo-web` → `todo-api`)

ĐÚNG — chỉ chốt dữ liệu, kiểu ở mức khái niệm:

| Thao tác (US liên quan) | Mục đích | Dữ liệu cần gửi đi / lưu | Dữ liệu cần nhận lại / đọc | Đồng bộ / Bất đồng bộ | Ràng buộc nghiệp vụ |
|---|---|---|---|---|---|
| Tạo task mới (US-001) | Người dùng thêm task từ giao diện | `title` (text, bắt buộc, không rỗng), `deadline` (ngày-giờ, tuỳ chọn) | Task vừa tạo: `id` (text, định danh duy nhất), `title` (text), `deadline` (ngày-giờ hoặc rỗng), `status` (enum: `open`/`done`, khởi tạo `open`) | Đồng bộ | `title` rỗng → từ chối, báo lỗi nghiệp vụ (nhóm lỗi ở mục 2) |

SAI — đây là thiết kế API cụ thể, thuộc Code (Bước C), KHÔNG viết vào tài liệu này:
```
POST /tasks
Request: { "title": string, "deadline": string | null }
Response 201: { "id": string, "title": string, "deadline": string | null, "status": "open" }
Response 400: { "error": "title_required" }
```

### Cặp container thường ↔ container DB thuần (vd CIC-002 `todo-api` → `todo-db`)

ĐÚNG — chỉ chốt dữ liệu cần lưu/đọc lại, kiểu ở mức khái niệm ("gửi đi" = ghi, "nhận lại" = đọc):

| Thao tác (US liên quan) | Mục đích | Dữ liệu cần gửi đi / lưu | Dữ liệu cần nhận lại / đọc | Đồng bộ / Bất đồng bộ | Ràng buộc nghiệp vụ |
|---|---|---|---|---|---|
| Lưu task mới (US-001) | Giữ được task để đọc lại ở phiên sau | `title` (text, bắt buộc), `deadline` (ngày-giờ, tuỳ chọn), `status` (enum: `open`/`done`, khởi tạo `open`) | (không cần đọc lại ngay) | Đồng bộ | — |

SAI — đây là thiết kế DDL, thuộc Code (Bước C), KHÔNG viết vào tài liệu này:
```
CREATE TABLE tasks (
  id uuid PRIMARY KEY,
  title text NOT NULL,
  deadline timestamptz NULL,
  status text NOT NULL
);
```

### Container nội bộ ↔ hệ thống ngoài (vd CIC-003 `todo-api` → Notification Service, bên thứ ba)

Khác 2 ví dụ trên: đây không phải 2 team nội bộ tự thoả thuận, nên có thể CHƯA xác nhận được
hết với bên thứ ba — vẫn phải ghi, không được bỏ qua vì "chưa chắc":

| Thao tác (US liên quan) | Mục đích | Dữ liệu cần gửi đi / lưu | Dữ liệu cần nhận lại / đọc | Đồng bộ / Bất đồng bộ | Ràng buộc nghiệp vụ |
|---|---|---|---|---|---|
| Gửi reminder (US-003) | Nhắc người dùng trước hạn task | `task_id` (text), `title` (text), kênh ưu tiên (enum: `push`/`email`), `send_at` (ngày-giờ) — **chưa xác nhận với Notification Service**: định dạng `send_at` họ yêu cầu, giới hạn rate limit | Xác nhận đã nhận yêu cầu gửi (chưa đảm bảo đã gửi) | Bất đồng bộ | Mỗi `task_id` + `send_at` chỉ gửi 1 lần — áp dụng quy ước idempotency ở mục 2 |

Nếu việc chưa xác nhận này đủ quan trọng để chặn Bước C → tạo `OQ-*` (xem `AGENTS.md` Bước E)
thay vì chỉ ghi "chưa xác nhận" rồi để đó.

### Cách phân biệt nhanh

Nếu 1 dòng sắp viết có method HTTP, path, status code, hoặc từ khoá SQL (`CREATE TABLE`, kiểu
cột, `PRIMARY KEY`...) → đó là SAI phạm vi, thuộc Bước C. Áp dụng cho **mọi mục** của tài liệu
này, kể cả quy ước chung ở mục 2 và nhãn mũi tên trong diagram ở mục 6. Thêm 2 dấu hiệu SAI
riêng của cấu trúc mới:

- Mục 2 xuất hiện chủ đề ngoài danh sách đóng (xác thực/token, phân trang, rate limit, giao
  thức, timeout...) → chuyển sang Bước C, xoá khỏi tài liệu.
- Nhãn mũi tên trong diagram mục 6 viết `POST /tasks` thay vì `Tạo task mới` → sửa lại thành tên
  thao tác nghiệp vụ đúng như ở mục 4.

Kiểu dữ liệu ở mức khái niệm (text/số/ngày-giờ/boolean/enum) LUÔN được viết — không phải trường
hợp ngoại lệ của quy tắc trên; chỉ **kiểu cụ thể của ngôn ngữ/DB** (`varchar(255)`, `timestamptz`,
`int32`, `string` kiểu TypeScript...) mới SAI phạm vi.

## 6. Luồng minh hoạ (tuỳ chọn)

Chỉ vẽ khi 1 luồng nghiệp vụ đi qua **từ 2 CIC trở lên** và đọc bảng ở mục 4 không thấy được thứ
tự (vd CIC-001 → CIC-004). Không vẽ cho mọi CIC — 1 CIC đơn lẻ đã nằm đủ trong bảng mục 4.

Ràng buộc khi vẽ: participant là container (kèm component nếu có), nhãn mũi tên là **tên thao
tác nghiệp vụ đúng như cột "Thao tác" ở mục 4** — không phải method/path/status code.

### 6.1 `<Tên luồng>` (CIC-00x → CIC-00y)

```mermaid
sequenceDiagram
```

## 7. Giới hạn & việc chuyển sang Bước C

- Chưa chọn giao thức, định dạng dữ liệu, framework, hay kiểu dữ liệu cụ thể của ngôn ngữ/DB —
  bảng ở mục 4 là hợp đồng logic, Bước C mới chuyển thành API/schema thật khi thực thi User Story.
- Chưa đặt rate limit, timeout/SLA, kích thước tối đa mỗi lần truyền — không suy đoán số liệu
  chưa có cơ sở; cần con số ngay thì tạo `OQ-*`.
- Khi `c4-component-*.md` đổi tên/thêm component (bump `version`), rà lại 2 cột Component ở mục 3.
- Khi bảng "Giao tiếp" của `c4-container.md` đổi (thêm/bớt cạnh), cập nhật mục 3 + mục 4 theo —
  `c4-container.md` là nguồn sự thật cho ranh giới giao tiếp, tài liệu này chỉ đào sâu bên trong
  từng cạnh đã duyệt. Thêm cạnh → cấp mã CIC mới tiếp theo, không tái sử dụng mã đã bỏ.
