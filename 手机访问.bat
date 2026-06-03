@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo.
echo ════════════════════════════════════════════════
echo    📱 手机访问游戏相册
echo ════════════════════════════════════════════════
echo.

REM 获取本机局域网 IP
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4"') do (
    set IP=%%a
    goto :found
)
:found
set IP=%IP:~1%

echo    电脑 IP 地址: %IP%
echo.
echo    手机访问地址：
echo.
echo    🔗  http://%IP%:3000/gallery.html
echo.
echo ════════════════════════════════════════════════
echo    ⚠️  确保手机和电脑连的是同一个 WiFi
echo    按 Ctrl+C 可以关闭服务器
echo ════════════════════════════════════════════════
echo.
echo 正在启动服务器...

npx --yes serve . -p 3000 --no-clipboard

pause
