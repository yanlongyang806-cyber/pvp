# GameServer 独立部署清单

## 📦 必需文件清单

### 1. 可执行文件
```
GameServer.exe (40.3 MB)
```

### 2. 必需 DLL 文件（30+ 个）

#### 核心运行时库
- `msvcr100.dll` (0.79 MB) - Visual C++ 运行时
- `zlib1.dll` (0.06 MB) - 压缩库

#### 游戏引擎库
- `XWrapper.dll` (2.37 MB) - 图形包装器
- `PhysXCore.dll` (4.2 MB) - 物理引擎
- `PhysXLoader.dll` (0.07 MB) - 物理引擎加载器
- `NxCooking.dll` (0.41 MB) - 物理烹饪库

#### 多媒体库
- `binkw32.dll` (0.18 MB) - 视频解码
- `avcodec-54.dll` (1.14 MB) - 音频/视频编解码
- `avformat-54.dll` (0.21 MB) - 媒体格式
- `avutil-51.dll` (0.13 MB) - 工具库
- `libsndfile-1.dll` (0.32 MB) - 音频文件处理

#### 网络和通信
- `vivoxsdk.dll` (5.99 MB) - 语音通信
- `vivoxplatform.dll` (1.21 MB) - 语音平台
- `vivoxoal.dll` (0.3 MB) - 语音 OpenAL
- `ortp.dll` (0.27 MB) - RTP 协议

#### DirectX 库
- `D3DX9_37.dll` (3.61 MB) - DirectX 9
- `d3dx9_42.dll` (1.8 MB) - DirectX 9
- `d3dx11_42.dll` (0.22 MB) - DirectX 11
- `D3DCompiler_42.dll` (1.88 MB) - 着色器编译

#### 其他库
- `icudt.dll` (9.5 MB) - Unicode 支持
- `libcef.dll` (21.19 MB) - Chromium 嵌入式框架
- `nvtt.dll` (0.22 MB) - NVIDIA 纹理工具
- `Tootle.dll` (0.15 MB) - 网格优化
- `steam_api.dll` (0.12 MB) - Steam API
- `xinput1_3.dll` (0.07 MB) - Xbox 控制器
- `xinput9_1_0.dll` (0.06 MB) - Xbox 控制器
- `LightFX.dll` (0.02 MB) - 灯光效果
- `BindIP.dll` (0.01 MB) - IP 绑定
- `dbghelp.dll` (0.99 MB) - 调试帮助
- `symsrv.dll` (0.12 MB) - 符号服务器
- `ICSharpCode.SharpZipLib.dll` (0.18 MB) - ZIP 压缩

**总计 DLL 大小：约 55 MB**

### 3. 游戏数据目录（必需）

#### 核心数据目录
```
data/
├── bin/                    # 编译后的二进制数据（地图、材质等）
├── server/
│   └── bin/                # 服务端二进制数据（AI、定义等）
├── defs/                   # 游戏定义文件（物品、技能等）
├── maps/                   # 地图文件
├── materials/              # 材质文件
├── messages/               # 消息/文本
├── translations/           # 翻译文件
├── ai/                     # AI 定义
├── gclScript/              # 客户端脚本
└── server/                 # 服务端脚本和配置
    └── TestServer/
        └── scripts/        # 服务器脚本（如 LoadPVP.lua）
```

**数据目录大小：可能数 GB（取决于游戏内容）**

### 4. 可选但推荐的文件

#### 配置文件
- 服务器配置文件（如果有）
- 日志目录配置

#### 启动脚本
- `StartServer.bat` - 启动脚本示例

---

## 🚀 部署步骤

### 方法 1：完整部署（推荐）

1. **创建部署目录**
   ```
   D:\GameServer\
   ├── GameServer.exe
   ├── *.dll (所有 DLL 文件)
   └── data\ (完整数据目录)
   ```

2. **复制文件**
   ```batch
   # 复制可执行文件和 DLL
   xcopy I:\Night\Night\tools\bin\GameServer.exe D:\GameServer\
   xcopy I:\Night\Night\tools\bin\*.dll D:\GameServer\
   
   # 复制数据目录（可能需要很长时间）
   xcopy I:\Night\Night\data D:\GameServer\data\ /E /I
   ```

3. **运行服务器**
   ```batch
   cd D:\GameServer
   GameServer.exe
   ```

### 方法 2：最小化部署（仅测试）

如果只是测试，可以：
1. 只复制 `GameServer.exe` 和必需的 DLL
2. 使用符号链接指向原 `data` 目录（如果在同一台机器）

---

## ⚠️ 重要注意事项

### 1. 数据目录路径
- GameServer 可能使用**硬编码路径**或**相对路径**
- 确保 `data` 目录在正确位置
- 可能需要修改配置文件中的路径

### 2. 其他服务器组件
GameServer 可能需要：
- **AccountServer** - 账户验证
- **AppServer** - 应用服务器
- **ChatServer** - 聊天服务器

**如果只运行 GameServer：**
- 可能需要配置为单机模式
- 某些功能可能不可用（如账户验证）

### 3. 网络配置
- 检查防火墙设置
- 确认端口未被占用
- 可能需要配置 IP 地址

### 4. 权限要求
- 确保有 `data` 目录的读写权限
- 可能需要管理员权限（取决于配置）

---

## 📋 快速检查清单

部署前检查：

- [ ] `GameServer.exe` 已复制
- [ ] 所有 DLL 文件已复制（30+ 个）
- [ ] `data` 目录已复制或链接
- [ ] `data\bin\` 目录存在
- [ ] `data\server\bin\` 目录存在
- [ ] 防火墙已配置
- [ ] 端口未被占用
- [ ] 有足够的磁盘空间（数据可能数 GB）

---

## 🔧 测试运行

### 1. 基本测试
```batch
cd D:\GameServer
GameServer.exe
```

### 2. 检查启动日志
- 查看控制台输出
- 检查是否有错误信息
- 确认数据加载成功

### 3. 测试连接
- 使用 GameClient 连接测试
- 或使用 TestClient 测试

---

## 💡 建议

### 如果只是测试：
1. 使用符号链接指向原 `data` 目录（节省空间）
2. 只复制必需的 DLL
3. 在同一台机器上测试

### 如果要完整部署：
1. 复制所有文件到新目录
2. 测试所有功能
3. 配置服务器参数
4. 设置自动启动脚本

---

## 📝 文件大小估算

- **GameServer.exe**: 40 MB
- **DLL 文件**: 55 MB
- **数据目录**: 数 GB（取决于内容）
- **总计**: 约 60 MB（不含数据）+ 数据大小

---

**最后更新：** 2025-11-21



