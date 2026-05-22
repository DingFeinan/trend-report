@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo ========================================
echo   报告同步工具
echo ========================================
echo.

:: Check for changes in reports/
git diff --quiet reports/ && git diff --cached --quiet reports/
if %errorlevel% equ 0 (
    echo [✓] reports 目录没有新文件，无需同步
    echo.
    pause
    exit /b 0
)

:: Show what's new
echo [→] 检测到以下新增/变更:
echo.
git status reports/ --short
echo.

:: Stage all reports
git add reports/

:: Commit with timestamp
for /f "tokens=1-6 delims=/. " %%a in ('echo %date% %time%') do (
    set ts=%%a-%%b-%%c_%%d:%%e:%%f
)
git commit -m "Sync reports - %ts%"

:: Push
echo.
echo [→] 正在推送到 GitHub...
git push

echo.
echo [✓] 同步完成！刷新网页后点击"获取最新信息"即可看到新报告。
echo.
pause
