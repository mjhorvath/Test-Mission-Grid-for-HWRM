-- this file contains parameters in the GUI scope
-- todo: why do some screens close when I press the Escape key, but others do not?
-- todo: what function controls the fact that the Speech Recall and Objectives List screens can toggle each other on/off? can I access this function?
-- todo: it *should not be* possible to click the floating JUMP button while the sector map screen is active; if it *is* possible, then I need to make adjustments to the button's position and/or visibility
-- todo: pausing the game when showing certain screens is important because the screens may fail to update when a ship moves to a different exit grid or out of range, thereby confusing things


--------------------------------------------------------------------------------
-- Various screen toggles
--

-- this event is triggered in "newtaskbar.lua", "keybindings.lua", "sectormapscreenmajor.lua" and "sectormapscreenminor.lua"
SectorMapScreenToggle = "MainUI_ScarEvent(\"SectorMapScreenToggleFunc()\")"
-- this event is triggered in "newtaskbar.lua", "keybindings.lua", "sectormapscreenmajor.lua" and "sectormapscreenminor.lua"
SquadMenuScreenToggle = "MainUI_ScarEvent(\"SquadMenuScreenToggleFunc()\")"
-- this event is triggered in "newtaskbar.lua" and "keybindings.lua"
SpeechRecallScreenToggle = "MainUI_ScarEvent(\"SpeechRecallScreenToggleFunc()\")"
-- this event is triggered in "newtaskbar.lua" and "keybindings.lua"
ObjectivesListScreenToggle = "MainUI_ScarEvent(\"ObjectivesListScreenToggleFunc()\")"
-- this event is triggered in "sectormapscreenminor.lua", "squadmenuscreenminor.lua", "sectormapscreenmajor.lua" and "squadmenuscreenmajor.lua"
SectorMapSquadMenuSwitch = "MainUI_ScarEvent(\"SectorMapSquadMenuSwitchFunc()\")"
-- update the label of the timer
UpdateTimeLabel = "MainUI_ScarEvent(\"UpdateTimeLabelFunc()\")"
-- leave a map and enter hyperspace
LeaveTheMapButton = "MainUI_ScarEvent(\"GetReadyAndLeaveSector()\")"

CloseQueueOfWindows =
[[
	print(say_something)
	if (UI_IsScreenActive("DialogueScreen") == 1) then
		UI_HideScreen("DialogueScreen")
	end
	if (UI_IsScreenActive("SpeechRecall") == 1) then
		UI_SetButtonPressed("NewTaskbar", "btnRecall", 0)
		UI_HideScreen("SpeechRecall")
	end
	if (UI_IsScreenActive("SquadMenuScreenMinor") == 1) then
		UI_SetButtonPressed("NewTaskbar", "btnSquadMenu", 0)
		UI_HideScreen("SquadMenuScreenMinor")
	end
	if (UI_IsScreenActive("ObjectivesList") == 1) then
		UI_SetButtonPressed("NewTaskbar", "btnObjectives", 0)
		UI_HideScreen("ObjectivesList")
	end
	if (UI_IsScreenActive("SectorMapScreenMinor") == 1) then
		UI_SetButtonPressed("NewTaskbar", "btnSectorMap", 0)
		UI_HideScreen("SectorMapScreenMinor")
	end
]]

TestCommands =
[[
	print("Testing interface commands.")
	Universe_EnableCmd(0, eBuildManager)
	Universe_EnableCmd(0, eLaunchManager)
	Universe_EnableCmd(0, eResearchManager)
--	Universe_EnableCmd(0, eMenu)
--	Universe_EnableCmd(0, ePopup)
--	Universe_EnableCmd(0, eSuperTurbo)
--	Universe_EnableCmd(0, eSwitchPlayer)
	Universe_EnableCmd(0, eTacticalOverlay)
--	Universe_EnableCmd(0, eTurboEnable)
]]


--------------------------------------------------------------------------------
-- Dialogue
-- currently only relevant in Sector D3
--

-- this event is triggered in "newtaskbar.lua" but not "keybindings.lua" (yet)
-- the dialogue script relies on a rule with a time interval to detect the selected ship, and thus does not function if time is paused
DialogueScreenToggle =
[[
	if (UI_IsScreenActive("DialogueScreen") == 1) then
		UI_HideScreen("DialogueScreen")
		UI_ReloadScreen("DialogueScreen")
	else
		UI_ReloadScreen("DialogueScreen")
		UI_ShowScreen("DialogueScreen", ePopup)
	end
]]

function CreateNewLogMessage(_index, _string, _color)
	return
	{
		type = "TextLabel",
		name = "btnLogItem_" .. _index,
		Layout =
		{
			pivot_XY = {0.0, 0.0},
			pos_XY = {x = 0, y = 0, xr = "px", yr = "px",},
			size_WH = {w = 388 - 16, h = 500, wr = "px", hr = "px",},
			pad_LT = {l = 8, t = 8, lr = "px", tr = "px",},
			pad_RB = {r = 8, b = 8, rr = "px", br = "px",},
		},
		autosize = 1,
		wrapping = 1,
		Text =
		{
			text = _string,
			textStyle = "FEButtonTextStyle",
			color = _color,
			hAlign = "Left",
			vAlign = "Top",
		},
	}
end

function CreateNewDialogueButton(_index, _string, _onclick)
	return
	{
		type = "Button",
		name = "btnDialogueChoice_" .. _index,
		buttonStyle = "FEButtonStyle1_Outlined",
		soundOnClicked = "SFX_ButtonClick",
		onMouseClicked = _onclick,
		Layout =
		{
			pivot_XY = {0.5, 0.0},
			pos_XY = {x = 0.5, y = 0, xr = "par", yr = "px",},
			min_WH = {w = 372, h = 36, wr = "px", hr = "px",},
		},
		wrapping = 1,
		autosize = 1,
		;
		{
			type = "TextLabel",
			giveParentMouseInput = 1,
			Layout =
			{
				size_WH = { w = 1.0, h = 0, wr = "par", hr = "px" },
			},
			Text =
			{
				text = _string,
--				textStyle = "RM_MenuButton_TextStyle",
				hAlign = "Left",
				vAlign = "Center",
			},
			autosize = 1,
			wrapping = 1,
		},
	}
end


--------------------------------------------------------------------------------
-- Game timer
--

GameTimeSlowDownClick = "MainUI_ScarEvent(\"GameTimeSlowDownFunc()\")"
GameTimeSpeedUpClick = "MainUI_ScarEvent(\"GameTimeSpeedUpFunc()\")"
GameTimePauseClick = "MainUI_ScarEvent(\"GameTimePauseFunc()\")"


--------------------------------------------------------------------------------
-- Save and load game
--

SaveGameMouseClick = [[UI_ShowScreen("ProgressSave", ePopup);]]
SaveGameYes = [[UI_HideScreen("ProgressSave"); MainUI_ScarEvent("SaveGameWithDialog()");]]
SaveGameNo = [[UI_HideScreen("ProgressSave");]]
LoadGameMouseClick = [[UI_ShowScreen("ProgressLoad", ePopup);]]
LoadGameYes = [[UI_HideScreen("ProgressLoad"); MainUI_ScarEvent("ClearTempFiles()"); FE_RestartGame(0);]]
LoadGameNo = [[UI_HideScreen("ProgressLoad");]]
ExitGameMouseClick = [[UI_ShowScreen("ProgressExit", ePopup);]]
ExitGameYes = [[UI_HideScreen("ProgressExit"); MainUI_ScarEvent("ClearTempFiles()"); FE_ExitToWindows();]]
ExitGameNo = [[UI_HideScreen("ProgressExit");]]
