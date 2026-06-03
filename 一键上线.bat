@echo off
chcp 65001 >nul 2>&1
cd /d "%~dp0"

:: Add Git to PATH
set "PATH=%PATH%;C:\Program Files\Git\bin;C:\Program Files\Git\cmd"

echo.
echo ================================================
echo   One-Click Deploy to GitHub Pages
echo ================================================
echo.
echo Paste your GitHub token and press Enter
echo.

set /p TOKEN="Token: "

echo.
echo [1/4] Cleaning large file from history...
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch 游戏相册.zip" --prune-empty -- --all 2>nul
echo        Done.

echo.
echo [2/4] Adding files...
git add -A
git commit -m "Game gallery" 2>nul
echo        Done.

echo.
echo [3/4] Pushing to GitHub (may take 1-2 min)...
git remote remove origin 2>nul
git remote add origin https://1944202453:%TOKEN%@github.com/1944202453/game-gallery.git
git branch -M main
git push -u origin main --force 2>&1

if errorlevel 1 (
    echo.
    echo ================================================
    echo   PUSH FAILED
    echo ================================================
    pause
    exit
)

echo.
echo [4/4] ============ SUCCESS! ============
echo.
echo Open: https://github.com/1944202453/game-gallery/settings/pages
echo.
echo Under Branch: select "main" - Save
echo.
echo YOUR LINK: https://1944202453.github.io/game-gallery/
echo ==========================================
pause
