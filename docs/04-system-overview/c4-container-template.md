---
id: SYS-CTR-001
type: system_container
status: draft        # draft | approved | deprecated
version: 1
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
source_docs: [SYS-CTX-001]
related_open_questions: []
---

# SYS-CTR-001 — <Tên hệ thống> (Container Diagram)

## Danh sách container

Mỗi container gán 1 mã (slug ngắn, duy nhất) — dữ liệu gốc mà Epic (`source_container`) và mọi
việc lập kế hoạch sau này tham chiếu theo đúng mã, không nơi nào khác tự đặt mã container mới.

| Mã | Loại | Trách nhiệm |
|---|---|---|
| | | |

## Giao tiếp

| Từ | Tới | Giao thức | Mô tả |
|---|---|---|---|
| | | | |

## Diagram

```mermaid
graph TD
```

## Ghi chú Component diagram

Với mỗi container: có tạo `c4-component-<mã>.md` hay không, và vì sao (container DB thuần/
dịch vụ bên thứ ba dùng nguyên trạng → không tạo; container quá đơn giản → ghi rõ candidate
component đã xét qua trước khi kết luận, xem skill `c4-model`).

-

## Ghi chú Interface Contract

Cặp container nào cần `interface-contracts.md` (schema dữ liệu trao đổi) — chỉ cần khi có dữ
liệu thật phải thống nhất trước lúc 2 container được thực thi độc lập; "cặp container" bao gồm
cả container nội bộ ↔ hệ thống ngoài đã liệt kê ở "Hệ thống ngoài liên quan" trong
`c4-context.md` (payment gateway, hệ thống bên thứ ba...), không chỉ 2 container nội bộ — xem
skill `c4-model`, mục "Quy trình tạo Interface Contract".

-
