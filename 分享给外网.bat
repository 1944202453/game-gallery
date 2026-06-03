@echo off
chcp 65001 >nul 2>&1
cd /d "%~dp0"
title Gallery Share

echo.
echo ================================================
echo   Gallery - Public Share Link Generator
echo ================================================
echo.

:: Kill old server on port 3000
for /f "tokens=5" %%a in ('netstat -ano ^| findstr :3000 ^| findstr LISTENING') do (
    taskkill /F /PID %%a >nul 2>&1
)

:: Start local HTTP server
echo Step 1/3: Starting local server...
start "GalleryServer" /MIN cmd /c "npx --yes serve . -p 3000 --no-clipboard"
timeout /t 5 /nobreak >nul
echo           Server is ready.

:: Show LAN address
echo Step 2/3: Local network address:
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4"') do (
    set IP=%%a
    goto :gotip
)
:gotip
set IP=%IP:~1%
echo           http://%IP%:3000/gallery.html

:: Create public tunnel
echo Step 3/3: Creating public link...
echo.
echo ================================================
echo.
echo   Copy this link and send to your friend:
echo.

npx --yes localtunnel --port 3000 2>&1 | findstr "your url"

echo.
echo   The link looks like: https://xxxx.loca.lt
echo.
echo   NOTE: When friend opens it first time,
echo   they need to click "Click to Continue"
echo   and enter the IP shown on that page.
echo   (Just copy & paste, one-time only)
echo.
echo ================================================
echo.
echo   Close this window = link stops working.
echo   Next time just double-click this file again.
echo.
pause
