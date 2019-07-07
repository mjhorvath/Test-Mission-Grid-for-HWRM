-- TEMP FILES SHOULD NOT BE LOADED FROM HERE


gametypeScope = "major"
oldGameTimeRate = 0
oldGameTimeText = ""
newGameTimeRate = 0
newGameTimeText = ""
timerPaused = 1
timerRuleRate = 1/6	-- once per minute at the slowest rate
isSectorMapScreenActive = 1
isSquadMenuScreenActive = 0


--------------------------------------------------------------------------------
-- needed for save game compatibility
--
function OnStartOrLoad()
	ClearTempFiles()
	PrepareTheScreen()
	WriteTempSectorMapData()
	WriteTempSquadMenuData()
	ReloadAllScreens()
end


--------------------------------------------------------------------------------
-- initialize the game with persistent data
--
function StartMission()
	Player_SetRU(0, playerRUs)
	GameTimeInitializeFunc()
	Rule_AddInterval("Rule_IncrementTimer", timerRuleRate)
--	Rule_AddInterval("Rule_TestStuff", 2)
end


--------------------------------------------------------------------------------
-- enter a sector from galaxy map
--
function EnterSectorFromGalaxyMap()
	loadSectorMap = 0
	SavePersistentData()
	ClearTempFiles()
	print("Gametype: Restarting game...")
	FE_RestartGame(0)		-- restarts the current mission without signaling campaign completion
end


--------------------------------------------------------------------------------
-- enable and disable the correct screens and screen elements
--
function PrepareTheScreen()
	UI_ShowScreen("SectorMapScreenMajor", ePopup)
	UI_HideScreen("ResourceMenu")
	UI_HideScreen("NewTaskbar")
	UI_SetScreenEnabled("NewTaskbar", 0)
	MainUI_DisableCommand(eBuildManager, 1)
	MainUI_DisableCommand(eLaunchManager, 1)
	MainUI_DisableCommand(eResearchManager, 1)
	MainUI_DisableCommand(ePause, 1)
	MainUI_DisableCommand(eScuttle, 1)
	MainUI_DisableCommand(eScuttle, 1)
	MainUI_DisableCommand(eSpecialAttack, 1)
	MainUI_DisableCommand(eSpecialAttack, 1)
	MainUI_DisableCommand(eMove, 1)
	MainUI_DisableCommand(eHyperspace, 1)
	MainUI_DisableCommand(eHarvest, 1)
	MainUI_DisableCommand(eHarvest, 1)
	MainUI_DisableCommand(eGuard, 1)
	MainUI_DisableCommand(eDock, 1)
	MainUI_DisableCommand(eParade, 1)
	MainUI_DisableCommand(eCancelOrders, 1)
--	MainUI_DisableCommand(eCancel, 1)
	MainUI_DisableCommand(eSensorPing, 1)
	MainUI_DisableCommand(eRepair, 1)
	MainUI_DisableCommand(eRallyPoint, 1)
	MainUI_DisableCommand(eRallyObject, 1)
	MainUI_DisableCommand(eRetire, 1)
	MainUI_DisableCommand(eDropMinesInstant, 1)
	MainUI_DisableCommand(eMoveAttack, 1)
	MainUI_DisableCommand(eMilitary, 1)
	MainUI_DisableCommand(eNotInStrikeGroup, 1)
	MainUI_DisableCommand(ePreviousTactic, 1)
	MainUI_DisableCommand(eNextTactic, 1)
	MainUI_DisableCommand(eTactics, 1)
	MainUI_DisableCommand(eStance, 1)
	MainUI_DisableCommand(eFocusHome, 1)
	MainUI_DisableCommand(eFocus, 1)
	MainUI_DisableCommand(eSelectAllVisible, 1)
	MainUI_DisableCommand(eNextFocus, 1)
	MainUI_DisableCommand(ePreviousFocus, 1)
	MainUI_DisableCommand(eZoom, 1)
	MainUI_DisableCommand(eTacticalOverlay, 1)
	MainUI_DisableCommand(eResearchManager, 1)
	MainUI_DisableCommand(eBuildManager, 1)
	MainUI_DisableCommand(eBuildManager, 1)
	MainUI_DisableCommand(eLaunchManager, 1)
	MainUI_DisableCommand(eLaunchManager, 1)
	MainUI_DisableCommand(eSensorsManager, 1)
	MainUI_DisableCommand(eHUD, 1)
	MainUI_DisableCommand(eGroup, 1)		-- there should actually be 10 of these
	MainUI_DisableCommand(eSelectGroup, 1)		-- there should actually be 10 of these
end
