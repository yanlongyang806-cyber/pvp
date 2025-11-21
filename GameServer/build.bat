@echo off
chcp 65001 >nul
echo ========================================
echo    GameServer 编译脚本
echo ========================================
echo.

cd /d "%~dp0"
echo 当前目录: %CD%
echo.

if not exist "NNOGameServer.sln" (
    echo 错误: 未找到 NNOGameServer.sln
    pause
    exit /b 1
)

echo 开始编译...
echo 配置: Debug ^| 平台: Win32
echo.

msbuild NNOGameServer.sln /p:Configuration=Debug /p:Platform=Win32 /v:minimal /nologo

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo    编译成功！
    echo ========================================
) else (
    echo.
    echo ========================================
    echo    编译失败，错误代码: %ERRORLEVEL%
    echo ========================================
    echo.
    echo 常见错误解决方案:
    echo 1. 检查是否有编译错误信息
    echo 2. 确保所有依赖项目都存在
    echo 3. 检查文件是否被其他程序占用
)

echo.
pause

