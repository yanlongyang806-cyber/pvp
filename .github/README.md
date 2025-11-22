# GitHub Actions 自动编译

## 🚀 自动编译状态

每次推送代码到GitHub，都会自动触发编译流程。

### 查看编译状态

访问仓库的 **Actions** 标签页：
```
https://github.com/yanlongyang806-cyber/pvp/actions
```

### 手动触发编译

1. 进入 Actions 页面
2. 选择 "Build GameServer (PVP Edition)" 工作流
3. 点击 "Run workflow" 按钮
4. 选择 main 分支
5. 点击 "Run workflow" 确认

## 📋 编译流程

GitHub Actions 会执行以下步骤：

1. ✅ 检出代码
2. ✅ 设置 MSBuild 环境
3. ✅ 检查项目文件
4. ✅ 显示依赖状态
5. ⚠️ 尝试编译（可能因缺少依赖而失败）
6. ✅ 生成编译总结
7. ✅ 上传项目文档

## ⚠️ 重要说明

**当前限制：**
- 项目需要完整的 Cryptic 引擎依赖库
- GitHub Actions 环境中没有这些依赖
- 编译步骤会失败，但这是**预期行为**

**可用内容：**
- ✅ 完整的源代码（132文件）
- ✅ PVP功能实现（PvPInvites, Combat系统）
- ✅ 完整的文档和指南
- ✅ 预编译的 GameServer.exe（本地有）

## 📦 获取可执行文件

由于编译需要外部依赖，建议：

1. **本地编译**：如果你有完整的引擎源码
   ```batch
   cd I:\Night\Night\src\Night\GameServer
   msbuild NNOGameServer.sln
   ```

2. **使用预编译版本**：
   - 查看 `bin/DOWNLOAD_EXE.md` 获取说明
   - GameServer.exe (40.3 MB) + 36个DLL文件

## 🔍 CI/CD 配置文件

- **工作流配置**：`.github/workflows/build-gameserver.yml`
- **触发条件**：
  - Push 到 main 分支
  - Pull Request 到 main 分支
  - 手动触发

## 📊 编译徽章

将以下内容添加到主 README.md 以显示编译状态：

```markdown
![Build Status](https://github.com/yanlongyang806-cyber/pvp/actions/workflows/build-gameserver.yml/badge.svg)
```

## 💡 未来改进

如果获得了依赖库，可以：
1. 将依赖库添加到仓库（如果许可允许）
2. 使用 Git Submodules 引用依赖
3. 设置缓存加速编译
4. 自动发布编译产物

---

**最后更新**：2025-11-22  
**项目**：全地图PVP GameServer

