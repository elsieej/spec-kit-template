# Ví dụ hội thoại — setup-context

File tham khảo, đi kèm `SKILL.md`. Mỗi tình huống dưới đây là 1 cặp **ĐÚNG/SAI** cụ thể — copy
đúng tinh thần (lắng nghe, phân loại, hỏi tiếp bám ngữ cảnh), không copy nguyên văn câu chữ
cho user khác. Các quy tắc bắt buộc vẫn nằm ở `SKILL.md`.

## Tình huống 1 — câu hỏi mở đầu

**ĐÚNG:**

> **Agent:** Kể tôi nghe về dự án bạn muốn làm — bạn đang hình dung xây cái gì, cho ai dùng, và
> điều gì khiến bạn muốn làm nó?

**SAI:**

> **Agent:** Đầu tiên, WHY của bạn là gì — vì sao dự án này cần tồn tại?
>
> *(đợi trả lời, rồi hỏi tiếp)* OK, tiếp theo WHO của bạn là gì — ai dùng hệ thống này?
>
> *(đợi trả lời, rồi hỏi tiếp)* Cuối cùng, WHAT của bạn là gì — hệ thống cần đạt kết quả gì?

Vì sao SAI: đọc nguyên văn 3 câu hỏi mẫu tách rời theo thứ tự cố định, dùng thẳng thuật ngữ nội
bộ WHY/WHO/WHAT với user — đây chính là kịch bản máy móc mà skill này đang tránh.

## Tình huống 2 — câu trả lời đã chứa sẵn nhiều khía cạnh

> **User:** Mình muốn làm app quản lý công việc cho team nhỏ (5-10 người) ở startup, vì hiện tại
> team đang dùng chung 1 file Excel nên hay ghi đè lên nhau, không biết ai đang làm gì.

**ĐÚNG** (công nhận phần đã rõ, chỉ hỏi tiếp phần còn thiếu — ở đây là kết quả/chức năng):

> **Agent:** Vậy để hết cảnh ghi đè đó, bạn hình dung mọi người sẽ thấy/thao tác thế nào trên hệ
> thống mới?

**SAI** (bỏ qua nội dung đã có, hỏi lại y hệt câu mẫu như chưa nghe gì):

> **Agent:** Cảm ơn bạn. Giờ cho mình hỏi thêm: ai dùng hệ thống này — persona nào, pain point
> hiện tại của họ là gì?

Vì sao SAI: user vừa nói rõ đối tượng dùng (team 5-10 người, startup) và pain point (ghi đè
Excel) ngay trong câu trả lời đầu — hỏi lại y hệt là bỏ qua ngữ cảnh vừa nghe, khiến hội thoại
có cảm giác là 3 form tách rời thay vì 1 cuộc trò chuyện.

## Tình huống 3 — câu trả lời còn mơ hồ

> **User:** Làm web bán hàng online thôi.

**ĐÚNG** (brainstorm 2-4 hướng cụ thể, hỏi user chọn/xác nhận):

> **Agent:** Được, để hình dung rõ hơn — bán hàng kiểu nào gần với ý bạn: (a) một shop online
> đơn lẻ tự quản lý sản phẩm/đơn hàng, (b) sàn nhiều người bán như marketplace, hay (c) đặt hàng
> qua catalogue rồi liên hệ ngoài (không thanh toán online)? Và ai là người vận hành chính — bạn
> tự bán, hay có thêm nhân viên/đối tác cùng dùng hệ thống?

**SAI — dạng 1** (hỏi lại chung chung, không giúp user thu hẹp):

> **Agent:** Bạn nói rõ hơn được không?

**SAI — dạng 2** (tự bịa chi tiết cụ thể thay vì hỏi):

> **Agent:** *(tự ghi vào FR-001)* "Hệ thống là marketplace nhiều người bán, hỗ trợ thanh toán
> online qua thẻ và ví điện tử, có giỏ hàng và theo dõi đơn hàng real-time."

Vì sao SAI: dạng 1 đẩy việc thu hẹp phạm vi ngược lại cho user thay vì chủ động đề xuất; dạng 2
vi phạm nguyên tắc không bịa nội dung — "marketplace", "thanh toán qua thẻ/ví", "real-time" đều
là chi tiết user chưa từng nói, không phải suy luận hợp lý từ "web bán hàng online thôi".

## Tình huống 4 — MoSCoW cho từng nhu cầu

> **User:** *(đã kể xong 2 nhu cầu: "xem danh sách task của cả team" và "nhận thông báo khi có
> task mới giao cho mình")*

**ĐÚNG** (hỏi tường minh riêng cho từng nhu cầu, không suy đoán từ giọng văn):

> **Agent:** Về 2 nhu cầu này, mức ưu tiên (MoSCoW) của từng cái là gì — Must have / Should have
> / Could have / Won't have? Ví dụ "xem danh sách task" so với "nhận thông báo", cái nào bắt
> buộc phải có ngay từ bản đầu tiên?

**SAI** (tự gán mức ưu tiên vì "nghe có vẻ" quan trọng hơn):

> **Agent:** *(tự ghi vào UR-001)* "Xem danh sách task của cả team" — Must have. "Nhận thông báo
> khi có task mới" — Should have.

Vì sao SAI: MoSCoW là field bắt buộc phải hỏi tường minh (xem `SKILL.md`) — không thể suy ra
mức ưu tiên chỉ từ cách user diễn đạt hay thứ tự họ kể, kể cả khi có vẻ hợp lý.
