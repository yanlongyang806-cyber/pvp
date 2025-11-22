@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo ╔══════════════════════════════════════════════════════════════════╗
echo ║  真正的 GameServer - 全地图PVP版本                             ║
echo ╚══════════════════════════════════════════════════════════════════╝
echo.
echo 这是完整的Cryptic引擎GameServer
echo 文件大小: 40.3 MB
echo 依赖DLL: 36个文件
echo.
echo 功能:
echo   ✅ 完整的游戏服务器
echo   ✅ 全地图PVP系统
echo   ✅ Combat战斗引擎
echo   ✅ 所有游戏功能
echo.
echo ══════════════════════════════════════════════════════════════════
echo.
echo 正在检查必需文件...
echo.

if not exist "GameServer.exe" (
    echo ❌ 错误: 找不到 GameServer.exe
    pause
    exit /b 1
)

if not exist "zlib1.dll" (
    echo ❌ 错误: 找不到必需的DLL文件
    echo 请确保所有DLL文件都在bin目录下
    pause
    exit /b 1
)

echo ✅ GameServer.exe - 找到
echo ✅ DLL文件 - 找到
echo.
echo ══════════════════════════════════════════════════════════════════
echo.
echo 启动服务器...
echo.
echo 提示:
echo   - 服务器需要 data 目录（游戏数据文件）
echo   - 可能需要配置文件
echo   - 首次运行可能会生成bin文件
echo   - 按 Ctrl+C 可以停止服务器
echo.
echo ══════════════════════════════════════════════════════════════════
echo.

REM 启动真正的GameServer
GameServer.exe

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ══════════════════════════════════════════════════════════════════
    echo ❌ 服务器异常退出
    echo.
    echo 可能的原因:
    echo   1. 缺少 data 目录
    echo   2. 缺少配置文件
    echo   3. 端口被占用
    echo   4. 缺少其他服务器组件 (AccountServer, DBServer)
    echo.
    echo 解决方案:
    echo   1. 复制完整的 data 目录到服务器目录
    echo   2. 检查 I:\Night\Night\data 是否存在
    echo   3. 查看服务器日志文件
    echo.
    echo 如果 I:\Night\Night\data 存在，可以：
    echo   - 将GameServer.exe复制到 I:\Night\Night\tools\bin
    echo   - 或在那里直接运行
    echo ══════════════════════════════════════════════════════════════════
)

echo.
pause

