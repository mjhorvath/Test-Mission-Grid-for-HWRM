-- TEMP FILES SHOULD NOT BE LOADED FROM HERE
dofilepath("data:scripts\\TMG_breadthfirstsearch.lua")

moveButtonPressed = 0
hoverPath = {}


--------------------------------------------------------------------------------
-- Sector map functions
--

function MouseClickSectorMapButton(j, k)
	if (moveButtonPressed == 1) then
		if ((currentSectorRow == j) and (currentSectorCol == k)) then
			MouseExitSectorMapButton(j, k)
			MouseClickMoveButton(movingSquad)
			return
		end
		local temp_node_a = hoverPath[1]
		local temp_node_b = hoverPath[2]
		local player_index = 0
		local this_squad = squadShips[player_index + 1][movingSquad]
		local this_path = this_squad.travel.path
		local this_ships = this_squad.ships
		local this_minspeed = CalcMinHyperSpeed(this_ships)
		local this_traveltime = CalcSectorTravelTime(this_minspeed)
		local this_cantravel = CanShipsTravel(this_ships)
		local temp_squad =
		{
			travel =
			{
				path = ttrim(hoverPath),
				lastpathnode = {temp_node_a[1],temp_node_a[2],tranDirections[temp_node_b[3]],},
				inhyperspace = 1,
				minhyperspeed = this_minspeed,
				cantravel = this_cantravel,
				escaping = 0,
				intransit = 1,			-- todo: switch over to this instead of inhyperspace
				departuretime = currentGameTime,
				arrivaltime = currentGameTime + this_traveltime,
			},
			task = {},
			ships = this_ships,
		}
		squadShips[player_index + 1][movingSquad] = temp_squad
		Queue_AddTask(this_traveltime, player_index + 1, movingSquad, "travel")
		WriteTempSectorMapData()
		WriteTempSquadMenuData()
		ReloadVisibleScreens()
		MouseExitSectorMapButton(j, k)
		MouseClickMoveButton(movingSquad)
		MouseClickSectorMapButton(currentSectorRow, currentSectorCol)		-- todo: temp files are being written here once again, despite just having been written above
	else
		if ((currentSectorRow ~= j) or (currentSectorCol ~= k)) then
			UI_SetElementVisible("SectorMapScreenMajor", "missionTop_" .. currentSectorRow .. "_" .. currentSectorCol, 0)
			UI_SetElementVisible("SectorMapScreenMajor", "missionTop_" .. j .. "_" .. k, 1)
		end

		local location_text = "LOCATION: SECTOR " .. colLabels[k] .. j
		UI_SetTextLabelText("SectorMapScreenMajor", "lblLocationLabel", location_text)

		local enter_bool = 0
		local player_index = 0
		local this_player = squadShips[player_index + 1]
		for i, this_squad in this_player do
			if (this_squad ~= nil) then
				local this_path = this_squad.travel.path
				local this_destination = this_path[1]
				local this_destination_row = this_destination[1]
				local this_destination_col = this_destination[2]
				local this_escaping = this_squad.travel.escaping
				local this_canhyperspace = this_squad.travel.cantravel
				local this_intransit = this_squad.travel.intransit
				local this_count_ships = getn(this_squad.ships)
				local move_bool = 0
				local stop_bool = 0
				if ((this_destination_row == j) and (this_destination_col == k) and (this_escaping == 0) and (this_count_ships > 0)) then
					if (this_intransit == 0) then
						if (this_canhyperspace == 1) then
							move_bool = 1
						end
						enter_bool = 1
					else
						stop_bool = 1
					end
				end
				UI_SetElementEnabled("SectorMapScreenMajor", "btnStop_" .. i, stop_bool)
				UI_SetElementEnabled("SectorMapScreenMajor", "btnMoveBlu_" .. i, move_bool)
				UI_SetElementEnabled("SectorMapScreenMajor", "btnMoveRed_" .. i, move_bool)
			end
		end
		UI_SetElementEnabled("SectorMapScreenMajor", "m_btnLeaveMap", enter_bool)

		currentSectorRow = j
		currentSectorCol = k

		WriteTempSectorMapData()
		WriteTempSquadMenuData()
	end
end

function MouseEnterSectorMapButton(j, k)
	if (moveButtonPressed == 1) then
		if ((currentSectorRow == j) and (currentSectorCol == k)) then
			UI_SetElementVisible("SectorMapScreenMajor", "frmLine_" .. j .. "_" .. k .. "_" .. 5 .. "_" .. 5, 1)
			return
		end
		local start_coordinates = {currentSectorRow, currentSectorCol}
		local final_coordinates = {j, k}
		local map_grid = tcopy(terrainTable)
		local path_table = findShortestPath(start_coordinates, final_coordinates, map_grid)
		local path_count = getn(path_table)
		for i = 1, path_count do
			local this_node = path_table[i]
			if (i == 1) then
				local next_node = path_table[i+1]
				UI_SetElementVisible("SectorMapScreenMajor", "frmLine_" .. this_node[1] .. "_" .. this_node[2] .. "_" .. 5 .. "_" .. tranDirections[next_node[3]], 1)
			elseif (i == path_count) then
				UI_SetElementVisible("SectorMapScreenMajor", "frmLine_" .. this_node[1] .. "_" .. this_node[2] .. "_" .. this_node[3] .. "_" .. 5, 1)
			else
				local next_node = path_table[i+1]
				UI_SetElementVisible("SectorMapScreenMajor", "frmLine_" .. this_node[1] .. "_" .. this_node[2] .. "_" .. this_node[3] .. "_" .. tranDirections[next_node[3]], 1)
			end
		end
		UI_SetButtonPressed("SectorMapScreenMajor", "missionTop_" .. j .. "_" .. k, 1)
		hoverPath = path_table
	end
end

function MouseExitSectorMapButton(j, k)
	if (moveButtonPressed == 1) then
		if ((currentSectorRow == j) and (currentSectorCol == k)) then
			UI_SetElementVisible("SectorMapScreenMajor", "frmLine_" .. j .. "_" .. k .. "_" .. 5 .. "_" .. 5, 0)
			return
		end
		local path_table = hoverPath
		local path_count = getn(path_table)
		for i = 1, path_count do
			local this_node = path_table[i]
			if (i == 1) then
				local next_node = path_table[i+1]
				UI_SetElementVisible("SectorMapScreenMajor", "frmLine_" .. this_node[1] .. "_" .. this_node[2] .. "_" .. 5 .. "_" .. tranDirections[next_node[3]], 0)
			elseif (i == path_count) then
				UI_SetElementVisible("SectorMapScreenMajor", "frmLine_" .. this_node[1] .. "_" .. this_node[2] .. "_" .. this_node[3] .. "_" .. 5, 0)
			else
				local next_node = path_table[i+1]
				UI_SetElementVisible("SectorMapScreenMajor", "frmLine_" .. this_node[1] .. "_" .. this_node[2] .. "_" .. this_node[3] .. "_" .. tranDirections[next_node[3]], 0)
			end
		end
		UI_SetButtonPressed("SectorMapScreenMajor", "missionTop_" .. j .. "_" .. k, 0)
	end
end

function MouseClickMoveButton(i)
	if (moveButtonPressed == 1) then
		if (movingSquad == i) then
			local player_index = 0
			local this_player = squadShips[player_index + 1]
			for j = 1, squadMax do
				local this_squad = this_player[j]
				if (IsSquadValid(this_squad) == 1) then
					if (j == i) then
						UI_SetElementVisible("SectorMapScreenMajor", "btnMoveBlu_" .. i, 1)
						UI_SetElementVisible("SectorMapScreenMajor", "btnMoveRed_" .. i, 0)
					end
					UI_SetElementEnabled("SectorMapScreenMajor", "btnMoveBlu_" .. j, 1)
				end
			end
			UI_SetElementEnabled("SectorMapScreenMajor", "m_btnLeaveMap", 1)
			UI_SetElementEnabled("SectorMapScreenMajor", "m_btnSquadMan", 1)
			UI_SetElementEnabled("SectorMapScreenMajor", "m_btnMainMenu", 1)
			UI_SetElementEnabled("SectorMapScreenMajor", "m_btnSaveGame", 1)
			UI_SetElementEnabled("SectorMapScreenMajor", "m_btnReloadGame", 1)
--			UI_SetElementEnabled("SectorMapScreenMajor", "m_btnTestButton", 1)
			UI_SetElementEnabled("SectorMapScreenMajor", "m_btnReloadScreen", 1)
			UI_SetElementEnabled("SectorMapScreenMajor", "m_btnTimePause", 1)
			UI_SetElementEnabled("SectorMapScreenMajor", "m_btnTimeSlower", 1)
			UI_SetElementEnabled("SectorMapScreenMajor", "m_btnTimeFaster", 1)
			movingSquad = 0
			moveButtonPressed = 0
		end
	elseif (moveButtonPressed == 0) then
		local player_index = 0
		local this_player = squadShips[player_index + 1]
		for j = 1, squadMax do
			local this_squad = this_player[j]
			if (IsSquadValid(this_squad) == 1) then
				if (j == i) then
					UI_SetElementVisible("SectorMapScreenMajor", "btnMoveBlu_" .. i, 0)
					UI_SetElementVisible("SectorMapScreenMajor", "btnMoveRed_" .. i, 1)
				end
				UI_SetElementEnabled("SectorMapScreenMajor", "btnMoveBlu_" .. j, 0)
			end
		end
		UI_SetElementEnabled("SectorMapScreenMajor", "m_btnLeaveMap", 0)
		UI_SetElementEnabled("SectorMapScreenMajor", "m_btnSquadMan", 0)
		UI_SetElementEnabled("SectorMapScreenMajor", "m_btnMainMenu", 0)
		UI_SetElementEnabled("SectorMapScreenMajor", "m_btnSaveGame", 0)
		UI_SetElementEnabled("SectorMapScreenMajor", "m_btnReloadGame", 0)
--		UI_SetElementEnabled("SectorMapScreenMajor", "m_btnTestButton", 0)
		UI_SetElementEnabled("SectorMapScreenMajor", "m_btnReloadScreen", 0)
		UI_SetElementEnabled("SectorMapScreenMajor", "m_btnTimePause", 0)
		UI_SetElementEnabled("SectorMapScreenMajor", "m_btnTimeSlower", 0)
		UI_SetElementEnabled("SectorMapScreenMajor", "m_btnTimeFaster", 0)
		movingSquad = i
		moveButtonPressed = 1
	end
end

function MouseClickStopButton(i)
	local player_index = 0
	local this_player = squadShips[player_index + 1]
	local this_squad = this_player[i]
	local this_ships = this_squad.ships
	local this_minspeed = CalcMinHyperSpeed(this_ships)
	local this_traveltime = CalcSectorTravelTime(this_minspeed)
	local this_cantravel = CanShipsTravel(this_ships)
	local node_prev = this_squad.travel.lastpathnode
	local time_prev = this_squad.travel.departuretime
	local time_diff = currentGameTime - time_prev
	local temp_squad =
	{
		travel =
		{
			path = {node_prev},
			lastpathnode = {},
			inhyperspace = 1,
			minhyperspeed = this_minspeed,
			cantravel = this_cantravel,
			escaping = 1,
			intransit = 1,
			departuretime = currentGameTime,
			arrivaltime = currentGameTime + time_diff,
		},
		task = {},
		ships = this_ships,
	}
	squadShips[player_index + 1][i] = temp_squad
	Queue_DeleteTask(player_index + 1, i)
	Queue_AddTask(time_diff, player_index + 1, i, "escape")
	WriteTempSectorMapData()
	WriteTempSquadMenuData()
	ReloadVisibleScreens()
end

function DisableAllSectorMapButtons()
	local numMissionCols = campaignTable.numMissionCols
	local numMissionRows = campaignTable.numMissionRows
	for j = 1, numMissionRows do
		for k = 1, numMissionCols do
			UI_SetElementEnabled("SectorMapScreenMajor", "missionBut_" .. j .. "_" .. k, 0)
		end
	end
	local player_index = 0
	local this_player = squadShips[player_index + 1]
	for j = 1, squadMax do
		local this_squad = this_player[j]
		if (IsSquadValid(this_squad) == 1) then
			UI_SetElementEnabled("SectorMapScreenMajor", "btnStop_" .. j, 0)
			UI_SetElementEnabled("SectorMapScreenMajor", "btnMoveRed_" .. j, 0)
			UI_SetElementEnabled("SectorMapScreenMajor", "btnMoveBlu_" .. j, 0)
		end
	end
	UI_SetElementEnabled("SectorMapScreenMajor", "m_btnLeaveMap", 0)
	UI_SetElementEnabled("SectorMapScreenMajor", "m_btnSquadMan", 0)
	UI_SetElementEnabled("SectorMapScreenMajor", "m_btnMainMenu", 0)
	UI_SetElementEnabled("SectorMapScreenMajor", "m_btnSaveGame", 0)
	UI_SetElementEnabled("SectorMapScreenMajor", "m_btnReloadGame", 0)
--	UI_SetElementEnabled("SectorMapScreenMajor", "m_btnTestButton", 0)
	UI_SetElementEnabled("SectorMapScreenMajor", "m_btnReloadScreen", 0)
	UI_SetElementEnabled("SectorMapScreenMajor", "m_btnTimePause", 0)
	UI_SetElementEnabled("SectorMapScreenMajor", "m_btnTimeSlower", 0)
	UI_SetElementEnabled("SectorMapScreenMajor", "m_btnTimeFaster", 0)
end


--------------------------------------------------------------------------------
-- write the sector map screen selection data to disk so that the squad manager is able to see it
-- todo: remove this function if and when I can swap all the GUI screen code for gametype code
--
function WriteTempSectorMapData()
	local WriteFile = "$TMG_tempsectormap.lua"
	writeto(WriteFile)
	write("currentSectorRow = " .. currentSectorRow .. "\n")
	write("currentSectorCol = " .. currentSectorCol .. "\n")
	write("currentGameTime = " .. currentGameTime .. "\n")
	write("legibleGameTime = \"" .. legibleGameTime .. "\"\n")
	write("allowedToLeaveMap = " .. allowedToLeaveMap .. "\n")
	WriteSectorsExplored()
	WriteObjectivesClear()
	writeto()
end
