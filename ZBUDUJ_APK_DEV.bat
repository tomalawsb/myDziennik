@echo off
setlocal
cd /d "%~dp0"
call gradlew.bat :composeApp:assembleDevDebug
if errorlevel 1 exit /b 1
endlocal
