@echo off
REM ============================================================
REM  MathTrainer - clean install helper for Windows
REM  Double-click this file, or run it from the terminal.
REM ============================================================

echo.
echo ==== MathTrainer setup ====
echo.

REM Show Node + npm versions
node -v >nul 2>&1
if errorlevel 1 (
  echo [X] Node.js is not installed.
  echo     Download the LTS version from https://nodejs.org then run this again.
  echo.
  pause
  exit /b 1
)

echo Node version:
node -v
echo npm version:
call npm -v
echo.

echo Cleaning old install (this is safe)...
if exist node_modules (
  rmdir /s /q node_modules
)
if exist package-lock.json (
  del /f /q package-lock.json
)

echo Clearing npm cache...
call npm cache clean --force

echo.
echo Installing dependencies (this can take a few minutes)...
call npm install
if errorlevel 1 (
  echo.
  echo [X] Install failed. Please read WINDOWS-FIX.txt for the most common cause
  echo     (folder must NOT be in Downloads/OneDrive and must have no spaces).
  echo.
  pause
  exit /b 1
)

echo.
echo [OK] Done! Starting the app...
echo     When it is ready, open the http://localhost:5173 link in your browser.
echo     Press Ctrl + C in this window to stop the app.
echo.
call npm run dev
pause
