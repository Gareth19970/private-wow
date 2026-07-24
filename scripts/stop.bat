@echo off
REM ============================================
REM  Stop AzerothCore Servers
REM ============================================
echo.
echo  Stopping AzerothCore servers...
echo.

taskkill /F /IM worldserver.exe 2>nul
taskkill /F /IM authserver.exe 2>nul

echo  Servers stopped.
echo.
pause
