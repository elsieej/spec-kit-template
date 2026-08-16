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
| Container | Loại (web app / mobile / DB / service...) | Công nghệ | Trách nhiệm |
|---|---|---|---|

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
