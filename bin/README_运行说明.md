# GameServer.exe 运行说明

## 📦 包含文件

### 可执行文件
- **GameServer.exe** (40.3 MB) - 全地图PVP游戏服务器

### 必需的DLL文件（36个）

#### 核心运行库
- `msvcr100.dll` - Visual C++ 运行时
- `zlib1.dll` - 压缩库

#### 游戏引擎库
- `XWrapper.dll` - 图形包装器
- `PhysXCore.dll` / `PhysXCoreDEBUG.dll` - 物理引擎
- `PhysXLoader.dll` / `PhysXLoaderDEBUG.dll` - 物理引擎加载器
- `NxCooking.dll` / `NxCookingDEBUG.dll` - 物理烹饪库
- `physxcudart_20.dll` - PhysX CUDA运行时

#### 多媒体库
- `binkw32.dll` - 视频解码
- `avcodec-54.dll` - 音频/视频编解码
- `avformat-54.dll` - 媒体格式
- `avutil-51.dll` - 工具库
- `libsndfile-1.dll` - 音频文件处理

#### 网络和通信
- `vivoxsdk.dll` - 语音通信
- `vivoxplatform.dll` - 语音平台
- `vivoxoal.dll` - 语音OpenAL
- `ortp.dll` - RTP协议

#### DirectX库
- `D3DX9_37.dll` / `d3dx9_42.dll` - DirectX 9
- `d3dx11_42.dll` - DirectX 11
- `D3DCompiler_42.dll` - 着色器编译

#### 其他库
- `icudt.dll` - Unicode支持
- `libcef.dll` - Chromium嵌入式框架
- `nvtt.dll` - NVIDIA纹理工具
- `Tootle.dll` - 网格优化
- `steam_api.dll` - Steam API
- `xinput1_3.dll` / `xinput9_1_0.dll` - Xbox控制器
- `LightFX.dll` - 灯光效果
- `BindIP.dll` - IP绑定
- `dbghelp.dll` / `symsrv.dll` - 调试帮助
- `ICSharpCode.SharpZipLib.dll` - ZIP压缩
- `AutoLoadLua.dll` - Lua脚本加载

## 🚀 快速启动

### 方法1：使用启动脚本（推荐）
```batch
双击运行: StartGameServer.bat
```

### 方法2：直接运行
```batch
GameServer.exe
```

## ⚠️ 重要说明

### 1. 游戏数据文件（可能需要）

GameServer可能需要以下数据目录：
```
data/
├── bin/              # 编译后的二进制数据
├── server/
│   └── bin/          # 服务端数据
├── defs/             # 游戏定义文件
├── maps/             # 地图文件
└── scripts/          # 脚本文件
```

**如果启动失败**，可能需要从完整游戏安装中复制 `data` 目录。

### 2. 配置文件

GameServer可能需要配置文件，通常位于：
- 当前目录的配置文件
- 或 `data/server/` 目录下的配置

### 3. 网络端口

GameServer可能使用以下端口（需要在防火墙中开放）：
- 游戏端口（默认可能是 7000-7100）
- 管理端口
- 数据库端口

### 4. 其他服务器组件

完整运行可能还需要：
- **AccountServer** - 账户验证服务器
- **DBServer** - 数据库服务器
- **ChatServer** - 聊天服务器

## 🎮 PVP功能

此版本是**全地图PVP版本**，包含以下PVP功能：

- ✅ 全地图玩家对战(PK)
- ✅ Combat战斗系统
- ✅ PVP邀请系统
- ✅ PVP资源/荣誉值
- ✅ 伤害计算系统

## 🔧 故障排除

### 问题1：缺少DLL文件
```
错误：找不到 xxx.dll
解决：确保所有36个DLL文件都在同一目录
```

### 问题2：启动后立即退出
```
可能原因：
1. 缺少 data 目录
2. 缺少配置文件
3. 端口被占用
```

### 问题3：无法连接
```
可能原因：
1. 防火墙阻止
2. 端口配置不正确
3. 缺少其他服务器组件（AccountServer等）
```

## 📊 文件信息

- **编译日期**：2015-11-10
- **文件大小**：约 90 MB（包含所有DLL）
- **架构**：Win32 (x86)
- **引擎**：Cryptic Engine

## 📝 命令行参数

GameServer支持多种命令行参数，例如：

```batch
GameServer.exe -port 7000              # 指定端口
GameServer.exe -makebinsAndExit 1      # 生成bin文件后退出
GameServer.exe -binLeaveUntouchedFiles 1  # 保留未修改的文件
```

更多参数请查看游戏文档。

## 🔗 相关链接

- 源代码仓库：https://github.com/yanlongyang806-cyber/pvp
- 编译说明：参见项目根目录的 `COMPILE_STATUS.md`

## ⚡ 快速测试

运行以下命令测试服务器是否正常启动：

```batch
GameServer.exe -help
```

如果显示帮助信息，说明exe文件正常。

---

**最后更新**：2025-11-22  
**版本**：全地图PVP版本

