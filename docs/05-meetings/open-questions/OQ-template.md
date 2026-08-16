---
id: OQ-001
type: open_question
status: open          # open | answered | closed
created: YYYY-MM-DD
raised_in_meeting: MEET-YYYYMMDD-01
blocks: []            # danh sách SYS-CTX/SYS-CTR/EPIC/FEAT/US/TASK/SPRINT/REL id bị block bởi câu hỏi này
---

# OQ-001 — <Câu hỏi cần làm rõ>

## Câu hỏi
<Nội dung câu hỏi chưa rõ ràng>

## Vì sao quan trọng
<Ảnh hưởng gì nếu không trả lời>

## Trả lời (khi có)
-

## Sau khi trả lời
- Cập nhật status → answered/closed
- Gỡ block khỏi các item trong `blocks`, đưa status của chúng quay về trạng thái **trước khi bị
  block** (không mặc định về `ready` — ví dụ một Task đang `in-progress` bị block thì trở lại
  `in-progress`, không lùi về `ready`)
