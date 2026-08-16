---
name: setup-context
description: >
  Dẫn dắt người dùng trả lời WHY (vì sao dự án tồn tại) → WHO (ai dùng) → HOW (làm thế
  nào), rồi tạo trực tiếp BR-001, UR-001, FR-001 (docs/00-02) từ template tương ứng của
  Spec Kit này — không qua bước nháp trung gian. Dùng skill này khi user nói "khởi tạo dự
  án mới", "setup context", "bắt đầu dùng spec kit cho dự án X", hoặc khi
  docs/00-business-requirement còn trống mà user muốn bắt đầu pipeline.
---

# setup-context

Mục tiêu: giúp user tạo `BR-001` (`docs/00-business-requirement`), `UR-001`
(`docs/01-user-requirement`), `FR-001` (`docs/02-functional-requirement`) bằng cách hỏi lần
lượt WHY → WHO → HOW, thay vì bắt user tự viết đủ 3 tài liệu chuẩn từ đầu. Đây là bước đầu
tiên trong pipeline (xem `AGENTS.md`, `README.md`, `CONTEXT.md`).

## Nguyên tắc khi chạy skill này

- Hỏi **từng câu một, đợi trả lời** — WHY trước, vì câu trả lời cho WHO/HOW thường phụ thuộc
  vào WHY. Không hỏi dồn.
- Ghi thẳng vào file chính thức (BR/UR/FR) — **không** tạo file nháp trung gian, không ghi
  vào `CONTEXT.md`. Trả lời tới đâu, tài liệu được tạo/cập nhật tới đó, tránh giữ hai bản.
- Vẫn phải điền đủ frontmatter theo `CLAUDE.md` (mục "Đặt tên, ID và versioning"): `id`,
  `type`, `status: draft`, `version: 1`, `created`/`last_updated` (lấy ngày hiện tại), và
  `parent_*` nối UR-001 → BR-001, FR-001 → UR-001.
- Nếu user chưa có câu trả lời rõ ràng cho một mục con trong template (ví dụ Success metrics,
  Edge cases), để nguyên placeholder gốc của template — không bịa nội dung, không tự suy diễn
  chi tiết user chưa cung cấp.
- Không tự set `status: approved` — skill chỉ tạo bản `draft`. Review/approve là bước riêng
  của user/team (xem `AGENTS.md`, nguyên tắc chung #2 — tầng sau chỉ được sinh khi tầng trước
  `approved`).
- Nếu user có nhiều hơn 1 WHY/WHO/HOW cần tách (ví dụ nhiều persona khác nhau → nhiều UR),
  tạo thêm `UR-002`, `UR-003`... theo đúng naming convention thay vì nhồi vào 1 file.

## Quy trình

1. Kiểm tra `docs/00-business-requirement/` đã có file `BR-*` nào ngoài `template.md` chưa.
   Nếu có, hỏi user muốn tạo BR mới hay tiếp tục/refine BR đang có — không tự ý ghi đè.
2. Hỏi **WHY**: "Vì sao dự án này cần tồn tại? Đang giải quyết vấn đề gì, hoặc nắm bắt cơ hội
   gì? Nếu không làm, điều gì sẽ tệ hơn? Có gì cải thiện được (IMPROVE) và đánh đổi gì
   (COST)?" → tạo `docs/00-business-requirement/BR-001_<slug>.md` từ `template.md`, điền mục
   "Bối cảnh (WHY)", "Mục tiêu kinh doanh", "Lợi ích & chi phí (IMPROVE/COST)".
3. Hỏi **WHO**: "Ai dùng hệ thống này — persona nào, pain point hiện tại của họ là gì? Nhu cầu
   cụ thể là gì?" → tạo `docs/01-user-requirement/UR-001_<slug>.md`, điền "Đối tượng người
   dùng (WHO)", "Nhu cầu người dùng", `parent_business_requirement: BR-001`.
4. Hỏi **HOW**: "Hệ thống phải làm gì để đáp ứng nhu cầu đó — mô tả chức năng cụ thể? Có
   business rule nào cần biết trước không?" → tạo `docs/02-functional-requirement/FR-001_<slug>.md`,
   điền "Mô tả chức năng (HOW)", "Business rules", `parent_user_requirement: UR-001`.
5. Cập nhật ngược mục "Liên kết" ở BR-001/UR-001 để trỏ xuôi tới UR-001/FR-001 vừa tạo.
6. Nhắc user: review và set `status: approved` cho từng tầng trước khi sang Bước A (System
   Overview) — xem `AGENTS.md`. Sau đó điền "Giai đoạn hiện tại" và "Team & đầu mối liên hệ"
   trong `CONTEXT.md` nếu chưa có.
