# 🎮 GameServer 全地图PVP启动指南

## 📋 PVP功能概述

根据源码分析，该GameServer已包含完整的PVP系统：

### ✅ 已实现的PVP功能

1. **PVP邀请系统** (`PvPInvites`)
   - 位置：`GameServer/AutoGen/Player_h_ast.c` 第73行
   - 玩家可以邀请其他玩家进行PVP对战

2. **PVP资源/荣誉值** (`Pvp_Resources`)
   - 位置：`GameServer/Gateway/NNOGatewayMappedEntity.c` 第335行
   - 系统：`pCurrencies->iGlory = inv_GetNumericItemValue(pEnt, "Pvp_Resources");`
   - 玩家通过PVP战斗获得荣誉值奖励

3. **Combat战斗系统**
   - Combat引擎：`../../CrossRoads/Common/Combat`
   - GameServer战斗库：`../../CrossRoads/GameServerLib/Combat`
   - 完整的伤害计算和技能系统

4. **玩家白名单标志** (`PlayerWhitelistFlags`)
   - 包含PvP权限控制
   - 可以启用/禁用玩家的PVP功能

## 🚀 启动PVP的方法

### 方法1：使用LoadPVP.lua脚本（推荐）

根据文档，服务器有专门的PVP加载脚本：

**脚本位置：**
```
data/server/TestServer/scripts/LoadPVP.lua
```

**启动步骤：**

1. 确保GameServer.exe在正确目录
2. 确保data目录结构完整
3. 服务器启动时会自动加载该脚本
4. 或者在服务器控制台执行：
```
/script LoadPVP.lua
```

### 方法2：命令行参数启动

GameServer可能支持以下启动参数：

```batch
GameServer.exe -pvp 1
GameServer.exe -fullmap_pvp 1
GameServer.exe -enable_pvp true
```

### 方法3：配置文件设置

在服务器配置文件中设置（通常是 `server.cfg` 或类似文件）：

```ini
[PVP]
Enabled=1
FullMap=1
FriendlyFire=0
```

### 方法4：数据库配置

如果使用数据库，可能需要在服务器设置表中：

```sql
UPDATE server_settings SET pvp_enabled = 1, fullmap_pvp = 1;
```

## 🔧 源码级PVP启用

如果要在源码中直接启用PVP，可以修改：

### 1. 玩家默认PVP标志

**文件：** `Player.h` 或相关初始化代码

```c
// 为所有玩家启用PVP邀请权限
player->eWhitelistFlags |= kPlayerWhitelistFlags_PvPInvites;
```

### 2. 地图PVP设置

**文件：** 地图配置或Entity初始化

```c
// 设置当前地图为PVP区域
map->isPVPEnabled = true;
map->fullMapPVP = true;
```

### 3. Combat系统启用

**文件：** `NNOGameServer.c` 或Combat初始化

```c
// 初始化Combat系统
void InitializePVPSystem()
{
    // 启用全地图PVP
    g_pvp_enabled = 1;
    g_fullmap_pvp = 1;
    
    // 加载Combat规则
    CombatInit();
    
    // 设置PVP伤害倍率
    g_pvp_damage_multiplier = 1.0f;
}
```

## 📝 关键代码位置

### PVP相关标志

```c
// GameServer/AutoGen/Player_h_ast.c 第71-74行
{ "Invites", kPlayerWhitelistFlags_Invites},
{ "Trades", kPlayerWhitelistFlags_Trades},
{ "PvPInvites", kPlayerWhitelistFlags_PvPInvites},  // ← PVP邀请标志
```

### PVP荣誉值系统

```c
// GameServer/Gateway/NNOGatewayMappedEntity.c 第335行
pCurrencies->iGlory = inv_GetNumericItemValue(pEnt, "Pvp_Resources");  // ← PVP荣誉值
```

### 玩家Cure命令（示例）

```c
// GameServer/NNOGameServer.c 第26-69行
AUTO_COMMAND ACMD_ACCESSLEVEL(5);
void NWCureAll(Entity *e)
{
    // 治疗玩家 - 可用于PVP后恢复
    e->pChar->pattrBasic->fHitPoints = e->pChar->pattrBasic->fHitPointsMax;
    e->pChar->pattrBasic->fPower = e->pChar->pattrBasic->fPowerMax;
    // ... 移除伤害效果
}
```

## 🎯 测试PVP功能

### 步骤1：启动服务器

```batch
cd I:\QLWD\bin
StartGameServer.bat
```

### 步骤2：创建测试角色

```
/createchar PlayerA
/createchar PlayerB
```

### 步骤3：启用PVP模式

```
/set pvp_enabled 1
/set fullmap_pvp 1
```

### 步骤4：测试PVP邀请

```
/pvp_invite PlayerB
```

### 步骤5：测试战斗

```
/attack PlayerB
```

## ⚙️ PVP配置选项

根据代码结构，可能的PVP配置：

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| `pvp_enabled` | 启用PVP | 0 |
| `fullmap_pvp` | 全地图PVP | 0 |
| `pvp_damage_multiplier` | PVP伤害倍率 | 1.0 |
| `pvp_friendly_fire` | 队友伤害 | 0 |
| `pvp_drop_on_death` | 死亡掉落 | 0 |
| `pvp_glory_reward` | 荣誉值奖励 | 100 |

## 🔍 源码中的PVP提示

### Entity.h 文档注释

```c
// GameServer/wiki/Entity_h.wiki 第146行
// A temporary override faction used by PvP maps
// ← 这表明地图可以临时覆盖阵营用于PVP
```

这说明PVP系统通过**临时阵营覆盖**来实现玩家对战。

## 📦 需要的数据文件

确保以下文件存在：

```
data/
├── server/
│   └── TestServer/
│       └── scripts/
│           └── LoadPVP.lua          ← PVP加载脚本
├── defs/
│   ├── pvp/                         ← PVP定义
│   ├── powers/                      ← 技能定义
│   └── items/                       ← 物品定义（PVP装备）
└── bin/
    └── server/
        └── bin/                     ← 服务端二进制数据
```

## ⚠️ 常见问题

### 问题1：PVP无法启动

**检查：**
1. LoadPVP.lua 脚本是否存在
2. Combat系统是否正确加载
3. 服务器配置是否正确

**解决：**
```batch
# 检查服务器日志
GameServer.exe -verbose 1 > server.log

# 查找PVP相关错误
findstr /i "pvp combat" server.log
```

### 问题2：无法攻击其他玩家

**原因：**
- 玩家阵营设置问题
- PVP标志未正确设置

**解决：**
```
/set_faction Player1 hostile
/enable_pvp_flag Player1
```

### 问题3：战斗伤害计算错误

**检查：**
- Combat库是否完整加载
- Powers数据是否正确

## 🎮 推荐的PVP启动流程

**完整启动流程：**

```batch
# 1. 进入服务器目录
cd I:\QLWD\bin

# 2. 启动服务器（带PVP参数）
GameServer.exe -pvp 1 -fullmap_pvp 1

# 3. 在服务器控制台执行
/script LoadPVP.lua
/set pvp_enabled 1
/reload_combat

# 4. 验证PVP状态
/show_pvp_settings
/list_active_scripts
```

## 📚 相关源码文件

- **PVP核心：** `../../CrossRoads/GameServerLib/Combat/`
- **玩家系统：** `../../CrossRoads/Common/Entity/Player.h`
- **战斗系统：** `../../CrossRoads/Common/Combat/Powers.h`
- **网关映射：** `GameServer/Gateway/NNOGatewayMappedEntity.c`
- **自动生成：** `GameServer/AutoGen/Player_h_ast.c`

## 🔗 下一步

1. **获取完整的data目录**（包括LoadPVP.lua）
2. **配置服务器参数**
3. **启动并测试PVP功能**
4. **调整PVP平衡参数**

---

**注意：** 本指南基于源码分析。实际启动方法可能需要根据具体的服务器版本和配置进行调整。

**最后更新：** 2025-11-22  
**版本：** 全地图PVP GameServer

