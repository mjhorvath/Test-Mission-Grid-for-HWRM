--------------------------------------------------------------------------------
-- Initialize everything
--
iRow = 0
iCol = 0
shipCount = 0
squadMax = 12
playerMax = 3
shipSizes = 4
listedSquad = 0
movingSquad = 0

-- todo: need to deprecate the "tasks" table
squadShips =
{
	{
		{
			travel =
			{
				minhyperspeed = 40,
				inhyperspace = 1,
				cantravel = 1,
				escaping = 1,
				intransit = 1,
				departuretime = 0,
				arrivaltime = 0,
				path =
				{
					{1,1,3},
				},
				lastpathnode = {},
			},
			task =
			{
				type = "escape",
			},
			ships =
			{
				{
					type = "hgn_mothership",
					name = "",
					subsystems =
					{
						"hgn_ms_module_hyperspace",
					},
					position = {0,0,0},
					rotation = {0,0,0},
					playerindex = 0,
					shiphold =
					{
					},
					sobgroups = {},
				},
				{
					type = "hgn_ioncannonfrigate",
					name = "",
					subsystems = {},
					position = {0,0,0},
					rotation = {0,0,0},
					playerindex = 0,
					shiphold = {},
					sobgroups = {},
				},
			},
		},
		{
			travel =
			{
				minhyperspeed = 81,
				inhyperspace = 1,
				cantravel = 1,
				escaping = 1,
				intransit = 1,
				departuretime = 0,
				arrivaltime = 0,
				path =
				{
					{1,1,3},
				},
				lastpathnode = {},
			},
			task =
			{
				type = "escape",
			},
			ships =
			{
				{
					type = "hgn_carrier",
					name = "",
					subsystems =
					{
						"hgn_c_module_hyperspace",
					},
					position = {0,0,0},
					rotation = {0,0,0},
					playerindex = 0,
					shiphold =
					{
						{
							type = "hgn_interceptor",
							name = "",
							subsystems = {},
							position = {0,0,0},
							rotation = {0,0,0},
							playerindex = 0,
							shiphold = {},
							sobgroups = {},
						},
						{
							type = "hgn_interceptor",
							name = "",
							subsystems = {},
							position = {0,0,0},
							rotation = {0,0,0},
							playerindex = 0,
							shiphold = {},
							sobgroups = {},
						},
					},
					sobgroups = {},
				},

			},
		},
	},
	{},
	{},
}

localShips =
{
	{{},{},{},{},},
	{{},{},{},{},},
	{{},{},{},{},},
	{{},{},{},{},},
}

-- mostly persistent, important mission sobgroups
localSobgroups =
{
	{{},{},{},{},},
	{{},{},{},{},},
	{{},{},{},{},},
	{{},{},{},{},},
}

--------------------------------------------------------------------------------
-- Sector A1: Build a Scout
--
iCol = 1
iRow = 1
shipCount = getn(localShips[iRow][iCol]) + 1
localShips[iRow][iCol][shipCount] = 
{
	type = "hgn_probe",
	name = "",
	position = {0,1000,0},
	rotation = {0,45,0},
	subsystems = {},
	sobgroups = {},
	playerindex = 0,
	shiphold = {},
}
shipCount = shipCount + 1
localShips[iRow][iCol][shipCount] =
{
	type = "hgn_probe",
	name = "",
	position = {0,-1000,0},
	rotation = {0,-45,0},
	subsystems = {},
	sobgroups = {},
	playerindex = 2,
	shiphold = {},
}

--------------------------------------------------------------------------------
-- Sector A2: Destroy the Enemy Ship
--
iCol = 1
iRow = 2
localSobgroups[iRow][iCol] = {"EnyGroup"}
shipCount = getn(localShips[iRow][iCol]) + 1
localShips[iRow][iCol][shipCount] = 
{
	type = "vgr_resourcecollector",
	name = "",
	position = {0,0,0},
	rotation = {0,0,0},
	subsystems = {},
	sobgroups = {"EnyGroup"},
	playerindex = 1,
	shiphold = {},
}
for i = 1, 4 do
	shipCount = shipCount + 1
	localShips[iRow][iCol][shipCount] =
	{
		type = "hgn_attackbomber",
		name = "",
		position = {-1000+i*-250, 0, 0},
		rotation = {0,0,0},
		subsystems = {},
		sobgroups = {},
		playerindex = 0,
		shiphold = {},
	}
end

--------------------------------------------------------------------------------
-- Sector A3: Find a Ship
--
iCol = 1
iRow = 3
localSobgroups[iRow][iCol] = {"EnyGroup"}
shipCount = getn(localShips[iRow][iCol]) + 1
localShips[iRow][iCol][shipCount] = 
{
	type = "vgr_carrier",
	name = "",
	position = {-15000,0,15000},
	rotation = {0,0,0},
	subsystems = {},
	sobgroups = {"EnyGroup"},
	playerindex = 1,
	shiphold = {},
}
shipCount = shipCount + 1
localShips[iRow][iCol][shipCount] =
{
	type = "hgn_scout",
	name = "",
	position = {0,0,0},
	rotation = {0,0,0},
	subsystems = {},
	sobgroups = {},
	playerindex = 0,
	shiphold = {},
}

--------------------------------------------------------------------------------
-- Sector A4: Avoid the Enemy Ship
--
iCol = 1
iRow = 4
localSobgroups[iRow][iCol] = {"EnyGroup"}
shipCount = getn(localShips[iRow][iCol]) + 1
localShips[iRow][iCol][shipCount] = 
{
	type = "kpr_sajuuk",
	name = "",
	position = {0,0,0},
	rotation = {0,0,0},
	subsystems = {},
	sobgroups = {"EnyGroup"},
	playerindex = 1,
	shiphold = {},
}

--------------------------------------------------------------------------------
-- Sector B1: Build a Fighter Module
--
-- Nothing.

--------------------------------------------------------------------------------
-- Sector B2: Destroy the Enemy Subsystem
--
iCol = 2
iRow = 2
localSobgroups[iRow][iCol] = {"EnyGroup"}
shipCount = getn(localShips[iRow][iCol]) + 1
localShips[iRow][iCol][shipCount] = 
{
	type = "vgr_carrier",
	name = "",
	position = {0,0,0},
	rotation = {0,0,0},
	subsystems = {},
	sobgroups = {"EnyGroup"},
	playerindex = 1,
	shiphold = {},
}
for i = 1, 4 do
	shipCount = shipCount + 1
	localShips[iRow][iCol][shipCount] =
	{
		type = "hgn_attackbomber",
		name = "",
		position = {i*300,0,-5000},
		rotation = {0,0,0},
		subsystems = {},
		sobgroups = {},
		playerindex = 0,
		shiphold = {},
	}
end

--------------------------------------------------------------------------------
-- Sector B3: Repair the Allied Ship
--
iCol = 2
iRow = 3
localSobgroups[iRow][iCol] = {"CRGroup"}
shipCount = getn(localShips[iRow][iCol]) + 1
localShips[iRow][iCol][shipCount] = 
{
	type = "hgn_carrier",
	name = "",
	position = {0,0,0},
	rotation = {0,0,0},
	subsystems = {},
	sobgroups = {"CRGroup"},
	playerindex = 2,
	shiphold = {},
}
for i = 1, 5 do
	shipCount = shipCount + 1
	localShips[iRow][iCol][shipCount] =
	{
		type = "hgn_resourcecollector",
		name = "",
		position = {i*300,0,-5000},
		rotation = {0,0,0},
		subsystems = {},
		sobgroups = {},
		playerindex = 0,
		shiphold = {},
	}
end

--------------------------------------------------------------------------------
-- Sector B4: Empty
--
-- Nothing.

--------------------------------------------------------------------------------
-- Sector C1: Gather Some Resources
--
iCol = 3
iRow = 1
shipCount = getn(localShips[iRow][iCol]) + 1
localShips[iRow][iCol][shipCount] = 
{
	type = "hgn_resourcecollector",
	name = "",
	position = {0,0,-2000},
	rotation = {0,0,0},
	subsystems = {},
	sobgroups = {},
	playerindex = 0,
	shiphold = {},
}
shipCount = shipCount + 1
localShips[iRow][iCol][shipCount] =
{
	type = "hgn_resourcecontroller",
	name = "",
	position = {0,0,2000},
	rotation = {0,0,0},
	subsystems = {},
	sobgroups = {},
	playerindex = 0,
	shiphold = {},
}

--------------------------------------------------------------------------------
-- Sector C2: Defend the Allied Ship
--
iCol = 3
iRow = 2
localSobgroups[iRow][iCol] = {"CRGroup", "EnyGroup"}
shipCount = getn(localShips[iRow][iCol]) + 1
localShips[iRow][iCol][shipCount] = 
{
	type = "hgn_carrier",
	name = "",
	position = {0,0,0},
	rotation = {0,0,0},
	subsystems = {},
	sobgroups = {"CRGroup"},
	playerindex = 2,
	shiphold = {},
}
for i = 1, 4 do
	shipCount = shipCount + 1
	localShips[iRow][iCol][shipCount] =
	{
		type = "vgr_bomber",
		name = "",
		position = {5000,0,i*300},
		rotation = {0,0,0},
		subsystems = {},
		sobgroups = {"EnyGroup"},
		playerindex = 1,
		shiphold = {},
	}
end
for i = 1, 4 do
	shipCount = shipCount + 1
	localShips[iRow][iCol][shipCount] = 
	{
		type = "hgn_interceptor",
		name = "",
		position = {-5000,0,i*300},
		rotation = {0,0,0},
		subsystems = {},
		sobgroups = {},
		playerindex = 0,
		shiphold = {},
	}
end

--------------------------------------------------------------------------------
-- Sector C3: Research an Item
--
-- Nothing.

--------------------------------------------------------------------------------
-- Sector C4: Empty
--
-- Nothing.

--------------------------------------------------------------------------------
-- Sector D1: Capture the Enemy Ship
--
iCol = 4
iRow = 1
localSobgroups[iRow][iCol] = {"EnyGroup"}
shipCount = getn(localShips[iRow][iCol]) + 1
localShips[iRow][iCol][shipCount] = 
{
	type = "vgr_carrier",
	name = "",
	position = {0,0,0},
	rotation = {0,0,0},
	subsystems = {},
	sobgroups = {"EnyGroup"},
	playerindex = 1,
	shiphold = {},
}
shipCount = shipCount + 1
localShips[iRow][iCol][shipCount] =
{
	type = "hgn_marinefrigate",
	name = "",
	position = {0, 0, -5000},
	rotation = {0,0,0},
	subsystems = {},
	sobgroups = {},
	playerindex = 0,
	shiphold = {},
}

--------------------------------------------------------------------------------
-- Sector D2: Move a Ship
--
iCol = 4
iRow = 2
localSobgroups[iRow][iCol] = {"sobscout"}
shipCount = getn(localShips[iRow][iCol]) + 1
localShips[iRow][iCol][shipCount] = 
{
	type = "hgn_scout",
	name = "",
	position = {0,0,0},
	rotation = {0,0,0},
	subsystems = {},
	sobgroups = {"sobscout"},
	playerindex = 0,
	shiphold = {},
}

--------------------------------------------------------------------------------
-- Sector D3: Meet New People
--
iCol = 4
iRow = 3
localSobgroups[iRow][iCol] = {"SobanGroup", "ElohimGroup"}
shipCount = getn(localShips[iRow][iCol]) + 1
localShips[iRow][iCol][shipCount] = 
{
	type = "hgn_marinefrigate_soban",
	name = "",
	position = {1000,0,0},
	rotation = {0,0,0},
	subsystems = {},
	sobgroups = {"SobanGroup"},
	playerindex = 2,
	shiphold = {},
}
shipCount = shipCount + 1
localShips[iRow][iCol][shipCount] = 
{
	type = "hgn_shipyard_elohim",
	name = "",
	position = {-1000,0,0},
	rotation = {0,0,0},
	subsystems = {},
	sobgroups = {"ElohimGroup"},
	playerindex = 2,
	shiphold = {},
}

--------------------------------------------------------------------------------
-- Sector D4: Final Skirmish
--
-- Nothing.
