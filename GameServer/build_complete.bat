@echo off
chcp 65001 >nul
echo ========================================
echo   Cryptic GameServer 完整编译脚本
echo   基于 Cryptic Builder Process 文档
echo ========================================
echo.

cd /d "%~dp0"
set "PROJECT_DIR=%~dp0"
REM 计算根目录：从 src\Night\GameServer 到 Night\Night
cd /d "%PROJECT_DIR%..\..\.."
set "ROOT_DIR=%CD%"
cd /d "%PROJECT_DIR%"
set "TOOLS_BIN=%ROOT_DIR%\tools\bin"
set "DATA_DIR=%ROOT_DIR%\data"
set "BUILD_CONFIG=Debug"
set "BUILD_PLATFORM=Win32"

echo [步骤 1/4] 环境检查
echo ========================================
echo 项目目录: %PROJECT_DIR%
echo 根目录: %ROOT_DIR%
echo 工具目录: %TOOLS_BIN%
echo.

if not exist "NNOGameServer.sln" (
    echo ❌ 错误: 未找到 NNOGameServer.sln
    pause
    exit /b 1
)

if not exist "%TOOLS_BIN%\GameServer.exe" (
    echo ⚠️  警告: 未找到 GameServer.exe，将先编译代码
    set "NEED_COMPILE=1"
) else (
    echo ✅ 找到已编译的 GameServer.exe
    set "NEED_COMPILE=0"
)

if not exist "%DATA_DIR%" (
    echo ⚠️  警告: 未找到 data 目录: %DATA_DIR%
    echo    某些 bin 文件可能无法生成
)

echo.
echo [步骤 2/4] 编译代码（如需要）
echo ========================================
if "%NEED_COMPILE%"=="1" (
    echo 开始编译 NNOGameServer.sln...
    echo 配置: %BUILD_CONFIG% ^| 平台: %BUILD_PLATFORM%
    echo.
    
    msbuild NNOGameServer.sln /p:Configuration=%BUILD_CONFIG% /p:Platform=%BUILD_PLATFORM% /v:minimal /nologo
    
    if %ERRORLEVEL% NEQ 0 (
        echo.
        echo ❌ 编译失败，错误代码: %ERRORLEVEL%
        echo.
        echo 常见错误解决方案:
        echo 1. 检查是否有编译错误信息
        echo 2. 确保所有依赖项目都存在
        echo 3. 检查文件是否被其他程序占用
        pause
        exit /b 1
    )
    
    echo.
    echo ✅ 代码编译成功
    echo.
    
    REM 检查编译输出
    if exist "%TOOLS_BIN%\GameServer.exe" (
        echo ✅ GameServer.exe 已生成
    ) else (
        echo ⚠️  警告: 编译成功但未找到 GameServer.exe
        echo    请检查项目输出目录设置
    )
) else (
    echo 跳过代码编译（使用现有 GameServer.exe）
)

echo.
echo [步骤 3/4] 生成 Bin 文件
echo ========================================
echo 根据 Cryptic Builder Process 文档：
echo - 执行 GameServer.exe --makebinsandexit
echo - 生成地图 bin、图片 bin 等关键文件
echo.

if not exist "%TOOLS_BIN%\GameServer.exe" (
    echo ❌ 错误: 未找到 GameServer.exe
    echo    请先完成代码编译
    pause
    exit /b 1
)

echo 切换到工具目录: %TOOLS_BIN%
cd /d "%TOOLS_BIN%"

if exist "_3_MakeBinsAndExit_Server.bat" (
    echo 使用现有脚本: _3_MakeBinsAndExit_Server.bat
    echo.
    REM 修复脚本：直接运行而不是 start
    GameServer.exe -binLeaveUntouchedFiles 1 -makebinsAndExit 1
) else (
    echo 直接执行 GameServer.exe --makebinsandexit
    echo.
    GameServer.exe -binLeaveUntouchedFiles 1 -makebinsAndExit 1
)

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ⚠️  警告: Bin 文件生成过程返回错误代码: %ERRORLEVEL%
    echo    请检查 GameServer 日志以获取详细信息
) else (
    echo.
    echo ✅ Bin 文件生成完成
)

echo.
echo [步骤 4/4] 验证编译产物
echo ========================================
cd /d "%PROJECT_DIR%"

echo 检查关键文件:
echo.

set "FILES_FOUND=0"
set "FILES_MISSING=0"

if exist "%TOOLS_BIN%\GameServer.exe" (
    echo ✅ GameServer.exe
    set /a FILES_FOUND+=1
) else (
    echo ❌ GameServer.exe (缺失)
    set /a FILES_MISSING+=1
)

if exist "%DATA_DIR%\bin" (
    echo ✅ data\bin\ 目录存在
    set /a FILES_FOUND+=1
) else (
    echo ⚠️  data\bin\ 目录不存在
    set /a FILES_MISSING+=1
)

if exist "%DATA_DIR%\server\bin" (
    echo ✅ data\server\bin\ 目录存在
    set /a FILES_FOUND+=1
) else (
    echo ⚠️  data\server\bin\ 目录不存在
    set /a FILES_MISSING+=1
)

echo.
echo ========================================
echo   编译总结
echo ========================================
echo 找到文件: %FILES_FOUND%
echo 缺失文件: %FILES_MISSING%
echo.

if %FILES_MISSING% EQU 0 (
    echo ✅ 所有关键文件已生成
    echo.
    echo 下一步操作:
    echo 1. 检查 data\bin\ 和 data\server\bin\ 下的 bin 文件
    echo 2. 如需部署，参考文档中的同步步骤
    echo 3. 运行 GameServer.exe 测试服务器
) else (
    echo ⚠️  部分文件缺失，请检查:
    echo    1. 编译日志是否有错误
    echo    2. data 目录路径是否正确
    echo    3. GameServer.exe 是否有足够权限
)

echo.
pause

