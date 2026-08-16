---
id: SYS-CTR-001
type: c4_container
status: draft        # draft | in-review | approved | changed | blocked
version: 1
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
source_docs: [SYS-CTX-001]
blocked_by_open_questions: []
---

# Container Diagram (C4 Level 2)

> Audience: kỹ thuật (architect, developer, ops). Cho thấy các container và công nghệ.

## Danh sách container
Cột "Mã" là slug ngắn, duy nhất trong bảng này (vd `checkout-web`, `checkout-api`, `db`) —
Epic tham chiếu tới container qua đúng mã này (field `source_container`), không dò theo tên
hay câu chữ ở cột Trách nhiệm. Cột "Repo triển khai" để trống nếu container không có repo
riêng (DB, service bên thứ 3, hoặc chung repo với container khác trong monorepo thì ghi cùng
1 tên repo).

| Mã | Container | Loại (web app / mobile / DB / service...) | Công nghệ | Trách nhiệm | Repo triển khai |
|---|---|---|---|---|---|

## Giao tiếp giữa các container
| Từ | Đến | Giao thức | Mô tả |
|---|---|---|---|

## Diagram (mermaid)
```mermaid
graph LR
  Web[Web App] -->|REST/HTTPS| API[API Service]
  API --> DB[(Database)]
```

## Ghi chú
- Chỉ dừng ở mức Container. Component/Code diagram (Level 3-4) chỉ tạo khi cần drill-down
  vào 1 container cụ thể, theo yêu cầu của team phụ trách container đó.
