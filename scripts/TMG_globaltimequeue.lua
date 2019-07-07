-- TEMP FILES SHOULD NOT BE LOADED FROM HERE


function Rule_IncrementTimer()
	currentGameTime = currentGameTime + newGameTimeRate * timerRuleRate
	legibleGameTime = disp_time(currentGameTime, 1)
	if (gametypeScope == "minor") then
		UI_SetTextLabelText("SectorMapScreenMinor", "txtGameTimer", "GAME TIME: " .. legibleGameTime)
	elseif (gametypeScope == "major") then
		UI_SetTextLabelText("SectorMapScreenMajor", "txtGameTimer", "GAME TIME: " .. legibleGameTime)
	end
	if (timerPaused == 0) then
		local time_queue_temp_1 = globalTimeQueue
		local time_queue_temp_2 = {}
		globalTimeQueue = {}
		for i = 1, getn(time_queue_temp_1) do
			local this_item = time_queue_temp_1[i]
			local this_time = this_item[1]
			local this_player_id = this_item[2]
			local this_squad_id = this_item[3]
			local this_task = this_item[4]
			local this_print_time = this_item[5]
			if (this_time <= currentGameTime) then
				Queue_DoTask(this_player_id, this_squad_id, this_task)
			else
				local queue_length = getn(time_queue_temp_2)
				time_queue_temp_2[queue_length + 1] = this_item
			end
		end
		for i = 1, getn(globalTimeQueue) do
			local queue_length = getn(time_queue_temp_2)
			time_queue_temp_2[queue_length + 1] = globalTimeQueue[i]
		end
		globalTimeQueue = time_queue_temp_2
	end
end

function Queue_DoTask(in_player_id, in_squad_id, in_task)
	if (in_squad_id ~= nil) then
		local this_squad = squadShips[in_player_id][in_squad_id]
		if (this_squad == nil) then
			Queue_DeleteTask(in_player_id, in_squad_id)
			return
		end
		local this_path = this_squad.travel.path
		local this_path_length = getn(this_path)
		local this_destination = this_path[1]
		local this_destination_row = this_destination[1]
		local this_destination_col = this_destination[2]
		local intercept_bool = CheckForInterceptions(this_destination_row, this_destination_col)
		if (in_task == "travel") then
			if ((this_path_length == 1) or (intercept_bool == 1)) then
				Queue_DeploySquad(in_player_id, in_squad_id)
			else
				Queue_TravelSquad(in_player_id, in_squad_id)
			end
		elseif (in_task == "deploy") then
			Queue_DeploySquad(in_player_id, in_squad_id)
		elseif (in_task == "respawn") then
			Queue_RespawnSquad(in_player_id, in_squad_id)
		elseif (in_task == "launch") then
			Queue_LaunchSquad(in_player_id, in_squad_id)
		elseif (in_task == "escape") then
			Queue_DeploySquad(in_player_id, in_squad_id)
		elseif (in_task == "ai_travel") then
			if ((this_path_length == 1) or (intercept_bool == 1)) then
				Queue_DeploySquad(in_player_id, in_squad_id)
			else
				Queue_TravelSquad(in_player_id, in_squad_id)
			end
		end
		if (intercept_bool == 1) then
			if (gametypeScope == "major") then
				GameTimePauseFunc()
				currentSectorRow = this_destination_row
				currentSectorCol = this_destination_col
				DisableAllSectorMapButtons()
				UI_FlashButton("SectorMapScreenMajor", "missionWarn_" .. currentSectorRow .. "_" .. currentSectorCol, -1)
				UI_SetElementVisible("SectorMapScreenMajor", "missionWarn_" .. currentSectorRow .. "_" .. currentSectorCol, 1)
				Rule_AddInterval("Rule_WaitAndEnterSectorMap", 4)
			end
		end
	else
		if (in_task == "ai_reinforce") then
			Queue_CreateNewSquad(in_player_id)
		end
	end
end

function Queue_DeploySquad(in_player_id, in_squad_id)
	local this_squad = squadShips[in_player_id][in_squad_id]
	local this_path = this_squad.travel.path
	local this_destination = this_path[1]
	local this_destination_row = this_destination[1]
	local this_destination_col = this_destination[2]
	if (in_player_id == 1) then
		sectorsExplored[this_destination_row][this_destination_col] = 1
	end
	local this_ships = this_squad.ships
	local this_minspeed = CalcMinHyperSpeed(this_ships)
	local this_cantravel = CanShipsTravel(this_ships)
	local temp_squad =
	{
		travel =
		{
			path = {this_destination},
			lastpathnode = {},
			inhyperspace = 1,		-- wait to clear this later
			minhyperspeed = this_minspeed,
			cantravel = this_cantravel,
			escaping = 0,
			intransit = 0,
			departuretime = 0,
			arrivaltime = 0,
		},
		task =
		{
			type = "wait",
		},
		ships = this_ships,
	}
	squadShips[in_player_id][in_squad_id] = temp_squad
	if (gametypeScope == "minor") then
		SpawnThisSquad(in_player_id, in_squad_id)
		InstadockThisSquad(in_player_id, in_squad_id)
		DespawnThisSquad(in_player_id, in_squad_id)
		Queue_AddTask(0.1, in_player_id, in_squad_id, "respawn")
	elseif (gametypeScope == "major") then
		if ((in_player_id == 1) and (currentSectorRow == this_destination_row) and (currentSectorCol == this_destination_col)) then
			UI_SetElementEnabled("SectorMapScreenMajor", "btnStop_" .. in_squad_id, 0)
			UI_SetElementEnabled("SectorMapScreenMajor", "btnMoveBlu_" .. in_squad_id, 1)
			UI_SetElementEnabled("SectorMapScreenMajor", "btnMoveRed_" .. in_squad_id, 1)
		end
		squadShips[in_player_id][in_squad_id].travel.inhyperspace = 0
	end
	local intercept_bool = CheckForInterceptions(this_destination_row, this_destination_col)
	if (intercept_bool == 0) then
		if (in_player_id > 1) then
			local random_row, random_col = Calc_NewDestination(this_destination_row, this_destination_col)
			local start_coordinates = {this_destination_row, this_destination_col}
			local final_coordinates = {random_row, random_col}
			local map_grid = tcopy(terrainTable)
			local path_table = findShortestPath(start_coordinates, final_coordinates, map_grid)
			local wait_time = 21600		-- 86400 seconds equal 24 hours, 21600 seconds equal 6 hours
			squadShips[in_player_id][in_squad_id].travel.path = path_table
			Queue_AddTask(wait_time, in_player_id, in_squad_id, "ai_travel")
		end
	end
	WriteTempSectorMapData()
	WriteTempSquadMenuData()
	ReloadVisibleScreens()
end

function Queue_RespawnSquad(in_player_id, in_squad_id)
	RespawnThisSquad(in_player_id, in_squad_id)
	Queue_AddTask(9.9, in_player_id, in_squad_id, "launch")
	WriteTempSectorMapData()
	WriteTempSquadMenuData()
	ReloadVisibleScreens()
end

function Queue_LaunchSquad(in_player_id, in_squad_id)
	LaunchThisSquad(in_player_id, in_squad_id)
	squadShips[in_player_id][in_squad_id].travel.inhyperspace = 0
	WriteTempSectorMapData()
	WriteTempSquadMenuData()
	ReloadVisibleScreens()
end

function Queue_TravelSquad(in_player_id, in_squad_id)
	local this_squad = squadShips[in_player_id][in_squad_id]
	local this_path = this_squad.travel.path
	local temp_node_a = this_path[1]
	local temp_node_b = this_path[2]
	local this_destination = this_path[1]
	local this_destination_row = this_destination[1]
	local this_destination_col = this_destination[2]
	if (in_player_id == 1) then
		sectorsExplored[this_destination_row][this_destination_col] = 1
	end
	local this_ships = this_squad.ships
	local this_minspeed = CalcMinHyperSpeed(this_ships)
	local this_traveltime = CalcSectorTravelTime(this_minspeed)
	local this_cantravel = CanShipsTravel(this_ships)
	local temp_squad =
	{
		travel =
		{
			path = ttrim(this_path),
			lastpathnode = {temp_node_a[1],temp_node_a[2],tranDirections[temp_node_b[3]],},
			inhyperspace = 1,
			minhyperspeed = this_minspeed,
			cantravel = this_cantravel,
			escaping = 0,
			intransit = 1,
			departuretime = currentGameTime,
			arrivaltime = currentGameTime + this_traveltime,
		},
		task = {},
		ships = this_ships,
	}
	squadShips[in_player_id][in_squad_id] = temp_squad
	local intercept_bool = CheckForInterceptions(this_destination_row, this_destination_col)
	if (intercept_bool == 0) then
		if (in_player_id > 1) then
			Queue_AddTask(this_traveltime, in_player_id, in_squad_id, "ai_travel")
		else
			Queue_AddTask(this_traveltime, in_player_id, in_squad_id, "travel")
		end
	end
	WriteTempSectorMapData()
	WriteTempSquadMenuData()
	ReloadVisibleScreens()
end

function Queue_CreateNewSquad(in_player_id)
	local squad_index = getn(squadShips[in_player_id]) + 1
	local this_ships = enemyReinforcements.vaygr_small_carrier_group
	local this_minspeed = CalcMinHyperSpeed(this_ships)
	local this_traveltime = CalcSectorTravelTime(this_minspeed)
	local this_cantravel = CanShipsTravel(this_ships)
	local temp_squad =
	{
		travel =
		{
			minhyperspeed = this_minspeed,
			cantravel = this_cantravel,
			inhyperspace = 1,
			escaping = 1,
			intransit = 1,
			departuretime = 0,
			arrivaltime = 0,
			path =
			{
				{4, 2, 4}
			},
			lastpathnode = {},
		},
		task = {},
		ships = this_ships,
	}
	squadShips[in_player_id][squad_index] = temp_squad
	Queue_AddTask(0, in_player_id, squad_index, "ai_travel")
	Queue_AddTask(86400, in_player_id, nil, "ai_reinforce")
end

function Queue_AddTask(in_tasktime, in_player, in_squad, in_task)
	if (in_squad ~= nil) then
		squadShips[in_player][in_squad].task.type = in_task
	end
	local new_time = currentGameTime + in_tasktime
	local new_task = {new_time, in_player, in_squad, in_task, disp_time(new_time, 1)}
	local queue_length = getn(globalTimeQueue)
	globalTimeQueue[queue_length + 1] = new_task
end

function Queue_DeleteTask(in_player_id, in_squad_id)
	local temp_queue = {}
	local temp_count = 0
	local queue_length = getn(globalTimeQueue)
	for i = 1, queue_length do
		local this_task = globalTimeQueue[i]
		if ((this_task[2] ~= in_player_id) or (this_task[3] ~= in_squad)) then
			temp_count = temp_count + 1
			temp_queue[temp_count] = this_task
		end
	end
	globalTimeQueue = temp_queue
end


--------------------------------------------------------------------------------
-- Game time GUI controls
-- todo: should really use a table for this stuff
--
function GameTimeInitializeFunc()
	oldGameTimeRate = 360
	oldGameTimeText = "6 min/s"
	newGameTimeRate = 0
	newGameTimeText = "Paused"
	UI_SetLabelTextHotkey("SectorMapScreenMajor", "txtTimeShowRate", newGameTimeText, 666)
end

function GameTimeSlowDownFunc()
	if (newGameTimeRate == 360) then
		GameTimePauseFunc()
	elseif (newGameTimeRate == 1800) then
		newGameTimeRate = 360
		newGameTimeText = "6 min/s"
		oldGameTimeRate = newGameTimeRate
		oldGameTimeText = newGameTimeText
		UI_SetLabelTextHotkey("SectorMapScreenMajor", "txtTimeShowRate", newGameTimeText, 666)
	elseif (newGameTimeRate == 3600) then
		newGameTimeRate = 1800
		newGameTimeText = "30 min/s"
		oldGameTimeRate = newGameTimeRate
		oldGameTimeText = newGameTimeText
		UI_SetLabelTextHotkey("SectorMapScreenMajor", "txtTimeShowRate", newGameTimeText, 666)
	end
end

function GameTimeSpeedUpFunc()
	if (newGameTimeRate == 0) then
		GameTimePauseFunc()
	elseif (newGameTimeRate == 360) then
		newGameTimeRate = 1800
		newGameTimeText = "30 min/s"
		oldGameTimeRate = newGameTimeRate
		oldGameTimeText = newGameTimeText
		UI_SetLabelTextHotkey("SectorMapScreenMajor", "txtTimeShowRate", newGameTimeText, 666)
	elseif (newGameTimeRate == 1800) then
		newGameTimeRate = 3600
		newGameTimeText = "60 min/s"
		oldGameTimeRate = newGameTimeRate
		oldGameTimeText = newGameTimeText
		UI_SetLabelTextHotkey("SectorMapScreenMajor", "txtTimeShowRate", newGameTimeText, 666)
	end
end

function GameTimePauseFunc()
	if (timerPaused == 1) then
		newGameTimeRate = oldGameTimeRate
		newGameTimeText = oldGameTimeText
		UI_SetLabelTextHotkey("SectorMapScreenMajor", "txtTimeShowRate", newGameTimeText, 666)
		timerPaused = 0
	else
		oldGameTimeRate = newGameTimeRate
		oldGameTimeText = newGameTimeText
		newGameTimeRate = 0
		newGameTimeText = "Paused"
		UI_SetLabelTextHotkey("SectorMapScreenMajor", "txtTimeShowRate", newGameTimeText, 666)
		timerPaused = 1
	end
end

-- check squadrons
-- todo: won't work if there are more than two players that are enemies
function AreSquadEnemiesClear(in_row, in_col)
	local player_1_bool = 0
	local player_2_bool = 0
	for i, this_player in squadShips do
		for j, this_squad in this_player do
			if (this_squad ~= nil) then
				local this_path = this_squad.travel.path
				local this_destination = this_path[1]
				local this_destination_row = this_destination[1]
				local this_destination_col = this_destination[2]
				if ((this_destination_row == in_row) and (this_destination_col == in_col)) then
					if (i == 1) then
						player_1_bool = 1
					elseif (i == 2) then
						player_2_bool = 1
					end
				end
			end
		end
	end
	if ((player_1_bool == 1) and (player_2_bool == 1)) then
		return 0
	end
	return 1
end

-- check loose ships
-- todo: won't work if there are more than two players that are enemies
function AreLocalEnemiesClear(in_row, in_col)
	local player_1_bool = 0
	local player_2_bool = 0
	local this_ships = localShips[in_row][in_col]
	for j, this_ship in this_ships do
		local this_playerindex = this_ship.playerindex
		if (this_playerindex == 0) then
			player_1_bool = 1
		elseif (this_playerindex == 1) then
			player_2_bool = 1
		end
	end
	if ((player_1_bool == 1) and (player_2_bool == 1)) then
		return 0
	end
	return 1
end

function CheckForInterceptions(in_row, in_col)
	local squad_enemies_clear = AreSquadEnemiesClear(in_row, in_col)
	-- switch these two lines if you want to also check for incomplete missions as well as for loose ships that are just sitting in the sector doing nothing
--	local local_enemies_clear = AreLocalEnemiesClear(in_row, in_col)
--	local missions_clear = objectivesClear[in_row][in_col]
	local local_enemies_clear = 1
	local missions_clear = 1
	if ((missions_clear == 0) or (squad_enemies_clear == 0) or (local_enemies_clear == 0)) then
		return 1
	end
	return 0
end

-- todo: this should only be triggered once per conflict, i.e. there's no need to trigger this for both sides of a fight
function Rule_WaitAndEnterSectorMap()
	EnterSectorFromGalaxyMap()
	GameTimePauseFunc()
	Rule_Remove("Rule_WaitAndEnterSectorMap")
end

function Calc_NewDestination(in_row, in_col)
	local random_row = floor(random() * (campaignTable.numMissionRows - 1) + 0.5) + 1
	local random_col = floor(random() * (campaignTable.numMissionCols - 1) + 0.5) + 1
--	print("in_row = " .. in_row .. ", in_col = " .. in_col)
--	print("random_row = " .. random_row .. ", random_col = " .. random_col)
	if ((random_row ~= in_row) or (random_col ~= in_col)) then
		return random_row, random_col
	else
		return Calc_NewDestination(in_row, in_col)
	end
end
