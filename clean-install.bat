@echo off
setlocal

echo.
echo ==== Force clean install ====
echo.

echo Stopping any running Node processes...
taskkill /F /IM node.exe >nul 2>&1
taskkill /F /IM esbuild.exe >nul 2>&1

echo Deleting old node_modules, please wait...
if exist node_modules mkdir __empty__ >nul 2>&1
if exist node_modules robocopy __empty__ node_modules /MIR >nul 2>&1
if exist node_modules rmdir /s /q node_modules >nul 2>&1
if exist __empty__ rmdir /s /q __empty__ >nul 2>&1
if exist package-lock.json del /f /q package-lock.json >nul 2>&1

echo Clearing npm cache...
call npm cache clean --force >nul 2>&1

echo.
echo Installing dependencies. This takes a few minutes. Do not close this window.
echo.
call npm install
if errorlevel 1 goto failed

echo.
echo [OK] Install complete. Starting the app...
echo Open the http://localhost:5173 link in your browser.
echo Press Ctrl + C here to stop.
echo.
call npm run dev
goto end

:failed
echo.
echo [X] Install still failed.
echo   1. Add C:\dev as a Windows Defender exclusion.
echo   2. Restart the PC, then run this file again BEFORE opening VS Code.
echo   See WINDOWS-FIX.txt for details.
echo.

:end
pause
