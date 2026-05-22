@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo ========================================
echo   报告同步工具
echo ========================================
echo.

:: Stage everything in reports/ (catches new + modified files)
git add reports/

:: Check if anything was staged
git diff --cached --quiet
if %errorlevel% equ 0 (
    echo [=] 没有新的报告文件，无需同步
    echo.
    pause
    exit /b 0
)

:: Show what will be pushed
echo.
echo [v] 检测到以下新文件/变更:
echo.
git diff --cached --name-status
echo.

:: Commit
git commit -m "Sync reports"

:: Push
echo [v] 正在推送到 GitHub...
git push

if %errorlevel% equ 0 (
    echo.
    echo [=] 同步成功！
    echo     刷新网页 https://dingfeinan.github.io/trend-report/
    echo     然后点击右上角"获取最新信息"即可看到新报告。
) else (
    echo.
    echo [X] 推送失败，请检查网络连接后重试
)
echo.
pause
