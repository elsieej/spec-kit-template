---
id: SYS-SIC-001
type: entity_interface
status: draft        # draft | approved | deprecated
version: 1
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
source_docs: []       # SYS-CTR-xxx (container/DB sở hữu entity) và/hoặc container-interface.md liên quan
related_open_questions: []
---

# SYS-SIC-001 — Entity Interface (<Tên hệ thống>)

> Tài liệu này định nghĩa **entity nào tồn tại trong hệ thống, field của mỗi entity, và quan hệ
> giữa các entity** (1-nhiều, nhiều-nhiều, đệ quy...) — ở mức **logic/khái niệm**, độc lập công
> nghệ lưu trữ (chưa chọn SQL hay NoSQL). KHÔNG thiết kế DDL/collection schema thật (kiểu cột,
> index, khoá ngoại vật lý), KHÔNG mô tả request/response body của từng thao tác giao tiếp (đó là
> `container-interface.md`, mã CIC), KHÔNG mô tả định dạng file/wire format cụ thể hay
> quy ước storage key (đó là Bước C khi thực thi User Story). Xem mục 4 để phân biệt rõ ranh
> giới này bằng ví dụ ĐÚNG/SAI.
>
> Số thứ tự mục (1-6) là **cố định**, kể cả mục mang tính hướng dẫn/ví dụ (mục 4): giữ nguyên
> trong tài liệu thật, không xoá hay đánh số lại — mục 4 vẫn hữu ích cho người đọc sau này khi
> cần bổ sung entity mới, và các cross-reference dạng "xem SYS-SIC-001 §3.x" phụ thuộc số mục
> không đổi.

## 1. Khi nào tạo tài liệu này

Không bắt buộc cho mọi hệ thống. Chỉ tạo khi có **nhiều entity liên quan chặt với nhau** (nhiều
cạnh quan hệ, entity dùng chung bởi nhiều CIC/container) mà mô tả rời rạc trong từng mục CIC của
`container-interface.md` sẽ bị lặp lại hoặc lệch nhau giữa các chỗ. Hệ thống đơn giản,
ít entity, quan hệ rời rạc → field list ngay trong từng CIC là đủ, không cần tài liệu riêng này.

## 2. Sơ đồ quan hệ entity

```mermaid
erDiagram
```

### 2.1 Mô tả quan hệ

| Quan hệ | Cardinality | Diễn giải | Ghi chú / rule liên quan |
|---|---|---|---|
| `<Entity A>` ↔ `<Entity B>` | 1 – 0..n | | |

Cardinality dùng ký hiệu quen thuộc: `1–1`, `1–0..n`, `n–n`, hoặc đệ quy (entity tự tham chiếu
tới chính nó, vd "bản ghi trước đó"/"bản gốc trộn ra"). Mỗi quan hệ nêu rõ: bên nào là FK (trỏ
tới bên kia bằng field định danh), và có bắt buộc hay tuỳ chọn (0 hoặc 1 ở đầu ký hiệu).

## 3. Entity schema

1 mục con cho mỗi entity ở sơ đồ mục 2.

### 3.1 `<Tên entity>`

| Field | Kiểu | Bắt buộc | Ghi chú |
|---|---|---|---|
| `<tên>Id` | định danh | ✓ | Định danh duy nhất, không đổi sau khi tạo — không quy định định danh là ULID/UUID/số tăng dần, đó là quyết định lưu trữ ở Bước C |
| | | | |

Kiểu ở mức khái niệm: `text`, `số`, `ngày-giờ`, `boolean`, `enum(...)` (liệt kê giá trị hợp lệ),
`định danh` (id ổn định, không đổi — dùng cho field FK trỏ tới entity khác, ghi thêm "FK →
`<Entity>`"), `object` (cấu trúc lồng — mô tả bảng con ngay dưới entity cha), `array<kiểu>`
(danh sách). Không dùng kiểu cụ thể của ngôn ngữ/DB (`ULID`, `varchar(255)`, `int32`...).

## 4. Ví dụ (ĐÚNG phạm vi vs SAI phạm vi)

ĐÚNG — chỉ chốt field + kiểu khái niệm + quan hệ:

| Field | Kiểu | Bắt buộc | Ghi chú |
|---|---|---|---|
| `taskId` | định danh | ✓ | |
| `title` | text | ✓ | |
| `assignedTo` | định danh | | FK → `User`, tuỳ chọn |

SAI — đây là thiết kế DDL, thuộc Code (Bước C), KHÔNG viết vào tài liệu này:
```
CREATE TABLE tasks (
  id uuid PRIMARY KEY,
  title varchar(255) NOT NULL,
  assigned_to uuid REFERENCES users(id)
);
```

SAI — đây là request/response body của 1 thao tác giao tiếp cụ thể, thuộc
`container-interface.md` (mã CIC) hoặc Code, KHÔNG viết vào tài liệu này:
```
POST /tasks
Request: { "title": string, "assignedTo": string | null }
```

Cách phân biệt nhanh: nếu 1 dòng sắp viết gắn với **1 thao tác/1 luồng giao tiếp cụ thể** (ai
gọi ai, gửi/nhận gì) → thuộc CIC, không phải tài liệu này — tài liệu này chỉ mô tả bản thân dữ
liệu (entity, field, quan hệ), không quan tâm nó di chuyển qua luồng nào.

## 5. Liên kết với Container Interface Contract

Khi 1 mã CIC trong `container-interface.md` gửi/nhận đúng 1 entity (hoặc 1 phần field
của entity) đã định nghĩa ở đây, CIC đó nên trỏ về entity này (`xem SYS-SIC-001 §3.x`) thay vì
liệt kê lại toàn bộ field — chỉ ghi thêm field khác biệt/subset nếu CIC đó không dùng hết field
của entity. Tài liệu này là nguồn sự thật cho **hình dạng** entity; CIC là nguồn sự thật cho
**thao tác nào gửi/nhận entity đó qua luồng nào**.

## 6. Giả định cần xác nhận

Khi FR/UR chưa đặc tả đủ chi tiết để suy ra field/quan hệ chắc chắn, ghi giả định hợp lý ở đây
kèm nhãn `[Agent đề xuất — cần PO xác nhận]` (xem `plan-backlog`) — không tự chốt thành sự thật
khi chưa ai xác nhận.

-
