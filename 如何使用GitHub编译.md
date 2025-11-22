# 如何使用GitHub Actions编译

## 🚀 已配置的CI/CD

你的仓库已经配置了自动编译！

**仓库地址**：https://github.com/yanlongyang806-cyber/pvp

---

## 📋 工作流说明

### 1. `build-full-gameserver.yml`

**触发条件**：
- 每次推送到main分支
- 手动触发（在GitHub Actions页面）

**编译内容**：
1. ✅ **GameServer_PVP_Demo.exe** - 一定成功
2. ❌ **完整GameServer.exe** - 需要完整源码树

---

## 🔍 为什么不能编译完整版？

### GitHub Actions的限制

GitHub Actions运行在云端的虚拟机上，**无法访问你本地的**：
```
I:\Night\Night\src\  - 完整的Cryptic引擎源码
I:\Night\Night\utilities\bin\structparser.exe  - 代码生成工具
```

### 解决方案

**方案1：上传完整源码到GitHub（不推荐）**

**问题**：
- 源码可能包含几百MB的文件
- 可能包含专有/敏感代码
- GitHub有仓库大小限制（推荐<1GB）

**方案2：使用Git LFS（大文件存储）**

如果你想上传完整源码：

```bash
# 1. 安装Git LFS
git lfs install

# 2. 追踪大文件
git lfs track "*.exe"
git lfs track "*.dll"
git lfs track "*.lib"

# 3. 提交
git add .gitattributes
git commit -m "Configure Git LFS"

# 4. 复制源码
xcopy /E /I /Y "I:\Night\Night\src" "I:\QLWD\Night_src"

# 5. 提交源码
git add Night_src
git commit -m "Add full engine source"
git push origin main
```

**方案3：本地编译 + 上传exe（推荐）**

1. 在本地获取 `structparser.exe`
2. 生成AutoGen文件
3. 本地编译成功
4. 只上传编译好的 `.exe` 到GitHub Release

---

## 🎯 当前可用的编译结果

### GitHub Actions会生成

**构建产物**（Artifacts）：
- ✅ `GameServer_PVP_Demo.exe` - Demo版本
- ✅ 所有文档（.md文件）
- ✅ 启动脚本

**下载方式**：
1. 访问：https://github.com/yanlongyang806-cyber/pvp/actions
2. 点击最新的workflow运行
3. 下载 `gameserver-build-report` 压缩包

---

## 🔧 手动触发编译

### 在GitHub网站上

1. 访问：https://github.com/yanlongyang806-cyber/pvp/actions
2. 选择 `编译完整GameServer (尝试)` workflow
3. 点击 `Run workflow` 按钮
4. 选择 `main` 分支
5. 点击 `Run workflow` 确认

### 使用gh命令行工具

```bash
gh workflow run "build-full-gameserver.yml"
```

---

## 📊 查看编译日志

### 在线查看

1. 访问：https://github.com/yanlongyang806-cyber/pvp/actions
2. 点击最新的workflow运行
3. 查看各个步骤的日志

### 日志内容

- ✅ 项目结构检查
- ✅ Demo编译过程
- ❌ 完整版编译失败原因
- ✅ 编译总结报告

---

## 💡 最佳实践

### 如果你想在GitHub上编译完整版

**需要准备**：

1. **获取structparser.exe**
   ```
   来源: Cryptic引擎工具包
   位置: utilities/bin/structparser.exe
   ```

2. **运行预编译步骤（本地）**
   ```batch
   cd I:\Night\Night\src\Night\GameServer
   ..\..\utilities\bin\structparser.exe [参数]
   ```

3. **复制生成的AutoGen文件**
   ```batch
   xcopy /E /I /Y "I:\Night\Night\src\CrossRoads\GameServerLib\AutoGen" "I:\QLWD\AutoGen"
   ```

4. **提交到Git**
   ```bash
   git add AutoGen
   git commit -m "Add pre-generated AutoGen files"
   git push origin main
   ```

5. **GitHub Actions就能编译成功了！**

---

## 🎮 已编译文件的使用

### Demo版本

**位置**（在Artifacts中）：
```
bin/GameServer_PVP_Demo.exe
bin/StartPVPDemo.bat
```

**运行方式**：
1. 下载Artifacts压缩包
2. 解压
3. 双击 `StartPVPDemo.bat`

### 完整版本（需要本地编译）

**配置文件方式**：
```
I:\Night\Night\tools\bin\启动全地图PVP服务器.bat
```

---

## 📝 相关文档

- ✅ `编译状态报告-最终.md` - 详细的编译状态
- ✅ `PVP启动指南.md` - PVP功能说明
- ✅ `如何编译全地图PVP版本.md` - 完整编译指南
- ✅ `已编译文件清单.md` - 可用文件列表

---

## 🔗 快速链接

- **仓库**: https://github.com/yanlongyang806-cyber/pvp
- **Actions**: https://github.com/yanlongyang806-cyber/pvp/actions
- **Releases**: https://github.com/yanlongyang806-cyber/pvp/releases

---

## ⚠️ 注意事项

### 隐私和安全

如果完整源码包含：
- 专有代码
- 游戏资产
- 敏感配置

**不要上传到公开的GitHub仓库！**

**建议**：
1. 使用私有仓库
2. 或只上传必要的文件
3. 或使用本地编译

---

## 🎯 推荐工作流程

### 开发和测试

1. **本地修改代码**
2. **本地编译测试**
3. **提交到GitHub**
4. **GitHub Actions自动构建Demo**
5. **手动上传完整编译版本到Releases**

### 发布版本

```bash
# 1. 本地编译成功
cd I:\Night\Night\src\Night\GameServer
msbuild NNOGameServer.sln /p:Configuration=Release

# 2. 创建发布包
mkdir Release_Package
copy Debug\GameServer.exe Release_Package\
copy ..\..\..\..\QLWD\bin\*.bat Release_Package\
copy ..\..\..\..\QLWD\*.md Release_Package\

# 3. 上传到GitHub Release
# 在GitHub网站上创建Release并上传压缩包
```

---

**最后更新**: 2025-11-22  
**状态**: GitHub Actions已配置，等待完整源码或AutoGen文件

