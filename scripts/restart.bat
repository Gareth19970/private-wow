@echo off
REM ============================================
REM  Restart AzerothCore Servers
REM ============================================
echo.
echo  Stopping servers...
echo.

taskkill /F /IM worldserver.exe 2>nul
taskkill /F /IM authserver.exe 2>nul

echo  Waiting for ports to free...
timeout /t 3 /nobreak >nul

echo  Starting servers...
echo.

REM Start auth server
echo  Starting Auth Server...
start "" "..\build\authserver.exe" -c "..\configs\authserver.conf"

REM Wait for auth server
timeout /t 3 /nobreak >nul

REM Start world server
echo  Starting World Server...
start "" "..\build\worldserver.exe" -c "..\configs\worldserver.conf"

echo.
echo  Servers restarted!
echo.
pause
