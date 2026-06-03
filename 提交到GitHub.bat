@echo off
chcp 65001 >nul 2>&1
cd /d "%~dp0"

:: Add Git to PATH
set "PATH=%PATH%;C:\Program Files\Git\bin;C:\Program Files\Git\cmd"

echo.
echo ================================================
echo   Step 1: Git Commit
echo ================================================
echo.

git add .
git commit -m "Game gallery - first version"

echo.
echo ================================================
echo   Done! Close this window.
echo ================================================
pause
