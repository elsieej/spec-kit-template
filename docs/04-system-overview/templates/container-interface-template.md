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

> Chỉ tạo file này khi có dữ liệu thật cần 2 bên thống nhất trước khi Bước C thực thi độc lập
> (xem skill `c4-model`). Tài liệu này CHỈ chốt schema dữ liệu (field: tên, kiểu ở mức khái
> niệm — text/số/ngày-giờ/boolean/enum, bắt buộc/tuỳ chọn, dữ liệu cần gửi/lưu, dữ liệu cần
> nhận lại/đọc) — KHÔNG thiết kế API/DB cụ thể (method HTTP, path, status code, kiểu cột SQL,
> index...). Đó là Code (Level 4), quyết định ở Bước C — kể cả với container DB thuần. Mọi mục
> phong phú hơn bên dưới đều nằm trong ranh giới này, không nới thêm.

## 1. Mục đích & phạm vi

- Cho 2 bên ở 2 đầu 1 luồng giao tiếp (2 team nội bộ, hoặc team mình ↔ bên thứ ba) thống nhất
  trước: ai gọi ai, thao tác nào, gửi/nhận gì.
- Chỉ đào sâu đúng các hàng đã duyệt trong bảng "Giao tiếp" của `c4-container.md` — **không tự
  thêm/bớt luồng giao tiếp**; `c4-container.md` là nguồn sự thật cho ranh giới đó.
- Nếu `entity-interface.md` (`SYS-SIC-xxx`) đã định nghĩa entity mà 1 CIC gửi/nhận,
  trỏ về entity đó thay vì liệt kê lại field.

## 2. Quy ước chung (nêu 1 lần, không lặp ở từng CIC)

Danh sách đóng — chỉ 4 chủ đề dưới đây, không thêm dòng. Xoá dòng nào dự án không dùng.

| Chủ đề | Ghi ở mức này |
|---|---|
| **Phân nhóm lỗi** | Bên gọi phân biệt được mấy nhóm lỗi, xử lý khác nhau ra sao (vd lỗi nghiệp vụ — nêu rõ luật bị vi phạm; lỗi tạm thời — cho phép gọi lại) |
| **Idempotency** | Thao tác ghi nào có thể bị gọi lại, và **field nghiệp vụ nào** xác định 1 bản là trùng (vd `task_id`+`send_at`) |
| **Thao tác chạy lâu** | Bên gọi submit → nhận định danh lần chạy → hỏi lại trạng thái tới khi xong/thất bại; dữ liệu trạng thái cần đọc là gì |
| **Định danh & phiên bản dữ liệu** | Định danh 1 đối tượng duy nhất, không đổi sau khi tạo; field nào là định danh, field nào là bản hiển thị |

Chủ đề KHÔNG viết ở đây dù có vẻ áp dụng cho nhiều CIC (thuộc Bước C): xác thực/token, phân
trang, rate limit, giao thức/định dạng, cơ chế truyền file lớn, timeout/SLA.

## 3. Bảng tổng hợp CIC

Mỗi luồng gán 1 mã **CIC** — mã cục bộ trong tài liệu này (không phải 1 loại tài liệu riêng),
giống cách `c4-container.md` gán "Mã" cho container. Quy tắc:

- 1 mã cho mỗi **hàng (cạnh có hướng)** trong bảng "Giao tiếp" của `c4-container.md` — 2 chiều
  ghi 2 hàng thì thành 2 mã.
- Đánh số `CIC-001` tăng dần theo thứ tự hàng. Mã đã cấp **cố định** — luồng bị bỏ thì đánh dấu
  ngừng dùng tại chỗ, không đánh số lại các mã còn lại.
- Không có cột giao thức (đã ở `c4-container.md`, nhắc lại dễ lệch và kéo về hướng thiết kế API).

| Mã | Từ | Tới | Loại | Đồng bộ / Bất đồng bộ | Component khởi tạo | Component xử lý |
|---|---|---|---|---|---|---|
| CIC-001 | `<container A>` | `<container B>` | nội bộ \| hệ thống ngoài | | | |

- **Loại**: `nội bộ` (kể cả DB thuần) hoặc `hệ thống ngoài` (đã liệt kê ở "Hệ thống ngoài liên
  quan" trong `c4-context.md`) — quyết định cách viết ở mục 4.
- **Component khởi tạo/xử lý**: tên thật từ `c4-component-<mã>.md` nếu có; DB thuần/hệ thống
  ngoài → `—`. Không tự đặt tên component mới ở đây.

## 4. Chi tiết từng CIC

1 mục con cho mỗi mã ở bảng mục 3.

### CIC-001 — `<container A>` → `<container B>`

- Loại: `nội bộ` | `hệ thống ngoài`
- Nguồn: `c4-container.md` (hàng tương ứng), `<FR-xxx nếu có>`

| Thao tác (US liên quan) | Mục đích | Dữ liệu cần gửi đi / lưu | Dữ liệu cần nhận lại / đọc | Đồng bộ / Bất đồng bộ | Ràng buộc nghiệp vụ |
|---|---|---|---|---|---|
| `<Thao tác>` (US-xxx) | | | | | |

Cách điền:

- **Thao tác**: tên nghiệp vụ đọc hiểu ngay ("Tạo task mới") — KHÔNG phải tên kỹ thuật endpoint.
- **Dữ liệu gửi/nhận**: field + kiểu khái niệm (text/số/ngày-giờ/boolean/enum) + bắt buộc/tuỳ
  chọn. Với container DB thuần: "gửi đi" = ghi, "nhận lại" = đọc — vẫn không thiết kế bảng.
- **Ràng buộc nghiệp vụ**: 1 câu, hoặc trỏ về mục 2 nếu trùng. Không có thì `—`.
- **Loại = `hệ thống ngoài`**: mục đích là ghi lại **kỳ vọng tích hợp cần xác nhận với bên thứ
  ba**, không phải hợp đồng 2 team tự chốt. Chưa xác nhận vẫn phải ghi, kèm "**chưa xác nhận
  với `<hệ thống ngoài>`**" — không bỏ trống. Nếu đủ quan trọng để chặn Bước C → tạo `OQ-*`.

## 5. Ví dụ (ĐÚNG phạm vi vs SAI phạm vi)

ĐÚNG — chỉ chốt dữ liệu, kiểu ở mức khái niệm, áp dụng như nhau cho cả 3 loại cặp:

| Cặp (mã CIC) | Thao tác | Gửi đi / lưu | Nhận lại / đọc | Đồng bộ/BĐ |
|---|---|---|---|---|
| `todo-web`→`todo-api` (CIC-001) | Tạo task mới (US-001) | `title` (text, bắt buộc), `deadline` (ngày-giờ, tuỳ chọn) | Task: `id`, `title`, `deadline`, `status` (enum `open`/`done`) | Đồng bộ |
| `todo-api`→`todo-db` (CIC-002, DB thuần) | Lưu task mới (US-001) | `title`, `deadline`, `status` (như trên) | (không cần đọc lại ngay) | Đồng bộ |
| `todo-api`→Notification Service (CIC-003, hệ thống ngoài) | Gửi reminder (US-003) | `task_id`, `title`, kênh (enum `push`/`email`), `send_at` (ngày-giờ) — **chưa xác nhận với Notification Service**: định dạng `send_at` họ yêu cầu | Xác nhận đã nhận yêu cầu (chưa đảm bảo đã gửi) | Bất đồng bộ |

SAI — bất kỳ dòng nào giống thế này đều thuộc Code (Bước C), KHÔNG viết vào tài liệu này:
```
POST /tasks  Request: { "title": string, "deadline": string | null }   ← thiết kế API
CREATE TABLE tasks (id uuid PRIMARY KEY, title text NOT NULL, ...)     ← thiết kế DDL
```

Cách phân biệt nhanh: dòng có method HTTP/path/status code, hoặc từ khoá SQL (`CREATE TABLE`,
kiểu cột, `PRIMARY KEY`...) → SAI phạm vi. Áp dụng cho **mọi mục**, kể cả quy ước chung (mục 2)
và nhãn mũi tên trong diagram (mục 6 — dùng tên thao tác nghiệp vụ, không phải endpoint). Kiểu
dữ liệu khái niệm (text/số/ngày-giờ/boolean/enum) LUÔN được viết — không phải ngoại lệ; chỉ kiểu
cụ thể của ngôn ngữ/DB (`varchar(255)`, `timestamptz`, `int32`...) mới SAI phạm vi.

## 6. Luồng minh hoạ (tuỳ chọn)

Chỉ vẽ khi 1 luồng nghiệp vụ đi qua **từ 2 CIC trở lên** (vd CIC-001 → CIC-004) và bảng mục 4
không thấy được thứ tự — không vẽ cho 1 CIC đơn lẻ.

### 6.1 `<Tên luồng>` (CIC-00x → CIC-00y)

```mermaid
sequenceDiagram
```

## 7. Giới hạn & việc chuyển sang Bước C

- Chưa chọn giao thức, định dạng, framework, hay kiểu dữ liệu cụ thể — Bước C chuyển bảng mục 4
  thành API/schema thật.
- Chưa đặt rate limit, timeout/SLA, kích thước tối đa — không suy đoán số liệu chưa có cơ sở;
  cần ngay thì tạo `OQ-*`.
- Container/component đổi (Mã, tên component) → rà lại mục 3-4. Bảng "Giao tiếp" của
  `c4-container.md` đổi → cập nhật theo (thêm cạnh → cấp mã CIC mới, không tái sử dụng mã đã bỏ).
