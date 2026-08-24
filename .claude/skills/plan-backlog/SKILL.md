---
name: plan-backlog
description: >
  Dẫn dắt team phân rã BR/UR/FR đã approved thành Epic → Feature → User Story. Dùng skill
  này khi user nói "tạo backlog", "phân rã epic/feature/user story", "backlog hoạt động thế
  nào", hoặc sau khi docs/01-03 đã `status: approved` và `docs/04-system-overview/
  c4-container.md` đã có mà chưa có Epic nào trong docs/05-backlog.
---

# plan-backlog

Mục tiêu: biến BR/UR/FR đã approved thành backlog thật (Epic/Feature/User Story có ID,
`parent_*`, đúng template). User Story là đơn vị thực thi cuối cùng trong spec-kit này — skill
này chỉ dẫn dắt việc phân rã tới User Story, không nói về việc chia nhỏ hơn nữa.

**Tiêu chí phân rã từng cấp** — dùng để quyết định một ý tưởng nên là Epic, Feature, hay
User Story:

| Cấp | Trả lời câu hỏi | Quy mô điển hình | `parent_*` bắt buộc | Ai review |
|---|---|---|---|---|
| Epic | Mục tiêu kinh doanh lớn nào (từ 1 BR) đang được hiện thực hoá? 1 Epic ≈ 1 mảng giá trị lớn, ứng với 1 container triển khai (`source_container`) | Nhiều Feature, thường ~5-20 Feature | `docs_requirements` (BR liên quan) | Product owner / tech lead |
| Feature | Epic này gồm những nhóm chức năng con nào? | Vài User Story | `parent_epic`, `docs_requirements` (UR liên quan) | Product owner |
| User Story | Persona cụ thể nào (từ UR) cần làm gì, để được lợi ích gì? Đủ nhỏ để 1 người triển khai xong trong 1 lần thay đổi mạch lạc, phải có Acceptance Criteria | Vài giờ đến vài ngày | `parent_feature`, `docs_requirements` (FR liên quan) | Dev nhận User Story / tech lead |

Nếu 1 Epic vượt xa mức ~20 Feature, đó là dấu hiệu đang gộp nhiều mảng giá trị khác nhau vào 1
Epic — đề xuất user tách thành nhiều Epic nhỏ hơn, cùng trỏ `docs_requirements` về cùng 1 BR,
thay vì giữ 1 Epic khổng lồ.

**User Story đủ nhỏ/đủ rõ là thế nào?** đảm bảo Acceptance
Criteria đủ rõ, đủ trường hợp để sau này phân task và định nghĩa test dễ dàng. Dùng 2 dấu hiệu
sau để quyết định có cần tách User Story tiếp không:
1. 1 User Story = 1 hành vi cụ thể, triển khai được trong 1 lần thay đổi mạch lạc. Mô tả phải
   nối nhiều hành vi bằng "và"/"rồi" → tách thành nhiều User Story.
2. Phải hình dung được cụ thể input/output hoặc kết quả mong đợi cho từng Acceptance Criteria
   ngay lúc tạo — không hình dung được nghĩa là User Story còn mơ hồ hoặc còn quá lớn, hỏi lại
   user hoặc tách tiếp trước khi tạo. Liệt kê cả edge case/trường hợp lỗi quan trọng, không chỉ
   happy path.

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
  `docs/04-system-overview/c4-container.md`) — không tự đặt mã container mới ở bước này; để
  trống (`null`) nếu chỉ có 1 container cho toàn hệ thống.
- Epic nằm phẳng trong `docs/05-backlog/epics/`. Feature/User Story nằm trong subfolder
  theo Epic sở hữu (tránh 1 thư mục phẳng chứa hàng nghìn file khi backlog lớn):
  `docs/05-backlog/{features,user-stories}/{EPIC-ID}_{slug-epic}/{PREFIX}-xxx_{slug}.md`,
  trong đó `{EPIC-ID}_{slug-epic}` trùng đúng tên file Epic sở hữu (bỏ đuôi `.md`). Tạo
  subfolder này khi tạo Feature đầu tiên của Epic đó.
- Mọi User Story **mới tạo qua skill này** bắt buộc có Acceptance Criteria dạng Given/When/Then
  (đủ rõ, bao phủ edge case quan trọng) và "Context cho Agent" — không tạo US thiếu các mục
  này, hỏi lại user nếu họ chỉ đưa ý tưởng chung chung. (US tạo trước khi `US-template.md` có
  các mục này có thể chưa đủ — không bắt buộc bổ sung ngược, chỉ áp dụng cho US mới.)
- **"AC phải phủ edge case" (trên) và "không tự bịa nội dung" (nguyên tắc chung của kit) có thể
  đụng nhau** trên cùng 1 dòng AC — ví dụ hành vi lỗi cụ thể, ngưỡng số, thứ tự ưu tiên khi xung
  đột mà user chưa xác nhận chi tiết. Khi gặp trường hợp này, KHÔNG tự chọn ngầm giữa 3 lối tắt
  (bịa chi tiết cụ thể / bỏ trống dòng AC / chỉ ghi vào "Ghi chú kỹ thuật" mà không tạo OQ):
  brainstorm 1 đề xuất cụ thể (xem nguyên tắc brainstorm-rồi-hỏi ở trên), viết vào dòng AC kèm
  nhãn `[Agent đề xuất — cần PO xác nhận]`, và nếu edge case này đủ quan trọng để không thể bắt
  đầu Bước C mà chưa rõ → tạo `OQ-*` + set `blocked_by_open_questions` trên US đó (theo
  AGENTS.md nguyên tắc chung #4), không chỉ ghi chú suông rồi bỏ qua.
- User Story phải đủ nhỏ theo 2 dấu hiệu ở trên; nếu user mô tả một User Story không đạt, đề
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
- Khi viết nội dung Epic/Feature/US, thuật ngữ đã có trong `docs/00-glossary/glossary.md` → gắn
  link Markdown tới đúng mục ở lần xuất hiện đầu tiên trong tài liệu (xem `RULES.md` mục 2).

## Quy trình

1. Xác nhận `docs/01-business-requirement`, `docs/02-user-requirement`,
   `docs/03-functional-requirement` liên quan đã `status: approved`, và
   `docs/04-system-overview/c4-container.md` đã tồn tại (không bắt buộc `status: approved`,
   nhưng phải có bảng "Danh sách container" để tra `source_container` ở bước 2). Nếu thiếu điều
   nào, dừng lại và nhắc user hoàn thiện trước.
2. Hỏi **Epic**: "Mục tiêu kinh doanh lớn nào từ BR-xxx đang cần hiện thực hoá?" (điền
   `docs_requirements: [BR-xxx, ...]` — có thể nhiều BR nếu Epic hiện thực hoá mục tiêu chung
   của nhiều BR) → đối chiếu mục tiêu đó với cột "Trách nhiệm" trong
   `docs/04-system-overview/c4-container.md` để tìm container khớp, rồi lấy đúng "Mã" của
   container đó cho `source_container`. Nếu mục tiêu khớp trách nhiệm của nhiều container, tách
   thành nhiều Epic (mỗi Epic 1 `source_container`) thay vì gán nhiều container cho 1 Epic. Nếu
   không container nào khớp, hoặc bảng container chưa có mã/chưa đủ rõ để quyết định — đây
   không phải việc để tự suy đoán ở bước này: dừng lại, hỏi trực tiếp user muốn đặt mã/tên
   container nào (hoặc nhờ user/team bổ sung `docs/04-system-overview/c4-container.md` trước)
   rồi mới tiếp tục tạo `docs/05-backlog/epics/EPIC-xxx_<slug>.md`.
3. Hỏi **Feature** (cho từng Epic vừa tạo): "Epic này gồm những nhóm chức năng con nào?" —
   nếu user chỉ trả lời chung chung, brainstorm 2-4 nhóm chức năng cụ thể dựa trên Mục tiêu của
   Epic + UR/FR nguồn rồi hỏi lại (xem nguyên tắc ở trên) → tạo
   `docs/05-backlog/features/{EPIC-ID}_{slug-epic}/FEAT-xxx_<slug>.md` cho mỗi Feature
   (subfolder trùng tên file Epic sở hữu), `parent_epic` + `docs_requirements` (UR liên quan)
   tương ứng.
   Nếu số Feature sắp vượt ~20, dừng lại nhắc user cân nhắc tách Epic (xem tiêu chí phân rã ở
   trên) trước khi tạo thêm.
4. Hỏi **User Story** (cho từng Feature): "Ai (persona từ UR) cần làm gì, để được lợi ích gì?
   Given/When/Then là gì?" — nếu user chỉ trả lời chung chung, brainstorm hành vi/edge case cụ
   thể dựa trên FR nguồn + Feature cha rồi hỏi lại → tạo
   `docs/05-backlog/user-stories/{EPIC-ID}_{slug-epic}/US-xxx_<slug>.md` (cùng Epic với Feature
   cha), điền `docs_requirements: [FR-xxx, ...]` và "Context cho Agent" (trỏ tới FR + system
   overview liên quan). Hỏi tiếp: "Còn edge
   case/trường hợp lỗi nào cần thêm vào Acceptance Criteria không?" → bổ sung ngay vào phần
   Acceptance Criteria — nếu không trả lời được cụ thể, coi đây là dấu hiệu User Story chưa đủ
   rõ/nhỏ (xem tiêu chí "User Story đủ nhỏ/đủ rõ" ở trên), hỏi lại hoặc tách tiếp trước khi tạo
   file.
5. Với mỗi Feature/User Story vừa tạo, hỏi user: "Có phụ thuộc item nào khác cần xong
   trước không?" → nếu có, điền ID vào `depends_on`.
6. Cập nhật ngược: liệt kê Feature vào phần "Phạm vi" của Epic, US vào "User stories thuộc
   feature này" của Feature. **Trước khi coi bước này xong**: kiểm lại **cả 3 cấp — Epic (bước
   2), Feature (bước 3), US (bước 4) — không chỉ 2 cấp vừa cập nhật ngược ở trên** — đã gắn link
   glossary ở lần xuất hiện đầu tiên của mỗi thuật ngữ đã có trong glossary chưa (xem
   nguyên tắc ở trên, `RULES.md` mục 2) — quy tắc này tồn tại từ đầu nhưng hay bị bỏ quên trong
   lúc tập trung viết nội dung, kiểm lại rõ ràng ở đây thay vì chỉ tin đã làm đúng lúc viết.
7. **Trước khi kết thúc phiên**, quét lại toàn bộ Acceptance Criteria/business rule vừa viết
   trong phiên (không chỉ chi tiết user đã hỏi tường minh) — tìm mọi chi tiết cụ thể mà user
   chưa xác nhận trực tiếp, cả **định lượng** (số/ngưỡng, thứ tự ưu tiên khi xung đột) lẫn
   **định tính** (hành vi lỗi cụ thể, business rule diễn đạt chắc chắn dù chỉ là suy đoán — không
   chỉ quét chi tiết có số). Với mỗi chi tiết như vậy, áp dụng đúng quy tắc "AC phải phủ edge
   case đụng không tự bịa nội dung" ở trên (nhãn `[Agent đề xuất — cần PO xác nhận]` + tạo OQ nếu
   đủ quan trọng) — không chỉ áp dụng cho chi tiết đã được hỏi tường minh trong hội thoại rồi bỏ
   qua các chi tiết tương tự khác.
   **Phạm vi quét bao gồm cả tầng C4** mà backlog vừa tham chiếu tới (`c4-container.md`,
   `c4-component-*.md`, `container-interface-contracts.md`, `schema-interface-contracts.md` nếu
   tồn tại, trong `source_container`/`Context cho Agent` của Epic/US vừa tạo) — xác minh bước
   "liệt kê Component rồi chờ user xác nhận" của `c4-model` thực sự đã xảy ra (có phản hồi thật
   của user trong mục "Xác nhận với user" của file Component/Container, không chỉ khẳng định
   suông), và mọi mã CIC được US tham
   chiếu đều có mặt trong bảng tổng hợp CIC; nếu phát hiện component/CIC nào chưa từng được xác
   nhận, xử lý như 1 chi tiết chưa xác nhận ở trên, không im lặng dùng tiếp.
   Đây là giới hạn cố hữu, không phải checklist làm 1 lần là triệt để: cùng 1 lượt suy luận vừa
   viết vừa tự rà dễ chỉ nhớ lại đúng những chỗ nó tự thấy "cần chú ý" lúc viết, bỏ sót chi tiết
   nó không nhớ là đã tự thêm vào. Nếu khả thi, chạy bước này như 1 lượt riêng, đọc lại toàn bộ
   tài liệu như người ngoài chưa biết trước phiên viết đã cài gì, thay vì xen kẽ ngay trong lúc
   viết.
