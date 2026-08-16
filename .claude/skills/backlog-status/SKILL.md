---
name: backlog-status
description: >
  Trả lời "sprint nào đang active/đang chạy", "backlog đang có gì", "Feature nào thuộc Epic
  nào", "cây Epic/Feature/User Story/Task", "EPIC-xxx có gì bên trong", "tình trạng dự án hiện
  tại đang thế nào" bằng cách đọc trực tiếp frontmatter của các file trong docs/04-backlog —
  không có file trạng thái/dashboard/index riêng nào được duy trì thủ công, mọi câu trả lời
  tính lại từ frontmatter mỗi lần hỏi để tránh dữ liệu cũ/sai lệch. Dùng skill này khi user hỏi
  về sprint hiện tại, nội dung backlog, hoặc quan hệ cha-con giữa các cấp backlog.
---

# backlog-status

Skill chỉ đọc (read-only) — không sửa file nào. Mục tiêu: tổng hợp nhanh trạng thái sprint +
backlog + quan hệ cha-con giữa các cấp, từ frontmatter, vì kit này không duy trì file
dashboard/index riêng (tránh trùng lặp nội dung đã có trong frontmatter, tránh dữ liệu cũ do
quên cập nhật). Mục "Phạm vi"/"User stories thuộc feature này"/"Tasks thuộc story này" trong
từng file Epic/Feature/US là bản tóm tắt cho người đọc, có thể bị quên cập nhật khi tạo item
mới thủ công (không qua skill `plan-backlog`) — skill này KHÔNG dựa vào các mục đó, chỉ dựa
vào field `parent_*` (nguồn duy nhất, luôn đúng vì mỗi file backlog bắt buộc có field này).

Epic nằm phẳng trong `docs/04-backlog/epics/`; Feature/User Story/Task nằm trong subfolder
theo Epic sở hữu (`docs/04-backlog/{features,user-stories,tasks}/{EPIC-ID}_{slug}/...`) — khi
quét các thư mục này, đọc đệ quy qua mọi subfolder (không chỉ cấp ngay bên dưới), vẫn loại trừ
mọi `*-template.md`. Subfolder chỉ là tổ chức vật lý, không thay đổi cách xác định quan hệ
cha-con (vẫn dựa vào `parent_*`, không suy ra Epic sở hữu từ tên subfolder).

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
   `docs/04-backlog/{epics,features,user-stories,tasks}/` (đệ quy qua subfolder theo Epic, trừ
   các `*-template.md`). "Backlog"
   là mọi item có `sprint: null` (chưa gắn vào sprint nào). Nhóm theo loại (Epic/Feature/US/
   Task) rồi theo `status`:
   - `blocked` → liệt kê riêng, kèm `blocked_by_open_questions` để user biết đang chờ OQ nào.
   - `draft`/`ready` → liệt kê theo nhóm, ưu tiên hiển thị `ready` trước (đây là phần có thể kéo
     vào sprint kế tiếp).
   - Với mỗi item còn ID trong `depends_on` mà ID đó chưa `status: done` → đánh dấu riêng
     "chưa thể ready (chờ <ID> xong)", kể cả khi `status` hiện tại đang là `ready` (nghĩa là ai
     đó set `ready` trước khi dependency xong — vẫn báo cho user biết, không tự sửa `status`).
   - Không liệt kê item đã có `sprint: <khác null>` — item đó thuộc về sprint đang chạy/đã xong,
     không còn tính là backlog.

3. **Cây phân cấp Epic → Feature → User Story → Task**: đọc frontmatter mọi file trong
   `docs/04-backlog/{epics,features,user-stories,tasks}/` (đệ quy qua subfolder theo Epic, trừ
   `*-template.md`), dựng cây từ
   `parent_epic` (Feature), `parent_feature` (User Story), `parent_user_story` (Task):
   - Với 1 Epic cụ thể được hỏi tới, hoặc toàn bộ backlog nếu user không chỉ định: in cây thụt
     lề theo cấp, mỗi node kèm ID + tên + `status` (ví dụ
     `EPIC-001 (ready) — Quản lý Task cá nhân` → thụt lề `FEAT-001 (draft) — CRUD Task` →
     thụt lề tiếp `US-001 (in-progress) — ...` → `TASK-001 (done) — ...`).
   - **Phát hiện liên kết gãy**: nếu 1 file có `parent_*` trỏ tới ID không tồn tại trong thư
     mục tương ứng (đã bị xoá/đổi tên/gõ sai), liệt kê riêng phần "Liên kết gãy" — không bỏ
     qua âm thầm.
   - **Phát hiện item mồ côi ở đúng cấp của nó**: Epic không có `parent_business_requirement`
     trỏ tới BR tồn tại, hoặc Feature/US/Task không match được vào cây (parent không tồn tại)
     → liệt kê ở "Liên kết gãy" cùng mục trên, không tự đoán nên gắn vào đâu.
   - Nếu node có `depends_on` khác rỗng, ghi kèm ngay sau status, ví dụ
     `TASK-007 (ready, chờ TASK-004) — ...` khi TASK-004 chưa `done`.

4. Trình bày kết quả dạng bảng/cây/gạch đầu dòng ngắn gọn, không diễn giải dài dòng. Nếu user
   chỉ hỏi 1 trong 3 phần (sprint, backlog, hoặc cây phân cấp), chỉ trả lời phần đó.
