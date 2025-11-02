#!/bin/bash
set -e

echo "🔄 开始同步上游更新..."
echo ""

# 切换到同步分支
echo "📋 切换到upstream-sync分支..."
git checkout upstream-sync

# 获取最新更新
echo "⬇️  获取上游更新..."
git fetch upstream

# 检查是否有新提交
UPSTREAM_COMMIT=$(git rev-parse upstream/main)
LOCAL_COMMIT=$(git rev-parse HEAD)

if [ "$UPSTREAM_COMMIT" = "$LOCAL_COMMIT" ]; then
    echo "✅ 没有新更新，当前分支已是最新"
else
    echo "📦 发现新更新，开始同步..."

    # 硬重置到上游最新
    git reset --hard upstream/main

    # 强制推送到你的远程仓库
    echo "📤 推送到origin..."
    git push -f origin upstream-sync

    echo "✅ 同步完成！"
    echo ""
    echo "🔀 接下来你可以合并到你的开发分支："
    echo "   git checkout your-feature-branch"
    echo "   git merge upstream-sync"
fi

# 显示当前状态
echo ""
echo "📊 当前分支状态："
git log --oneline -5

# 显示远程信息
echo ""
echo "📦 仓库地址："
git remote get-url origin