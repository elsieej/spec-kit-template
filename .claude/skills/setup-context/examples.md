# Ví dụ hội thoại — setup-context

File tham khảo, đi kèm `SKILL.md`. Minh hoạ cụ thể cách hỏi tự nhiên thay vì đọc nguyên văn 3
câu hỏi WHY/WHO/WHAT — đây là ví dụ để tham khảo tinh thần, **không phải kịch bản cố định để
lặp lại nguyên văn từng chữ**. Chỉ đọc file này khi cần hình dung cụ thể; các quy tắc bắt buộc
vẫn nằm ở `SKILL.md`.

## Ví dụ 1 — câu trả lời đầu tiên đã chứa cả 3 khía cạnh

> **Agent:** Kể tôi nghe về dự án bạn muốn làm — bạn đang hình dung xây cái gì, cho ai dùng, và
> điều gì khiến bạn muốn làm nó?
>
> **User:** Mình muốn làm một app quản lý công việc cho team nhỏ (5-10 người) ở startup, vì hiện
> tại team đang dùng chung 1 file Excel nên hay ghi đè lên nhau, không biết ai đang làm gì.

Agent phân loại ngay, không hỏi lại những phần đã rõ:
- **Động cơ (→ BR):** đủ rõ — vấn đề hiện tại là xung đột dữ liệu khi dùng chung Excel, không
  ai biết ai đang làm gì. Có thể hỏi thêm 1 câu bám ngữ cảnh để làm rõ hệ quả: "Việc ghi đè này
  đang gây thiệt hại gì cụ thể — trễ deadline, làm trùng việc?" thay vì hỏi lại "WHY là gì?".
- **Đối tượng (→ UR):** đủ rõ — team nhỏ 5-10 người ở startup. Vẫn hỏi tường minh MoSCoW cho
  từng nhu cầu cụ thể sẽ liệt ở bước sau (không tự suy đoán mức ưu tiên).
- **Kết quả (→ FR):** chưa rõ — user mới nói vấn đề, chưa nói hệ thống mới cần làm được gì. Hỏi
  tiếp tự nhiên: "Vậy để hết cảnh ghi đè đó, bạn hình dung mọi người sẽ thấy/thao tác thế nào
  trên hệ thống mới?" — không hỏi máy móc "WHAT của bạn là gì?".

## Ví dụ 2 — câu trả lời chỉ có 1 khía cạnh, câu trả lời còn chung chung

> **Agent:** Kể tôi nghe về dự án bạn muốn làm?
>
> **User:** Làm web bán hàng online thôi.

Chỉ có khía cạnh kết quả/chức năng ở mức rất chung, thiếu cả động cơ lẫn đối tượng, và "web bán
hàng online" còn quá mơ hồ để viết vào FR. Theo nguyên tắc brainstorm (xem `SKILL.md`), agent
không hỏi lại kiểu "bạn nói rõ hơn được không?" mà chủ động đề xuất cụ thể:

> **Agent:** Được, để hình dung rõ hơn — bán hàng kiểu nào là gần với ý bạn: (a) một shop online
> đơn lẻ tự quản lý sản phẩm/đơn hàng, (b) sàn nhiều người bán như marketplace, hay (c) đặt hàng
> qua catalogue rồi liên hệ ngoài (không thanh toán online)? Và ai là người vận hành chính — bạn
> tự bán, hay có thêm nhân viên/đối tác cùng dùng hệ thống?

Chỉ ghi vào BR/UR/FR sau khi user xác nhận/chọn 1 trong các hướng brainstorm này.

## Phản ví dụ — SAI, không nên làm

> **Agent:** Đầu tiên, WHY của bạn là gì — vì sao dự án này cần tồn tại?
>
> **User:** ...
>
> **Agent:** OK, tiếp theo WHO của bạn là gì — ai dùng hệ thống này?
>
> **User:** ...
>
> **Agent:** Cuối cùng, WHAT của bạn là gì — hệ thống cần đạt kết quả gì?

Sai vì: đọc nguyên văn 3 câu hỏi mẫu tách rời theo đúng thứ tự cố định, dùng thuật ngữ nội bộ
WHY/WHO/WHAT trực tiếp với user, và bỏ qua nội dung liên quan đã lộ ra ở câu trả lời trước (ví
dụ user nhắc tới đối tượng dùng ngay trong câu trả lời cho "WHY" nhưng agent vẫn hỏi lại y hệt
ở câu "WHO" thay vì công nhận đã biết).
