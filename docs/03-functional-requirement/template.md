---
id: FR-001
type: functional_requirement
status: draft        # draft | approved | deprecated
version: 1
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
parent_user_requirement: UR-001    # 1 UR duy nhất — nếu FR phục vụ nhiều UR/persona, xem ghi chú ở mục "Liên kết" bên dưới
related_open_questions: []
---

# FR-001 — <Tên functional requirement>

## Mô tả chức năng (WHAT)
<Hệ thống phải đạt được kết quả/đầu ra gì, cụ thể — không mô tả cách triển khai kỹ thuật (đó là việc của System Overview/C4 và Epic/Feature/User Story)>

## Business rules
-

## Input / Output
| Input | Xử lý | Output |
|---|---|---|
| | | |

## Edge cases cần xử lý
-

## Liên kết
- User requirement: UR-001
- Sẽ được dùng để sinh: system_overview, epics/features/user-stories

**FR phục vụ nhiều UR/persona?** `parent_user_requirement` chỉ nhận 1 ID — chọn UR mà FR này
phục vụ trực tiếp nhất làm parent. Kiểm tra bằng 2 câu hỏi cụ thể, không suy đoán chung chung:
1. Cột **Input/Output** ở trên có khác nhau giữa các persona không (field khác, luồng xử lý
   khác), hay giống hệt nhau và chỉ khác cách diễn đạt trong "Mô tả chức năng"?
2. Có **Business rule** nào chỉ áp dụng cho 1 persona mà không áp dụng cho persona còn lại
   không?

Nếu câu trả lời cho 1 trong 2 câu hỏi trên là **có** → hành vi khác nhau thật, tách thành FR
riêng cho từng UR thay vì gộp 1 FR nhiều parent (cùng cách xử lý với Epic chạm nhiều container,
xem `plan-backlog`). Nếu cả 2 câu đều **không** (Input/Output và Business rule giống hệt nhau) →
đây là 1 hành vi dùng chung, liệt kê UR còn lại (ngoài parent) vào đây, kèm 1 câu vì sao FR này
cũng phục vụ UR đó.
