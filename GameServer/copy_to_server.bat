@echo off
chcp 65001 >nul
echo ========================================
echo   GameServer 部署脚本
echo   复制文件到服务端目录
echo ========================================
echo.

REM 设置源目录和目标目录
set "SOURCE_BIN=I:\Night\Night\tools\bin"
set "SOURCE_DATA=I:\Night\Night\data"
set "TARGET_DIR=%~1"

REM 如果没有指定目标目录，使用当前目录
if "%TARGET_DIR%"=="" (
    set "TARGET_DIR=%CD%\GameServer_Deploy"
    echo 未指定目标目录，使用默认目录: %TARGET_DIR%
) else (
    echo 目标目录: %TARGET_DIR%
)

echo.
echo 源目录:
echo   可执行文件: %SOURCE_BIN%
echo   数据目录: %SOURCE_DATA%
echo.
echo 目标目录: %TARGET_DIR%
echo.

REM 确认操作
set /p CONFIRM="确认开始复制? (Y/N): "
if /i not "%CONFIRM%"=="Y" (
    echo 操作已取消
    pause
    exit /b 0
)

echo.
echo [步骤 1/3] 创建目标目录...
if not exist "%TARGET_DIR%" (
    mkdir "%TARGET_DIR%"
    echo ✅ 已创建目录: %TARGET_DIR%
) else (
    echo ✅ 目录已存在: %TARGET_DIR%
)

echo.
echo [步骤 2/3] 复制可执行文件和 DLL...
if not exist "%SOURCE_BIN%\GameServer.exe" (
    echo ❌ 错误: 未找到 GameServer.exe
    echo    路径: %SOURCE_BIN%\GameServer.exe
    pause
    exit /b 1
)

REM 复制 GameServer.exe
copy "%SOURCE_BIN%\GameServer.exe" "%TARGET_DIR%\" >nul
if %ERRORLEVEL% EQU 0 (
    echo ✅ 已复制 GameServer.exe
) else (
    echo ❌ 复制 GameServer.exe 失败
    pause
    exit /b 1
)

REM 复制所有 DLL
echo 正在复制 DLL 文件...
xcopy "%SOURCE_BIN%\*.dll" "%TARGET_DIR%\" /Y /Q >nul
if %ERRORLEVEL% EQU 0 (
    echo ✅ 已复制 DLL 文件
) else (
    echo ⚠️  警告: 部分 DLL 文件可能复制失败
)

REM 复制启动脚本（如果存在）
if exist "%SOURCE_BIN%\StartServer.bat" (
    copy "%SOURCE_BIN%\StartServer.bat" "%TARGET_DIR%\" >nul
    echo ✅ 已复制 StartServer.bat
)

echo.
echo [步骤 3/3] 复制数据目录...
echo ⚠️  注意: 数据目录可能很大，复制需要较长时间
echo.

set /p COPY_DATA="是否复制 data 目录? (Y/N): "
if /i "%COPY_DATA%"=="Y" (
    if not exist "%SOURCE_DATA%" (
        echo ❌ 错误: 未找到数据目录
        echo    路径: %SOURCE_DATA%
    ) else (
        echo 正在复制数据目录（这可能需要很长时间）...
        echo 从: %SOURCE_DATA%
        echo 到: %TARGET_DIR%\data
        echo.
        
        xcopy "%SOURCE_DATA%" "%TARGET_DIR%\data\" /E /I /Y /Q
        
        if %ERRORLEVEL% EQU 0 (
            echo ✅ 数据目录复制完成
        ) else (
            echo ⚠️  警告: 数据目录复制可能不完整
        )
    )
) else (
    echo ⚠️  跳过数据目录复制
    echo    提示: 可以使用符号链接或手动复制
)

echo.
echo ========================================
echo   部署完成
echo ========================================
echo.
echo 文件位置: %TARGET_DIR%
echo.
echo 下一步操作:
echo 1. 检查文件是否完整
echo 2. 运行 GameServer.exe 测试
echo 3. 配置服务器参数（如需要）
echo.

REM 询问是否打开目录
set /p OPEN_DIR="是否打开目标目录? (Y/N): "
if /i "%OPEN_DIR%"=="Y" (
    explorer "%TARGET_DIR%"
)

echo.
pause



