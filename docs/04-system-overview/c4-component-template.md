---
id: SYS-CMP-001
type: system_component
status: draft        # draft | approved | deprecated
version: 1
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
source_docs: [SYS-CTR-xxx]     # container cha (Mã trong c4-container.md)
related_open_questions: []
---

# SYS-CMP-001 — <mã container> (Component Diagram)

## Component

Ở mức đủ để dev trong team sở hữu container hiểu bố cục mà không cần đọc code trước. Không
xuống tới class/function cụ thể (đó là Level 4, không thuộc phạm vi tài liệu này).

Cột "CIC liên quan" chỉ điền nếu `docs/04-system-overview/interface-contracts/
container-interface-contracts.md` tồn tại và component này là component khởi tạo hoặc xử lý của
1 mã CIC (đối chiếu đúng tên component ở cột "Component khởi tạo"/"Component xử lý" trong bảng
tổng hợp CIC của tài liệu đó) — để trống/`—` nếu component chỉ giao tiếp nội bộ trong container.
Đây là tham chiếu ngược, không phải nguồn sự thật: nếu 2 chỗ lệch nhau, `container-interface-
contracts.md` mới là nguồn đúng — sửa ở đây theo đó, không sửa ngược lại.

| Component | Trách nhiệm chính | CIC liên quan |
|---|---|---|
| | | |

## Diagram

```mermaid
graph TD
```

## Xác nhận với user

Bắt buộc điền trước khi coi file này là chính thức (xem skill `c4-model`, Component Diagram
bước 5) — ghi **nguyên văn** danh sách candidate component đã trình bày và phản hồi thật của
user, không chỉ khẳng định suông "đã đề xuất và PO xác nhận". Đây là bằng chứng duy nhất đọc lại
được độc lập với git log (không phải môi trường nào cũng có) hay trí nhớ phiên làm việc.

- Candidate đã trình bày:
- Phản hồi user:
