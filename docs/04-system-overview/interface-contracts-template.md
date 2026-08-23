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

# SYS-IFC-001 — Schema giao tiếp (<Tên hệ thống>)

> Chỉ tạo file này khi có dữ liệu thật cần 2 container thống nhất trước khi thực thi độc lập
> (xem skill `c4-model`). Tài liệu này CHỈ chốt schema dữ liệu (mỗi field: tên, kiểu ở mức khái
> niệm — text/số/ngày-giờ/boolean/enum (liệt kê giá trị hợp lệ nếu là enum), bắt buộc/tuỳ chọn,
> dữ liệu cần gửi/lưu, dữ liệu cần nhận lại/đọc) — KHÔNG thiết kế API hay DB cụ thể (method
> HTTP, path, status code, tên bảng/cột/**kiểu cột SQL/ngôn ngữ cụ thể** như `varchar(255)`,
> `timestamptz`, `int32`, index...). Đó là Code (Level 4), quyết định ở Bước C khi thực thi User
> Story, không phải việc của tài liệu này — kể cả với container DB thuần: chỉ ghi dữ liệu nào
> cần lưu được/đọc lại được kèm kiểu khái niệm, không thiết kế schema bảng.

## Schema giao tiếp: `<container A>` ↔ `<container B>`

1 mục cho mỗi cặp container giao tiếp trong `c4-container.md` cần chốt trước (xem "Ghi chú
Interface Contract" ở `c4-container.md`) — kể cả khi 1 trong 2 bên là container DB thuần (khi
đó "gửi đi" nghĩa là ghi/lưu, "nhận lại" nghĩa là đọc), **hoặc là hệ thống ngoài** đã liệt kê ở
`c4-context.md` (payment gateway, hệ thống bên thứ ba...) — khi đó mục đích là ghi lại kỳ vọng
tích hợp cần xác nhận với bên thứ ba, không phải hợp đồng 2 team nội bộ tự chốt (xem ví dụ 3
bên dưới).

Nguồn: `c4-container.md` (giao tiếp `<container A>` ↔ `<container B>`). Mỗi field ghi kèm kiểu
ở mức khái niệm (text/số/ngày-giờ/boolean/enum) và bắt buộc/tuỳ chọn — xem ví dụ bên dưới.

| Thao tác (US liên quan) | Dữ liệu cần gửi đi / lưu | Dữ liệu cần nhận lại / đọc |
|---|---|---|
| | | |

## Ví dụ (ĐÚNG phạm vi vs SAI phạm vi)

### Cặp container thường ↔ container thường (vd `todo-web` ↔ `todo-api`)

ĐÚNG — chỉ chốt dữ liệu, kiểu ở mức khái niệm:

| Tạo task mới (US-001) | `title` (text, bắt buộc, không rỗng), `deadline` (ngày-giờ, tuỳ chọn) | Task vừa tạo: `id` (text, định danh duy nhất), `title` (text), `deadline` (ngày-giờ hoặc rỗng), `status` (enum: `open`/`done`, khởi tạo `open`) |

SAI — đây là thiết kế API cụ thể, thuộc Code (Bước C), KHÔNG viết vào tài liệu này:
```
POST /tasks
Request: { "title": string, "deadline": string | null }
Response 201: { "id": string, "title": string, "deadline": string | null, "status": "open" }
Response 400: { "error": "title_required" }
```

### Cặp container thường ↔ container DB thuần (vd `todo-api` ↔ `todo-db`)

ĐÚNG — chỉ chốt dữ liệu cần lưu/đọc lại, kiểu ở mức khái niệm ("gửi đi" = ghi, "nhận lại" = đọc):

| Lưu task mới (US-001) | `title` (text, bắt buộc), `deadline` (ngày-giờ, tuỳ chọn), `status` (enum: `open`/`done`, khởi tạo `open`) | (không cần đọc lại ngay) |

SAI — đây là thiết kế DDL, thuộc Code (Bước C), KHÔNG viết vào tài liệu này:
```
CREATE TABLE tasks (
  id uuid PRIMARY KEY,
  title text NOT NULL,
  deadline timestamptz NULL,
  status text NOT NULL
);
```

Cách phân biệt nhanh: nếu 1 dòng sắp viết có method HTTP, path, status code, hoặc từ khoá SQL
(`CREATE TABLE`, kiểu cột, `PRIMARY KEY`...) → đó là SAI phạm vi, thuộc Bước C. Kiểu dữ liệu ở
mức khái niệm (text/số/ngày-giờ/boolean/enum) LUÔN được viết — không phải trường hợp ngoại lệ
của quy tắc trên; chỉ **kiểu cụ thể của ngôn ngữ/DB** (`varchar(255)`, `timestamptz`, `int32`,
`string` kiểu TypeScript...) mới SAI phạm vi.

### Container nội bộ ↔ hệ thống ngoài (vd `todo-api` ↔ Notification Service, bên thứ ba)

Khác 2 ví dụ trên: đây không phải 2 team nội bộ tự thoả thuận, nên có thể CHƯA xác nhận được
hết với bên thứ ba — vẫn phải ghi, không được bỏ qua vì "chưa chắc":

| Gửi reminder (US-003) | `task_id` (text), `title` (text), kênh ưu tiên (enum: `push`/`email`), `send_at` (ngày-giờ) — **chưa xác nhận với Notification Service**: định dạng `send_at` họ yêu cầu, giới hạn rate limit | Xác nhận đã nhận yêu cầu gửi (chưa đảm bảo đã gửi) |

Nếu việc chưa xác nhận này đủ quan trọng để chặn Bước C → tạo `OQ-*` (xem `AGENTS.md` Bước E)
thay vì chỉ ghi "chưa xác nhận" rồi để đó.
