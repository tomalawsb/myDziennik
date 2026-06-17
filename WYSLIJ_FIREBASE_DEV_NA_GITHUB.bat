@echo off
setlocal
cd /d "%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0upload_firebase_dev_to_github.ps1"
if errorlevel 1 exit /b 1
endlocal
