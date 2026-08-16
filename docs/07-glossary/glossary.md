---
type: glossary
last_updated: YYYY-MM-DD
---

# Từ điển thuật ngữ dự án

> Agent PHẢI đọc file này trước khi thực hiện bất kỳ task nào, để hiểu đúng ngữ cảnh
> các thuật ngữ riêng của dự án (tránh hiểu theo nghĩa phổ thông sai lệch), đồng thời
> dùng nhất quán thuật ngữ kỹ thuật khi viết tài liệu (xem quy tắc tone ở `RULES.md`).

## Thuật ngữ nghiệp vụ

Định nghĩa thuật ngữ business/domain riêng của dự án.

| Thuật ngữ | Định nghĩa trong ngữ cảnh dự án | Ví dụ |
|---|---|---|
| dataset | | |
| training-toolkit | | |

## Thuật ngữ kỹ thuật / văn phong

Quy định thuật ngữ kỹ thuật nào giữ nguyên tiếng Anh, thuật ngữ nào dịch và dịch thành gì,
để agent và người viết tài liệu dùng nhất quán xuyên suốt dự án. Trước khi dùng một thuật
ngữ kỹ thuật mới trong tài liệu, tra bảng này trước; nếu chưa có, thêm một dòng mới vào
đúng nhóm trước khi dùng.

### Quy trình / Agile

| Thuật ngữ (EN) | Cách dùng trong dự án | Ghi chú / Ví dụ |
|---|---|---|
| backlog | Giữ nguyên "backlog" | Không dịch thành "danh sách công việc tồn đọng" |
| epic | Giữ nguyên "epic" | |
| feature | Giữ nguyên "feature" | Không dịch "tính năng" trong ID/tiêu đề, có thể dùng trong câu mô tả |
| sprint | Giữ nguyên "sprint" | Không dịch "chạy nước rút" |
| story point | Giữ nguyên "story point" | |
| user story | Giữ nguyên "user story" | |

### Git / Release

| Thuật ngữ (EN) | Cách dùng trong dự án | Ghi chú / Ví dụ |
|---|---|---|
| branch | Giữ nguyên "branch" | |
| commit | Giữ nguyên "commit" | Không dịch "lần chốt thay đổi" |
| Gitflow | Giữ nguyên "Gitflow" | Tên riêng, viết hoa chữ G |
| merge | Giữ nguyên "merge" | |
| pull request (PR) | Giữ nguyên "pull request" hoặc viết tắt "PR" | |
| release | Giữ nguyên "release" | |

### Kiến trúc / C4

| Thuật ngữ (EN) | Cách dùng trong dự án | Ghi chú / Ví dụ |
|---|---|---|
| container (C4) | Giữ nguyên "container" | Không nhầm với container hoá (Docker) |
| context diagram | Giữ nguyên "context diagram" hoặc "diagram context" | |
| endpoint | Giữ nguyên "endpoint" | |

### Trạng thái tài liệu

| Thuật ngữ (EN) | Cách dùng trong dự án | Ghi chú / Ví dụ |
|---|---|---|
| approved | Giữ nguyên trong field `status`, có thể dịch "đã duyệt" trong văn xuôi | |
| blocked | Giữ nguyên trong field `status`, có thể dịch "đang bị chặn" trong văn xuôi | Luôn kèm `blocked_by_open_questions` |
| draft | Giữ nguyên trong field `status`, có thể dịch "bản nháp" trong văn xuôi | |

<!-- Thêm nhóm/thuật ngữ mới bên dưới, giữ đúng định dạng bảng 3 cột. -->
