# skills/spec-kit

Nguồn duy nhất (source of truth) cho 5 skill của kit này — `about-spec-kit`, `setup-context`,
`c4-model`, `plan-backlog`, `list-backlog`. Theo đúng convention
`skills/<category>/<name>/SKILL.md` mà
CLI [vercel-labs/skills](https://github.com/vercel-labs/skills) (công cụ mattpocock/skills cũng
dùng) và hệ sinh thái xung quanh nó nhận diện — agent-agnostic, không riêng Claude Code.

## Cài đặt

```bash
npx skills add <owner>/spec-kit-template
```

CLI sẽ đọc skill từ đây, cho chọn skill nào cần, rồi cài vào đúng thư mục skill của coding agent
đang dùng (`.claude/skills/` nếu là Claude Code, hoặc thư mục tương ứng của agent khác).

**`npx skills add` một mình là đủ để chạy pipeline, kể cả cài lẻ 1 skill.** Mỗi skill mang theo
template cần thiết (thư mục `templates/` cạnh chính `SKILL.md` của nó — BR/UR/FR/glossary/OQ/MEET
trong `setup-context`, 5 template C4/Interface Contract trong `c4-model`, Epic/Feature/US/OQ/MEET
trong `plan-backlog`, và `spec-kit-conventions.md` — quy tắc cốt lõi xuyên suốt kit: bảng
prefix/ID, vòng đời `status`, glossary-link, ma trận lan truyền thay đổi... — trong cả 5 skill)
và tự tạo `docs/<tầng>/` + copy đúng template vào khi dự án chưa có, thay vì tự bịa cấu trúc (xem
mục "Điều kiện tiên quyết" ở đầu mỗi `SKILL.md`). `spec-kit-conventions.md` chỉ scaffold thành
**1 bản duy nhất** tại `docs/spec-kit-conventions.md` của dự án đích dù bundle sẵn ở cả 5 skill —
không phải 5 bản trùng lặp.

## Cập nhật

Khi repo này có bản cập nhật, ở dự án đã cài, chạy:

```bash
npx skills update
```

(hoặc `npx skills update -y` để bỏ qua câu hỏi phạm vi project/global). CLI tự nhớ nguồn +
đường dẫn của từng skill đã cài (`skills-lock.json`), so hash nội dung mới nhất từ repo này và
ghi đè skill nào đổi — không cần chạy lại `add` hay chỉ định lại `<owner>/spec-kit-template`.
Có thể cập nhật riêng lẻ: `npx skills update c4-model plan-backlog`.
