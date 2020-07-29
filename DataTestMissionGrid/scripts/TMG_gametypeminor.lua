-- TEMP FILES SHOULD NOT BE LOADED FROM HERE


gametypeScope = "minor"
allowedToLeaveMap = 1
newGameTimeRate = 1
timerRuleRate = 0.1
timerPaused = 0
respawnQueue = {}
launchQueue = {}
isSectorMapScreenActive = 0
isSquadMenuScreenActive = 0
humanPlayerIndex = 0
enemyPlayerIndex = 1
allyPlayerIndex = 2


--------------------------------------------------------------------------------
-- GAME BEGINNING --------------------------------------------------------------
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- needed for save game compatibility
-- 
function OnStartOrLoad()
	ClearTempFiles()
	WriteTempSectorMapData()
	WriteTempSquadMenuData()
	ReloadAllScreens()
end


--------------------------------------------------------------------------------
-- initialize the game with persistent data
-- 
function StartMission()

	------------------------------------------------------------------------
	-- copied from "leveldata\multiplayer\lib\lib.lua"
	-- todo: is this still needed?
	Volume_AddSphere("centre", {-11111, 11111, 11111,}, 10)
	SobGroup_Create("Special_Splitter")
	SobGroup_SpawnNewShipInSobGroup(-1, "Special_Splitter", "Special_Splitter", "Special_Splitter", "centre")
	SobGroup_SetInvulnerability("Special_Splitter", 1)
	SobGroup_MakeUntargeted("Special_Splitter")
	------------------------------------------------------------------------

	-- run the timer and process the global time queue
	Rule_AddInterval("Rule_IncrementTimer", timerRuleRate)

	-- spawn the map entry points
	SpawnEntryPoints()
	-- spawn the map exit points
	SpawnExitPoints()
	-- add pings around the map edges, and trigger the flagship detection script
	EnableMapExits()

	-- give the player his RUs
	-- todo: should be on a per-squad basis, not per-player, but how?
	Player_SetRU(humanPlayerIndex, playerRUs)
	-- player 2 should always be allied with player 0
	SetAlliance(humanPlayerIndex, allyPlayerIndex)
	SetAlliance(allyPlayerIndex, humanPlayerIndex)

	-- enemy AI stuff
	CPU_DoString(enemyPlayerIndex, "setLevelOfDifficulty(2)")
	CPU_DoString(enemyPlayerIndex, "g_LOD = 3")
	if (Player_ResearchOptionIsRestricted(enemyPlayerIndex, "CPUPLAYERS_AGGRESSIVE") == 1) then
		Player_UnrestrictResearchOption(enemyPlayerIndex, "CPUPLAYERS_AGGRESSIVE")
	end
	Player_GrantResearchOption(enemyPlayerIndex, "CPUPLAYERS_AGGRESSIVE")

	-- spawn ships onto the map
	SpawnLocalSquads()
	SpawnLocalShips()

	-- put the camera in the correct place
	SetUpCamera()

	-- dock ships that should be docked and give subsystems to ships that should have subsystems
	InstadockLocalSquads()
	InstadockLocalShips()

	-- put the ships in hyperspace so they can later be moved and oriented to their proper positions
	DespawnLocalSquads()

	-- bring the squad ships out of hyperspace and reposition them, then launch strikecraft
	Rule_AddInterval("Rule_WaitAndRespawnLocalSquads", 0.1)

	-- when the objectives are done and there are no enemy ships, allow players to leave the map normally (e.g. using the sector map screen instead of an exit grid)
	Rule_AddInterval("Rule_SectorCleared", 1)
	-- are there any player squads left on the map? if not then go to the galaxy map
	Rule_AddInterval("Rule_SectorEmptied", 1)

--	Rule_AddInterval("Rule_TestStuff", 2)
end


-------------------------------------------------------------------------------
-- rules
--

function Rule_WaitAndRespawnLocalSquads()
	-- move and align ships from the outer locations and orientations to their proper inner locations and orientations
	RespawnLocalSquads()
	-- launch strikecraft
	Rule_AddInterval("Rule_WaitAndLaunchAllShips", 0.9)
	Rule_Remove("Rule_WaitAndRespawnLocalSquads")
end

function Rule_WaitAndLaunchAllShips()
	LaunchLocalSquads()
	LaunchLocalShips()
	Rule_Remove("Rule_WaitAndLaunchAllShips")
end

-- is the sector cleared of enemies and objectives?
function Rule_SectorCleared()
	local enemy_count = SobGroup_Count("Player_Ships" .. enemyPlayerIndex)
	local sector_cleared = objectivesClear[currentSectorRow][currentSectorCol]
	if ((sector_cleared == 1) and (enemy_count == 0)) then
		if (allowedToLeaveMap == 0) then
			allowedToLeaveMap = 1
			WriteTempSectorMapData()
			ReloadVisibleScreens()
		end
	else
		if (allowedToLeaveMap == 1) then
			allowedToLeaveMap = 0
			WriteTempSectorMapData()
			ReloadVisibleScreens()
		end
	end
end

-- leave the sector if no player-owned ships remain in it
function Rule_SectorEmptied()
	local is_empty = 1
	local player_index = humanPlayerIndex
	local this_player = squadShips[player_index + 1]
	for j, this_squad in this_player do
		if (IsSquadValid(this_squad) == 1) then
			is_empty = 0
			break
		end
	end
	if (is_empty == 1) then
		GetReadyAndLeaveSector()
		Rule_Remove("Rule_SectorEmptied")
	end
end


-------------------------------------------------------------------------------
-- spawn the entry points
-- 0 = loose, 1 = East, 2 = South, 3 = West, 4 = North, 5 = center
--
function SpawnEntryPoints()
	for i = 1, 4 do
		local random_rot = 45/2 - random() * 45
		local random_loc = random() * 0.2 + 0.9
		local enter_rot = vaddV(exitRotations[i], {0,random_rot,0})
		local enter_loc = vrotate({-1,0,0}, enter_rot)
		local enter_pos_inner = vmultiply(enter_loc, enter_distance * 1.00 * random_loc)
		local enter_pos_outer = vmultiply(enter_loc, enter_distance * 1.10 * random_loc)
		Volume_AddSphere("EntryPointInner_" .. i, enter_pos_inner, 1)
		Volume_AddSphere("EntryPointOuter_" .. i, enter_pos_outer, 1)
	end
	Volume_AddSphere("EntryPointInner_0", {100000,100000,100000}, 1)	-- todo: not sure exactly why these can't be located close to the "SobGroup_SetPosition" position, but they can't
	Volume_AddSphere("EntryPointOuter_0", {100000,100000,100000}, 1)	-- todo: not sure exactly why these can't be located close to the "SobGroup_SetPosition" position, but they can't
	Volume_AddSphere("EntryPointInner_5", {0,0,0}, 1)
	Volume_AddSphere("EntryPointOuter_5", {0,0,0}, 1)
end


-------------------------------------------------------------------------------
-- spawn the exit points
--
function SpawnExitPoints()
	for i, iCount in exitSpheres[currentSectorRow][currentSectorCol] do
		if (iCount ~= nil) then
			local exit_rot = exitRotations[i]
			local exit_loc = vrotate({-1,0,0}, exit_rot)
			local grid_rot = exit_rot
			local grid_mtx = EulerToMatrix(grid_rot)
			local grid_loc = vmultiply(exit_loc, grid_distance)
			local grid_nam = "exitgrid_" .. textDirections[i]
			local ping_loc = vmultiply(exit_loc, ping_distance)
			local ping_nam = "pingsphr_" .. iCount[1]
			local sphr_nam = "centre"
			Volume_AddSphere(ping_nam, ping_loc, 1)
			SobGroup_CreateIfNotExist(grid_nam)
			SobGroup_SpawnNewShipInSobGroup(-1, "meg_exitgridcircle", "noname", grid_nam, sphr_nam)
			SobGroup_SetPosition(grid_nam, grid_loc)
			SobGroup_SetTransform(grid_nam, grid_mtx)
		else
			-- todo: maybe add a gray "disabled" version of the exit grid here?
		end
	end
end


--------------------------------------------------------------------------------
-- focus the camera on hyperspacing squads if possible, or else focus the camera on stationary squads, or else focus on the map center
-- todo: should the target sobgroup be chosen randomly, or by using another method?
-- todo: should I check for loose ships as well, maybe?
--
function SetUpCamera()
	local player_index = humanPlayerIndex
	local this_player = squadShips[player_index + 1]
	local loca_innr = ""
	local squads_sobg = ""
	local camera_bool_a = 0
	local camera_bool_b = 0
	for j, this_squad in this_player do
		if (IsSquadValid(this_squad) == 1) then
			local this_path = this_squad.travel.path
			local this_destination = this_path[1]
			local this_direction = this_destination[3]
			local this_inhyperspace = this_squad.travel.inhyperspace
			if (this_inhyperspace == 1) then
				loca_innr = "EntryPointInner_" .. this_direction
				camera_bool_a = 1
			else
				squads_sobg = "SquadShips_" .. (player_index + 1) .. "_" .. j
				camera_bool_b = 1
			end
		end
	end
	if (camera_bool_a == 1) then
		Camera_FocusVolumeWithBuffer(loca_innr, 100000, 5000, 0)
	elseif (camera_bool_b == 1) then
		Camera_FocusSobGroupWithBuffer(squads_sobg, 100000, 5000, 0)
	else
		Camera_FocusVolumeWithBuffer("centre", 100000, 5000, 0)
	end
end


--------------------------------------------------------------------------------
-- spawn the roaming squad ships
--

function SpawnAllSquads()
	for i, this_player in squadShips do
		for j, this_squad in this_player do
			if (IsSquadValid(this_squad) == 1) then
				SpawnThisSquad(i, j)
			end
		end
	end
end

function SpawnLocalSquads()
	for i, this_player in squadShips do
		for j, this_squad in this_player do
			if (IsSquadValid(this_squad) == 1) then
				local this_inhyperspace = this_squad.travel.inhyperspace
				if (this_inhyperspace == 0) then
					SpawnThisSquad(i, j)
				end
			end
		end
	end
end

function SpawnThisSquad(i, j)
	local this_squad = squadShips[i][j]
	local this_path = this_squad.travel.path
	local this_destination = this_path[1]
	local this_direction = this_destination[3]		-- 0 = loose, 1 = East, 2 = South, 3 = West, 4 = North, 5 = center
	local this_ships = this_squad.ships
	local squads_sobg = "SquadShips_" .. i .. "_" .. j
	SobGroup_CreateIfNotExist(squads_sobg)
	SpawnThisSquad_Sub(this_ships, i, j, this_direction, 1)
end

function SpawnThisSquad_Sub(ship_table, i, j, in_direction, ship_count)
	local squads_sobg = "SquadShips_" .. i .. "_" .. j
	local loca_outr = "EntryPointOuter_" .. in_direction
	for k = 1, getn(ship_table) do
		local this_ship = ship_table[k]
		local ship_type = this_ship.type	-- make sure this is always lower case!
		local ship_hold = this_ship.shiphold
		local ship_name = "SQUADSHIPNAME_" .. i .. "_" .. j .. "_" .. ship_count .. "_" .. ship_type
		local ship_sobg = "SQUADSHIPSOBG_" .. i .. "_" .. j .. "_" .. ship_count .. "_" .. ship_type
		SobGroup_CreateIfNotExist(ship_sobg)
		SobGroup_SpawnNewShipInSobGroup(i-1, ship_type, ship_name, ship_sobg, loca_outr)
		SobGroup_SobGroupAdd(squads_sobg, ship_sobg)
		if (in_direction == 0) then		-- 0 = loose, 1 = East, 2 = South, 3 = West, 4 = North, 5 = center
			local ship_position = this_ship.position
			local ship_rotation = this_ship.rotation
			local ship_matrix = EulerToMatrix(ship_rotation)
			SobGroup_SetPosition(ship_sobg, ship_position)
			SobGroup_SetTransform(ship_sobg, ship_matrix)
		end
		ship_count = SpawnThisSquad_Sub(ship_hold, i, j, in_direction, ship_count + 1)
	end
	return ship_count
end


--------------------------------------------------------------------------------
-- spawn the stationary local ships
--

-- not sure these should be global variables, can I make them local?
sector_sobgroups_table = {}
sector_sobgroups_count = 0

function SpawnLocalShips()
	local this_ships = localShips[currentSectorRow][currentSectorCol]
	local sector_sobg = "LocalShips"
	SobGroup_CreateIfNotExist(sector_sobg)
	SpawnLocalShips_Sub(this_ships, 1)
end

function SpawnLocalShips_Sub(ship_table, ship_count)
	local sector_sobg = "LocalShips"
	for k = 1, getn(ship_table) do
		local this_ship = ship_table[k]
		local ship_type = this_ship.type	-- make sure this is always lower case!
		local ship_position = this_ship.position
		local ship_rotation = this_ship.rotation
		local ship_matrix = EulerToMatrix(ship_rotation)
		local ship_hold = this_ship.shiphold
		local ship_play = this_ship.playerindex
		local ship_name = "LOCALSHIPNAME_" .. ship_count .. "_" .. ship_type
		local ship_sobg = "LOCALSHIPSOBG_" .. ship_count .. "_" .. ship_type
		local loca_outr = "EntryPointOuter_0"
		SobGroup_CreateIfNotExist(ship_sobg)
		SobGroup_SpawnNewShipInSobGroup(ship_play, ship_type, ship_name, ship_sobg, loca_outr)
		SobGroup_SobGroupAdd(sector_sobg, ship_sobg)
		SobGroup_SetTransform(ship_sobg, ship_matrix)
		SobGroup_SetPosition(ship_sobg, ship_position)
		-- do sobgroups
		local ship_sobgroups_table = this_ship.sobgroups
		local ship_sobgroups_count = getn(ship_sobgroups_table)
		for l = 1, ship_sobgroups_count do
			local sobgroup_match = 0
			local ship_this_sobgroup = ship_sobgroups_table[l]
			for m = 1, sector_sobgroups_count do
				local sector_this_sobgroup = sector_sobgroups_table[m]
				if (sector_this_sobgroup == ship_this_sobgroup) then
					sobgroup_match = 1
					break
				end
			end
			if (sobgroup_match == 0) then
				SobGroup_CreateIfNotExist(ship_this_sobgroup)
				sector_sobgroups_count = sector_sobgroups_count + 1
				sector_sobgroups_table[sector_sobgroups_count] = ship_this_sobgroup
			end
			SobGroup_SobGroupAdd(ship_this_sobgroup, ship_sobg)
		end
		ship_count = SpawnLocalShips_Sub(ship_hold, ship_count + 1)
	end
	return ship_count
end


--------------------------------------------------------------------------------
-- dock the roaming squad ships
--

function InstadockAllSquads()
	for i, this_player in squadShips do
		for j, this_squad in this_player do
			if (IsSquadValid(this_squad) == 1) then
				InstadockThisSquad(i, j)
			end
		end
	end
end

function InstadockLocalSquads()
	for i, this_player in squadShips do
		for j, this_squad in this_player do
			if (IsSquadValid(this_squad) == 1) then
				local this_inhyperspace = this_squad.travel.inhyperspace
				if (this_inhyperspace == 0) then
					InstadockThisSquad(i, j)
				end
			end
		end
	end
end

function InstadockThisSquad(i, j)
	local this_squad = squadShips[i][j]
	local this_ships = this_squad.ships
	InstadockThisSquad_Sub(this_ships, nil, i, j, 1)
end

function InstadockThisSquad_Sub(ship_table, large_ship, i, j, ship_count)
	for k = 1, getn(ship_table) do
		local this_ship = ship_table[k]
		local ship_type = strlower(this_ship.type)	-- make sure this is always lower case!
		local ship_subs = this_ship.subsystems
		local ship_hold = this_ship.shiphold
		local ship_sobg = "SQUADSHIPSOBG_" .. i .. "_" .. j .. "_" .. ship_count .. "_" .. ship_type
		-- do subsystems
		for l = 1, getn(ship_subs) do
			local this_subs = strlower(ship_subs[l])
			SobGroup_CreateSubSystem(ship_sobg, this_subs)
		end
		ship_count = InstadockThisSquad_Sub(ship_hold, ship_sobg, i, j, ship_count + 1)		-- children need to dock before parents dock
		-- do docking
		if (large_ship == nil) then
		else
			SobGroup_DockSobGroupInstant(ship_sobg, large_ship)
		end
	end
	return ship_count
end


--------------------------------------------------------------------------------
-- dock the stationary local ships
--
function InstadockLocalShips()
	local this_ships = localShips[currentSectorRow][currentSectorCol]
	InstadockLocalShips_Sub(this_ships, nil, 1)
end

function InstadockLocalShips_Sub(ship_table, large_ship, ship_count)
	for k = 1, getn(ship_table) do
		local this_ship = ship_table[k]
		local ship_type = strlower(this_ship.type)	-- make sure this is always lower case!
		local ship_subs = this_ship.subsystems
		local ship_hold = this_ship.shiphold
		local ship_sobg = "LOCALSHIPSOBG_" .. ship_count .. "_" .. ship_type
		-- do subsystems
		for l = 1, getn(ship_subs) do
			local this_subs = strlower(ship_subs[l])
			SobGroup_CreateSubSystem(ship_sobg, this_subs)
		end
		ship_count = InstadockLocalShips_Sub(ship_hold, ship_sobg, ship_count + 1)		-- children need to dock before parents dock
		-- do docking
		if (large_ship == nil) then
		else
			SobGroup_DockSobGroupInstant(ship_sobg, large_ship)
		end
	end
	return ship_count
end

--------------------------------------------------------------------------------
-- despawn squad ships that arrived via hyperspace
--
function DespawnAllSquads()
	for i, this_player in squadShips do
		for j, this_squad in this_player do
			if (IsSquadValid(this_squad) == 1) then
				DespawnThisSquad(i, j)
			end
		end
	end
end

function DespawnLocalSquads()
	for i, this_player in squadShips do
		for j, this_squad in this_player do
			if (IsSquadValid(this_squad) == 1) then
				local this_path = this_squad.travel.path
				local this_destination = this_path[1]
				local this_direction = this_destination[3]		-- 0 = loose, 1 = East, 2 = South, 3 = West, 4 = North, 5 = center
				local this_inhyperspace = this_squad.travel.inhyperspace
				if ((this_inhyperspace == 0) and (this_direction ~= 0)) then
					DespawnThisSquad(i, j)
				end
			end
		end
	end
end

function DespawnThisSquad(i, j)
	local squads_sobg = "SquadShips_" .. i .. "_" .. j
	SobGroup_Despawn(squads_sobg)
end


--------------------------------------------------------------------------------
-- move squad ships from outer to inner start points so they point in the right direction and are in formation
--

function RespawnAllSquads()
	for i, this_player in squadShips do
		for j, this_squad in this_player do
			if (IsSquadValid(this_squad) == 1) then
				RespawnThisSquad(i, j)
			end
		end
	end
end

function RespawnLocalSquads()
	for i, this_player in squadShips do
		for j, this_squad in this_player do
			if (IsSquadValid(this_squad) == 1) then
				local this_path = this_squad.travel.path
				local this_destination = this_path[1]
				local this_direction = this_destination[3]		-- 0 = loose, 1 = East, 2 = South, 3 = West, 4 = North, 5 = center
				local this_inhyperspace = this_squad.travel.inhyperspace
				if ((this_inhyperspace == 0) and (this_direction ~= 0)) then
					RespawnThisSquad(i, j)
				end
			end
		end
	end
end

function RespawnThisSquad(i, j)
	local this_squad = squadShips[i][j]
	local this_inhyperspace = this_squad.travel.inhyperspace
	local this_path = this_squad.travel.path
	local this_destination = this_path[1]
	local this_direction = this_destination[3]		-- 0 = loose, 1 = East, 2 = South, 3 = West, 4 = North, 5 = center
	local loca_innr = "EntryPointInner_" .. this_direction
	local squads_sobg = "SquadShips_" .. i .. "_" .. j
	if (this_inhyperspace == 0) then
		SobGroup_Spawn(squads_sobg, loca_innr)
	else
		SobGroup_HyperspaceTo(squads_sobg, loca_innr)
	end
end


--------------------------------------------------------------------------------
-- launch squad strikecraft from shipholds
-- if ships are docked within other ships, and the other ships are docked within still other ships, and so on, there may be problems
--

function LaunchAllSquads()
	for i, this_player in squadShips do
		for j, this_squad in this_player do
			if (IsSquadValid(this_squad) == 1) then
				LaunchThisSquad(i, j)
			end
		end
	end
end

function LaunchLocalSquads()
	for i, this_player in squadShips do
		for j, this_squad in this_player do
			if (IsSquadValid(this_squad) == 1) then
				local this_inhyperspace = this_squad.travel.inhyperspace
				if (this_inhyperspace == 0) then
					LaunchThisSquad(i, j)
				end
			end
		end
	end
end

function LaunchThisSquad(i, j)
	local this_squad = squadShips[i][j]
	local this_ships = this_squad.ships
	LaunchThisSquad_Sub(this_ships, nil, i, j, 1)
	squadShips[i][j].travel.path[1][3] = 0
	-- todo: not needed any more?
--	local flagsh_sobg = "FlagsShips_" .. i .. "_" .. j
--	local squads_sobg = "SquadShips_" .. i .. "_" .. j
--	SobGroup_ParadeSobGroup(squads_sobg, flagsh_sobg, 0)		-- ships are not "attached" to the flagships and simply sit there instead of following them around, so we should parade them now here, however it looks awkward and is very slow or very fast depending on the mode
end

function LaunchThisSquad_Sub(ship_table, large_ship, i, j, ship_count)
	for k = 1, getn(ship_table) do
		local this_ship = ship_table[k]
		local ship_type = strlower(this_ship.type)	-- make sure this is always lower case!
		local ship_sobg = "SQUADSHIPSOBG_" .. i .. "_" .. j .. "_" .. ship_count .. "_" .. ship_type
		local ship_hold = this_ship.shiphold
		if (large_ship == nil) then
		else
			SobGroup_Launch(ship_sobg, large_ship)
		end
		ship_count = LaunchThisSquad_Sub(ship_hold, ship_sobg, i, j, ship_count + 1)		-- parents need to launch before children launch
	end
	return ship_count
end


--------------------------------------------------------------------------------
-- launch stationary local strikecraft from shipholds
-- if ships are docked within other ships, and the other ships are docked within still other ships, it may cause problems
--
function LaunchLocalShips()
	local this_ships = localShips[currentSectorRow][currentSectorCol]
	LaunchLocalShips_Sub(this_ships, nil, 1)
end

function LaunchLocalShips_Sub(ship_table, large_ship, ship_count)
	for k = 1, getn(ship_table) do
		local this_ship = ship_table[k]
		local ship_type = strlower(this_ship.type)	-- make sure this is always lower case!
		local ship_sobg = "LOCALSHIPSOBG_" .. ship_count .. "_" .. ship_type
		local ship_hold = this_ship.shiphold
		if (large_ship == nil) then
		else
			SobGroup_Launch(ship_sobg, large_ship)
		end
		ship_count = LaunchLocalShips_Sub(ship_hold, ship_sobg, ship_count + 1)		-- parents need to launch before children launch
	end
	return ship_count
end



















--------------------------------------------------------------------------------
-- GAME MIDDLE -----------------------------------------------------------------
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- create and display pings for map exits
--
function EnableMapExits()
	-- create pings
	for i, iCount in exitSpheres[currentSectorRow][currentSectorCol] do
		if (iCount) then
			local ping_name = "pingsphr_" .. iCount[1]
			local ping_text = iCount[4]
			local ping_type = "anomaly"		-- todo: there are several to choose from, should try them all
			local ping_id = Ping_AddPoint(ping_text, ping_type, ping_name)
			Ping_LabelVisible(ping_id, 1)
		end
	end
	-- now check if a flagship is inside one of the pings, and end the mission if it is
	Rule_AddInterval("Rule_CheckMapExitsForSquads", 0.1)
end


--------------------------------------------------------------------------------
-- check exit grids for squads of ships
-- hopefully there are no performance issues with this rule
--
isJumpButtonEnabled = 0
isJumpButtonVisible = 0
exitGridJumpDirection = 0
exitGridJumpSquadron = 0

function Rule_CheckMapExitsForSquads()
	exitGridJumpDirection = 0
	exitGridJumpSquadron = 0
--	UpdateSquadShips()		-- too slow
--	UpdateLocalShips()		-- too slow
	local player_index = humanPlayerIndex
	local this_player = squadShips[player_index + 1]
	local visi_bool = 0
	for i, this_squad in this_player do
		if (IsSquadValid(this_squad) == 1) then
			local squads_sobg = "SquadShips_" .. (player_index + 1) .. "_" .. i
			-- todo: need to find a better place and time to periodically update squads with new or destroyed ships
			if (SobGroup_Empty(squads_sobg) == 1) then
				UpdateThisSquad(player_index + 1, i)
			elseif (SobGroup_Empty(squads_sobg) == 0) then
				local ships_has_big_radius = 1
				local ships_can_exit_hyper = 1
				local ships_same_direction = 1
				local ships_dock_or_select = 1
				local ships_dock_in_others = 0
				local ships_map_exits_here = 1
				local ships_other_selected = 0
				local old_direction = 0
				local first_loop = 1
				local jump_text = ""
				local text_count = 1
				local ship_name_sub = "SELECTSHIP_THISPLAYER_" .. (player_index + 1) .. "_" .. i .. "_"
				local ship_count = SobGroup_Separate(ship_name_sub, squads_sobg)
				for j = 1, ship_count do
					local ship_name = ship_name_sub .. (j-1)
					local ship_has_big_radius, ship_can_hyperspace, ship_is_selected, ship_direction = CheckIsSobGroupOnExitTile(ship_name)
					local ship_is_docked_sobg = SobGroup_IsDockedSobGroup(ship_name, squads_sobg)
					if (ship_has_big_radius == 0) then
						ships_has_big_radius = 0
						break
					end
					if ((ship_is_selected == 0) and (ship_is_docked_sobg == 0)) then
						ships_dock_or_select = 0
						break
					end
					if (first_loop == 1) then
						first_loop = 0
					elseif (ship_direction ~= old_direction) then
						ships_same_direction = 0
						break
					end
					if (exitSpheres[currentSectorRow][currentSectorCol][ship_direction] == nil) then
						ships_map_exits_here = 0
						break
					end
					if ((ship_can_hyperspace == 0) and (ship_is_docked_sobg == 0)) then
						ships_can_exit_hyper = 0
						--break
					end
					old_direction = ship_direction
				end
				if ((ships_has_big_radius == 1) and (ships_same_direction == 1) and (ships_dock_or_select == 1) and (ships_map_exits_here == 1)) then
					for j, others_squad in this_player do
						if ((IsSquadValid(others_squad) == 1) and (j ~= i)) then
							local others_sobg = "SquadShips_" .. (player_index + 1) .. "_" .. j
							local othr_name_sub = "SELECTSHIP_OTHERPLAYER_" .. (player_index + 1) .. "_" .. j .. "_"
							local othr_count = SobGroup_Separate(othr_name_sub, others_sobg)
							for k = 1, othr_count do
								local othr_ship = others_squad.ships[k]
								local othr_name = othr_name_sub .. (k-1)
								local othr_type = othr_ship.type
								local othr_has_big_radius, othr_can_hyperspace, othr_is_selected, othr_direction = CheckIsSobGroupOnExitTile(othr_name)
								if (othr_is_selected == 1) then
									--print(othr_type)
									ships_other_selected = 1
									break
								end
							end
							if (ships_other_selected == 1) then
								break
							end
							local dock_1 = SobGroup_IsDockedSobGroup(others_sobg, squads_sobg)
							local dock_2 = SobGroup_IsDockedSobGroup(squads_sobg, others_sobg)
							if ((dock_1 == 1) or (dock_2 == 1)) then
								ships_dock_in_others = 1
								break
							end
						end
					end
					if ((ships_can_exit_hyper == 1) and (ships_dock_in_others == 0) and (ships_other_selected == 0)) then
						if (isJumpButtonEnabled == 0) then
							jump_text = "Ready to jump."
							UI_SetTextLabelText("NewTaskbar", "btnJumpText", jump_text)
							UI_SetElementEnabled("NewTaskbar", "btnJump", 1)
							isJumpButtonEnabled = 1
						end
						exitGridJumpDirection = old_direction
						exitGridJumpSquadron = i
					else
						if (ships_can_exit_hyper == 0) then
							jump_text = jump_text .. text_count .. ". One or more ships cannot enter hyperspace. Can't jump.\n"
							text_count = text_count + 1
						end
						if (ships_dock_in_others == 1) then
							jump_text = jump_text .. text_count .. ". One or more ships are docked in the wrong squad. Can't jump.\n"
							text_count = text_count + 1
						end
						if (ships_other_selected == 1) then
							jump_text = jump_text .. text_count .. ". Ships from more than one squad are selected. Can't jump.\n"
							text_count = text_count + 1
						end
						UI_SetTextLabelText("NewTaskbar", "btnJumpText", jump_text)
						if (isJumpButtonEnabled == 1) then
							UI_SetElementEnabled("NewTaskbar", "btnJump", 0)
							isJumpButtonEnabled = 0
						end
					end
					visi_bool = 1
					break
				else
--					if (ships_has_big_radius == 0) then
--						jump_text = jump_text .. ""
--						text_count = text_count + 1
--					end
--					if (ships_same_direction == 0) then
--						jump_text = jump_text .. ""
--						text_count = text_count + 1
--					end
--					if (ships_dock_or_select == 0) then
--						jump_text = jump_text .. ""
--						text_count = text_count + 1
--					end
--					if (ships_map_exits_here == 0) then
--						jump_text = jump_text .. ""
--						text_count = text_count + 1
--					end
				end
			end
		end
	end
	if (visi_bool == 1) then
		if (isJumpButtonVisible == 0) then
			UI_SetElementVisible("NewTaskbar", "btnJump", 1)
			isJumpButtonVisible = 1
		end
	elseif (visi_bool == 0) then
		if (isJumpButtonVisible == 1) then
			UI_SetElementVisible("NewTaskbar", "btnJump", 0)
			isJumpButtonVisible = 0
		end
	end
end


--------------------------------------------------------------------------------
-- jump if the squad is on an exit grid, then update sector map
-- todo: should really wait until it's confirmed that all ships in the squad are in fact in hyperspace
-- todo: otherwise, some ships might get killed but not recorded as being dead
--
function JumpFromExitGrid()
	local player_index = humanPlayerIndex
	local squad_index = exitGridJumpSquadron
	local squads_sobg = "SquadShips_" .. (player_index + 1) .. "_" .. squad_index
	SobGroup_AbilityActivate(squads_sobg, AB_Builder, 0)			-- todo: this doesn't take ships off the build menu like I want
	SobGroup_EnterHyperSpaceOffMap(squads_sobg)
	local this_ships = UpdateSquadronTable(squads_sobg)
	local this_minspeed = CalcMinHyperSpeed(this_ships)
	local this_traveltime = CalcSectorTravelTime(this_minspeed)
	local this_cantravel = CanShipsTravel(this_ships)
	local this_destination_row = currentSectorRow + exitDirectionsRow[exitGridJumpDirection]
	local this_destination_col = currentSectorCol + exitDirectionsCol[exitGridJumpDirection]
	local temp_squad =
	{
		travel =
		{
			path =
			{
				{this_destination_row, this_destination_col, tranDirections[exitGridJumpDirection]},
			},
			lastpathnode = {},
			inhyperspace = 1,
			minhyperspeed = this_minspeed,
			cantravel = this_cantravel,
			escaping = 1,
			intransit = 1,
			departuretime = currentGameTime,
			arrivaltime = currentGameTime + this_traveltime,
		},
		task = {},
		ships = this_ships,
	}
	squadShips[player_index + 1][squad_index] = temp_squad
	Queue_AddTask(this_traveltime, player_index + 1, squad_index, "escape")
	WriteTempSectorMapData()
	WriteTempSquadMenuData()
	ReloadVisibleScreens()
	print("Gametype: Player #" .. (player_index + 1) .. ", Squad #" .. squad_index .. " has successfully jumped off the map.")
	-- todo: this stuff gets overridden by Rule_CheckMapExitsForSquads, so there's no point in doing it here too (though I would if I could)
--	if (isJumpButtonEnabled == 1) then
--		UI_SetElementEnabled("NewTaskbar", "btnJump", 0)
--		isJumpButtonEnabled = 0
--	end
--	if (isJumpButtonVisible == 1) then
--		UI_SetElementVisible("NewTaskbar", "btnJump", 0)
--		isJumpButtonVisible = 0
--	end
end


--------------------------------------------------------------------------------
-- checks whether a sobgroup is on one of the semi-circular exit grids
--
function CheckIsSobGroupOnExitTile(check_group)
	local old_position = SobGroup_GetPosition(check_group)
	local new_position = {old_position[1],0,old_position[3]}
	local pos_radius = vdistance({0,0,0}, new_position)
	local temp_direction = 0
	local can_hyperspace = SobGroup_CanDoAbility(check_group, AB_Hyperspace)
	local has_big_radius = 0
	if (pos_radius > inner_distance) then
		has_big_radius = 1
	end
	local is_selected = SobGroup_Selected(check_group)
	local pos_angles = vanglesXY(new_position)
	local y_angle = pos_angles[2]
	if     ((y_angle >= 225) and (y_angle < 315)) then
		temp_direction = 3	-- West
	elseif ((y_angle >= 135) and (y_angle < 225)) then
		temp_direction = 4	-- North
	elseif ((y_angle >=  45) and (y_angle < 135)) then
		temp_direction = 1	-- East
	elseif ((y_angle >=   0) and (y_angle <  45)) then
		temp_direction = 2	-- South
	elseif ((y_angle >= 315) and (y_angle < 360)) then
		temp_direction = 2	-- South
	end
	return has_big_radius, can_hyperspace, is_selected, temp_direction
end








--------------------------------------------------------------------------------
-- GAME END -----------------------------------------------------------------
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- get ready and leave the sector
--
function GetReadyAndLeaveSector()
	Rule_AddInterval("Rule_LeavingTheSector", 0.1)
end

function Rule_LeavingTheSector()
	print("Gametype: Updating squad ships...")
	UpdateSquadShips()
	print("Gametype: Done updating squad ships!")

	print("Gametype: Updating local ships...")
	UpdateLocalShips()
	print("Gametype: Done updating local ships!")

	print("Gametype: Saving campaign status...")
	loadSectorMap = 1
	SavePersistentData()
	ClearTempFiles()
	print("Gametype: Done saving campaign status!")

	print("Gametype: Restarting game...")
	FE_RestartGame(0)		-- restarts the current mission without signaling campaign completion

	Rule_Remove("Rule_LeavingTheSector")
end


--------------------------------------------------------------------------------
-- Mission event text strings
--
this_campaign_mission = campaignTable.missions[currentSectorRow][currentSectorCol]
mission_text_short = sectorName .. ": " .. this_campaign_mission.description
mission_text_long = sectorName .. ": " .. this_campaign_mission.longDescription
mission_text_success = sectorName .. ": Mission successful. You may continue on to the next sector."
mission_text_clear = sectorName .. ": This sector is clear. You may continue on to the next sector."
mission_text_card = "Postmortem Tutorial - " .. sectorName
