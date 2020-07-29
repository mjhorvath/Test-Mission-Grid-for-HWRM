-- This file initializes the campaign state, which is overriden later with "TMG_savegame.lua" if it exists.
-- You can reset the campaign to its initial state by deleting all files in the "HomeworldRM\Bin\Profiles\Profile2\TestMissionGrid" folder.
-- Make sure that all ship and subsystem types are always lower case!

colLabels		= {"A","B","C","D","E","F","G","H",}				-- sector column labels
modVersion		= ""		-- keep this blank for now
campaignIsStarted	= 0		-- 0 or 1
loadSectorMap		= 1		-- got to galaxy map instead of an individual sector
currentSectorRow	= 1		-- 1 to 4
currentSectorCol	= 1		-- 1 to 4
sectorCode		= colLabels[currentSectorCol] .. currentSectorRow		-- for instance "A1" or "D3"
sectorName		= "Sector " .. sectorCode					-- for instance "Sector A1" or "Sector D3"
currentModVersion	= "0.15.2"
playerRUs		= 5000
currentGameTime		= 0		-- game time since start in seconds
legibleGameTime		= ""		-- formatted game time string
allowedToLeaveMap	= 0


-- Make sure there's one entry for each map sector/mission.
sectorsExplored =
{
	{0,0,0,0,},
	{0,0,0,0,},
	{0,0,0,0,},
	{0,0,0,0,},
}

objectivesClear =
{
	{0,0,0,0,},
	{0,0,0,0,},
	{0,0,0,0,},
	{0,0,0,0,},
}

questsStatus = {}

globalTimeQueue =
{
	-- 86400 seconds equal 24 hours, 21600 seconds equal 6 hours
	-- time, player, squad, task, formatted time string
	{0, 1, 1, "escape", ""},
	{0, 1, 2, "escape", ""},
	{0, 1, 3, "escape", ""},
	{86400, 2, nil, "ai_reinforce", ""},
}
