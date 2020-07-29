-- TEMP FILES SHOULD NOT BE LOADED FROM HERE


function ClearTempFiles()
	local WriteFile = "$TMG_tempsquadmenu.lua"
		writeto(WriteFile)
		write("")
		writeto()
	WriteFile = "$TMG_tempsectormap.lua"
		writeto(WriteFile)
		write("")
		writeto()
	WriteFile = "$TMG_tempdialoguestatus.lua"
		writeto(WriteFile)
		write("")
		writeto()
end

function ReloadVisibleScreens()
	local sectormap = ""
	local squadmenu = ""
	if (gametypeScope == "minor") then
		sectormap = "SectorMapScreenMinor"
		squadmenu = "SquadMenuScreenMinor"
	elseif (gametypeScope == "major") then
		sectormap = "SectorMapScreenMajor"
		squadmenu = "SquadMenuScreenMajor"
	end
	-- todo: fails sometimes, for instance when the screen turns into a letterbox
--	if (UI_IsScreenActive(sectormap) == 1) then
--		UI_ReloadScreen(sectormap)
--	elseif (UI_IsScreenActive(squadmenu) == 1) then
--		UI_ReloadScreen(squadmenu)
--	end
	if (isSectorMapScreenActive == 1) then
		UI_ReloadScreen(sectormap)
	elseif (isSquadMenuScreenActive == 1) then
		UI_ReloadScreen(squadmenu)
	end
end

function ReloadAllScreens()
	local sectormap = ""
	local squadmenu = ""
	if (gametypeScope == "minor") then
		sectormap = "SectorMapScreenMinor"
		squadmenu = "SquadMenuScreenMinor"
	elseif (gametypeScope == "major") then
		sectormap = "SectorMapScreenMajor"
		squadmenu = "SquadMenuScreenMajor"
	end
	UI_ReloadScreen(sectormap)
	UI_ReloadScreen(squadmenu)
end


--------------------------------------------------------------------------------
-- Screen toggles
--

function ObjectivesListScreenToggleFunc()
	if (gametypeScope == "minor") then
		if (UI_IsScreenActive("ObjectivesList") == 1) then
			UI_SetButtonPressed("NewTaskbar", "btnObjectives", 0)
			UI_HideScreen("ObjectivesList")
		else
			UI_SetButtonPressed("NewTaskbar", "btnObjectives", 1)
			UI_ShowScreen("ObjectivesList", ePopup)
			if (UI_IsScreenActive("SquadMenuScreenMinor") == 1) then
				UI_SetButtonPressed("NewTaskbar", "btnSquadMenu", 0)
				UI_HideScreen("SquadMenuScreenMinor")
				isSquadMenuScreenActive = 0
			end
			if (UI_IsScreenActive("SectorMapScreenMinor") == 1) then
				UI_SetButtonPressed("NewTaskbar", "btnSectorMap", 0)
				UI_HideScreen("SectorMapScreenMinor")
				isSectorMapScreenActive = 0
			end
			if (UI_IsScreenActive("SpeechRecall") == 1) then
				UI_SetButtonPressed("NewTaskbar", "btnRecall", 0)
				UI_HideScreen("SpeechRecall")
			end
		end
	end
end

function SpeechRecallScreenToggleFunc()
	if (gametypeScope == "minor") then
		if (UI_IsScreenActive("SpeechRecall") == 1) then
			UI_SetButtonPressed("NewTaskbar", "btnRecall", 0)
			UI_HideScreen("SpeechRecall")
		else
			UI_SetButtonPressed("NewTaskbar", "btnRecall", 1)
			UI_ShowScreen("SpeechRecall", ePopup)
			if (UI_IsScreenActive("ObjectivesList") == 1) then
				UI_SetButtonPressed("NewTaskbar", "btnObjectives", 0)
				UI_HideScreen("ObjectivesList")
			end
			if (UI_IsScreenActive("SquadMenuScreenMinor") == 1) then
				UI_SetButtonPressed("NewTaskbar", "btnSquadMenu", 0)
				UI_HideScreen("SquadMenuScreenMinor")
				isSquadMenuScreenActive = 0
			end
			if (UI_IsScreenActive("SectorMapScreenMinor") == 1) then
				UI_SetButtonPressed("NewTaskbar", "btnSectorMap", 0)
				UI_HideScreen("SectorMapScreenMinor")
				isSectorMapScreenActive = 0
			end
		end
	end
end

function SectorMapScreenToggleFunc()
	if (gametypeScope == "minor") then
		if (UI_IsScreenActive("SectorMapScreenMinor") == 1) then
			UI_SetButtonPressed("NewTaskbar", "btnSectorMap", 0)
			UI_HideScreen("SectorMapScreenMinor")
			isSectorMapScreenActive = 0
		else
			UI_SetButtonPressed("NewTaskbar", "btnSectorMap", 1)
			UI_ShowScreen("SectorMapScreenMinor", ePopup)
			UI_ReloadScreen("SectorMapScreenMinor")
			isSectorMapScreenActive = 1
			if (UI_IsScreenActive("SpeechRecall") == 1) then
				UI_SetButtonPressed("NewTaskbar", "btnRecall", 0)
				UI_HideScreen("SpeechRecall")
			end
			if (UI_IsScreenActive("ObjectivesList") == 1) then
				UI_SetButtonPressed("NewTaskbar", "btnObjectives", 0)
				UI_HideScreen("ObjectivesList")
			end
			if (UI_IsScreenActive("SquadMenuScreenMinor") == 1) then
				UI_SetButtonPressed("NewTaskbar", "btnSquadMenu", 0)
				UI_HideScreen("SquadMenuScreenMinor")
				isSquadMenuScreenActive = 0
			end
		end
	elseif (gametypeScope == "major") then
		SectorMapSquadMenuSwitchFunc()
	end
end

function SquadMenuScreenToggleFunc()
	if (gametypeScope == "minor") then
		if (UI_IsScreenActive("SquadMenuScreenMinor") == 1) then
			UI_SetButtonPressed("NewTaskbar", "btnSquadMenu", 0)
			UI_HideScreen("SquadMenuScreenMinor")
			isSquadMenuScreenActive = 0
		else
			UI_SetButtonPressed("NewTaskbar", "btnSquadMenu", 1)
			UI_ShowScreen("SquadMenuScreenMinor", ePopup)
			UI_ReloadScreen("SquadMenuScreenMinor")
			isSquadMenuScreenActive = 1
			if (UI_IsScreenActive("SectorMapScreenMinor") == 1) then
				UI_SetButtonPressed("NewTaskbar", "btnSectorMap", 0)
				UI_HideScreen("SectorMapScreenMinor")
				isSectorMapScreenActive = 0
			end
			if (UI_IsScreenActive("SpeechRecall") == 1) then
				UI_SetButtonPressed("NewTaskbar", "btnRecall", 0)
				UI_HideScreen("SpeechRecall")
			end
			if (UI_IsScreenActive("ObjectivesList") == 1) then
				UI_SetButtonPressed("NewTaskbar", "btnObjectives", 0)
				UI_HideScreen("ObjectivesList")
			end
		end
	elseif (gametypeScope == "major") then
		SectorMapSquadMenuSwitchFunc()
	end
end

function SectorMapSquadMenuSwitchFunc()
	if (gametypeScope == "minor") then
		if (UI_IsScreenActive("SectorMapScreenMinor") == 1) then
			UI_HideScreen("SectorMapScreenMinor")
			UI_SetButtonPressed("NewTaskbar", "btnSectorMap", 0)
			isSectorMapScreenActive = 0
			UI_ShowScreen("SquadMenuScreenMinor", ePopup)
			UI_ReloadScreen("SquadMenuScreenMinor")
			UI_SetButtonPressed("NewTaskbar", "btnSquadMenu", 1)
			isSquadMenuScreenActive = 1
		elseif (UI_IsScreenActive("SquadMenuScreenMinor") == 1) then
			UI_HideScreen("SquadMenuScreenMinor")
			UI_SetButtonPressed("NewTaskbar", "btnSquadMenu", 0)
			isSquadMenuScreenActive = 0
			UI_ShowScreen("SectorMapScreenMinor", ePopup)
			UI_ReloadScreen("SectorMapScreenMinor")
			UI_SetButtonPressed("NewTaskbar", "btnSectorMap", 1)
			isSectorMapScreenActive = 1
		end
	elseif (gametypeScope == "major") then
		if (UI_IsScreenActive("SectorMapScreenMajor") == 1) then
			UI_HideScreen("SectorMapScreenMajor")
			isSectorMapScreenActive = 0
			UI_ShowScreen("SquadMenuScreenMajor", ePopup)
			UI_ReloadScreen("SquadMenuScreenMajor")
			isSquadMenuScreenActive = 1
		elseif (UI_IsScreenActive("SquadMenuScreenMajor") == 1) then
			UI_HideScreen("SquadMenuScreenMajor")
			isSquadMenuScreenActive = 0
			UI_ShowScreen("SectorMapScreenMajor", ePopup)
			UI_ReloadScreen("SectorMapScreenMajor")
			isSectorMapScreenActive = 1
		end
	end
end

function UpdateTimeLabelFunc()
	UI_SetLabelTextHotkey("SectorMapScreenMajor", "txtTimeShowRate", newGameTimeText, 666)
end


--------------------------------------------------------------------------------
-- save persistant data
--
function SavePersistentData()
	print("Gametype: Saving campaign status...")
	local WriteFile = "$TMG_savegame.lua"
	writeto(WriteFile)

	print("Gametype: Writing map progress...")
	write("colLabels = {\"A\",\"B\",\"C\",\"D\",\"E\",\"F\",\"G\",\"H\",}		-- sector column labels\n")
	write("modVersion = \"" .. currentModVersion .. "\"		-- mod version number, hopefully correct ;)\n")
	write("campaignIsStarted = 1\t\t-- 0 or 1\n")
	write("loadSectorMap = " .. loadSectorMap .. "\n")
	write("playerRUs = " .. Player_GetRU(0) .. "\n")
	write("currentGameTime = " .. currentGameTime .. "\n")
	write("legibleGameTime = \"" .. legibleGameTime .. "\"\n\n")
	write("currentSectorRow = " .. currentSectorRow .. "\t\t-- 1 to 4\n")
	write("currentSectorCol = " .. currentSectorCol .. "\t\t-- 1 to 4\n")
	write("sectorCode = colLabels[currentSectorCol] .. currentSectorRow\t\t-- for instance \"A1\" or \"D3\"\n")
	write("sectorName = \"Sector \" .. sectorCode\t\t-- for instance \"Sector A1\" or \"Sector D3\"\n\n")
	print("Gametype: Done writing map progress!")

	write("-- sectors you have visited\n")
	WriteSectorsExplored()
	write("-- sector missions you have completed\n")
	WriteObjectivesClear()

	print("Gametype: Writing quest progress...")
	WriteQuestsStatus()
	print("Gametype: Done writing quest progress!")

	print("Gametype: Writing global time queue...")
	WriteGlobalTimeQueue()
	print("Gametype: Done writing global time queue!")

	print("Gametype: Writing squad ships...")
	WriteSquadShips()
	print("Gametype: Done writing squad ships!")

	print("Gametype: Writing local ships...")
	WriteLocalShips()
	print("Gametype: Done writing local ships!")

	print("Gametype: Writing local sobgroups...")
	WriteLocalSobgroups()
	print("Gametype: Done writing local sobgroups!")

	writeto()
	print("Gametype: Done saving campaign status!")
end


--------------------------------------------------------------------------------
-- save game and show confirmation dialog (confirmation dialog is triggered elsewhere)
--
function SaveGameWithDialog()
	if (gametypeScope == "minor") then
		UpdateSquadShips()
		UpdateLocalShips()
		SavePersistentData()
	elseif (gametypeScope == "major") then
		SavePersistentData()
	end
end


--------------------------------------------------------------------------------
-- 
--
function SobGroup_Separate(outgroup, fromgroup)
	-- created by shadowwinterknig
	local c, i, n = SobGroup_Count(fromgroup), 0, 0
	SobGroup_CreateIfNotExist("temp")
	SobGroup_Clear("temp")
	while i < c do
		SobGroup_FillShipsByIndexRange("temp", fromgroup, i, 1)
		if (SobGroup_Count("temp") > 0) then
			SobGroup_CreateIfNotExist(outgroup .. n)
			SobGroup_Clear(outgroup .. n)
			SobGroup_SobGroupAdd(outgroup .. n, "temp")
			i = i + SobGroup_Count("temp")
			n = n + 1
		else
			i = i + 1
		end
	end
	return n
end
