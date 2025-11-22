# 全地图PVP GameServer 项目

基于 Cryptic 引擎的 GameServer，支持全地图 PVP/PK 功能。

## ✨ 主要特性

- ✅ **全地图PVP系统** - 完整的 Combat 战斗系统
- ✅ **UGC支持** - 用户生成内容（User Generated Content）
- ✅ **Gateway网关** - 完整的客户端-服务器映射
- ✅ **自动代码生成** - AutoGen 系统
- ✅ **完整编译工具链** - 包含编译和部署脚本
- 🎮 **可执行文件已准备** - GameServer.exe 和所有DLL文件已复制到 `bin/` 目录

## 📂 项目结构

```
QLWD/
├── bin/                        # 🎮 可执行文件目录（新增）
│   ├── GameServer.exe          # 全地图PVP服务器（40.3MB）
│   ├── *.dll                   # 36个必需的DLL文件
│   ├── StartGameServer.bat     # 启动脚本
│   ├── README_运行说明.md      # 运行文档
│   └── DOWNLOAD_EXE.md         # 文件获取说明
├── GameServer/
│   ├── AutoGen/                # 自动生成的代码（82个文件）
│   ├── Gateway/                # 网关映射层
│   ├── UGC/                    # 用户生成内容系统
│   ├── wiki/                   # 项目文档
│   ├── NNOGameServer.sln       # Visual Studio 解决方案
│   ├── build_complete.bat      # 完整编译脚本
│   ├── quick_build.ps1         # 快速编译脚本
│   ├── 编译说明.md             # 编译说明文档
│   ├── 编译指南_Cryptic引擎.md # 详细编译指南
│   └── 部署清单_GameServer独立运行.md # 部署清单
├── PropertySheets/             # 编译配置文件
├── README.md                   # 本文件
└── COMPILE_STATUS.md           # 编译状态报告
```

## 🚀 快速开始（运行已编译的exe）

**如果你只想运行服务器，不需要编译！**

```batch
# 方法1：使用启动脚本（推荐）
cd bin
StartGameServer.bat

# 方法2：直接运行
cd bin
GameServer.exe
```

📖 **详细说明**：查看 `bin/README_运行说明.md`

⚠️ **注意**：
- GameServer.exe 和 DLL 文件已复制到 `bin/` 目录（本地有，Git未提交）
- 如需获取这些文件，参见 `bin/DOWNLOAD_EXE.md`
- 运行可能需要游戏数据文件（`data/`目录）

---

## 🔧 编译方法（如果你想重新编译）

### 方法1：使用完整编译脚本（推荐）
```batch
cd GameServer
build_complete.bat
```

### 方法2：使用 PowerShell 快速编译
```powershell
cd GameServer
.\quick_build.ps1
```

### 方法3：Visual Studio
1. 打开 `GameServer/NNOGameServer.sln`
2. 选择配置：Debug | Win32
3. 生成解决方案（Ctrl+Shift+B）

## 📋 系统要求

- **Visual Studio 2022/2019/2017**
- **MSBuild**（随 Visual Studio 安装）
- **依赖库**：
  - `CrossRoads/` - Combat 战斗系统
  - `libs/` - 各种库文件
  - `core/` - 核心库

## 🎮 PVP功能说明

项目已内置全地图PVP功能：
- Combat 战斗系统（`../../Crossroads/Common/Combat`）
- PVP 邀请系统（`PvPInvites`）
- PVP 资源/荣誉值（`Pvp_Resources`）
- 服务器脚本支持（`LoadPVP.lua`）

## 📦 部署

编译输出位置：
```
tools/bin/GameServer.exe  # 主程序（40.3 MB）
data/bin/                  # 客户端数据
data/server/bin/           # 服务端数据
```

详细部署说明请参考：`GameServer/部署清单_GameServer独立运行.md`

## 📝 文档

- [编译说明](GameServer/编译说明.md) - 基础编译说明
- [编译指南](GameServer/编译指南_Cryptic引擎.md) - 详细编译指南
- [部署清单](GameServer/部署清单_GameServer独立运行.md) - 独立运行部署清单

## 📊 项目统计

- **文件数量**：132 个文件
- **代码行数**：66,852 行
- **项目类型**：C/C++ GameServer
- **引擎**：Cryptic Engine

## 🔗 相关链接

- 项目位置：`I:\Night\Night\src\Night\GameServer`（原始位置）
- 当前位置：`I:\QLWD\GameServer`

## ⚠️ 注意事项

1. 项目依赖特定的目录结构
2. 确保所有依赖库都已安装
3. 某些路径可能需要根据实际情况调整
4. 编译前请仔细阅读编译说明文档

## 📅 更新日志

### 2025-11-21
- ✅ 初始化 Git 仓库
- ✅ 添加 .gitignore 文件
- ✅ 创建初始提交（132文件，66,852行代码）
- ✅ 添加 README 文档

---

**开发环境**：Windows 10  
**编译器**：Visual Studio 2022  
**最后更新**：2025-11-21

