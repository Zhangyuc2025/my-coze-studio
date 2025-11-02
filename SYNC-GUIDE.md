# Coze Studio Fork 同步指南

## 📦 仓库信息

你的GitHub仓库：https://github.com/Zhangyuc2025/my-coze-studio.git

原始仓库：https://github.com/coze-dev/coze-studio.git

## 🤖 自动同步 (GitHub Actions)

### ✅ 已配置的自动化

你的仓库已配置GitHub Actions实现**云端自动同步**：

1. **sync-upstream.yml** - 基础自动同步
   - 每天UTC 0点（北京时间8点）自动运行
   - 检测到上游更新时自动同步到upstream-sync分支
   - 可手动触发强制同步

2. **sync-with-pr.yml** - 带PR的自动同步
   - 每天自动运行
   - 同步后自动创建Pull Request审核变更
   - 适合需要代码审查的场景

### 🔍 查看工作流状态

访问：https://github.com/Zhangyuc2025/my-coze-studio/actions

### ⚡ 手动触发同步

在GitHub Actions页面选择工作流 → 点击 "Run workflow"

### 🎯 优势

- ✅ **完全自动化** - 无需手动运行脚本
- ✅ **每天更新** - 定时同步上游最新代码
- ✅ **即时通知** - 同步完成后可在Actions查看日志
- ✅ **可追溯** - 每次同步都有详细记录和日志
- ✅ **标签标记** - 同步后自动创建标签便于追踪

### 🔄 本地同步 vs 云端自动同步

| 方式 | 触发条件 | 优点 | 适用场景 |
|------|----------|------|----------|
| **GitHub Actions** | 每天自动/手动触发 | 全自动、云端运行 | 日常维护、持续集成 |
| **本地脚本** | 手动运行 | 灵活控制、即时同步 | 开发时需要立即更新 |

**推荐**：GitHub Actions负责日常自动同步，本地脚本作为备用方案。

## 🌿 分支结构

### 本地分支
- **main**: 你的主分支，与上游同步
- **upstream-sync**: 专门用于自动同步原项目的分支
- **feature/\***: 基于upstream-sync的各种开发分支

### 远程分支
- **origin/main**: 你的主分支
- **origin/upstream-sync**: 你的同步分支
- **origin/feature/***: 你的开发分支
- **upstream/main**: 原项目的主分支

## 🔄 日常开发工作流

### 1. 同步上游更新

当原项目有更新时，执行：
```bash
./sync-upstream.sh
```

这个脚本会：
- 检查上游是否有新更新
- 自动同步到upstream-sync分支
- 推送到你的远程仓库

### 2. 创建新功能分支

```bash
# 基于upstream-sync创建新分支
git checkout upstream-sync
git checkout -b feature/your-feature-name

# 推送到远程
git push origin feature/your-feature-name
```

### 3. 开发功能

```bash
# 在你的功能分支上开发
git add .
git commit -m "feat: your feature"
git push origin feature/your-feature-name
```

### 4. 合并上游更新到功能分支

```bash
# 切换到功能分支
git checkout feature/your-feature-name

# 合并upstream-sync的更新
git merge upstream-sync

# 解决冲突（如果有）
git add .
git commit -m "resolve merge conflicts"

# 推送更新
git push origin feature/your-feature-name
```

## 🔧 手动同步命令

如果你想手动同步：

```bash
# 1. 切换到同步分支
git checkout upstream-sync

# 2. 获取上游更新
git fetch upstream

# 3. 硬重置到上游最新
git reset --hard upstream/main

# 4. 强制推送到你的远程
git push -f origin upstream-sync

# 5. 合并到你的开发分支
git checkout your-feature-branch
git merge upstream-sync
```

## 📋 常见操作

### 查看分支状态
```bash
git branch -a
```

### 查看远程信息
```bash
git remote -v
```

### 查看上游更新
```bash
git log upstream/main --oneline -10
```

### 切换分支
```bash
git checkout branch-name
```

## ⚠️ 注意事项

1. **upstream-sync分支是同步专用分支，请勿直接在此分支上开发**
2. **开发请基于upstream-sync创建新分支**
3. **同步时会强制推送，可能覆盖upstream-sync上的本地更改**
4. **合并上游更新前，请确保你的工作已提交**

## 🆘 遇到问题？

### 同步失败
```bash
# 强制重新同步
git checkout upstream-sync
git fetch upstream
git reset --hard upstream/main
git push -f origin upstream-sync
```

### 恢复误删的分支
```bash
# 查看所有分支（包括已删除的）
git reflog

# 恢复分支
git checkout -b branch-name commit-hash
```

### 重置到上游最新
```bash
git fetch upstream
git reset --hard upstream/main
git push -f origin main
```

## 📝 脚本和文件说明

### 本地脚本
- **setup-sync.sh**: 初始设置脚本（已执行，可重复使用）
- **sync-upstream.sh**: 日常手动同步脚本（备用方案）

### GitHub Actions工作流
- **.github/workflows/sync-upstream.yml**: 基础自动同步
  - 每天UTC 0点自动运行
  - 检测到上游更新时自动同步到upstream-sync分支
  - 强制推送更新并创建标签

- **.github/workflows/sync-with-pr.yml**: 带PR的自动同步
  - 每天自动运行
  - 同步后自动创建Pull Request
  - 适合需要代码审查的团队

### 文档
- **SYNC-GUIDE.md**: 本使用指南
- **SYNC-GUIDE.md**: 详细操作文档

## 🎯 推荐工作流

### 云端自动同步模式（推荐）

1. **GitHub Actions自动同步**：每天UTC 0点自动运行，无需手动操作
   - 查看同步状态：https://github.com/Zhangyuc2025/my-coze-studio/actions
   - 手动触发：在Actions页面点击 "Run workflow"

2. **开发新功能**：
   ```bash
   git checkout upstream-sync
   git checkout -b feature/your-feature
   git push origin feature/your-feature
   ```

3. **定期合并更新**：
   ```bash
   git checkout feature/your-feature
   git merge upstream-sync
   # 解决冲突后提交
   git push origin feature/your-feature
   ```

### 手动同步模式（备用）

如果需要立即同步或GitHub Actions未运行时：

1. **手动同步**：`./sync-upstream.sh`
2. **开发新功能**：同上
3. **合并更新**：同上

---

🚀 享受你的开发之旅！