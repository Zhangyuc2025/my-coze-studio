#!/bin/bash
set -e

echo "🚀 开始设置GitHub仓库同步分支..."

# 清理旧的推送进程
pkill -f "git push" 2>/dev/null || true

# 1. 设置upstream-sync分支
echo "📋 设置upstream-sync分支..."
if ! git show-ref --verify --quiet refs/heads/upstream-sync; then
    git checkout -b upstream-sync upstream/main
    git branch --set-upstream-to=upstream/main upstream-sync
else
    echo "⚠️  upstream-sync分支已存在，跳过创建..."
    git checkout upstream-sync
    git reset --hard upstream/main
fi

# 2. 推送main分支（简化版）
echo "📤 推送main分支到origin..."
git checkout main
git push origin main --no-progress 2>&1 | tee push-main.log &
PUSH_MAIN_PID=$!

# 等待推送完成
wait $PUSH_MAIN_PID
echo "✅ main分支推送完成"

# 3. 推送upstream-sync分支
echo "📤 推送upstream-sync分支到origin..."
git checkout upstream-sync
git push origin upstream-sync --no-progress 2>&1 | tee push-sync.log &
PUSH_SYNC_PID=$!

# 等待推送完成
wait $PUSH_SYNC_PID
echo "✅ upstream-sync分支推送完成"

# 4. 切回main分支
git checkout main

# 5. 创建示例开发分支
echo "🌿 创建示例开发分支..."
read -p "输入你要创建的分支名 (例如: feature/my-feature): " FEATURE_BRANCH
if [ ! -z "$FEATURE_BRANCH" ]; then
    git checkout -b "$FEATURE_BRANCH"
    git push origin "$FEATURE_BRANCH"
    echo "✅ 开发分支 '$FEATURE_BRANCH' 已创建"
fi

echo ""
echo "🎉 设置完成！"
echo ""
echo "📊 分支结构："
echo "  - main: 你的主分支"
echo "  - upstream-sync: 自动同步原项目的分支"
echo "  - feature/*: 基于upstream-sync的开发分支"
echo ""
echo "🔄 同步命令："
echo "  git checkout upstream-sync"
echo "  git fetch upstream"
echo "  git reset --hard upstream/main"
echo "  git push -f origin upstream-sync"
echo "  git checkout your-feature-branch"
echo "  git merge upstream-sync"
echo ""
echo "📦 仓库地址："
git remote get-url origin