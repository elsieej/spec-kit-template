---
name: c4-model
description: >
  Giải thích phương pháp C4 Model (Context, Container, Component, Code — c4model.com) và
  dẫn dắt tạo docs/04-system-overview/c4-context.md + c4-container.md đúng tầng, đúng
  audience. Dùng khi user hỏi "C4 model là gì", "vẽ context diagram/container diagram",
  "system overview", "kiến trúc hệ thống", hoặc khi BR/UR/FR đã approved và cần sinh system
  overview.
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
- `docs/01-business-requirement`, `01-user-requirement`, `02-functional-requirement` liên
  quan đã `status: approved`, cần sinh system overview.

## Quy trình tạo Context Diagram (Level 1)

1. Đọc toàn bộ `docs/01-04` đã approved (đặc biệt UR để lấy Actor/Persona, FR để lấy hệ thống
   ngoài cần tích hợp).
2. Viết 1–2 câu mô tả hệ thống trung tâm.
3. Điền `docs/04-system-overview/c4-context.md`: bảng Actors/Personas, bảng Hệ thống ngoài
   liên quan (mục đích tích hợp + hướng dữ liệu in/out), diagram mermaid `graph TD`.
4. **Không** đưa chi tiết kỹ thuật (tên container, công nghệ, API) vào tầng này — đó là việc
   của Container Diagram. Audience tầng này gồm cả người phi kỹ thuật.

## Quy trình tạo Container Diagram (Level 2)

1. Bắt đầu từ Context Diagram đã có (`source_docs: [SYS-CTX-001]`).
2. Liệt kê từng container, mỗi container gán 1 **mã** (slug ngắn, duy nhất trong bảng, vd
   `checkout-web`, `checkout-api`, `db`), kèm loại (web app/mobile/service/DB...), công nghệ,
   trách nhiệm, và tên repo triển khai nếu container đó có repo riêng (để trống nếu là
   DB/service bên thứ ba, hoặc dùng chung tên repo nếu nhiều container nằm chung 1 monorepo).
   Bảng này là dữ liệu gốc mà mọi việc lập kế hoạch sau này sẽ đọc lại và tham chiếu đúng theo
   mã — không nơi nào khác tự đặt mã/tên container/repo mới.
3. Nếu chưa rõ hệ thống nên tách thành bao nhiêu container/repo độc lập (mô hình còn mơ hồ,
   ranh giới trách nhiệm giữa các phần chưa rõ): hỏi trực tiếp user, ví dụ "hệ thống này gồm
   bao nhiêu service/app độc lập? mỗi service có repo riêng hay dùng chung 1 repo?" — không tự
   suy đoán ranh giới. Nếu user chưa có tên cụ thể cho container/repo, có thể tự đề xuất tên gợi
   ý theo trách nhiệm (ví dụ `checkout-service`, `notification-service`) nhưng phải để user xác
   nhận trước khi ghi chính thức vào bảng.
4. Vẽ giao tiếp giữa các container: từ đâu → tới đâu, giao thức (REST/HTTPS, gRPC, message
   queue...), mô tả ngắn.
5. Dừng ở Level 2. Không tự vẽ Component/Code diagram trừ khi user yêu cầu rõ drill-down vào
   một container cụ thể.

## Lỗi thường gặp cần tránh

- Nhồi chi tiết kỹ thuật vào Context Diagram — sai audience, người phi kỹ thuật không đọc nổi.
- Vẽ Component/Code diagram cho toàn bộ hệ thống ngay từ đầu khi chưa ai yêu cầu — tốn công,
  nhanh lỗi thời.
- Bỏ qua Context Diagram, nhảy thẳng vào Container — mất bối cảnh actor/hệ thống ngoài mà
  Container Diagram cần tham chiếu.
- Không cập nhật diagram khi kiến trúc đổi — review lại Container Diagram mỗi khi có Epic mới
  ảnh hưởng kiến trúc (bump `version`, không tạo file mới cho mỗi lần sửa).
