---
id: US-001
type: user_story
status: draft         # draft | approved | blocked | deprecated
version: 1
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
parent_feature: FEAT-001
docs_requirements: [FR-001]  # 1 hoặc nhiều ID BR/UR/FR mà User Story này hiện thực hoá/liên quan trực tiếp
story_points: null
assignee: null
blocked_by_open_questions: []
depends_on: []         # ID Feature/US khác phải status:approved trước khi story này thực hiện được
priority: null         # P0 | P1 | P2 | P3 — ưu tiên xử lý trong backlog, xem AGENTS.md mục "Backlog"
---

# US-001 — <Tên user story>

## Story
**Là** <persona>, **tôi muốn** <hành động>, **để** <lợi ích>.

## Acceptance Criteria (Given/When/Then)
Phải bao phủ đủ các trường hợp chính (happy path + edge case/lỗi quan trọng) — đây là nguồn
duy nhất để phân task và định nghĩa test case sau này, không bổ sung ở đâu khác trong spec-kit
này.
1. **Giả sử** <điều kiện ban đầu>, **khi** <hành động xảy ra>, **thì** <kết quả mong đợi>.
2.

## Context cho Agent (đọc trước khi thực hiện)
- Business/Functional requirement liên quan: FR-001
- System overview liên quan: SYS-CTR-001 (container: <mã container, xem c4-container.md>)
- Container Interface Contract liên quan: <mã CIC-xxx trong container-interface-contracts.md —
  nếu file này tồn tại và có luồng giao tiếp liên quan tới US này, xem AGENTS.md Bước C>
- Glossary liên quan: xem docs/00-glossary/glossary.md

## Ghi chú kỹ thuật
Bắt buộc ghi lý do ở đây khi **sau này đổi** `priority` khác giá trị đã chọn ban đầu (xem
AGENTS.md mục "Backlog"), hoặc quyết định tại họp (kèm liên kết `MEET-xxx`). KHÔNG bắt buộc ghi
lý do lúc **chọn lần đầu** giữa 2 giá trị hợp lệ cùng mức MoSCoW khi tạo mới.

-
