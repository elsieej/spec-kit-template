---
name: setup-context
description: >
  Dẫn dắt người dùng bằng hội thoại tự nhiên (không đọc nguyên văn 3 câu hỏi cố định) để lộ
  ra WHY (vì sao dự án tồn tại) → WHO (ai dùng) → WHAT (nhu cầu/kết quả cần đạt được, không
  phải cách hiện thực), rồi tạo trực tiếp BR-001, UR-001, FR-001 (docs/01-03) từ template
  tương ứng của Spec Kit này — không qua bước nháp trung gian. Dùng skill này khi user nói
  "khởi tạo dự án mới", "setup context", "bắt đầu dùng spec kit cho dự án X", hoặc khi
  docs/01-business-requirement còn trống mà user muốn bắt đầu pipeline.
---

# setup-context

Mục tiêu: giúp user tạo `BR-001` (`docs/01-business-requirement`), `UR-001`
(`docs/02-user-requirement`), `FR-001` (`docs/03-functional-requirement`) qua một cuộc hội
thoại tự nhiên về dự án họ muốn làm, thay vì bắt user tự viết đủ 3 tài liệu chuẩn từ đầu hoặc
trả lời máy móc 3 câu hỏi cố định "WHY của bạn là gì?". Đây là bước đầu tiên khi chưa có
BR/UR/FR nào trong dự án — Business Requirement là gốc, User Requirement và Functional
Requirement sinh ra từ đó. WHY/WHO/WHAT ở đây là 3 **nhóm nội dung nội bộ** agent dùng để phân
loại và điền đúng tài liệu — không phải kịch bản câu hỏi đọc nguyên văn cho user.

## Tài liệu tham khảo thêm

- [examples.md](examples.md) — ví dụ hội thoại minh hoạ cách hỏi tự nhiên (câu trả lời đủ cả 3
  khía cạnh, câu trả lời chỉ 1 khía cạnh cần hỏi tiếp, câu trả lời mơ hồ cần brainstorm) và 1
  phản ví dụ (SAI). Đọc file này khi cần hình dung cụ thể cách diễn đạt câu hỏi — không phải
  quy tắc bắt buộc, các quy tắc bắt buộc nằm ở phần dưới đây.

## Nguyên tắc khi chạy skill này

- **Câu hỏi mở đầu bằng ngôn ngữ đời thường, không nhắc thuật ngữ WHY/WHO/WHAT.** Hỏi user
  đang muốn xây dự án gì, theo cách một người bình thường mô tả ý tưởng của họ — không đọc lại
  3 câu hỏi mẫu cố định như một bảng câu hỏi. Câu trả lời tự do có thể chứa cả 3 khía cạnh
  (động cơ, đối tượng dùng, kết quả cần đạt) trộn lẫn cùng lúc, hoặc chỉ 1-2 khía cạnh — agent
  tự nghe và phân loại nội dung vào đúng nhóm (bối cảnh/động cơ → BR, đối tượng+nhu cầu → UR,
  kết quả/chức năng → FR), không bắt user tự tách bạch.
- **Hỏi tiếp để lấp khoảng trống, bằng câu hỏi bám sát ngữ cảnh vừa nghe — không đọc lại câu
  hỏi mẫu.** Sau câu hỏi mở, rà xem nhóm nào (động cơ/đối tượng/kết quả) còn thiếu hoặc còn mờ,
  rồi hỏi tiếp tự nhiên dựa trên chính những gì user vừa kể — ví dụ nếu user đã kể rõ ai dùng
  và họ cần gì nhưng chưa nói vì sao dự án cần tồn tại, hỏi tiếp kiểu "Điều gì khiến bạn muốn
  làm cái này ngay bây giờ? Nếu không làm thì sao?" thay vì hỏi máy móc "WHY của bạn là gì?".
  Một số câu hỏi (ví dụ MoSCoW cho từng nhu cầu — xem bước 4) vẫn cần hỏi tường minh vì không
  thể suy ra từ văn phong tự nhiên; những câu đó vẫn nên lồng vào mạch hội thoại, không đọc như
  đang điền form.
- Hỏi **từng câu một, đợi trả lời** — không hỏi dồn nhiều câu cùng lúc trong 1 lượt.
- Ghi thẳng vào file chính thức (BR/UR/FR) — **không** tạo file nháp trung gian. Trả lời tới
  đâu, tài liệu được tạo/cập nhật tới đó, tránh giữ hai bản.
- Vẫn phải điền đủ frontmatter theo template của từng loại: `id`, `type`, `status: draft`,
  `version: 1`, `created`/`last_updated` (lấy ngày hiện tại), và `parent_*` nối UR-001 →
  BR-001, FR-001 → UR-001.
- **Câu trả lời còn sơ sài/chung chung → brainstorm rồi hỏi lại, đừng hỏi lại kiểu "bạn nói rõ
  hơn được không?".** Dựa vào ngữ cảnh đã có (câu trả lời trước đó trong cùng phiên, glossary,
  loại dự án), chủ động đề xuất 2-4 khả năng cụ thể và hỏi user xác nhận/chọn/sửa — ví dụ:
  "Ý bạn có phải là X hay Y? Còn edge case Z thì sao?". Đây KHÔNG phải ngoại lệ cho nguyên tắc
  không bịa nội dung ở dưới — mọi khả năng brainstorm ra chỉ là câu hỏi gợi ý, CHỈ ghi vào tài
  liệu sau khi user xác nhận rõ ràng.
- Nếu sau khi đã brainstorm/hỏi lại mà user vẫn chưa có câu trả lời rõ ràng cho một mục con
  trong template (ví dụ Success metrics, Edge cases), để nguyên placeholder gốc của template —
  không bịa nội dung, không tự suy diễn chi tiết user chưa cung cấp.
- Không tự set `status: approved` — skill chỉ tạo bản `draft`. Review/approve là bước riêng
  của user/team. Quy ước xuyên suốt kit này: tài liệu tầng sau (User Requirement từ Business
  Requirement, Functional Requirement từ User Requirement, System Overview từ Functional
  Requirement) chỉ được tạo khi tài liệu tầng trước đã `status: approved` — không nhảy cấp.
- Nếu user có nhiều hơn 1 WHY/WHO/WHAT cần tách (ví dụ nhiều persona khác nhau → nhiều UR),
  tạo thêm `UR-002`, `UR-003`... theo đúng naming convention thay vì nhồi vào 1 file.
- Khi viết nội dung BR/UR/FR, thuật ngữ đã có trong `docs/00-glossary/glossary.md` → gắn link
  Markdown tới đúng mục ở lần xuất hiện đầu tiên trong tài liệu (xem `RULES.md` mục 2).

## Quy trình

1. Kiểm tra `docs/00-glossary/glossary.md` đã tồn tại chưa (AGENTS.md, nguyên tắc chung #1 bắt
   buộc đọc file này trước mọi tài liệu). Đây thường là task đầu tiên chạy trên 1 dự án mới nên
   file này nhiều khả năng chưa có — nếu chưa có, copy nguyên trạng
   `docs/00-glossary/template.md` thành `glossary.md` trước khi hỏi câu mở đầu, không hỏi user,
   không bỏ qua bước này. Nếu đã có, đọc qua để nắm thuật ngữ dự án hiện tại.
2. Kiểm tra `docs/01-business-requirement/` đã có file `BR-*` nào ngoài `template.md` chưa.
   Nếu có, hỏi user muốn tạo BR mới hay tiếp tục/refine BR đang có — không tự ý ghi đè.
3. **Hỏi mở đầu, 1 câu duy nhất, ngôn ngữ tự nhiên** — ví dụ: "Kể tôi nghe về dự án bạn muốn
   làm — bạn đang hình dung xây cái gì, cho ai dùng, và điều gì khiến bạn muốn làm nó?". Không
   đọc nguyên văn 3 câu hỏi WHY/WHO/WHAT tách rời, không dùng thuật ngữ này khi hỏi user. Nếu
   câu trả lời còn chung chung/mơ hồ ngay từ đầu, brainstorm 2-4 hướng cụ thể rồi hỏi lại (xem
   nguyên tắc ở trên) trước khi đi tiếp.
4. **Phân loại câu trả lời vừa nghe** vào 3 nhóm nội bộ, rồi hỏi tiếp để lấp phần còn thiếu —
   mỗi câu hỏi tiếp theo bám vào chính những gì user vừa kể, không đọc lại câu hỏi mẫu:
   - **Động cơ/bối cảnh (→ BR, khái niệm WHY):** vì sao dự án cần tồn tại, đang giải quyết vấn
     đề/nắm bắt cơ hội gì, không làm thì sao, cải thiện được gì (IMPROVE) và đánh đổi gì (COST).
     Nếu phần này còn thiếu/mờ sau câu hỏi mở, hỏi tiếp tự nhiên theo mạch chuyện (ví dụ dựa
     vào lý do user vừa nêu, hỏi sâu hơn về hệ quả nếu không làm). Khi đủ nội dung → tạo
     `docs/01-business-requirement/BR-001_<slug>.md` từ `template.md`, điền "Bối cảnh (WHY)",
     "Mục tiêu kinh doanh", "Lợi ích & chi phí (IMPROVE/COST)".
   - **Đối tượng dùng + nhu cầu (→ UR, khái niệm WHO):** ai dùng — persona nào, pain point hiện
     tại, nhu cầu cụ thể. Nếu còn thiếu/mờ, hỏi tiếp tự nhiên (ví dụ "Còn ai khác cũng dùng cái
     này không, hay chỉ mình họ?"). Khi đủ → tạo `docs/02-user-requirement/UR-001_<slug>.md`,
     điền "Đối tượng người dùng (WHO)", "Nhu cầu người dùng",
     `parent_business_requirement: BR-001`. Riêng mục này **luôn phải hỏi tường minh, không tự
     suy đoán từ văn phong**, vì không thể rút ra từ cách user kể chuyện: "Nhu cầu này ở mức ưu
     tiên nào — Must have / Should have / Could have / Won't have (MoSCoW)?" cho từng nhu cầu
     vừa ghi → điền mục "Ưu tiên" của UR. Đây là field bắt buộc trong `UR-template.md`, không
     phải nội dung agent tự gán theo cảm nhận.
   - **Kết quả/chức năng cần đạt (→ FR, khái niệm WHAT):** hệ thống cần đạt được kết quả/đầu ra
     gì để đáp ứng nhu cầu đó (mô tả ở mức kết quả cần đạt, chưa cần nói cách triển khai kỹ
     thuật — cách hiện thực sẽ quyết định ở System Overview/C4 và khi phân rã Epic/Feature/User
     Story), có business rule nào cần biết trước không. Nếu còn thiếu/mờ, hỏi tiếp tự nhiên.
     Khi đủ → tạo `docs/03-functional-requirement/FR-001_<slug>.md`, điền "Mô tả chức năng
     (WHAT)", "Business rules", `parent_user_requirement: UR-001`.
   Thứ tự hỏi-tiếp không bắt buộc theo đúng thứ tự BR→UR→FR ở trên nếu mạch hội thoại tự nhiên
   dẫn sang nhóm khác trước — miễn cuối cùng cả 3 nhóm đều đủ nội dung trước khi tạo file tương
   ứng (file vẫn phải tạo theo đúng thứ tự BR trước UR trước FR, vì UR/FR cần trỏ `parent_*` về
   tài liệu đã tồn tại).
5. Cập nhật ngược mục "Liên kết" ở BR-001/UR-001 để trỏ xuôi tới UR-001/FR-001 vừa tạo. **Trước
   khi coi bước này xong**: kiểm lại riêng việc gắn link glossary — mọi thuật ngữ đã có trong
   `docs/00-glossary/glossary.md` dùng trong BR/UR/FR vừa viết có link ở lần xuất hiện đầu tiên
   chưa (xem nguyên tắc ở trên, `RULES.md` mục 2) — quy tắc này hay bị bỏ quên trong lúc tập
   trung viết nội dung, kiểm lại rõ ràng ở đây thay vì chỉ tin đã làm đúng lúc viết.
6. **Trước khi kết thúc phiên**, quét lại toàn bộ nội dung BR/UR/FR vừa viết trong phiên (không
   chỉ mục user vừa hỏi lại tường minh) — tìm mọi chi tiết cụ thể mà user chưa thực sự xác nhận,
   cả **định lượng** (con số, ngưỡng, success metric) lẫn **định tính** (business rule diễn đạt
   kiểu chắc chắn dù chỉ là suy đoán, hành vi lỗi cụ thể, MoSCoW tự gán thay vì hỏi — không chỉ
   quét chi tiết có số), kể cả chi tiết agent chèn thêm khi diễn giải
   lại câu trả lời chung chung của user. Với mỗi chi tiết như vậy: hỏi lại user, hoặc để nguyên
   placeholder gốc của template (xem nguyên tắc "không bịa nội dung" ở trên) — không chỉ dựa vào
   trí nhớ những chỗ agent tự thấy "cần chú ý" lúc viết, vì cùng 1 lượt suy luận vừa viết vừa tự
   rà thường bỏ sót đúng những chi tiết nó không nhớ là đã tự thêm vào. Nếu khả thi, chạy bước
   này như 1 lượt riêng sau khi đã viết xong toàn bộ, thay vì xen kẽ ngay trong lúc viết.
7. Nhắc user: review và set `status: approved` cho từng tầng trước khi tạo System Overview
   (C4 Context + Container Diagram). Sau đó điền "Giai đoạn hiện tại" và "Team & đầu mối liên
   hệ" trong `CONTEXT.md` nếu chưa có.
