---
name: plan-backlog
description: >
  Dẫn dắt team phân rã BR/UR/FR đã approved thành Epic → Feature → User Story → Task
  (Bước B trong AGENTS.md), rồi kéo các item đang ready vào Sprint (Bước F). Dùng skill
  này khi user nói "tạo backlog", "phân rã epic/feature/user story/task", "lên sprint",
  "kéo task vào sprint", "backlog hoạt động thế nào", hoặc sau khi docs/00-03 đã
  `status: approved` mà chưa có Epic nào trong docs/04-backlog.
---

# plan-backlog

Mục tiêu: biến BR/UR/FR đã approved thành backlog thật (Epic/Feature/User Story/Task có ID,
`parent_*`, đúng template), sau đó kéo phần đã `ready` vào một Sprint cụ thể. Tiêu chí phân
rã đầy đủ + ví dụ minh hoạ nằm ở `AGENTS.md` (Bước B, Bước F) — đọc trước khi chạy skill này.

## Nguyên tắc khi chạy skill này

- Đi từ trên xuống: xác nhận Epic trước, rồi mới hỏi Feature bên trong Epic đó, rồi User
  Story bên trong Feature, rồi Task bên trong User Story. Không nhảy cấp, không hỏi dồn tất
  cả cùng lúc.
- Mỗi cấp phải trỏ `parent_*` về đúng cấp cha (xem bảng tiêu chí ở `AGENTS.md`, Bước B) và về
  đúng BR/UR/FR nguồn.
- Epic cần hỏi thêm field `repo` (repo nào sẽ triển khai Epic này) nếu team làm đa repo — để
  trống (`null`) nếu chỉ có 1 repo.
- User Story bắt buộc có Acceptance Criteria dạng Given/When/Then — không tạo US thiếu mục
  này, hỏi lại user nếu họ chỉ đưa ý tưởng chung chung.
- Task phải đủ nhỏ (vài giờ đến 1–2 ngày); nếu user mô tả một Task lớn hơn mức đó, đề xuất
  tách thành nhiều Task hoặc nâng thành User Story riêng.
- Tất cả tạo mới ở `status: draft`. Không tự set `ready`/`approved` — đó là quyết định của
  team khi review.
- Nếu một item phụ thuộc vào điều chưa rõ, không tự đoán — tạo `OQ-xxx` (xem Bước E) và set
  `status: blocked` kèm `blocked_by_open_questions`.

## Quy trình

### Phần 1 — Phân rã backlog (Bước B)

1. Xác nhận `docs/00-03` liên quan đã `status: approved`. Nếu chưa, dừng lại và nhắc user
   hoàn thiện BR/UR/FR trước (skill `setup-context`).
2. Hỏi **Epic**: "Mục tiêu kinh doanh lớn nào từ BR-xxx đang cần hiện thực hoá? Epic này ứng
   với repo nào (nếu đa repo)?" → tạo `docs/04-backlog/epics/EPIC-xxx_<slug>.md`.
3. Hỏi **Feature** (cho từng Epic vừa tạo): "Epic này gồm những nhóm chức năng con nào?" →
   tạo `docs/04-backlog/features/FEAT-xxx_<slug>.md` cho mỗi Feature, `parent_epic` +
   `parent_user_requirement` tương ứng.
4. Hỏi **User Story** (cho từng Feature): "Ai (persona từ UR) cần làm gì, để được lợi ích gì?
   Given/When/Then là gì?" → tạo `docs/04-backlog/user-stories/US-xxx_<slug>.md`.
5. Hỏi **Task** (cho từng User Story): "Cần làm những việc kỹ thuật cụ thể nào để hoàn thành
   story này?" → tạo `docs/04-backlog/tasks/TASK-xxx_<slug>.md`, điền "Context cho Agent"
   (trỏ tới FR + system overview liên quan) và "Definition of Done".
6. Cập nhật ngược: liệt kê Feature vào phần "Phạm vi" của Epic, US vào "User stories thuộc
   feature này" của Feature, Task vào "Tasks thuộc story này" của User Story.

### Phần 2 — Đưa vào Sprint (Bước F)

7. Hỏi user: đã có `SPRINT-xxx` đang `active` chưa? Nếu chưa, hỏi Sprint Goal +
   `start_date`/`end_date`, tạo từ `docs/04-backlog/sprints/SPRINT-template.md`.
8. Hỏi user muốn kéo User Story/Task nào (trong số đang `ready`, không `blocked`) vào sprint
   này — không tự ý kéo hết backlog vào, để user chọn theo năng lực team.
9. Với mỗi item được chọn: điền `sprint: SPRINT-xxx` trên US/Task đó, thêm vào bảng "User
   Stories / Tasks cam kết" trong file Sprint.
10. Nhắc user: cuối sprint quay lại điền Review/Retro trong `SPRINT-xxx` (xem `AGENTS.md`,
    Bước F).
