---
name: plan-backlog
description: >
  Dẫn dắt team phân rã BR/UR/FR đã approved thành Epic → Feature → User Story. Dùng skill
  này khi user nói "tạo backlog", "phân rã epic/feature/user story", "backlog hoạt động thế
  nào", hoặc sau khi docs/01-04 đã `status: approved` mà chưa có Epic nào trong
  docs/05-backlog.
---

# plan-backlog

Mục tiêu: biến BR/UR/FR đã approved thành backlog thật (Epic/Feature/User Story có ID,
`parent_*`, đúng template). User Story là đơn vị thực thi cuối cùng trong spec-kit này — không
có tầng Task kỹ thuật hay Sprint riêng (việc chia nhỏ hơn, lên lịch, release là việc của repo
triển khai, xem `AGENTS.md` mục "Làm việc đa repo").

**Tiêu chí phân rã từng cấp** — dùng để quyết định một ý tưởng nên là Epic, Feature, hay
User Story:

| Cấp | Trả lời câu hỏi | Quy mô điển hình | `parent_*` bắt buộc | Ai review |
|---|---|---|---|---|
| Epic | Mục tiêu kinh doanh lớn nào (từ 1 BR) đang được hiện thực hoá? 1 Epic ≈ 1 mảng giá trị lớn, ứng với 1 container triển khai (`source_container` + `repo`) | Nhiều Feature, thường ~5-20 Feature | `parent_business_requirement` | Product owner / tech lead |
| Feature | Epic này gồm những nhóm chức năng con nào? | Vài User Story | `parent_epic`, `parent_user_requirement` | Product owner |
| User Story | Persona cụ thể nào (từ UR) cần làm gì, để được lợi ích gì? Đủ nhỏ để 1 người triển khai xong trong 1 lần thay đổi mạch lạc, phải có Acceptance Criteria | Vài giờ đến vài ngày | `parent_feature`, `parent_functional_requirement` | Dev nhận User Story / tech lead |

Nếu 1 Epic vượt xa mức ~20 Feature, đó là dấu hiệu đang gộp nhiều mảng giá trị khác nhau vào 1
Epic — đề xuất user tách thành nhiều Epic nhỏ hơn, cùng trỏ `parent_business_requirement` về
cùng 1 BR, thay vì giữ 1 Epic khổng lồ.

**User Story đủ nhỏ để dễ test là thế nào?** Vì không còn tầng Task để tách tiếp, dùng 3 dấu
hiệu cụ thể để quyết định có cần tách User Story tiếp không:
1. 1 User Story = 1 hành vi cụ thể, triển khai được trong 1 lần thay đổi mạch lạc. Mô tả phải
   nối nhiều hành vi bằng "và"/"rồi" → tách thành nhiều User Story.
2. Phải viết được ít nhất 1 test case cụ thể (Input → Expected output) ngay lúc tạo User Story,
   điền thẳng vào bảng "Testing" của User Story — không hình dung được test case cụ thể nghĩa
   là User Story còn mơ hồ hoặc còn quá lớn, hỏi lại user hoặc tách tiếp trước khi tạo.
3. Definition of Done chỉ nên xoay quanh 1 nhóm tiêu chí liên quan — nhiều nhóm không liên
   quan tới nhau (vừa "thêm API" vừa "cập nhật UI" vừa "viết doc") là dấu hiệu đang gộp việc.

## Nguyên tắc khi chạy skill này

- **BR/UR/FR nguồn còn sơ sài/chưa đủ chi tiết để phân rã → brainstorm rồi hỏi lại, đừng hỏi
  lại kiểu "bạn nói rõ hơn được không?".** Dựa vào ngữ cảnh đã có (nội dung BR/UR/FR, C4
  container, glossary, các Epic/Feature/US đã tạo trong cùng phiên), chủ động đề xuất 2-4 khả
  năng cụ thể (ví dụ: "Epic này có thể chia thành nhóm chức năng A, B, C — đúng không, hay còn
  thiếu nhóm nào?", "US này có cần xử lý edge case X không?") rồi hỏi user xác nhận/chọn/sửa.
  Đây KHÔNG phải ngoại lệ cho việc "không tự suy đoán" ở các mục dưới — mọi khả năng brainstorm
  ra chỉ là câu hỏi gợi ý, CHỈ ghi vào Epic/Feature/US sau khi user xác nhận rõ ràng. Nếu sau
  khi brainstorm mà user vẫn chưa quyết được, dừng lại hỏi thẳng, không tự chọn 1 phương án rồi
  ghi vào tài liệu.
- Đi từ trên xuống: xác nhận Epic trước, rồi mới hỏi Feature bên trong Epic đó, rồi User
  Story bên trong Feature. Không nhảy cấp, không hỏi dồn tất cả cùng lúc.
- Mỗi cấp phải trỏ đúng `parent_*` theo bảng tiêu chí ở trên, và về đúng BR/UR/FR nguồn.
- Epic cần điền `source_container` (mã container, cột "Mã" trong
  `docs/04-system-overview/c4-container.md`) và `repo` (copy đúng giá trị ở cột "Repo triển
  khai" của container đó) — không tự đặt mã/tên repo mới ở bước này; để trống (`null`) cả hai
  nếu chỉ có 1 container/repo cho toàn hệ thống.
- Epic nằm phẳng trong `docs/05-backlog/epics/`. Feature/User Story nằm trong subfolder
  theo Epic sở hữu (tránh 1 thư mục phẳng chứa hàng nghìn file khi backlog lớn):
  `docs/05-backlog/{features,user-stories}/{EPIC-ID}_{slug-epic}/{PREFIX}-xxx_{slug}.md`,
  trong đó `{EPIC-ID}_{slug-epic}` trùng đúng tên file Epic sở hữu (bỏ đuôi `.md`). Tạo
  subfolder này khi tạo Feature đầu tiên của Epic đó.
- Mọi User Story **mới tạo qua skill này** bắt buộc có Acceptance Criteria dạng Given/When/Then,
  "Context cho Agent", "Definition of Done", và ít nhất 1 dòng trong bảng "Testing" — không tạo
  US thiếu các mục này, hỏi lại user nếu họ chỉ đưa ý tưởng chung chung. (US tạo trước khi
  `US-template.md` có các mục này có thể chưa đủ — không bắt buộc bổ sung ngược, chỉ áp dụng
  cho US mới.)
- User Story phải đủ nhỏ theo 3 dấu hiệu ở trên; nếu user mô tả một User Story không đạt, đề
  xuất tách thành nhiều User Story.
- Tất cả tạo mới ở `status: draft`. Không tự set `approved` — đó là quyết định của
  team khi review/khi việc thực sự xong.
- Nếu một item phụ thuộc vào điều chưa rõ, không tự đoán — tạo file mới từ
  `docs/06-meetings/open-questions/OQ-template.md` và set `status: blocked` kèm
  `blocked_by_open_questions` trên item đó.
- Nếu một Feature/US chỉ thực hiện được sau khi Feature/US khác xong (phụ thuộc thứ
  tự, không phải chờ quyết định) → ghi ID đó vào field `depends_on` của item, KHÔNG dùng
  `status: blocked`/`blocked_by_open_questions` cho trường hợp này. Không bắt đầu thực hiện
  một item khi `depends_on` còn ID chưa `status: approved`.

## Quy trình

1. Xác nhận `docs/01-business-requirement`, `docs/02-user-requirement`,
   `docs/03-functional-requirement` liên quan đã `status: approved`. Nếu chưa, dừng lại và
   nhắc user hoàn thiện BR/UR/FR trước.
2. Hỏi **Epic**: "Mục tiêu kinh doanh lớn nào từ BR-xxx đang cần hiện thực hoá?" → đối chiếu
   mục tiêu đó với cột "Trách nhiệm" trong `docs/04-system-overview/c4-container.md` để tìm
   container khớp, rồi lấy đúng "Mã" của container đó cho `source_container` và giá trị ở cột
   "Repo triển khai" cho `repo`. Nếu mục tiêu khớp trách nhiệm của nhiều container, tách thành
   nhiều Epic (mỗi Epic 1 `source_container`) thay vì gán nhiều container cho 1 Epic. Nếu không
   container nào khớp, hoặc bảng container chưa có mã/chưa đủ rõ để quyết định — đây không
   phải việc để tự suy đoán ở bước này: dừng lại, hỏi trực tiếp user muốn đặt mã/tên container
   nào (hoặc nhờ user/team bổ sung `docs/04-system-overview/c4-container.md` trước) rồi mới
   tiếp tục tạo `docs/05-backlog/epics/EPIC-xxx_<slug>.md`.
3. Hỏi **Feature** (cho từng Epic vừa tạo): "Epic này gồm những nhóm chức năng con nào?" —
   nếu user chỉ trả lời chung chung, brainstorm 2-4 nhóm chức năng cụ thể dựa trên Mục tiêu của
   Epic + UR/FR nguồn rồi hỏi lại (xem nguyên tắc ở trên) → tạo
   `docs/05-backlog/features/{EPIC-ID}_{slug-epic}/FEAT-xxx_<slug>.md` cho mỗi Feature
   (subfolder trùng tên file Epic sở hữu), `parent_epic` + `parent_user_requirement` tương ứng.
   Nếu số Feature sắp vượt ~20, dừng lại nhắc user cân nhắc tách Epic (xem tiêu chí phân rã ở
   trên) trước khi tạo thêm.
4. Hỏi **User Story** (cho từng Feature): "Ai (persona từ UR) cần làm gì, để được lợi ích gì?
   Given/When/Then là gì?" — nếu user chỉ trả lời chung chung, brainstorm hành vi/edge case cụ
   thể dựa trên FR nguồn + Feature cha rồi hỏi lại → tạo
   `docs/05-backlog/user-stories/{EPIC-ID}_{slug-epic}/US-xxx_<slug>.md` (cùng Epic với Feature
   cha), điền "Context cho Agent" (trỏ tới FR + system overview liên quan) và "Definition of
   Done". Hỏi tiếp: "Test case nào xác nhận User Story này xong?" → điền ít nhất 1 dòng vào
   bảng "Testing" (Input → Expected output) ngay lúc tạo — nếu không trả lời được cụ thể, coi
   đây là dấu hiệu User Story chưa đủ rõ/nhỏ (xem tiêu chí "User Story đủ nhỏ" ở trên), hỏi lại
   hoặc tách tiếp trước khi tạo file.
5. Với mỗi Feature/User Story vừa tạo, hỏi user: "Có phụ thuộc item nào khác cần xong
   trước không?" → nếu có, điền ID vào `depends_on`.
6. Cập nhật ngược: liệt kê Feature vào phần "Phạm vi" của Epic, US vào "User stories thuộc
   feature này" của Feature.
