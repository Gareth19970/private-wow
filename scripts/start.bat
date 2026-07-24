@echo off
REM ============================================
REM  Start AzerothCore Servers
REM ============================================
echo.
echo  Starting AzerothCore servers...
echo.

REM Check if configs exist
if not exist "..\configs\authserver.conf" (
    echo [ERROR] configs\authserver.conf not found!
    echo Please run setup.bat first
    pause
    exit /b 1
)

REM Start auth server
echo  Starting Auth Server...
start "" "..\build\authserver.exe" -c "..\configs\authserver.conf"

REM Wait for auth server to initialize
timeout /t 3 /nobreak >nul

REM Start world server
echo  Starting World Server...
start "" "..\build\worldserver.exe" -c "..\configs\worldserver.conf"

echo.
echo  Servers started! You can close this window.
echo  Auth Server: port 3724
echo  World Server: port 8085
echo.
echo  To stop servers: run stop.bat
echo.
pause
