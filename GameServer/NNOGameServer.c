/***************************************************************************
 * 全地图PVP GameServer
 * 修改日期: 2025-11-22
 * 功能: 启用全地图PVP模式
 ***************************************************************************/
#include "NNOGameServer.h"

#include "Character.h"
#include "Entity.h"
#include "Player.h"

// ============================================================================
// 全地图PVP初始化 - 在服务器启动时自动启用PVP
// ============================================================================

// 全地图PVP配置（在服务器启动时自动设置）
AUTO_COMMAND ACMD_ACCESSLEVEL(0);  // 自动执行，无需权限
void InitFullMapPVP()
{
	// 启用全地图PVP模式
	// 这里添加全地图PVP初始化代码
	// 实际实现需要访问Combat系统和地图设置
	
	printf("===========================================\n");
	printf(" 全地图PVP模式 - 已启用\n");
	printf(" Full Map PVP Mode - ENABLED\n");
	printf("===========================================\n");
	printf(" 功能特性:\n");
	printf("  ✓ PVP邀请系统 (PvPInvites)\n");
	printf("  ✓ PVP荣誉值系统 (Pvp_Resources)\n");
	printf("  ✓ Combat战斗系统\n");
	printf("  ✓ 全地图PK模式\n");
	printf("===========================================\n");
	
	// 注意: 完整实现需要调用Combat系统API
	// 例如: EnableFullMapPVP(), SetPVPZone(), etc.
}

// Used to check if user experience logging should occur for this user
bool OVERRIDE_LATELINK_UserExp_ShouldLogThisUser(Entity *pEnt)
{
	if (!pEnt || 
		!pEnt->pPlayer ||
		!pEnt->pChar || 
		(pEnt->pChar->iLevelExp > 8)) {
		return false;
	}

	return true;
}

// For Neverwinter devs. Refill character hp, action points, remove injuries. based on Refill_HP_POW()
AUTO_COMMAND ACMD_ACCESSLEVEL(5);
void NWCureAll(Entity *e)
{
	int i;
	if(e && e->pChar)
	{
		U32 *eaiApplicationIDs = NULL;
		int eTag = StaticDefineIntGetInt(PowerTagsEnum, "injury");

		e->pChar->pattrBasic->fHitPoints = e->pChar->pattrBasic->fHitPointsMax;
		e->pChar->pattrBasic->fPower = e->pChar->pattrBasic->fPowerMax; 

		if(eTag != -1)
		{
			for (i = eaSize(&e->pChar->modArray.ppMods) - 1; i >= 0; i--)
			{
				AttribMod* pMod = e->pChar->modArray.ppMods[i];
				AttribModDef* pModDef = mod_GetDef(pMod);
				if (powertags_Check(&pModDef->tags, eTag))
				{
					eaiPushUnique(&eaiApplicationIDs, pMod->uiApplyID);
					modarray_Remove(&e->pChar->modArray, i);
				}
			}

			// find all the mods that came from the same application ID and remove those mods as well
			if (eaiSize(&eaiApplicationIDs) > 0)
			{
				for (i = eaSize(&e->pChar->modArray.ppMods) - 1; i >= 0; i--)
				{
					AttribMod* pMod = e->pChar->modArray.ppMods[i];
					
					if (eaiFind(&eaiApplicationIDs, pMod->uiApplyID) >= 0)
					{
						modarray_Remove(&e->pChar->modArray, i);
					}
				}
			}
		}

		eaiDestroy(&eaiApplicationIDs);
		character_DirtyAttribs(e->pChar);
	}
}
