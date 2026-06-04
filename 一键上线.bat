@echo off
cd /d "%~dp0"

echo ================================================
echo   GitHub Push Tool
echo ================================================
echo.
echo Paste your GitHub token below and press Enter:
echo.

set /p TOKEN="Token: "

echo.
echo Working...

set "PATH=%PATH%;C:\Program Files\Git\bin;C:\Program Files\Git\cmd"

git add -A
git commit -m "Update"
git remote remove origin 2>nul
git remote add origin https://1944202453:%TOKEN%@github.com/1944202453/game-gallery.git
git branch -M main
git push -u origin main --force

echo.
echo ================================================
echo   If no error above - SUCCESS!
echo.
echo   Exam page:
echo   https://1944202453.github.io/game-gallery/考试复习.html
echo ================================================
pause
