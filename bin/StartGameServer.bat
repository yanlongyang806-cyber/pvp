@echo off
chcp 65001 >nul
echo ========================================
echo   全地图PVP GameServer 启动脚本
echo ========================================
echo.
echo [提示] 正在启动 GameServer.exe...
echo.

cd /d "%~dp0"

REM 检查是否有必需的DLL
if not exist "zlib1.dll" (
    echo [错误] 缺少必需的DLL文件！
    echo 请确保所有DLL文件都在同一目录下。
    pause
    exit /b 1
)

REM 启动 GameServer
echo [启动] GameServer.exe
echo.
echo 说明：
echo - 这是全地图PVP版本的GameServer
echo - 支持玩家对战(PK)功能
echo - 按 Ctrl+C 可以停止服务器
echo.
echo ========================================
echo.

GameServer.exe %*

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [错误] GameServer 异常退出，错误代码: %ERRORLEVEL%
    echo.
    echo 可能的原因：
    echo 1. 缺少游戏数据文件 (data目录)
    echo 2. 缺少配置文件
    echo 3. 端口被占用
    echo 4. 缺少其他依赖
    echo.
)

pause

