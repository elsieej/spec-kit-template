---
name: c4-model
description: >
  Giải thích phương pháp C4 Model (Context, Container, Component, Code — c4model.com) và
  dẫn dắt tạo docs/03-system-overview/c4-context.md + c4-container.md (Bước A trong
  AGENTS.md) đúng tầng, đúng audience. Dùng khi user hỏi "C4 model là gì", "vẽ context
  diagram/container diagram", "system overview", "kiến trúc hệ thống", hoặc khi bắt đầu
  Bước A sau khi BR/UR/FR đã approved.
---

# c4-model

## C4 Model là gì

C4 (nguồn: https://c4model.com/) là cách vẽ kiến trúc phần mềm qua 4 tầng, zoom dần từ tổng
quan xuống chi tiết — mỗi tầng phục vụ một loại người đọc khác nhau, không nhồi hết vào 1 sơ
đồ:

| Tầng | Trả lời câu hỏi | Đọc bởi | Trong kit này |
|---|---|---|---|
| 1. System Context | Hệ thống tương tác với ai, hệ thống ngoài nào? | Mọi người (kỹ thuật + phi kỹ thuật) | `c4-context.md` |
| 2. Container | Hệ thống gồm những container nào (web app/API/DB/service...), giao tiếp ra sao? | Kỹ thuật (architect/dev/ops) | `c4-container.md` |
| 3. Component | Bên trong 1 container có những component/module nào? | Dev trong team sở hữu container đó | Không tạo mặc định |
| 4. Code | Class/function cụ thể | Dev đang code trực tiếp | Không tạo — để code + IDE tự giải thích |

Kit này chỉ tạo Level 1–2 theo mặc định. Level 3–4 chỉ tạo khi có yêu cầu rõ ràng để
drill-down vào **một** container cụ thể (xem ghi chú cuối `c4-container.md`) — tránh vẽ diagram
chi tiết rồi không ai maintain, nhanh lỗi thời hơn cả code.

## Khi nào dùng skill này

- User hỏi C4 model là gì / vì sao kit tách riêng Context và Container.
- Bắt đầu Bước A (`AGENTS.md`): `docs/00-03` đã `status: approved`, cần sinh system overview.

## Quy trình tạo Context Diagram (Level 1)

1. Đọc toàn bộ `docs/00-03` đã approved (đặc biệt UR để lấy Actor/Persona, FR để lấy hệ thống
   ngoài cần tích hợp).
2. Viết 1–2 câu mô tả hệ thống trung tâm.
3. Điền `docs/03-system-overview/c4-context.md`: bảng Actors/Personas, bảng Hệ thống ngoài
   liên quan (mục đích tích hợp + hướng dữ liệu in/out), diagram mermaid `graph TD`.
4. **Không** đưa chi tiết kỹ thuật (tên container, công nghệ, API) vào tầng này — đó là việc
   của Container Diagram. Audience tầng này gồm cả người phi kỹ thuật.

## Quy trình tạo Container Diagram (Level 2)

1. Bắt đầu từ Context Diagram đã có (`source_docs: [SYS-CTX-001]`).
2. Liệt kê từng container: loại (web app/mobile/service/DB...), công nghệ, trách nhiệm.
3. Vẽ giao tiếp giữa các container: từ đâu → tới đâu, giao thức (REST/HTTPS, gRPC, message
   queue...), mô tả ngắn.
4. Dừng ở Level 2. Không tự vẽ Component/Code diagram trừ khi user yêu cầu rõ drill-down vào
   một container cụ thể.

## Lỗi thường gặp cần tránh

- Nhồi chi tiết kỹ thuật vào Context Diagram — sai audience, người phi kỹ thuật không đọc nổi.
- Vẽ Component/Code diagram cho toàn bộ hệ thống ngay từ đầu khi chưa ai yêu cầu — tốn công,
  nhanh lỗi thời.
- Bỏ qua Context Diagram, nhảy thẳng vào Container — mất bối cảnh actor/hệ thống ngoài mà
  Container Diagram cần tham chiếu.
- Không cập nhật diagram khi kiến trúc đổi — review lại Container Diagram mỗi khi có Epic mới
  ảnh hưởng kiến trúc (bump `version`, không tạo file mới cho mỗi lần sửa).
