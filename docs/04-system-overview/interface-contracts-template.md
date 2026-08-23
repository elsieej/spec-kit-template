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
> (xem skill `c4-model`). Tài liệu này CHỈ chốt schema dữ liệu (field nào bắt buộc/tuỳ chọn,
> dữ liệu cần gửi/lưu, dữ liệu cần nhận lại/đọc) — KHÔNG thiết kế API hay DB cụ thể (method
> HTTP, path, status code, tên bảng/cột/kiểu SQL, index...). Đó là Code (Level 4), quyết định ở
> Bước C khi thực thi User Story, không phải việc của tài liệu này — kể cả với container DB
> thuần: chỉ ghi dữ liệu nào cần lưu được/đọc lại được, không thiết kế schema bảng.

## Schema giao tiếp: `<container A>` ↔ `<container B>`

1 mục cho mỗi cặp container giao tiếp trong `c4-container.md` cần chốt trước (xem "Ghi chú
Interface Contract" ở `c4-container.md`) — kể cả khi 1 trong 2 bên là container DB thuần (khi
đó "gửi đi" nghĩa là ghi/lưu, "nhận lại" nghĩa là đọc).

Nguồn: `c4-container.md` (giao tiếp `<container A>` ↔ `<container B>`).

| Thao tác (US liên quan) | Dữ liệu cần gửi đi / lưu | Dữ liệu cần nhận lại / đọc |
|---|---|---|
| | | |

Ví dụ 1 dòng cho cặp container thường ↔ container DB thuần (minh hoạ ranh giới "dữ liệu cần
lưu" — ĐÚNG phạm vi — khác với "thiết kế bảng" — SAI phạm vi, xem cảnh báo ở trên):

| Lưu task mới (US-001) | `title` (bắt buộc), `deadline` (tuỳ chọn), `status` khởi tạo `open` | (không cần đọc lại ngay) |

KHÔNG viết thành `bảng tasks(id uuid PK, title text NOT NULL, deadline timestamptz NULL, ...)`
— đó là thiết kế DDL, thuộc Bước C.
