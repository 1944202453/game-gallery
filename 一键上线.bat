@echo off
chcp 65001 >nul 2>&1
cd /d "%~dp0"
set "PATH=%PATH%;C:\Program Files\Git\bin;C:\Program Files\Git\cmd"

echo.
echo ================================================
echo   Deploy to GitHub Pages
echo ================================================
echo.
echo Paste your new GitHub token and press Enter
echo.

set /p TOKEN="Token: "

echo.
echo [1/2] Committing...
git add -A
git commit -m "Game gallery" 2>nul
echo        Done.

echo [2/2] Pushing to GitHub...
git remote remove origin 2>nul
git remote add origin https://1944202453:%TOKEN%@github.com/1944202453/game-gallery.git
git branch -M main
git push -u origin main --force 2>&1

if errorlevel 1 (
    echo.
    echo ================================================
    echo   FAILED - Check token and try again
    echo ================================================
    pause
    exit
)

echo.
echo ================================================
echo   SUCCESS!
echo.
echo   Enable Pages:
echo   https://github.com/1944202453/game-gallery/settings/pages
echo.
echo   Branch: main -> Save
echo.
echo   Your link:
echo   https://1944202453.github.io/game-gallery/
echo ================================================
pause
