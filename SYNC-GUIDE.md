# Coze Studio Fork 同步指南

## 📦 仓库信息

你的GitHub仓库：https://github.com/Zhangyuc2025/my-coze-studio.git

原始仓库：https://github.com/coze-dev/coze-studio.git

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

## 📝 脚本说明

- **setup-sync.sh**: 初始设置脚本（已执行）
- **sync-upstream.sh**: 日常同步脚本

## 🎯 推荐工作流

1. **每天开始工作前**：运行 `./sync-upstream.sh` 同步最新代码
2. **开发新功能**：创建新的feature分支
3. **定期同步**：每天或每周将upstream-sync合并到你的功能分支
4. **提交代码**：在功能分支上提交和推送

---

🚀 享受你的开发之旅！