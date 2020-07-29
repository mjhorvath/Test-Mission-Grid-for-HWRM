-- TEMP FILES SHOULD NOT BE LOADED FROM HERE
baseSectorTravelTime = 86400		-- 24 hours
baseSectorTravelMult = 10		-- lower is faster, 100 makes sense but will feels slow unless I add more "time steps" to the timer


--------------------------------------------------------------------------------
-- Squad management functions
--

-- update loose ships with current makeup
function UpdateLocalShips()
	local sector_sobg = "LocalShips"
	SobGroup_Clear(sector_sobg)
	for i, this_player in squadShips do
		local filter_sobg = "FilterShips"
		SobGroup_CreateIfNotExist(filter_sobg)
		SobGroup_Clear(filter_sobg)
		Player_GetShipsByFilterInclude(i-1, filter_sobg, "NoFilter", "")
		local ship_name_sub = "PROCESSLOCALSHIP_"
		local ship_count = SobGroup_Separate(ship_name_sub, filter_sobg)
		for j = 1, ship_count do
			local ship_name = ship_name_sub .. (j-1)
			local ship_type = strlower(SobGroup_GetShipType(ship_name))		-- make sure this is always lower case!
			local ship_bool = 1
			for k, this_squad in this_player do
				if (this_squad ~= nil) then
					local squads_sobg_ik = "SquadShips_" .. i .. "_" .. k
					if (SobGroup_Exists(squads_sobg_ik) == 1) then
						if (SobGroup_GroupInGroup(squads_sobg_ik, ship_name) == 1) then
							ship_bool = 0
							break
						end
					end
				end
			end
			if (ship_bool == 1) then
				SobGroup_SobGroupAdd(sector_sobg, ship_name)
			end
			SobGroup_Clear(ship_name)
		end
	end
	localShips[currentSectorRow][currentSectorCol] = UpdateSquadronTable(sector_sobg)
	-- don't need to calculate minhyperspeed or cantravel here
end

-- update all squads with current makeup
function UpdateSquadShips()
	for i, this_player in squadShips do
		for j, this_squad in this_player do
			UpdateThisSquad(i, j)
		end
	end
end

function UpdateThisSquad(i, j)
	local this_squad = squadShips[i][j]
	if (IsSquadValid(this_squad) == 1) then
		local squads_sobg = "SquadShips_" .. i .. "_" .. j
		local this_ships = UpdateSquadronTable(squads_sobg)
		if (getn(this_ships) == 0) then
			squadShips[i][j] = nil
		else
			squadShips[i][j].ships = this_ships
			squadShips[i][j].travel.minhyperspeed = CalcMinHyperSpeed(this_ships)
			squadShips[i][j].travel.cantravel = CanShipsTravel(this_ships)
		end
	end
end

-- write all ships to a temp file
function WriteTempSquadMenuData()
	local WriteFile = "$TMG_tempsquadmenu.lua"
	writeto(WriteFile)
	write("listedSquad = " .. listedSquad .. "\n")
	WriteSquadShips()
	WriteLocalShips()
	writeto()
end

function RefreshShipsList()
	listedSquad = 0
	UpdateLocalShips()
	UpdateSquadShips()
	WriteTempSquadMenuData()
	ReloadVisibleScreens()
end

-- list all ships in a squad
function ListSquad(squad_index)
	listedSquad = squad_index
	if (gametypeScope == "minor") then
		UpdateThisSquad(1, squad_index)
	end
	WriteTempSquadMenuData()
	ReloadVisibleScreens()
end

-- clear all ships from a squad
function ClearSquad(squad_index)
	local player_index = 0
	squadShips[player_index + 1][squad_index] = nil
	if (squad_index == listedSquad) then
		listedSquad = 0
	end
	local squads_sobg = "SquadShips_" .. (player_index + 1) .. "_" .. squad_index
	SobGroup_Clear(squads_sobg)
	UpdateSquadShips()
	WriteTempSquadMenuData()
	ReloadVisibleScreens()
end

-- select all ships in a squad
function SelectSquad(squad_index)
	if (squad_index > 0) then
		local player_index = 0
		local squads_sobg = "SquadShips_" .. (player_index + 1) .. "_" .. squad_index
		SobGroup_SelectSobGroup(squads_sobg)
	elseif (squad_index == 0) then
		local sector_sobg = "LocalShips"
		SobGroup_SelectSobGroup(sector_sobg)
	end
end

-- set a squad to the current selection
-- todo: don't allow probes and platforms here, they should never go in a squad
function SetSquad(squad_index)
	local player_index = 0
	local filter_sobg = "FilterShips"
	local docked_sobg = "DockedShips"
	local unions_sobg = "UnionShips"
	local squads_sobg = "SquadShips_" .. (player_index + 1) .. "_" .. squad_index
	SobGroup_CreateIfNotExist(filter_sobg)
	SobGroup_CreateIfNotExist(docked_sobg)
	SobGroup_CreateIfNotExist(unions_sobg)
	SobGroup_CreateIfNotExist(squads_sobg)
	SobGroup_Clear(filter_sobg)
	SobGroup_Clear(docked_sobg)
	SobGroup_Clear(unions_sobg)
	SobGroup_Clear(squads_sobg)
	Player_GetShipsByFilterInclude(player_index, filter_sobg, "NoFilter", "")
	local ship_name_sub = "PROCESSSQUADSHIP_"
	local ship_count = SobGroup_Separate(ship_name_sub, filter_sobg)
	for j = 1, ship_count do
		local ship_name = ship_name_sub .. (j-1)
		local is_selected = SobGroup_Selected(ship_name)
		if (is_selected == 1) then
			SobGroup_SobGroupAdd(unions_sobg, ship_name)
		end
		SobGroup_Clear(ship_name)
	end
	SobGroup_GetSobGroupDockedWithGroup(unions_sobg, docked_sobg)
	SobGroup_SobGroupAdd(unions_sobg, docked_sobg)
	SobGroup_SobGroupAdd(squads_sobg, unions_sobg)
	if (SobGroup_Empty(squads_sobg) == 1) then
		return
	end
	local this_ships = UpdateSquadronTable(squads_sobg)
	local temp_squad =
	{
		travel =
		{
			inhyperspace = 0,
			minhyperspeed = CalcMinHyperSpeed(this_ships),
			cantravel = CanShipsTravel(this_ships),
			escaping = 0,
			intransit = 0,
			departuretime = 0,
			arrivaltime = 0,
			path =
			{
				{currentSectorRow, currentSectorCol, 0}
			},
			lastpathnode = {},
		},
		task = {},
		ships = this_ships,
	}
	squadShips[player_index + 1][squad_index] = temp_squad
	-- remove ships from other squads
	local this_player = squadShips[player_index + 1]
	for j, this_squad in this_player do
		if ((IsSquadValid(this_squad) == 1) and (j ~= squad_index)) then
			local squads_sobg_j = "SquadShips_" .. (player_index + 1) .. "_" .. j
			SobGroup_FillSubstract(squads_sobg_j, squads_sobg_j, squads_sobg)
			local othr_ships = UpdateSquadronTable(squads_sobg_j)
			if (getn(othr_ships) == 0) then
				squadShips[player_index + 1][j] = nil
			else
				squadShips[player_index + 1][j].ships = othr_ships
				squadShips[player_index + 1][j].travel.minhyperspeed = CalcMinHyperSpeed(othr_ships)
				squadShips[player_index + 1][j].travel.cantravel = CanShipsTravel(othr_ships)
			end
		end
	end
	listedSquad = squad_index
	UpdateSquadShips()
	WriteTempSquadMenuData()
	ReloadVisibleScreens()
end

-- add one or more ships from a squad
function AddToSquad(squad_index)
	local player_index = 0
	local filter_sobg = "FilterShips"
	local docked_sobg = "DockedShips"
	local unions_sobg = "UnionShips"
	local squads_sobg = "SquadShips_" .. (player_index + 1) .. "_" .. squad_index
	SobGroup_CreateIfNotExist(filter_sobg)
	SobGroup_CreateIfNotExist(docked_sobg)
	SobGroup_CreateIfNotExist(unions_sobg)
	SobGroup_CreateIfNotExist(squads_sobg)
	SobGroup_Clear(filter_sobg)
	SobGroup_Clear(docked_sobg)
	SobGroup_Clear(unions_sobg)
	Player_GetShipsByFilterInclude(player_index, filter_sobg, "NoFilter", "")
	local ship_name_sub = "PROCESSSQUADSHIP_"
	local ship_count = SobGroup_Separate(ship_name_sub, filter_sobg)
	for j = 1, ship_count do
		local ship_name = ship_name_sub .. (j-1)
		local is_selected = SobGroup_Selected(ship_name)
		if (is_selected == 1) then
			SobGroup_SobGroupAdd(unions_sobg, ship_name)
		end
		SobGroup_Clear(ship_name)
	end
	SobGroup_GetSobGroupDockedWithGroup(unions_sobg, docked_sobg)
	SobGroup_SobGroupAdd(unions_sobg, docked_sobg)
	SobGroup_SobGroupAdd(squads_sobg, unions_sobg)
	if (SobGroup_Empty(squads_sobg) == 1) then
		return
	end
	local this_ships = UpdateSquadronTable(squads_sobg)
	local temp_squad = squadShips[player_index + 1][squad_index]
	if (temp_squad == nil) then
		temp_squad =
		{
			travel =
			{
				inhyperspace = 0,
				minhyperspeed = CalcMinHyperSpeed(this_ships),
				cantravel = CanShipsTravel(this_ships),
				escaping = 0,
				intransit = 0,
				path =
				{
					{currentSectorRow, currentSectorCol, 0},
				},
				lastpathnode = {},
			},
			task = {},
			ships = this_ships,
		}
	end
	squadShips[player_index + 1][squad_index] = temp_squad
	-- remove ships from other squads
	local this_player = squadShips[player_index + 1]
	for j, this_squad in this_player do
		if ((IsSquadValid(this_squad) == 1) and (j ~= squad_index)) then
			local squads_sobg_j = "SquadShips_" .. (player_index + 1) .. "_" .. j
			SobGroup_FillSubstract(squads_sobg_j, squads_sobg_j, squads_sobg)
			local othr_ships = UpdateSquadronTable(squads_sobg_j)
			if (getn(othr_ships) == 0) then
				squadShips[player_index + 1][j] = nil
			else
				squadShips[player_index + 1][j].ships = othr_ships
				squadShips[player_index + 1][j].travel.minhyperspeed = CalcMinHyperSpeed(othr_ships)
				squadShips[player_index + 1][j].travel.cantravel = CanShipsTravel(othr_ships)
			end
		end
	end
	UpdateSquadShips()
	WriteTempSquadMenuData()
	ReloadVisibleScreens()
end

-- remove one or more ships from a squad
function SubtractFromSquad(squad_index)
	local player_index = 0
	local filter_sobg = "FilterShips"
	local docked_sobg = "DockedShips"
	local unions_sobg = "UnionShips"
	local squads_sobg = "SquadShips_" .. (player_index + 1) .. "_" .. squad_index
	SobGroup_CreateIfNotExist(filter_sobg)
	SobGroup_CreateIfNotExist(docked_sobg)
	SobGroup_CreateIfNotExist(unions_sobg)
	SobGroup_CreateIfNotExist(squads_sobg)
	SobGroup_Clear(filter_sobg)
	SobGroup_Clear(docked_sobg)
	SobGroup_Clear(unions_sobg)
	Player_GetShipsByFilterInclude(player_index, filter_sobg, "NoFilter", "")
	local ship_name_sub = "PROCESSSQUADSHIP_"
	local ship_count = SobGroup_Separate(ship_name_sub, filter_sobg)
	for j = 1, ship_count do
		local ship_name = ship_name_sub .. (j-1)
		local is_selected = SobGroup_Selected(ship_name)
		if (is_selected == 1) then
			SobGroup_SobGroupAdd(unions_sobg, ship_name)
		end
		SobGroup_Clear(ship_name)
	end
	SobGroup_GetSobGroupDockedWithGroup(unions_sobg, docked_sobg)
	SobGroup_SobGroupAdd(unions_sobg, docked_sobg)
	SobGroup_FillSubstract(squads_sobg, squads_sobg, unions_sobg)
	local this_ships = UpdateSquadronTable(squads_sobg)
	if (getn(this_ships) == 0) then
		squadShips[player_index + 1][squad_index] = nil
	else
		squadShips[player_index + 1][squad_index].ships = this_ships
		squadShips[player_index + 1][squad_index].travel.minhyperspeed = CalcMinHyperSpeed(this_ships)
		squadShips[player_index + 1][squad_index].travel.cantravel = CanShipsTravel(this_ships)
	end
	UpdateSquadShips()
	WriteTempSquadMenuData()
	ReloadVisibleScreens()
end

-- todo: ships docked inside ships that are docked inside still more ships, and so on will probably fail here, since the routine is not recursive
function UpdateSquadronTable(in_sobgroup)
	local valid_ships_count = 1
	local valid_ships = {}
	local large_ships_count = 1
	local large_ships = {}
	local medum_ships_count = 1
	local medum_ships = {}
	local small_ships_count = 1
	local small_ships = {}
	local other_ships_count = 1
	local other_ships = {}
	local ship_name_sub = "PROCESSSHIP_"
	local ship_count = SobGroup_Separate(ship_name_sub, in_sobgroup)
	-- first pass, do all ships
	for j = 1, ship_count do
		-- do ships
		local ship_name = ship_name_sub .. (j-1)
		local this_ship = {}
		local ship_type = strlower(SobGroup_GetShipType(ship_name))		-- make sure this is always lower case!
		local ship_cood = SobGroup_GetPosition(ship_name)
		local ship_syst = SobGroup_GetCoordSys(ship_name)
		local list_ship = objectData.ships[ship_type]
		this_ship.name = ship_name					-- not unique across all fleets, and could be deleted from output
		this_ship.type = ship_type
		this_ship.position = ship_cood
		this_ship.rotation = MatrixToEuler(ship_syst)
		this_ship.playerindex = SobGroup_OwnedBy(ship_name)
		this_ship.shiphold = {}

		-- do subsystems
		local list_subs = list_ship.subsystems
		local ship_subs = {}
		local ship_subs_count = 1
		for k = 1, getn(list_subs) do
			local this_subs = strlower(list_subs[k])
			if (SobGroup_HasSubsystem(ship_name, this_subs) == 1) then
				ship_subs[ship_subs_count] = this_subs
				ship_subs_count = ship_subs_count + 1
			end
		end
		this_ship.subsystems = ship_subs

		-- do sobgroups, *should* only apply to local ships
		local temp_sobgroups_table = {}
		local list_sobgroups_table = localSobgroups[currentSectorRow][currentSectorCol]
		local list_sobgroups_count = getn(list_sobgroups_table)
		local sobg_count = 1
		for k = 1, list_sobgroups_count do
			local this_important_sobgroup = list_sobgroups_table[k]
			if (SobGroup_GroupInGroup(ship_name, this_important_sobgroup) == 1) then
				temp_sobgroups_table[sobg_count] = this_important_sobgroup
				sobg_count = sobg_count + 1
			end
		end
		this_ship.sobgroups = temp_sobgroups_table

		-- divide ships into large and small categories
		local has_shiphold = list_ship.hasshiphold
		local can_dock = list_ship.candock
		local can_hyper = list_ship.canhyperspace
		if (has_shiphold == 1) then
			large_ships[large_ships_count] = this_ship
			large_ships_count = large_ships_count + 1
		elseif (can_hyper == 1) then
			medum_ships[medum_ships_count] = this_ship
			medum_ships_count = medum_ships_count + 1
		elseif (can_dock == 1) then
			small_ships[small_ships_count] = this_ship
			small_ships_count = small_ships_count + 1
		else
			other_ships[other_ships_count] = this_ship
			other_ships_count = other_ships_count + 1
		end

		SobGroup_Clear(ship_name)
	end
	-- second pass, do undocked and docked small ships
	for j = 1, getn(small_ships) do
		local this_small_ship = small_ships[j]
		local this_small_name = this_small_ship.name
		local hold_bool = 0
		for k = 1, getn(large_ships) do
			local this_large_ship = large_ships[k]
			local this_large_name = this_large_ship.name
			local is_docked = SobGroup_IsDockedSobGroup(this_small_name, this_large_name)
			-- do docked small ships
			if (is_docked == 1) then
				local shiphold_count = getn(large_ships[k].shiphold)
				large_ships[k].shiphold[shiphold_count + 1] = this_small_ship
				hold_bool = 1
				break
			end
		end
		-- do undocked small ships
		if (hold_bool == 0) then
			valid_ships[valid_ships_count] = this_small_ship
			valid_ships_count = valid_ships_count + 1
		end
	end
	-- third pass, do large ships
	for j = 1, getn(large_ships) do
		local this_large_ship = large_ships[j]
		valid_ships[valid_ships_count] = this_large_ship
		valid_ships_count = valid_ships_count + 1
	end
	-- fourth pass, do medium ships
	for j = 1, getn(medum_ships) do
		local this_medum_ship = medum_ships[j]
		valid_ships[valid_ships_count] = this_medum_ship
		valid_ships_count = valid_ships_count + 1
	end
	-- fifth pass, do platforms and probes
	for j = 1, getn(other_ships) do
		local this_other_ship = other_ships[j]
		valid_ships[valid_ships_count] = this_other_ship
		valid_ships_count = valid_ships_count + 1
	end
	return valid_ships
end

function CanShipsTravel(this_ships)
	for i = 1, getn(this_ships) do
		local this_ship = this_ships[i]
		local ship_type = this_ship.type	-- make sure this is always lower case!
		local ship_subs = this_ship.subsystems
		for j = 1, getn(ship_subs) do
			local this_subs = ship_subs[j]
			for k = 1, getn(hyperMods) do
				local hypr_subs = hyperMods[k]
				if (this_subs == hypr_subs) then
					return 1
				end
			end
		end
	end
	return 0
end

-- determine the speed of the slowest hyperspace-capable ship in the squad
function CalcMinHyperSpeed(in_ships)
	local min_ship_speed = 1000000		-- obscenely large value
	for j = 1, getn(in_ships) do
		local this_ship = in_ships[j]
		local ship_type = this_ship.type
		local list_ship = objectData.ships[ship_type]
		local list_speed = list_ship.hyperspeed
		local list_canhyper = list_ship.canhyperspace
		if (list_canhyper == 1) then
			min_ship_speed = min(min_ship_speed, list_speed)
		end
	end
	if (min_ship_speed == 1000000) then
		error("CalcMinHyperSpeed: Error. Min hyper speed is 1000000.")
	elseif (min_ship_speed == 0) then
		error("CalcMinHyperSpeed: Error. Min hyper speed is 0.")
	end
	return min_ship_speed
end

-- calculate the amount of time it takes to travel between sectors
function CalcSectorTravelTime(in_minspeed)
	if ((in_minspeed > 0) and (in_minspeed < 1000000)) then
		return baseSectorTravelTime * baseSectorTravelMult / in_minspeed
	else
		return -1
	end
end

-- determine if a squad is populated, and if the squad is located in the current sector
function IsSquadValid(temp_squad)
	if (temp_squad == nil) then
		return 0
	else
		local temp_path = temp_squad.travel.path
		local temp_path_length = getn(temp_path)
		local temp_destination = temp_path[1]
		local temp_destination_row = temp_destination[1]
		local temp_destination_col = temp_destination[2]
		if ((temp_destination_row == currentSectorRow) and (temp_destination_col == currentSectorCol) and (temp_path_length == 1)) then
			return 1
		else
			return 0
		end
	end
end
