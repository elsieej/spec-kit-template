# RULES.md — Quy tắc dự án

Tập hợp các nhóm quy tắc áp dụng khi làm việc với Spec Kit này (agent hoặc người đóng góp).
Mỗi nhóm là một phần độc lập bên dưới — không phải tất cả đều về văn phong. Dùng cùng với
`CLAUDE.md` (quy trình pipeline + naming convention) và `AGENTS.md` (hành vi agent theo
từng bước); những file đó là nguồn chi tiết, RULES.md không lặp lại nội dung của chúng.

## Danh mục

1. [Ngôn ngữ & giọng văn](#1-ngôn-ngữ--giọng-văn)
2. [Thuật ngữ](#2-thuật-ngữ)
3. [Traceability & trạng thái tài liệu](#3-traceability--trạng-thái-tài-liệu)
4. [Bảo mật & thông tin nhạy cảm](#4-bảo-mật--thông-tin-nhạy-cảm)
5. [Git & commit](#5-git--commit)

---

## 1. Ngôn ngữ & giọng văn

**Đối tượng đọc:** mặc định là **developer/kỹ sư phần mềm** (kể cả tài liệu tầng nghiệp vụ
như BR/UR, vì agent và dev đọc cùng một bộ tài liệu để lấy context). Viết cho người đã quen
thao tác kỹ thuật, không cần giải thích lại khái niệm phổ thông trong ngành.

1. **Ngắn gọn, đi thẳng vào vấn đề.** Không rào đón, không lặp lại yêu cầu, không câu văn
   hoa mỹ/marketing trong tài liệu kỹ thuật.
2. **Ưu tiên thuật ngữ chuyên ngành** khi nói về vấn đề kỹ thuật, thay vì dịch gượng ép sang
   tiếng Việt (chi tiết ở mục 2 — Thuật ngữ).
3. **Nhất quán thuật ngữ xuyên suốt.** Một khái niệm chỉ dùng một cách gọi trong toàn bộ dự
   án — không đổi qua lại giữa các cách dịch/viết khác nhau cho cùng một thứ.
4. **Khách quan, trung lập.** Mô tả sự việc/yêu cầu/kết quả, không đánh giá chủ quan
   ("rất tốt", "cực kỳ quan trọng") trừ khi đó là nhận định có căn cứ (metric, test result).
5. **Câu mệnh lệnh rõ ràng** trong checklist, Definition of Done, test case: dùng động từ
   hành động ở đầu câu (Thêm / Sửa / Xoá / Kiểm tra / Cập nhật...), tránh câu bị động dài dòng.

Áp dụng theo loại nội dung:
- **Tài liệu 01–04 (BR/UR/FR/System Overview):** văn phong nghiệp vụ nhưng vẫn ưu tiên thuật
  ngữ kỹ thuật chuẩn khi mô tả giải pháp/hệ thống; tránh diễn giải mơ hồ.
- **Backlog (Epic/Feature/User Story):** ngắn, cụ thể, có thể thực thi được — đặc biệt phần
  "Context cho Agent" và "Acceptance Criteria" trong User Story phải đủ chi tiết (bao phủ cả
  edge case) để agent code không cần đoán thêm, và để dễ phân task/định nghĩa test case sau
  này.
- **Giao tiếp với người dùng (chat, PR description):** vẫn ngắn gọn, kỹ thuật, nhưng có thể
  thêm ngữ cảnh/giải thích quyết định nếu người đọc không phải lúc nào cũng theo sát toàn bộ
  tài liệu.

## 2. Thuật ngữ

`docs/00-glossary/glossary.md` gồm hai phần: **Thuật ngữ nghiệp vụ** (định nghĩa
business/domain riêng của dự án) và **Thuật ngữ kỹ thuật / văn phong** (quy định thuật ngữ
kỹ thuật nào giữ nguyên tiếng Anh, thuật ngữ nào dịch).

- Trước khi viết một thuật ngữ kỹ thuật hoặc thuật ngữ riêng của dự án vào tài liệu, **tra
  glossary trước** (đúng phần tương ứng).
- Nếu thuật ngữ đã có → dùng đúng hình thức đã quy định ở đó, không tự sáng tạo cách viết khác.
- Nếu thuật ngữ chưa có → thêm một dòng mới vào nhóm phù hợp trong glossary (kèm định nghĩa
  hoặc cách dùng + ví dụ) **trước khi** dùng thuật ngữ đó trong tài liệu đang viết.
- Không tự ý dịch các thuật ngữ đã chuẩn hoá trong ngành (commit, pull request, sprint,
  backlog, endpoint, container...) trừ khi glossary quy định khác.
- **Không viết tắt tự chế.** Chỉ dùng viết tắt đã chuẩn hoá trong glossary hoặc phổ biến
  trong ngành (PR, CI/CD, API...); viết tắt lần đầu xuất hiện nên kèm dạng đầy đủ.
- **Link tham chiếu tới glossary khi trích xuất thuật ngữ.** Ở lần xuất hiện đầu tiên của một
  thuật ngữ trong tài liệu, nếu thuật ngữ đó đã có trong `docs/00-glossary/glossary.md` →
  gắn link Markdown tới đúng mục (heading) chứa thuật ngữ đó — **chỉ tính lần xuất hiện trong
  thân bài (nội dung dưới heading); thuật ngữ chỉ xuất hiện trong chính tiêu đề/heading (H1/H2)
  của tài liệu không bắt buộc gắn link ở đó**, gắn ở lần xuất hiện đầu tiên trong thân bài ngay
  sau đó. Số cấp `../` tuỳ độ sâu thư mục của file đang viết so với `docs/`, không cố định 1
  con số:
  - File nằm ngay trong `docs/{00-04}-.../` (BR/UR/FR, C4 Context/Container/Component,
    Container/Entity Interface) — 1 cấp: ví dụ từ `docs/01-business-requirement/BR-001.md`:
    `[sprint](../00-glossary/glossary.md#quy-trình--agile)`. Riêng `docs/04-system-overview/`,
    file `*-template.md` nằm trong subfolder `templates/` không cần gắn link (đây là placeholder,
    không phải tài liệu thật của 1 dự án cụ thể).
  - File nằm trong 1 subfolder của `docs/05-backlog/` hoặc `docs/06-meetings/` (Epic trong
    `docs/05-backlog/epics/`, meeting notes, open question) — 2 cấp: ví dụ từ
    `docs/05-backlog/epics/EPIC-001.md`:
    `[sprint](../../00-glossary/glossary.md#quy-trình--agile)`.
  - Feature/User Story trong subfolder theo Epic (`docs/05-backlog/{features,user-stories}/
    {EPIC-ID}_{slug}/`) — **3 cấp**: ví dụ từ
    `docs/05-backlog/features/EPIC-001_checkout/FEAT-001.md`:
    `[sprint](../../../00-glossary/glossary.md#quy-trình--agile)`.
  Không lặp lại link ở các lần nhắc lại sau trong cùng tài liệu. Nếu thuật ngữ **chưa có** trong
  glossary → không bắt buộc phải thêm link — chỉ thêm vào glossary khi thuật ngữ đó cần chuẩn
  hoá cách dùng (theo quy tắc phía trên), không phải mọi từ đều cần vào glossary chỉ để có chỗ
  link tới.

## 3. Traceability & trạng thái tài liệu

- Mọi tài liệu backlog (Epic/Feature/User Story) phải trỏ ngược lên tài liệu đã sinh ra nó:
  `parent_*` cho quan hệ cha-con trong backlog (`parent_epic`, `parent_feature`) và
  `docs_requirements` cho liên kết tới BR/UR/FR — không tạo tài liệu backlog mà thiếu các liên
  kết này (xem `CLAUDE.md`, mục "Đặt tên, ID và versioning").
- Không sinh tài liệu ở tầng N+1 khi tài liệu tầng N liên quan chưa có `status: approved`
  (xem `AGENTS.md`) — **trừ tầng backlog** (Epic → Feature → User Story): được phép thêm
  Feature/User Story mới vào 1 Epic/Feature đang `draft` bất kỳ lúc nào (backlog grooming là
  việc liên tục), miễn `parent_*` trỏ đúng và item cha chưa `deprecated` (xem `AGENTS.md`,
  nguyên tắc chung #2).
- Khi một item bị chặn bởi open question, set `status: blocked` và điền
  `blocked_by_open_questions: [OQ-xxx]` — không được để `blocked` mà thiếu field này, và
  không tự suy đoán câu trả lời để né trạng thái `blocked`.

## 4. Bảo mật & thông tin nhạy cảm

- Không đưa credential, API key, token, hoặc dữ liệu cá nhân thật vào bất kỳ tài liệu nào
  (kể cả ví dụ minh hoạ) — dùng placeholder rõ ràng (`<token>`, `xxx-xxx-xxx`...).
- Khi trích dẫn nội dung từ meeting notes hoặc nguồn bên ngoài vào tài liệu dự án, rà lại để
  loại bỏ thông tin nhạy cảm không cần thiết cho ngữ cảnh kỹ thuật.

## 5. Git & commit

- Mỗi thay đổi tài liệu là một commit riêng, không gộp nhiều thay đổi không liên quan vào
  cùng một commit (xem `README.md`).
- Định dạng commit message: xem `CLAUDE.md` (mục "Đặt tên, ID và versioning"). Mô tả ngắn dùng
  động từ hành động, tiếng Việt hoặc tiếng Anh đều được nhưng phải nhất quán trong cùng một dự
  án.
- Branching, sprint, và release không thuộc phạm vi spec-kit này.
