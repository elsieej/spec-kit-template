---
name: c4-model
description: >
  Giải thích phương pháp C4 Model (Context, Container, Component, Code — c4model.com) và
  dẫn dắt tạo docs/04-system-overview/c4-context.md + c4-container.md + c4-component-*.md
  đúng tầng, đúng audience. Dùng khi user hỏi "C4 model là gì", "vẽ context/container/
  component diagram", "system overview", "kiến trúc hệ thống", hoặc khi BR/UR/FR đã approved
  và cần sinh system overview.
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
| 3. Component | Bên trong 1 container có những component/module nào? | Dev trong team sở hữu container đó | `c4-component-<mã-container>.md`, 1 file/container |
| 4. Code | Class/function cụ thể | Dev đang code trực tiếp | Không tạo — để code + IDE tự giải thích |

Kit này tạo Level 1–3 theo mặc định: Context + Container cho toàn hệ thống, và 1 file
Component riêng cho mỗi container có codebase thực sự (bỏ qua container không có component
nội bộ để mô hình hoá, ví dụ DB thuần hoặc dịch vụ bên thứ ba dùng nguyên trạng). Level 4
(Code) không tạo — để code + IDE tự giải thích, tránh diagram chi tiết đến mức không ai
maintain nổi, nhanh lỗi thời hơn cả code.

## Khi nào dùng skill này

- User hỏi C4 model là gì / vì sao kit tách riêng Context và Container.
- `docs/01-business-requirement`, `02-user-requirement`, `03-functional-requirement` liên
  quan đã `status: approved`, cần sinh system overview.

## Quy trình tạo Context Diagram (Level 1)

1. Đọc `docs/00-glossary/glossary.md` (thuật ngữ dự án, dùng nhất quán khi đặt tên hệ thống/
   container/component), rồi toàn bộ `docs/01-03` đã approved (đặc biệt UR để lấy
   Actor/Persona, FR để lấy hệ thống ngoài cần tích hợp).
2. Viết 1–2 câu mô tả hệ thống trung tâm.
3. Điền `docs/04-system-overview/c4-context.md`: bảng Actors/Personas, bảng Hệ thống ngoài
   liên quan (mục đích tích hợp + hướng dữ liệu in/out), diagram mermaid `graph TD`.
4. **Không** đưa chi tiết kỹ thuật (tên container, công nghệ, API) vào tầng này — đó là việc
   của Container Diagram. Audience tầng này gồm cả người phi kỹ thuật.

## Quy trình tạo Container Diagram (Level 2)

1. Bắt đầu từ Context Diagram đã có (`source_docs: [SYS-CTX-001]`).
2. Liệt kê từng container, mỗi container gán 1 **mã** (slug ngắn, duy nhất trong bảng, vd
   `checkout-web`, `checkout-api`, `db`), kèm loại (web app/mobile/service/DB...), công nghệ,
   và trách nhiệm. Bảng này là dữ liệu gốc mà mọi việc lập kế hoạch sau này sẽ đọc lại và tham
   chiếu đúng theo mã — không nơi nào khác tự đặt mã container mới.
3. Nếu chưa rõ hệ thống nên tách thành bao nhiêu container độc lập (mô hình còn mơ hồ, ranh
   giới trách nhiệm giữa các phần chưa rõ): hỏi trực tiếp user, ví dụ "hệ thống này gồm bao
   nhiêu service/app độc lập?" — không tự suy đoán ranh giới. Nếu user chưa có tên cụ thể cho
   container, có thể tự đề xuất tên gợi ý theo trách nhiệm (ví dụ `checkout-service`,
   `notification-service`) nhưng phải để user xác nhận trước khi ghi chính thức vào bảng.
4. Vẽ giao tiếp giữa các container: từ đâu → tới đâu, giao thức (REST/HTTPS, gRPC, message
   queue...), mô tả ngắn.
5. Với mỗi container có codebase thực sự (không phải DB thuần/dịch vụ bên thứ ba dùng nguyên
   trạng), tiếp tục sang Quy trình tạo Component Diagram bên dưới. Không tự vẽ Code diagram
   (Level 4) trừ khi user yêu cầu rõ ràng.

## Quy trình tạo Component Diagram (Level 3)

1. Với mỗi container thuộc diện cần Component diagram (xem bước 5 ở trên), tạo file
   `docs/04-system-overview/c4-component-<mã-container>.md` (`<mã-container>` là "Mã" của
   container đó trong `c4-container.md`), `source_docs: [SYS-CTR-xxx]` trỏ về container cha.
2. Liệt kê từng component/module bên trong container, mỗi component gán tên ngắn gọn kèm
   trách nhiệm chính — ở mức đủ để dev trong team sở hữu container hiểu bố cục mà không cần
   đọc code trước. Không xuống tới class/function cụ thể (đó là Level 4, không thuộc phạm vi
   skill này).
3. Vẽ giao tiếp giữa các component trong cùng container (gọi hàm, event nội bộ...) bằng
   diagram mermaid `graph TD`.
4. Nếu container quá đơn giản (1-2 component, không có cấu trúc nội bộ đáng vẽ), không tạo
   file Component cho container đó — ghi chú lý do trong `c4-container.md` thay vì tạo file
   rỗng/hình thức.
5. Dừng ở Level 3. Không tự vẽ Code diagram trừ khi user yêu cầu rõ ràng.

## Lỗi thường gặp cần tránh

- Nhồi chi tiết kỹ thuật vào Context Diagram — sai audience, người phi kỹ thuật không đọc nổi.
- Vẽ Code diagram (Level 4) cho toàn bộ hệ thống khi chưa ai yêu cầu — tốn công, nhanh lỗi
  thời.
- Tạo Component diagram hình thức cho container quá đơn giản (không có cấu trúc nội bộ đáng
  vẽ) — xem bước 4 ở Quy trình tạo Component Diagram.
- Bỏ qua Context Diagram, nhảy thẳng vào Container — mất bối cảnh actor/hệ thống ngoài mà
  Container Diagram cần tham chiếu.
- Không cập nhật diagram khi kiến trúc đổi — review lại Container/Component Diagram mỗi khi có Epic mới
  ảnh hưởng kiến trúc (bump `version`, không tạo file mới cho mỗi lần sửa).
