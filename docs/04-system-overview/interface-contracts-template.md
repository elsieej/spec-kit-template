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

# SYS-IFC-001 — Schema giao tiếp & dữ liệu (<Tên hệ thống>)

> Chỉ tạo file này khi có dữ liệu thật cần 2 container thống nhất trước khi thực thi độc lập
> (xem skill `c4-model`). Tài liệu này CHỈ chốt schema dữ liệu (field nào bắt buộc/tuỳ chọn,
> request cần gì, response cần gì) và schema lưu trữ cho container DB thuần — KHÔNG quy định
> API cụ thể (method HTTP, path, status code, hình dạng response chi tiết). Đó là Code
> (Level 4), quyết định ở Bước C khi thực thi User Story, không phải việc của tài liệu này.

## Schema giao tiếp: `<container A>` ↔ `<container B>`

Nguồn: `c4-container.md` (giao tiếp `<container A>` ↔ `<container B>`).

| Thao tác (US liên quan) | Dữ liệu cần gửi đi | Dữ liệu cần nhận lại |
|---|---|---|
| | | |

## DB schema: `<mã container DB thuần>`

Nguồn: `c4-container.md` (`<mã container>` — DB thuần, không có Component diagram).

### Bảng `<tên bảng>`

| Cột | Kiểu | Ghi chú |
|---|---|---|
| | | |
