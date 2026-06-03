@echo off
chcp 65001 >nul 2>&1
cd /d "%~dp0"

:: Add Git to PATH
set "PATH=%PATH%;C:\Program Files\Git\bin;C:\Program Files\Git\cmd"

echo.
echo ================================================
echo   Push to GitHub
echo ================================================
echo.
echo Paste your GitHub token below (starts with ghp_)
echo Then press Enter.
echo.
echo To paste: right-click in this window
echo.

set /p TOKEN="Token: "

echo.
echo Pushing...
echo.

:: Remove old remote if exists
git remote remove origin 2>nul

:: Set remote with token
git remote add origin https://1944202453:%TOKEN%@github.com/1944202453/game-gallery.git

:: Push
git push -u origin main

echo.
echo ================================================
echo   If you see no error above, SUCCESS!
echo ================================================
echo.
echo Now go to this URL to enable Pages:
echo https://github.com/1944202453/game-gallery/settings/pages
echo.
echo Click "Branch" dropdown - select "main" - Save
echo.
echo Your gallery will be at:
echo https://1944202453.github.io/game-gallery/
echo.
pause
