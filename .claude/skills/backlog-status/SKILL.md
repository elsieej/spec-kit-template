---
name: backlog-status
description: >
  Trả lời "backlog đang có gì", "Feature nào thuộc Epic nào", "cây Epic/Feature/User Story",
  "EPIC-xxx có gì bên trong", "tình trạng dự án hiện tại đang thế nào" bằng cách đọc trực tiếp
  frontmatter của các file trong docs/05-backlog — không có file trạng thái/dashboard/index
  riêng nào được duy trì thủ công, mọi câu trả lời tính lại từ frontmatter mỗi lần hỏi để
  tránh dữ liệu cũ/sai lệch. Dùng skill này khi user hỏi về nội dung backlog, hoặc quan hệ
  cha-con giữa các cấp backlog.
---

# backlog-status

Skill chỉ đọc (read-only) — không sửa file nào. Mục tiêu: tổng hợp nhanh trạng thái backlog +
quan hệ cha-con giữa các cấp, từ frontmatter, vì kit này không duy trì file
dashboard/index riêng (tránh trùng lặp nội dung đã có trong frontmatter, tránh dữ liệu cũ do
quên cập nhật). Mục "Phạm vi"/"User stories thuộc feature này" trong
từng file Epic/Feature là bản tóm tắt cho người đọc, có thể bị quên cập nhật khi tạo item
mới thủ công (không qua skill `plan-backlog`) — skill này KHÔNG dựa vào các mục đó, chỉ dựa
vào field `parent_*` (`parent_epic`, `parent_feature` — quan hệ cha-con trong backlog) và
`docs_requirements` (liên kết tới BR/UR/FR), nguồn duy nhất, luôn đúng vì mỗi file backlog bắt
buộc có các field này.

Epic nằm phẳng trong `docs/05-backlog/epics/`; Feature/User Story nằm trong subfolder
theo Epic sở hữu (`docs/05-backlog/{features,user-stories}/{EPIC-ID}_{slug}/...`) — khi
quét các thư mục này, đọc đệ quy qua mọi subfolder (không chỉ cấp ngay bên dưới), vẫn loại trừ
mọi `*-template.md`. Subfolder chỉ là tổ chức vật lý, không thay đổi cách xác định quan hệ
cha-con (vẫn dựa vào `parent_*`, không suy ra Epic sở hữu từ tên subfolder).

## Quy trình

1. **Backlog hiện có**: đọc frontmatter mọi file trong
   `docs/05-backlog/{epics,features,user-stories}/` (đệ quy qua subfolder theo Epic, trừ
   các `*-template.md`). "Backlog" là mọi item `status: draft` và không `blocked` (chưa
   `approved` nghĩa là chưa xong). Nhóm theo loại (Epic/Feature/US) rồi theo `status`:
   - `blocked` → liệt kê riêng, kèm `blocked_by_open_questions` để user biết đang chờ OQ nào.
   - `draft` → liệt kê theo nhóm (đây là phần có thể bắt đầu thực hiện), sắp xếp theo field
     `priority` trên Feature/US (`P0` trước, `P3` sau cùng, `null` xếp cuối) — đúng thứ tự xử
     lý backlog theo `AGENTS.md` mục "Backlog". Epic không có `priority`, giữ nguyên nhóm.
   - Với mỗi item còn ID trong `depends_on` mà ID đó chưa `status: approved` → đánh dấu riêng
     "chưa thể bắt đầu (chờ <ID> xong)" cạnh item đó, dù `status` hiện tại là `draft`.
   - Không liệt kê item đã `status: approved`/`deprecated` — không còn tính là backlog đang mở.
   - `blocked` không cascade từ con lên cha (xem AGENTS.md nguyên tắc chung #4): 1 Feature/Epic
     `draft` có toàn bộ US/Feature con đang `blocked` vẫn liệt kê ở nhóm `draft` như bình thường
     (không tự chuyển nhóm `blocked`) — nhưng ghi kèm 1 ghi chú riêng "toàn bộ con đang blocked,
     chưa có việc nào làm được ngay" để user không hiểu nhầm là còn việc thực hiện được.

2. **Cây phân cấp Epic → Feature → User Story**: đọc frontmatter mọi file trong
   `docs/05-backlog/{epics,features,user-stories}/` (đệ quy qua subfolder theo Epic, trừ
   `*-template.md`), dựng cây từ
   `parent_epic` (Feature), `parent_feature` (User Story). Đọc thêm frontmatter (chỉ để lấy
   `id`) của `docs/01-business-requirement/`, `docs/02-user-requirement/`,
   `docs/03-functional-requirement/` (trừ `template.md`) để verify các field `parent_*` trỏ
   sang tầng 01-03 dưới đây có tồn tại thật:
   - Với 1 Epic cụ thể được hỏi tới, hoặc toàn bộ backlog nếu user không chỉ định: in cây thụt
     lề theo cấp, mỗi node kèm ID + tên + `status` (ví dụ
     `EPIC-001 (draft) — Quản lý Task cá nhân` → thụt lề `FEAT-001 (draft) — CRUD Task` →
     thụt lề tiếp `US-001 (approved) — ...`).
   - **Phát hiện liên kết gãy**: nếu 1 file có `parent_*`/`docs_requirements` trỏ tới ID không
     tồn tại (đã bị xoá/đổi tên/gõ sai) — bao gồm `parent_epic`/`parent_feature` (trong
     `docs/05-backlog`) lẫn `docs_requirements` trên Epic/Feature/US (**mảng**, bắt buộc ≥1 ID
     — kiểm tra từng ID trong mảng theo đúng prefix: `BR-*` tra trong
     `docs/01-business-requirement/`, `UR-*` tra trong `docs/02-user-requirement/`, `FR-*` tra
     trong `docs/03-functional-requirement/`) — liệt kê riêng phần "Liên kết gãy" — không bỏ
     qua âm thầm.
   - **Phát hiện item mồ côi ở đúng cấp của nó**: item không match được vào cây (parent không
     tồn tại, dù ở tầng 05-backlog hay trỏ ngược lên 01-03) → liệt kê ở "Liên kết gãy" cùng mục
     trên, không tự đoán nên gắn vào đâu.
   - Nếu node có `depends_on` khác rỗng, ghi kèm ngay sau status, ví dụ
     `US-007 (draft, chờ US-004) — ...` khi US-004 chưa `approved`.

3. Trình bày kết quả dạng bảng/cây/gạch đầu dòng ngắn gọn, không diễn giải dài dòng. Nếu user
   chỉ hỏi 1 trong 2 phần (backlog hoặc cây phân cấp), chỉ trả lời phần đó.
