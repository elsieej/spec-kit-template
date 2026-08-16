---
name: backlog-status
description: >
  Trả lời "sprint nào đang active/đang chạy", "backlog đang có gì", "tình trạng dự án hiện
  tại đang thế nào" bằng cách đọc trực tiếp frontmatter của các file trong docs/04-backlog —
  không có file trạng thái/dashboard riêng nào được duy trì thủ công, mọi câu trả lời tính lại
  từ frontmatter mỗi lần hỏi để tránh dữ liệu cũ/sai lệch. Dùng skill này khi user hỏi về sprint
  hiện tại hoặc nội dung backlog.
---

# backlog-status

Skill chỉ đọc (read-only) — không sửa file nào. Mục tiêu: tổng hợp nhanh trạng thái sprint +
backlog từ frontmatter, vì kit này không duy trì file dashboard/index riêng (tránh trùng lặp
nội dung đã có trong frontmatter, tránh dữ liệu cũ do quên cập nhật).

## Quy trình

1. **Sprint đang active**: đọc frontmatter mọi file trong `docs/04-backlog/sprints/` (trừ
   `SPRINT-template.md`), tìm `status: active`. Quy ước: chỉ được có tối đa 1 sprint `active`
   tại một thời điểm — sprint cũ phải chuyển `done` trước khi sprint mới được mở.
   - Đúng 1 file active → báo cáo Sprint Goal, `start_date`/`end_date`, và bảng "User Stories /
     Tasks cam kết" của file đó.
   - 0 file active → báo "chưa có sprint nào đang active", gợi ý tạo sprint mới từ
     `docs/04-backlog/sprints/SPRINT-template.md`.
   - >1 file active → đây là vi phạm quy ước "chỉ 1 sprint active" — báo rõ cho user, không tự
     ý chọn 1 sprint để sửa `status`.

2. **Backlog hiện có**: đọc frontmatter mọi file trong
   `docs/04-backlog/{epics,features,user-stories,tasks}/` (trừ các `*-template.md`). "Backlog"
   là mọi item có `sprint: null` (chưa gắn vào sprint nào). Nhóm theo loại (Epic/Feature/US/
   Task) rồi theo `status`:
   - `blocked` → liệt kê riêng, kèm `blocked_by_open_questions` để user biết đang chờ OQ nào.
   - `draft`/`ready` → liệt kê theo nhóm, ưu tiên hiển thị `ready` trước (đây là phần có thể kéo
     vào sprint kế tiếp).
   - Không liệt kê item đã có `sprint: <khác null>` — item đó thuộc về sprint đang chạy/đã xong,
     không còn tính là backlog.

3. Trình bày kết quả dạng bảng/gạch đầu dòng ngắn gọn, không diễn giải dài dòng. Nếu user chỉ
   hỏi 1 trong 2 phần (sprint hoặc backlog), chỉ trả lời phần đó.
