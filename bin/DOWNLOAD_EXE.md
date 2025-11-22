# 📥 GameServer.exe 下载说明

## 🎮 全地图PVP GameServer 可执行文件

由于GitHub对大文件有限制，**GameServer.exe** 和相关DLL文件（共约90MB）需要单独获取。

## 📍 文件位置

如果你有完整的引擎源码，这些文件位于：

```
I:\Night\Night\tools\bin\
├── GameServer.exe (40.3 MB)
└── *.dll (36个DLL文件)
```

## 🚀 快速复制命令

如果你能访问原始目录，运行以下PowerShell命令：

```powershell
# 复制GameServer.exe
Copy-Item "I:\Night\Night\tools\bin\GameServer.exe" "I:\QLWD\bin\" -Force

# 复制所有DLL文件
Copy-Item "I:\Night\Night\tools\bin\*.dll" "I:\QLWD\bin\" -Force
```

或使用批处理：

```batch
xcopy "I:\Night\Night\tools\bin\GameServer.exe" "I:\QLWD\bin\" /Y
xcopy "I:\Night\Night\tools\bin\*.dll" "I:\QLWD\bin\" /Y
```

## 📦 需要的文件清单

### 可执行文件（1个）
- **GameServer.exe** - 40.3 MB

### 必需的DLL文件（36个，约50MB）

核心库：
- msvcr100.dll
- zlib1.dll
- XWrapper.dll
- PhysXCore.dll
- PhysXLoader.dll
- NxCooking.dll

多媒体：
- binkw32.dll
- avcodec-54.dll
- avformat-54.dll
- avutil-51.dll
- libsndfile-1.dll

网络通信：
- vivoxsdk.dll
- vivoxplatform.dll
- vivoxoal.dll
- ortp.dll

DirectX：
- D3DX9_37.dll
- d3dx9_42.dll
- d3dx11_42.dll
- D3DCompiler_42.dll

其他：
- icudt.dll
- libcef.dll
- nvtt.dll
- Tootle.dll
- steam_api.dll
- xinput1_3.dll
- xinput9_1_0.dll
- LightFX.dll
- BindIP.dll
- dbghelp.dll
- symsrv.dll
- ICSharpCode.SharpZipLib.dll
- AutoLoadLua.dll
- PhysXCoreDEBUG.dll
- PhysXLoaderDEBUG.dll
- NxCookingDEBUG.dll
- physxcudart_20.dll

## ✅ 验证文件完整性

复制完成后，检查文件：

```powershell
Get-ChildItem "I:\QLWD\bin" | Measure-Object -Property Length -Sum | Select-Object Count, @{Name="TotalMB";Expression={[math]::Round($_.Sum/1MB,2)}}
```

应该显示：
- **Count**: 37个文件（1 exe + 36 dll）
- **TotalMB**: 约90 MB

## 🎯 复制完成后

1. 运行 `StartGameServer.bat` 启动服务器
2. 或查看 `README_运行说明.md` 了解详细使用方法

## 📝 备注

- 这些文件已经编译好，可以直接运行
- 编译日期：2015-11-10
- 架构：Win32 (x86)
- **包含全地图PVP功能**

---

**如果你无法访问原始文件**，你需要自己编译源代码，或者从其他渠道获取这些文件。

