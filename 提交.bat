@echo off
setlocal enabledelayedexpansion

:: ==================== 配置区域（请修改以下变量） ====================
set REPO_URL=https://github.com/用户名/仓库名.git
:: 如果使用 SSH，请改为 git@github.com:用户名/仓库名.git

set BRANCH=main
:: 如果仓库默认分支为 master，请改为 master

set COMMIT_MSG=自动提交 %date% %time%
:: 可自定义提交信息
:: ===================================================================

:: 检查 Git 是否可用
where git >nul 2>&1
if errorlevel 1 (
    echo 错误：未找到 Git，请先安装 Git for Windows。
    pause
    exit /b 1
)

:: 初始化 Git 仓库（如果尚未初始化）
if not exist ".git" (
    echo 初始化 Git 仓库...
    git init
    if errorlevel 1 (
        echo 初始化失败，请检查目录权限。
        pause
        exit /b 1
    )
)

:: 检查远程仓库是否已配置
git remote get-url origin >nul 2>&1
if errorlevel 1 (
    echo 添加远程仓库...
    git remote add origin %REPO_URL%
    if errorlevel 1 (
        echo 添加远程仓库失败，请检查 REPO_URL 是否正确。
        pause
        exit /b 1
    )
)

:: 添加所有文件到暂存区
echo 添加文件到暂存区...
git add .
if errorlevel 1 (
    echo 添加文件失败。
    pause
    exit /b 1
)

:: 提交更改
echo 提交更改...
git commit -m "%COMMIT_MSG%"
if errorlevel 1 (
    echo 提交失败（可能没有需要提交的更改），跳过提交。
    :: 不退出，继续推送
)

:: 推送到远程仓库
echo 推送到远程仓库 %BRANCH% 分支...
git push -u origin %BRANCH%
if errorlevel 1 (
    echo 推送失败，请检查网络、凭据或分支名称。
    pause
    exit /b 1
)

echo 上传成功！
pause