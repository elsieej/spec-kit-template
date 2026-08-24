---
name: setup-context
description: >
  Dẫn dắt người dùng trả lời WHY (vì sao dự án tồn tại) → WHO (ai dùng) → WHAT (nhu cầu/
  kết quả cần đạt được, không phải cách hiện thực), rồi tạo trực tiếp BR-001, UR-001,
  FR-001 (docs/01-03) từ template tương ứng của
  Spec Kit này — không qua bước nháp trung gian. Dùng skill này khi user nói "khởi tạo dự
  án mới", "setup context", "bắt đầu dùng spec kit cho dự án X", hoặc khi
  docs/01-business-requirement còn trống mà user muốn bắt đầu pipeline.
---

# setup-context

Mục tiêu: giúp user tạo `BR-001` (`docs/01-business-requirement`), `UR-001`
(`docs/02-user-requirement`), `FR-001` (`docs/03-functional-requirement`) bằng cách hỏi lần
lượt WHY → WHO → WHAT, thay vì bắt user tự viết đủ 3 tài liệu chuẩn từ đầu. Đây là bước đầu
tiên khi chưa có BR/UR/FR nào trong dự án — Business Requirement là gốc, User Requirement và
Functional Requirement sinh ra từ đó.

## Nguyên tắc khi chạy skill này

- Hỏi **từng câu một, đợi trả lời** — WHY trước, vì câu trả lời cho WHO/WHAT thường phụ thuộc
  vào WHY. Không hỏi dồn.
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
   `docs/00-glossary/template.md` thành `glossary.md` trước khi hỏi WHY, không hỏi user, không
   bỏ qua bước này. Nếu đã có, đọc qua để nắm thuật ngữ dự án hiện tại.
2. Kiểm tra `docs/01-business-requirement/` đã có file `BR-*` nào ngoài `template.md` chưa.
   Nếu có, hỏi user muốn tạo BR mới hay tiếp tục/refine BR đang có — không tự ý ghi đè.
3. Hỏi **WHY**: "Vì sao dự án này cần tồn tại? Đang giải quyết vấn đề gì, hoặc nắm bắt cơ hội
   gì? Nếu không làm, điều gì sẽ tệ hơn? Có gì cải thiện được (IMPROVE) và đánh đổi gì
   (COST)?" — nếu câu trả lời còn chung chung, brainstorm 2-4 hướng cụ thể rồi hỏi lại (xem
   nguyên tắc ở trên) → tạo `docs/01-business-requirement/BR-001_<slug>.md` từ `template.md`,
   điền mục "Bối cảnh (WHY)", "Mục tiêu kinh doanh", "Lợi ích & chi phí (IMPROVE/COST)".
4. Hỏi **WHO**: "Ai dùng hệ thống này — persona nào, pain point hiện tại của họ là gì? Nhu cầu
   cụ thể là gì?" — nếu câu trả lời còn chung chung, brainstorm persona/pain point cụ thể rồi
   hỏi lại → tạo `docs/02-user-requirement/UR-001_<slug>.md`, điền "Đối tượng người
   dùng (WHO)", "Nhu cầu người dùng", `parent_business_requirement: BR-001`. Hỏi tiếp, tường
   minh, không tự suy đoán: "Nhu cầu này ở mức ưu tiên nào — Must have / Should have / Could
   have / Won't have (MoSCoW)?" cho từng nhu cầu vừa ghi → điền mục "Ưu tiên" của UR. Đây là
   field bắt buộc trong `UR-template.md`, không phải nội dung agent tự gán theo cảm nhận.
5. Hỏi **WHAT**: "Hệ thống cần đạt được kết quả/đầu ra gì để đáp ứng nhu cầu đó? (mô tả
   chức năng ở mức kết quả cần đạt, chưa cần nói cách triển khai kỹ thuật — cách hiện thực sẽ
   quyết định ở System Overview/C4 và khi phân rã Epic/Feature/User Story). Có business rule nào cần
   biết trước không?" — nếu câu trả lời còn chung chung, brainstorm kết quả/business rule cụ
   thể rồi hỏi lại → tạo `docs/03-functional-requirement/FR-001_<slug>.md`, điền "Mô tả
   chức năng (WHAT)", "Business rules", `parent_user_requirement: UR-001`.
6. Cập nhật ngược mục "Liên kết" ở BR-001/UR-001 để trỏ xuôi tới UR-001/FR-001 vừa tạo.
7. **Trước khi kết thúc phiên**, quét lại toàn bộ nội dung BR/UR/FR vừa viết trong phiên (không
   chỉ mục user vừa hỏi lại tường minh) — tìm mọi chi tiết cụ thể mà user chưa thực sự xác nhận,
   cả **định lượng** (con số, ngưỡng, success metric) lẫn **định tính** (business rule diễn đạt
   kiểu chắc chắn dù chỉ là suy đoán, hành vi lỗi cụ thể, MoSCoW tự gán thay vì hỏi — không chỉ
   quét chi tiết có số), kể cả chi tiết agent chèn thêm khi diễn giải
   lại câu trả lời chung chung của user. Với mỗi chi tiết như vậy: hỏi lại user, hoặc để nguyên
   placeholder gốc của template (xem nguyên tắc "không bịa nội dung" ở trên) — không chỉ dựa vào
   trí nhớ những chỗ agent tự thấy "cần chú ý" lúc viết, vì cùng 1 lượt suy luận vừa viết vừa tự
   rà thường bỏ sót đúng những chi tiết nó không nhớ là đã tự thêm vào. Nếu khả thi, chạy bước
   này như 1 lượt riêng sau khi đã viết xong toàn bộ, thay vì xen kẽ ngay trong lúc viết.
8. Nhắc user: review và set `status: approved` cho từng tầng trước khi tạo System Overview
   (C4 Context + Container Diagram). Sau đó điền "Giai đoạn hiện tại" và "Team & đầu mối liên
   hệ" trong `CONTEXT.md` nếu chưa có.
