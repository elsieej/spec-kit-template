# skills/spec-kit

Nguồn duy nhất (source of truth) cho 4 skill của kit này — `setup-context`, `c4-model`,
`plan-backlog`, `backlog-status`. Theo đúng convention `skills/<category>/<name>/SKILL.md` mà
CLI [vercel-labs/skills](https://github.com/vercel-labs/skills) (công cụ mattpocock/skills cũng
dùng) và hệ sinh thái xung quanh nó nhận diện — agent-agnostic, không riêng Claude Code.

## Cài đặt

```bash
npx skills add <owner>/spec-kit-template
```

CLI sẽ đọc skill từ đây, cho chọn skill nào cần, rồi cài vào đúng thư mục skill của coding agent
đang dùng (`.claude/skills/` nếu là Claude Code, hoặc thư mục tương ứng của agent khác).

**`npx skills add` một mình là đủ để chạy pipeline.** Mỗi skill mang theo sẵn template cần thiết
(thư mục `templates/` cạnh chính `SKILL.md` của nó — BR/UR/FR/glossary/OQ trong
`setup-context`, 5 template C4/Interface Contract trong `c4-model`, Epic/Feature/US/OQ trong
`plan-backlog`) và tự tạo `docs/<tầng>/` + copy đúng template vào khi dự án chưa có, thay vì tự
bịa cấu trúc (xem mục "Điều kiện tiên quyết" ở đầu mỗi `SKILL.md`).

`CLAUDE.md`, `AGENTS.md`, `RULES.md`, `CONTEXT.md` không đi kèm skill — quy tắc cốt lõi của
chúng đã được nhắc lại trực tiếp trong từng `SKILL.md`, nên không bắt buộc phải có mới chạy
được. Muốn có bản đầy đủ của các file này (ví dụ để đọc trực tiếp thay vì chỉ dựa vào phần được
nhắc lại, hoặc cần bảng vòng đời `status` đầy đủ, quy tắc glossary-link chi tiết ở `RULES.md`
mục 2), sinh scaffold bằng [degit](https://github.com/Rich-Harris/degit) (không kèm lịch sử
git, không cần tự `clone` rồi xoá `.git`):

```bash
npx degit <owner>/spec-kit-template .
```

Chạy trong 1 thư mục trống (dự án hoàn toàn mới). Với dự án đã có sẵn file, `degit` từ chối
chạy trừ khi thêm `--force` — cờ này **ghi đè mọi file trùng tên** (kể cả `README.md` của chính
dự án, nếu có), không hỏi lại; xem trước file nào sẽ trùng trước khi thêm `--force`, hoặc chạy
vào 1 thư mục con rồi tự merge `CLAUDE.md`/`AGENTS.md`/`RULES.md`/`CONTEXT.md` sang. Bước này là
tuỳ chọn — không bắt buộc để chạy được pipeline.

## Cập nhật

Khi repo này có bản cập nhật, ở dự án đã cài, chạy:

```bash
npx skills update
```

(hoặc `npx skills update -y` để bỏ qua câu hỏi phạm vi project/global). CLI tự nhớ nguồn +
đường dẫn của từng skill đã cài (`skills-lock.json`), so hash nội dung mới nhất từ repo này và
ghi đè skill nào đổi — không cần chạy lại `add` hay chỉ định lại `<owner>/spec-kit-template`.
Có thể cập nhật riêng lẻ: `npx skills update c4-model plan-backlog`.
