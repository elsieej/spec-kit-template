---
type: glossary
last_updated: YYYY-MM-DD
---

# Từ điển thuật ngữ dự án

> Agent PHẢI đọc file này trước khi thực hiện bất kỳ task nào, để hiểu đúng ngữ cảnh
> các thuật ngữ riêng của dự án (tránh hiểu theo nghĩa phổ thông sai lệch), đồng thời
> dùng nhất quán thuật ngữ kỹ thuật khi viết tài liệu (xem mục "Ngôn ngữ, thuật ngữ,
> glossary-link" ở `spec-kit-conventions.md`).

## Thuật ngữ nghiệp vụ

Định nghĩa thuật ngữ business/domain riêng của dự án — điền dần khi viết BR/UR/FR (tra glossary
trước khi dùng 1 thuật ngữ, thêm dòng mới nếu chưa có — xem mục "Ngôn ngữ, thuật ngữ,
glossary-link" ở `spec-kit-conventions.md`). Gom theo nhóm chủ đề, ví dụ "Vai trò người dùng"
(persona), các nhóm domain khác
tuỳ dự án. Định nghĩa ở tầng này bằng khái niệm nghiệp vụ — **không nhắc tên mã
container/hệ thống cụ thể** (mã đó chỉ chốt ở Bước A, `c4-container.md`, chưa tồn tại khi
viết BR/UR/FR).

### Vai trò người dùng
Mô tả đầy đủ persona (pain point, nhu cầu) xem UR tương ứng; bảng dưới đây chỉ là bảng tra
cứu slug.

| Thuật ngữ | Định nghĩa trong ngữ cảnh dự án | Ví dụ |
|---|---|---|
| | | |

### Thuật ngữ KHÔNG dùng

Các cách gọi gây nhập nhằng trong ngữ cảnh dự án — dùng thuật ngữ ở cột giữa thay thế khi viết
tài liệu.

| Không dùng | Dùng thay bằng | Lý do |
|---|---|---|
| | | |

## Thuật ngữ kỹ thuật / văn phong

Quy định thuật ngữ kỹ thuật nào giữ nguyên tiếng Anh, thuật ngữ nào dịch và dịch thành gì,
để agent và người viết tài liệu dùng nhất quán xuyên suốt dự án. Trước khi dùng một thuật
ngữ kỹ thuật mới trong tài liệu, tra bảng này trước; nếu chưa có, thêm một dòng mới vào
đúng nhóm trước khi dùng.

### Quy trình / Agile

| Thuật ngữ (EN) | Cách dùng trong dự án | Ghi chú / Ví dụ |
|---|---|---|
| acceptance criteria | Giữ nguyên "Acceptance Criteria" ở tên mục; nội dung liệt kê viết tiếng Việt (Given/When/Then dịch thành Giả sử/Khi/Thì) | Mục `## Acceptance Criteria (Given/When/Then)` trong US-template.md |
| backlog | Giữ nguyên "backlog" | Không dịch thành "danh sách công việc tồn đọng" |
| epic | Giữ nguyên "epic" | |
| feature | Giữ nguyên "feature" | Không dịch "tính năng" trong ID/tiêu đề, có thể dùng trong câu mô tả |
| Given/When/Then | Dịch thành **Giả sử** / **Khi** / **Thì**, in đậm 3 từ khoá này khi viết Acceptance Criteria | 1. **Giả sử** ..., **khi** ..., **thì** ... |
| story point | Giữ nguyên "story point" | |
| user story | Giữ nguyên "user story" | Khi viết mục `## Story`, in đậm 3 từ khoá **Là** / **tôi muốn** / **để** |

<!-- Thêm nhóm/thuật ngữ mới bên dưới, giữ đúng định dạng bảng 3 cột. -->
