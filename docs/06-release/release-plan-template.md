---
id: REL-vX.Y.Z
type: release_plan
status: planned        # planned | in-progress | blocked | released
release_date: YYYY-MM-DD
sprint: []
git_branch: release/vX.Y.Z
blocked_by_open_questions: []
---

# Release vX.Y.Z

## Phạm vi release (theo Gitflow: cắt từ `develop`)
| Epic/Feature/Story | Trạng thái | Ghi chú |
|---|---|---|

## Checklist theo Gitflow
- [ ] Cắt `release/vX.Y.Z` từ `develop`
- [ ] Chỉ fix bug / chuẩn bị release trên branch này (không thêm feature mới)
- [ ] Version bump + cập nhật CHANGELOG
- [ ] Merge vào `main`, tag `vX.Y.Z`
- [ ] Merge ngược vào `develop`
- [ ] Xoá branch `release/vX.Y.Z`
- [ ] Đóng các Task/Story liên quan (external_ref → Done trên GitHub/Jira)

## Rollback plan (nếu cần hotfix)
- Nhánh `hotfix/*` cắt từ `main`, merge vào cả `main` và `develop` sau khi fix.
