# Coze Studio Fork 同步指南

## 📦 仓库信息

你的GitHub仓库：https://github.com/Zhangyuc2025/my-coze-studio.git

原始仓库：https://github.com/coze-dev/coze-studio.git

## 🌿 简化的分支结构

### 仅需2个分支！

#### 1. **upstream-sync** - 同步专用分支
```
├── 跟踪：upstream/main
├── 推送：origin/upstream-sync
├── 作用：专门同步原项目代码
├── 更新：GitHub Actions自动维护（每天UTC 0点）
└── ⚠️ 勿直接在此分支开发
```

#### 2. **main** - 开发分支
```
├── 基础：upstream-sync
├── 推送：origin/main
├── 包含：上游代码 + 你的开发代码
├── 作用：所有开发工作
└── ✅ 在此分支开发或创建feature分支
```

## 🤖 自动同步机制

### GitHub Actions 工作流

**sync-upstream.yml** - 自动同步
- 每天UTC 0点（北京时间8点）自动运行
- 从 `upstream/main` 同步到 `upstream-sync` 分支
- 自动推送到 `origin/upstream-sync`
- 可手动触发：https://github.com/Zhangyuc2025/my-coze-studio/actions

### 同步流程

```
原项目 (upstream/main)
      ↓ GitHub Actions 自动
upstream-sync 分支
      ↓ 手动合并
main 分支
      ↓ 推送
origin/main
```

## 🔄 开发工作流

### 日常开发（推荐）

```bash
# 1. 开发前先同步上游
# GitHub Actions已自动完成，或手动触发同步

# 2. 在main分支开发
git checkout main
git pull origin main

# 3. 开发你的功能
git add .
git commit -m "feat: your feature"
git push origin main

# 4. 或创建feature分支开发
git checkout -b feature/new-feature
git push origin feature/new-feature
```

### 手动合并上游更新（当需要时）

```bash
# 1. 确保upstream-sync是最新的（GitHub Actions已处理）
# 或手动同步：
git fetch upstream
git checkout upstream-sync
git reset --hard upstream/main
git push -f origin upstream-sync

# 2. 合并到main分支
git checkout main
git merge upstream-sync

# 3. 解决冲突（如果有）
git add .
git commit -m "resolve merge conflicts"
git push origin main
```

## 📋 常见操作

### 查看分支状态
```bash
git branch -vv
```

### 查看分支差异
```bash
# 查看main比upstream-sync多哪些提交
git log upstream-sync..main --oneline

# 查看上游最新提交
git log upstream/main --oneline -5
```

### 创建新功能分支
```bash
# 基于main创建
git checkout main
git checkout -b feature/your-feature
git push origin feature/your-feature
```

### 删除分支
```bash
# 删除本地分支
git branch -D feature/branch-name

# 删除远程分支
git push origin --delete feature/branch-name
```

## ⚠️ 重要提醒

1. **upstream-sync是只读同步分支**
   - 不要在此分支上开发或提交
   - GitHub Actions会强制推送覆盖

2. **main分支是开发分支**
   - 所有开发工作在main或基于main的分支上进行
   - main包含上游代码 + 你的开发代码

3. **同步策略**
   - GitHub Actions自动维护upstream-sync与上游同步
   - 你手动决定何时将upstream-sync合并到main
   - 建议定期（每周或每月）合并一次

## 🎯 推荐节奏

1. **每天**：GitHub Actions自动同步上游到upstream-sync
2. **每周**：检查upstream-sync的更新，考虑合并到main
3. **开发时**：在main分支直接开发，或创建feature分支
4. **发布前**：确保main分支包含最新上游代码

## 🔍 查看同步状态

- **GitHub Actions**: https://github.com/Zhangyuc2025/my-coze-studio/actions
- **upstream-sync分支**: https://github.com/Zhangyuc2025/my-coze-studio/tree/upstream-sync
- **对比上游变更**: https://github.com/Zhangyuc2025/my-coze-studio/compare/upstream-sync...main

## 🆘 遇到问题？

### 强制重新同步upstream-sync
```bash
git checkout upstream-sync
git fetch upstream
git reset --hard upstream/main
git push -f origin upstream-sync
```

### 重置main分支到upstream-sync
```bash
git checkout main
git reset --hard upstream-sync
git push -f origin main
```

### 查看详细日志
```bash
# 查看GitHub Actions运行日志
# 访问：https://github.com/Zhangyuc2025/my-coze-studio/actions
```

---

**🎉 简单、高效、自动化！**