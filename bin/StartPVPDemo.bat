@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo ╔═══════════════════════════════════════════════════╗
echo ║  GameServer PVP Demo - 全地图PVP演示程序         ║
echo ╚═══════════════════════════════════════════════════╝
echo.
echo 这是一个可运行的PVP功能演示程序
echo.
echo 功能特性:
echo   ✓ PVP邀请系统 (PvPInvites)
echo   ✓ PVP荣誉值系统 (Pvp_Resources) 
echo   ✓ Combat战斗系统演示
echo   ✓ 玩家治疗功能 (NWCureAll)
echo.
echo 文件大小: 107 KB (无需DLL依赖)
echo 编译时间: 2025-11-22
echo.
echo ═══════════════════════════════════════════════════
echo.
echo 按任意键启动...
pause >nul

GameServer_PVP_Demo.exe

echo.
echo ═══════════════════════════════════════════════════
echo 演示结束！
echo.
echo 查看完整文档:
echo   - PVP启动指南.md - PVP功能详解
echo   - README.md - 项目说明
echo   - COMPILE_STATUS.md - 编译状态
echo.
pause

