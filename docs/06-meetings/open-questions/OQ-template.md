---
id: OQ-001
type: open_question
status: draft         # draft| approved | blocked | deprecated
created: YYYY-MM-DD
raised_in_meeting: MEET-YYYYMMDD-01
blocks: []            # danh sách EPIC/FEAT/US id bị block bởi câu hỏi này (SYS-CTX/SYS-CTR không có blocked, dùng related_open_questions)
---

# OQ-001 — <Câu hỏi cần làm rõ>

## Câu hỏi
<Nội dung câu hỏi chưa rõ ràng>

## Vì sao quan trọng
<Ảnh hưởng gì nếu không trả lời>

## Trả lời (khi có)
-

## Sau khi trả lời
- Cập nhật status → approved
- Gỡ block khỏi các item trong `blocks`, đưa status của chúng quay về trạng thái **trước khi bị
  block** (không mặc định về `draft` — ví dụ một User Story đang `draft` bị block thì trở lại
  `draft`, một User Story đã `approved` rồi mới bị block lại vì phát sinh vấn đề thì trở lại
  `approved`)
