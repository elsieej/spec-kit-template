---
name: plan-backlog
description: >
  Dẫn dắt team phân rã BR/UR/FR đã approved thành Epic → Feature → User Story → Task, rồi
  kéo các item đang ready vào một Sprint cụ thể. Dùng skill này khi user nói "tạo backlog",
  "phân rã epic/feature/user story/task", "lên sprint", "kéo task vào sprint", "backlog hoạt
  động thế nào", hoặc sau khi docs/00-03 đã `status: approved` mà chưa có Epic nào trong
  docs/04-backlog.
---

# plan-backlog

Mục tiêu: biến BR/UR/FR đã approved thành backlog thật (Epic/Feature/User Story/Task có ID,
`parent_*`, đúng template), sau đó kéo phần đã `ready` vào một Sprint cụ thể.

**Tiêu chí phân rã từng cấp** — dùng để quyết định một ý tưởng nên là Epic, Feature, User
Story hay Task:

| Cấp | Trả lời câu hỏi | Quy mô điển hình | `parent_*` bắt buộc | Ai review |
|---|---|---|---|---|
| Epic | Mục tiêu kinh doanh lớn nào (từ 1 BR) đang được hiện thực hoá? 1 Epic ≈ 1 mảng giá trị lớn, ứng với 1 container triển khai (`source_container` + `repo`) | Kéo dài nhiều sprint, thường ~5-20 Feature | `parent_business_requirement` | Product owner / tech lead |
| Feature | Epic này gồm những nhóm chức năng con nào? | Vài sprint | `parent_epic`, `parent_user_requirement` | Product owner |
| User Story | Persona cụ thể nào (từ UR) cần làm gì, để được lợi ích gì? Đủ nhỏ để xong trong 1 sprint, phải có Acceptance Criteria | Trong 1 sprint | `parent_feature`, `parent_functional_requirement` | Cả team lúc sprint planning |
| Task | Việc kỹ thuật cụ thể nào để hoàn thành User Story đó? Đủ nhỏ để 1 dev làm xong trong vài giờ–1-2 ngày | Giờ tới 1-2 ngày | `parent_user_story` | Dev nhận Task |

Nếu 1 Epic vượt xa mức ~20 Feature, đó là dấu hiệu đang gộp nhiều mảng giá trị khác nhau vào 1
Epic — đề xuất user tách thành nhiều Epic nhỏ hơn, cùng trỏ `parent_business_requirement` về
cùng 1 BR, thay vì giữ 1 Epic khổng lồ.

## Nguyên tắc khi chạy skill này

- Đi từ trên xuống: xác nhận Epic trước, rồi mới hỏi Feature bên trong Epic đó, rồi User
  Story bên trong Feature, rồi Task bên trong User Story. Không nhảy cấp, không hỏi dồn tất
  cả cùng lúc.
- Mỗi cấp phải trỏ đúng `parent_*` theo bảng tiêu chí ở trên, và về đúng BR/UR/FR nguồn.
- Epic cần điền `source_container` (mã container, cột "Mã" trong
  `docs/03-system-overview/c4-container.md`) và `repo` (copy đúng giá trị ở cột "Repo triển
  khai" của container đó) — không tự đặt mã/tên repo mới ở bước này; để trống (`null`) cả hai
  nếu chỉ có 1 container/repo cho toàn hệ thống.
- Epic nằm phẳng trong `docs/04-backlog/epics/`. Feature/User Story/Task nằm trong subfolder
  theo Epic sở hữu (tránh 1 thư mục phẳng chứa hàng nghìn file khi backlog lớn):
  `docs/04-backlog/{features,user-stories,tasks}/{EPIC-ID}_{slug-epic}/{PREFIX}-xxx_{slug}.md`,
  trong đó `{EPIC-ID}_{slug-epic}` trùng đúng tên file Epic sở hữu (bỏ đuôi `.md`). Tạo
  subfolder này khi tạo Feature đầu tiên của Epic đó.
- User Story bắt buộc có Acceptance Criteria dạng Given/When/Then — không tạo US thiếu mục
  này, hỏi lại user nếu họ chỉ đưa ý tưởng chung chung.
- Task phải đủ nhỏ (vài giờ đến 1–2 ngày); nếu user mô tả một Task lớn hơn mức đó, đề xuất
  tách thành nhiều Task hoặc nâng thành User Story riêng.
- Tất cả tạo mới ở `status: draft`. Không tự set `ready`/`approved` — đó là quyết định của
  team khi review.
- Nếu một item phụ thuộc vào điều chưa rõ, không tự đoán — tạo file mới từ
  `docs/05-meetings/open-questions/OQ-template.md` và set `status: blocked` kèm
  `blocked_by_open_questions` trên item đó.
- Nếu một Feature/US/Task chỉ thực hiện được sau khi Feature/US/Task khác xong (phụ thuộc thứ
  tự, không phải chờ quyết định) → ghi ID đó vào field `depends_on` của item, KHÔNG dùng
  `status: blocked`/`blocked_by_open_questions` cho trường hợp này. Không set `status: ready`
  khi `depends_on` còn ID chưa `status: done`.

## Quy trình

### Phần 1 — Phân rã backlog

1. Xác nhận `docs/00-business-requirement`, `docs/01-user-requirement`,
   `docs/02-functional-requirement` liên quan đã `status: approved`. Nếu chưa, dừng lại và
   nhắc user hoàn thiện BR/UR/FR trước.
2. Hỏi **Epic**: "Mục tiêu kinh doanh lớn nào từ BR-xxx đang cần hiện thực hoá?" → đối chiếu
   mục tiêu đó với cột "Trách nhiệm" trong `docs/03-system-overview/c4-container.md` để tìm
   container khớp, rồi lấy đúng "Mã" của container đó cho `source_container` và giá trị ở cột
   "Repo triển khai" cho `repo`. Nếu mục tiêu khớp trách nhiệm của nhiều container, tách thành
   nhiều Epic (mỗi Epic 1 `source_container`) thay vì gán nhiều container cho 1 Epic. Nếu không
   container nào khớp, hoặc bảng container chưa có mã/chưa đủ rõ để quyết định — đây không
   phải việc để tự suy đoán ở bước này: dừng lại, hỏi trực tiếp user muốn đặt mã/tên container
   nào (hoặc nhờ user/team bổ sung `docs/03-system-overview/c4-container.md` trước) rồi mới
   tiếp tục tạo `docs/04-backlog/epics/EPIC-xxx_<slug>.md`.
3. Hỏi **Feature** (cho từng Epic vừa tạo): "Epic này gồm những nhóm chức năng con nào?" →
   tạo `docs/04-backlog/features/{EPIC-ID}_{slug-epic}/FEAT-xxx_<slug>.md` cho mỗi Feature
   (subfolder trùng tên file Epic sở hữu), `parent_epic` + `parent_user_requirement` tương ứng.
   Nếu số Feature sắp vượt ~20, dừng lại nhắc user cân nhắc tách Epic (xem tiêu chí phân rã ở
   trên) trước khi tạo thêm.
4. Hỏi **User Story** (cho từng Feature): "Ai (persona từ UR) cần làm gì, để được lợi ích gì?
   Given/When/Then là gì?" → tạo
   `docs/04-backlog/user-stories/{EPIC-ID}_{slug-epic}/US-xxx_<slug>.md` (cùng Epic với Feature
   cha).
5. Hỏi **Task** (cho từng User Story): "Cần làm những việc kỹ thuật cụ thể nào để hoàn thành
   story này?" → tạo `docs/04-backlog/tasks/{EPIC-ID}_{slug-epic}/TASK-xxx_<slug>.md` (cùng
   Epic với User Story cha), điền "Context cho Agent" (trỏ tới FR + system overview liên quan)
   và "Definition of Done".
6. Với mỗi Feature/User Story/Task vừa tạo, hỏi user: "Có phụ thuộc item nào khác cần xong
   trước không?" → nếu có, điền ID vào `depends_on`.
7. Cập nhật ngược: liệt kê Feature vào phần "Phạm vi" của Epic, US vào "User stories thuộc
   feature này" của Feature, Task vào "Tasks thuộc story này" của User Story.

### Phần 2 — Đưa vào Sprint

8. Hỏi user: đã có `SPRINT-xxx` đang `active` chưa (chỉ được có tối đa 1 sprint active tại một
   thời điểm)? Nếu chưa, hỏi Sprint Goal + `start_date`/`end_date`, tạo từ
   `docs/04-backlog/sprints/SPRINT-template.md`.
9. Hỏi user muốn kéo User Story/Task nào (trong số đang `ready`, không `blocked`) vào sprint
   này — không tự ý kéo hết backlog vào, để user chọn theo năng lực team. Với mỗi item, kiểm
   tra `depends_on`: nếu còn ID chưa `status: done`, cảnh báo rõ cho user trước khi kéo vào
   (không tự ý loại ra — để team quyết định có chấp nhận rủi ro hay không).
10. Với mỗi item được chọn: điền `sprint: SPRINT-xxx` trên US/Task đó, thêm vào bảng "User
    Stories / Tasks cam kết" trong file Sprint.
11. Nhắc user: cuối sprint quay lại điền mục "Review" và "Retro" trong `SPRINT-xxx`, set
    `status: done`, dời việc chưa xong sang sprint kế tiếp hoặc huỷ (ghi rõ lý do).
