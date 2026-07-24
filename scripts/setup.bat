@echo off
REM ============================================
REM  AzerothCore Private Server - Initial Setup
REM ============================================
echo.
echo  ========================================
echo   AzerothCore Private Server Setup
echo  ========================================
echo.

REM Check for MySQL
where mysql >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] MySQL not found in PATH
    echo Please install MySQL 8.0 and add it to PATH
    echo Download: https://dev.mysql.com/downloads/mysql/
    pause
    exit /b 1
)

REM Get MySQL password
set /p MYSQL_PASS="Enter MySQL root password: "

echo.
echo Creating databases...
mysql -u root -p%MYSQL_PASS% -e "CREATE DATABASE IF NOT EXISTS acore_auth;"
mysql -u root -p%MYSQL_PASS% -e "CREATE DATABASE IF NOT EXISTS acore_world;"
mysql -u root -p%MYSQL_PASS% -e "CREATE DATABASE IF NOT EXISTS acore_characters;"
mysql -u root -p%MYSQL_PASS% -e "CREATE DATABASE IF NOT EXISTS acore_playerbots;"

echo.
echo Importing SQL files...
echo (This may take 5-10 minutes)

REM Import auth database
if exist "sql\auth\base\auth.sql" (
    mysql -u root -p%MYSQL_PASS% acore_auth < "sql\auth\base\auth.sql"
    echo   - Auth base imported
)

REM Import world database
if exist "sql\world\base\world.sql" (
    mysql -u root -p%MYSQL_PASS% acore_world < "sql\world\base\world.sql"
    echo   - World base imported
)

REM Import characters database
if exist "sql\characters\base\characters.sql" (
    mysql -u root -p%MYSQL_PASS% acore_characters < "sql\characters\base\characters.sql"
    echo   - Characters base imported
)

REM Import playerbots
if exist "sql\playerbots\base\playerbots.sql" (
    mysql -u root -p%MYSQL_PASS% acore_playerbots < "sql\playerbots\base\playerbots.sql"
    echo   - Playerbots base imported
)

echo.
echo Applying world updates...
for %%f in (sql\world\updates\*.sql) do (
    mysql -u root -p%MYSQL_PASS% acore_world < "%%f"
)
echo   - World updates applied

echo.
echo Creating GM account...
mysql -u root -p%MYSQL_PASS% acore_auth -e "INSERT INTO account (username, sha_pass_hash, expansion, realm_id, account_flags) VALUES ('ADMIN', '', 0, -1, 3) ON DUPLICATE KEY UPDATE account_flags=3;"
echo   - Account ADMIN created (password: admin)

echo.
echo  ========================================
echo   Setup Complete!
echo  ========================================
echo.
echo Next steps:
echo 1. Edit configs\authserver.conf - set your MySQL password
echo 2. Edit configs\worldserver.conf - set MySQL password and WoW client path
echo 3. Edit configs\playerbots.conf - customize bot settings
echo 4. Run start.bat to launch the server
echo.
echo Login: Username ADMIN, Password admin
echo.
pause
