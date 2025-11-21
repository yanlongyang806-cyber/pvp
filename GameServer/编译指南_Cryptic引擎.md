# Cryptic 引擎 GameServer 编译指南

基于 Cryptic Builder Process 文档整理的完整编译流程。

## 📋 目录

1. [编译前准备](#编译前准备)
2. [核心编译流程](#核心编译流程)
3. [常见问题排查](#常见问题排查)
4. [编译后验证](#编译后验证)

---

## 一、编译前准备

### 1. 环境与依赖检查

#### 必需工具
- ✅ **Visual Studio 2022** (或 2019/2017)
  - 工作负载：使用 C++ 的桌面开发
  - 工具集：MSVC v143 (VS 2022) 或 v142 (VS 2019)
  
- ✅ **MSBuild** 
  - 通常随 Visual Studio 安装
  - 路径示例：`C:\Program Files (x86)\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe`

#### 项目结构检查
```
I:\Night\Night\
├── src\
│   ├── Night\GameServer\     ← 当前项目目录
│   │   ├── NNOGameServer.sln ← 解决方案文件
│   │   └── NNOGameServer.vcxproj
│   ├── libs\                  ← 依赖库
│   ├── CrossRoads\            ← 游戏服务器库
│   └── Core\                  ← 核心系统
├── tools\bin\                 ← 编译输出目录
│   └── GameServer.exe         ← 编译后的可执行文件
└── data\                      ← 游戏数据目录
    ├── bin\                   ← 客户端 bin 文件
    └── server\bin\            ← 服务端 bin 文件
```

### 2. 关键文件确认

检查以下文件是否存在：

- ✅ `NNOGameServer.sln` - 解决方案文件
- ✅ `tools\bin\GameServer.exe` - 可执行文件（编译后生成）
- ✅ `data\` 目录 - 游戏数据目录（可选，用于生成 bin 文件）

---

## 二、核心编译流程

### 方法 1: 使用完整编译脚本（推荐）

运行 `build_complete.bat`，它会自动执行以下步骤：

```batch
cd I:\Night\Night\src\Night\GameServer
build_complete.bat
```

**脚本执行流程：**
1. ✅ 环境检查
2. ✅ 编译代码（如需要）
3. ✅ 生成 Bin 文件（`--makebinsandexit`）
4. ✅ 验证编译产物

### 方法 2: 手动分步编译

#### 步骤 1: 编译代码

```batch
cd I:\Night\Night\src\Night\GameServer
msbuild NNOGameServer.sln /p:Configuration=Debug /p:Platform=Win32 /v:minimal /nologo
```

**输出位置：**
- `I:\Night\Night\tools\bin\GameServer.exe`

#### 步骤 2: 生成 Bin 文件

根据 Cryptic Builder Process 文档，需要运行 GameServer 并添加 `--makebinsandexit` 参数：

```batch
cd I:\Night\Night\tools\bin
GameServer.exe -binLeaveUntouchedFiles 1 -makebinsAndExit 1
```

或者使用现有脚本：

```batch
cd I:\Night\Night\tools\bin
_3_MakeBinsAndExit_Server.bat
```

**生成的文件：**
- `data\bin\` - 客户端 bin 文件（地图、材质等）
- `data\server\bin\` - 服务端 bin 文件（AI、定义等）

### 方法 3: 使用 Visual Studio IDE

1. 打开 `NNOGameServer.sln`
2. 选择配置：**Debug** 或 **Full Debug**
3. 选择平台：**Win32**
4. 生成 → 生成解决方案 (Ctrl+Shift+B)
5. 编译完成后，手动运行 `_3_MakeBinsAndExit_Server.bat` 生成 bin 文件

---

## 三、常见问题排查

### 1. 编译错误

#### 错误：项目文件无法加载
```
error MSB4025: 未能加载项目文件。有多个根元素。
```

**解决方案：**
- 检查 `.vcxproj` 文件是否有 XML 格式错误
- 移除重复的 `</Project>` 标签
- 确保文件编码为 UTF-8（无 BOM）

#### 错误：找不到依赖项目
```
error MSB3202: 无法打开项目文件 "...\AILib.vcxproj"
```

**解决方案：**
- 检查解决方案文件中的相对路径是否正确
- 确认所有依赖项目存在于 `src\libs\` 目录

#### 错误：函数重定义
```
error C2084: 函数 "round" 已有主体
error C2084: 函数 "log2" 已有主体
```

**解决方案：**
- 在自定义函数定义前添加 `#undef`：
  ```c
  #ifdef round
  #undef round
  #endif
  ```

### 2. Bin 文件生成问题

#### 问题：GameServer.exe 启动失败
- 检查 `data\` 目录是否存在
- 确认所有必需的 DLL 文件在 `tools\bin\` 目录
- 查看 GameServer 日志文件

#### 问题：Bin 文件未生成
- 确认 `data\` 目录有写入权限
- 检查 GameServer 启动参数是否正确
- 查看 GameServer 控制台输出是否有错误

### 3. 路径问题

#### 问题：找不到工具或数据目录
- 确认项目根目录结构正确
- 检查相对路径是否正确（从 `src\Night\GameServer` 到 `tools\bin`）
- 使用绝对路径作为备选方案

---

## 四、编译后验证

### 1. 检查关键文件

运行编译后，验证以下文件是否存在：

```batch
✅ I:\Night\Night\tools\bin\GameServer.exe
✅ I:\Night\Night\data\bin\              (目录存在)
✅ I:\Night\Night\data\server\bin\        (目录存在)
```

### 2. 测试服务器启动

```batch
cd I:\Night\Night\tools\bin
GameServer.exe
```

或使用启动脚本：

```batch
cd I:\Night\Night\tools\bin
StartServer.bat
```

### 3. 检查日志

- GameServer 日志：`I:\Night\Night\logs\` 或 `tools\bin\` 目录
- 编译日志：查看 MSBuild 输出
- 错误日志：`tools\bin\ERRORS.log`

---

## 📝 快速参考

### 完整编译命令（一行）

```batch
cd I:\Night\Night\src\Night\GameServer && msbuild NNOGameServer.sln /p:Configuration=Debug /p:Platform=Win32 /v:minimal /nologo && cd ..\..\..\tools\bin && GameServer.exe -binLeaveUntouchedFiles 1 -makebinsAndExit 1
```

### 常用脚本位置

- 编译脚本：`src\Night\GameServer\build.bat`
- 完整编译：`src\Night\GameServer\build_complete.bat`
- 生成 Bin：`tools\bin\_3_MakeBinsAndExit_Server.bat`
- 启动服务器：`tools\bin\StartServer.bat`

---

## 🔗 相关文档

- Cryptic Builder Process 文档（doc.pdf 第 11 页）
- 项目 README：`I:\Night\Night\README.md`
- 编译说明：`I:\Night\Night\编译说明.md`

---

**最后更新：** 2025-11-21  
**适用版本：** Cryptic 引擎 GameServer (NNO)



