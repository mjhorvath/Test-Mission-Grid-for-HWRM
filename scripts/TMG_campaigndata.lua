outer_distance = 50000
inner_distance = 40000
enter_distance = 30000
grid_distance = inner_distance
ping_distance = (outer_distance + inner_distance)/2

textDirections = {"East","South","West","North","Center",}		-- 1 = East, 2 = South, 3 = West, 4 = North, 5 = Center
abbvDirections = {"e","s","w","n","x",}					-- 1 = East, 2 = South, 3 = West, 4 = North, 5 = Center
tranDirections = {3,4,1,2,5,}						-- 1 = East, 2 = South, 3 = West, 4 = North, 5 = Center
exitDirectionsCol = {1,0,-1,0,0}					-- 1 = East, 2 = South, 3 = West, 4 = North, 5 = Center
exitDirectionsRow = {0,1,0,-1,0}					-- 1 = East, 2 = South, 3 = West, 4 = North, 5 = Center

exitRotations =
{
	{0,1*-90-90,0},	-- East
	{0,2*-90-90,0},	-- South
	{0,3*-90-90,0},	-- West
	{0,4*-90-90,0},	-- North
	{0,0,0},	-- Center
}

-- there should be one item in the spheres table for every sector
-- each sector has up to four exit spheres and entry spheres: 1. East, 2. South, 3. West, 4. North
-- each exit sphere has four parameters: 1. the sector the exit leads to, 2. the sphere's location, 3. the sphere's radius, 4. the ping's text label
exitSpheres =
{
	-- row 1
	{
		-- column A
		{
			{"sector_b1", nil, nil, "Proceed east to Sector B1.",},		-- East
			{"sector_a2", nil, nil, "Proceed south to Sector A2.",},	-- South
			nil,								-- West
			nil,								-- North
		},
		-- column B
		{
			{"sector_c1", nil, nil, "Proceed east to Sector C1.",},
			{"sector_b2", nil, nil, "Proceed south to Sector B2.",},
			{"sector_a1", nil, nil, "Proceed west to Sector A1.",},
			nil,
		},
		-- column C
		{
			{"sector_d1", nil, nil, "Proceed east to Sector D1.",},
			{"sector_c2", nil, nil, "Proceed south to Sector C2.",},
			{"sector_b1", nil, nil, "Proceed west to Sector B1.",},
			nil,
		},
		-- column D
		{
			nil,
			{"sector_d2", nil, nil, "Proceed south to Sector D2.",},
			{"sector_c1", nil, nil, "Proceed west to Sector C1.",},
			nil,
		},
	},
	-- row 2
	{
		-- column A
		{
			{"sector_b2", nil, nil, "Proceed east to Sector B2.",},
			{"sector_a3", nil, nil, "Proceed south to Sector A3.",},
			nil,
			{"sector_a1", nil, nil, "Proceed north to Sector A1.",},
		},
		-- column B
		{
			{"sector_c2", nil, nil, "Proceed east to Sector C2.",},
			{"sector_b3", nil, nil, "Proceed south to Sector B3.",},
			{"sector_a2", nil, nil, "Proceed west to Sector A2.",},
			{"sector_b1", nil, nil, "Proceed north to Sector B1.",},
		},
		-- column C
		{
			{"sector_d2", nil, nil, "Proceed east to Sector D2.",},
			{"sector_c3", nil, nil, "Proceed south to Sector C3.",},
			{"sector_b2", nil, nil, "Proceed west to Sector B2.",},
			{"sector_c1", nil, nil, "Proceed north to Sector C1.",},
		},
		-- column D
		{
			nil,
			{"sector_d3", nil, nil, "Proceed south to Sector D3.",},
			{"sector_c2", nil, nil, "Proceed west to Sector C2.",},
			{"sector_d1", nil, nil, "Proceed north to Sector D1.",},
		},
	},
	-- row 3
	{
		-- column A
		{
			{"sector_b3", nil, nil, "Proceed east to Sector B3.",},
			{"sector_a4", nil, nil, "Proceed south to Sector A4.",},
			nil,
			{"sector_a2", nil, nil, "Proceed north to Sector A2.",},
		},
		-- column B
		{
			{"sector_c3", nil, nil, "Proceed east to Sector C3.",},
			{"sector_b4", nil, nil, "Proceed south to Sector B4.",},
			{"sector_a3", nil, nil, "Proceed west to Sector A3.",},
			{"sector_b2", nil, nil, "Proceed north to Sector B2.",},
		},
		-- column C
		{
			{"sector_d3", nil, nil, "Proceed east to Sector D3.",},
			{"sector_c4", nil, nil, "Proceed south to Sector C4.",},
			{"sector_b3", nil, nil, "Proceed west to Sector B3.",},
			{"sector_c2", nil, nil, "Proceed north to Sector C2.",},
		},
		-- column D
		{
			nil,
			{"sector_d4", nil, nil, "Proceed south to Sector D4.",},
			{"sector_c3", nil, nil, "Proceed west to Sector C3.",},
			{"sector_d2", nil, nil, "Proceed north to Sector D2.",},
		},
	},
	-- row 4
	{
		-- column A
		{
			{"sector_b4", nil, nil, "Proceed east to Sector B4.",},
			nil,
			nil,
			{"sector_a3", nil, nil, "Proceed north to Sector A3.",},
		},
		-- column B
		{
			{"sector_c4", nil, nil, "Proceed east to Sector C4.",},
			nil,
			{"sector_a4", nil, nil, "Proceed west to Sector A4.",},
			{"sector_b3", nil, nil, "Proceed north to Sector B3.",},
		},
		-- column C
		{
			{"sector_d4", nil, nil, "Proceed east to Sector D4.",},
			nil,
			{"sector_b4", nil, nil, "Proceed west to Sector B4.",},
			{"sector_c3", nil, nil, "Proceed north to Sector C3.",},
		},
		-- column D
		{
			nil,
			nil,
			{"sector_c4", nil, nil, "Proceed west to Sector C4.",},
			{"sector_d3", nil, nil, "Proceed north to Sector D3.",},
		},
	},
}

-- if you don't have any images, or want to cut down on file size, you can use this placeholder: [[Data:UI\MapThumbnails\Campaign\Default.tga]].
campaignTable =
{
	title = [[Test Mission Grid]],
	titlecaps = [[TEST MISSION GRID]],
	description = [[Details about the Test Mission Grid campaign.]],
	background = [[Data:ui\newui\ingameicons\galaxy_map.tga]],
	backgroundUV = {0,0,1024,1024},		-- should be square
	useBackground = 1,
	useThumbnails = 0,
	numMissionCols = 4,
	numMissionRows = 4,
	missions =
	{
		-- row 1
		{
			-- column A
			{
				displayName = "Sector A1",
				description = "Build a Ship",
				longDescription = "Build one Scout squadron to win the mission.",
				thumb = [[Data:UI\MapThumbnails\Campaign\testmissiongrid\sector_a1.dds]],
				thumbUV = {0,0,484,388},
			},
			-- column B
			{
				displayName = "Sector B1",
				description = "Build a Subsytem",
				longDescription = "Build one fighter production facility on a shipyard or mothership to win the mission.",
				thumb = [[Data:UI\MapThumbnails\Campaign\testmissiongrid\sector_b1.dds]],
				thumbUV = {0,0,484,388},
			},
			-- column C
			{
				displayName = "Sector C1",
				description = "Gather Resources",
				longDescription = "Gather 200 additional RUs to win the mission.",
				thumb = [[Data:UI\MapThumbnails\Campaign\testmissiongrid\sector_c1.dds]],
				thumbUV = {0,0,484,388},
			},
			-- column D
			{
				displayName = "Sector D1",
				description = "Capture an Enemy Ship",
				longDescription = "Capture the enemy ship to win the mission.",
				thumb = [[Data:UI\MapThumbnails\Campaign\testmissiongrid\sector_d1.dds]],
				thumbUV = {0,0,484,388},
			},
		},
		-- row 2
		{
			-- column A
			{
				displayName = "Sector A2",
				description = "Destroy an Enemy Ship",
				longDescription = "Destroy the enemy ship to win the mission.",
				thumb = [[Data:UI\MapThumbnails\Campaign\testmissiongrid\sector_a2.dds]],
				thumbUV = {0,0,484,388},
			},
			-- column B
			{
				displayName = "Sector B2",
				description = "Destroy an Enemy Subsystem",
				longDescription = "Destroy the carrier's fighter module to win the mission.",
				thumb = [[Data:UI\MapThumbnails\Campaign\testmissiongrid\sector_b2.dds]],
				thumbUV = {0,0,484,388},
			},
			-- column C
			{
				displayName = "Sector C2",
				description = "Defend an Allied Ship",
				longDescription = "Defend the allied carrier from attack. Destroy the attackers.",
				thumb = [[Data:UI\MapThumbnails\Campaign\testmissiongrid\sector_c2.dds]],
				thumbUV = {0,0,484,388},
			},
			-- column D
			{
				displayName = "Sector D2",
				description = "Move a Ship",
				longDescription = "Send a ship to the marked destination.",
				thumb = [[Data:UI\MapThumbnails\Campaign\testmissiongrid\sector_d2.dds]],
				thumbUV = {0,0,484,388},
			},
		},
		-- row 3
		{
			-- column A
			{
				displayName = "Sector A3",
				description = "Find an Enemy Ship",
				longDescription = "Find the enemy carrier to win the mission.",
				thumb = [[Data:UI\MapThumbnails\Campaign\testmissiongrid\sector_a3.dds]],
				thumbUV = {0,0,484,388},
			},
			-- column B
			{
				displayName = "Sector B3",
				description = "Repair an Allied Ship",
				longDescription = "Repair the allied carrier to win the mission.",
				thumb = [[Data:UI\MapThumbnails\Campaign\testmissiongrid\sector_b3.dds]],
				thumbUV = {0,0,484,388},
			},
			-- column C
			{
				displayName = "Sector C3",
				description = "Research an Item",
				longDescription = "Research the Repair ability to win the mission.",
				thumb = [[Data:UI\MapThumbnails\Campaign\testmissiongrid\sector_c3.dds]],
				thumbUV = {0,0,484,388},
			},
			-- column D
			{
				displayName = "Sector D3",
				description = "Meet New People",
				longDescription = "Have a friendly chat with Captain Soban and Shipyard Nabaal. You must fly within 10,000 meters of the target and select the ship in order to initiate dialogue.",
				thumb = [[Data:UI\MapThumbnails\Campaign\testmissiongrid\sector_d3.dds]],
				thumbUV = {0,0,484,388},
			},
		},
		-- row 4
		{
			-- column A
			{
				displayName = "Sector A4",
				description = "Avoid an Enemy Ship",
				longDescription = "Avoid the ship in the center of the map while continuing on to the next sector. The enemy ship should still be here if you come back later.",
				thumb = [[Data:UI\MapThumbnails\Campaign\testmissiongrid\sector_a4.dds]],
				thumbUV = {0,0,484,388},
			},
			-- column B
			{
				displayName = "Sector B4",
				description = "Empty",
				longDescription = "This sector is empty.",
				thumb = [[Data:UI\MapThumbnails\Campaign\testmissiongrid\sector_b4.dds]],
				thumbUV = {0,0,484,388},
			},
			-- column C
			{
				displayName = "Sector C4",
				description = "Empty",
				longDescription = "This sector is empty.",
				thumb = [[Data:UI\MapThumbnails\Campaign\testmissiongrid\sector_c4.dds]],
				thumbUV = {0,0,484,388},
			},
			-- column D
			{
				displayName = "Sector D4",
				description = "Final Skirmish",
				longDescription = "Defeat the enemy fleet in battle.",
				thumb = [[Data:UI\MapThumbnails\Campaign\testmissiongrid\sector_d4.dds]],
				thumbUV = {0,0,484,388},
			},
		},
	},
}

-- are there obstacles preventing movement in the galaxy?
-- values should only be "Empty" or "Obstacle"
terrainTable =
{
	{"Empty","Empty","Empty","Empty",},
	{"Empty","Empty","Empty","Empty",},
	{"Empty","Empty","Empty","Empty",},
	{"Empty","Empty","Empty","Empty",},
}
