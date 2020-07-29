-- Sector A1: Build a Scout

-- event variables can be created outside of everything, giving them global scope
obj_prim_newobj_id = 0


--------------------------------------------------------------------------------
-- game rules
--

function OnInit()

	-- Add the Rule_Init
	Rule_Add( "Rule_Init" )

	-- OnInit isn't a rule so there is no need to remove it
end

function Rule_Init()

	-- if the player just started this campaign spawn a mothership, else load persistent data
	StartMission()

	-- if the sector has not been cleared already, trigger the objectives and cutscenes, else skip them
	if (questsStatus.a1_ScoutHasBeenBuilt ~= 1) then

		-- Do one of those fancy Intel-tell-the-player-whats-going-on
		Event_Start( "IntelEvent_Intro" )

		-- Setup the Win and Lose conditions
		Rule_AddInterval( "Rule_PlayerWins", 2 )
	else

		-- Signal all objectives are completed
		objectivesClear[currentSectorRow][currentSectorCol] = 1

		-- Sector has already been cleared, time to move on
		Event_Start( "IntelEvent_AlreadyDone" )
	end

	-- We only want this rule to play once - so remove it now
	Rule_Remove( "Rule_Init" )
end

function Rule_PlayerWins()

	-- Check to see if the player has a squadron of Scouts
	if ( Player_GetNumberOfSquadronsOfTypeAwakeOrSleeping( 0, "hgn_scout" ) > 0 ) then

		-- Record quest completion status
		questsStatus.a1_ScoutHasBeenBuilt = 1

		-- Update the Objective
		Objective_SetState( obj_prim_newobj_id, OS_Complete )

		-- Signal all objectives are completed
		objectivesClear[currentSectorRow][currentSectorCol] = 1

		-- Play final event
		Event_Start( "IntelEvent_Finale" )

		-- Remove the rule
		Rule_Remove( "Rule_PlayerWins" )
	end
end


--------------------------------------------------------------------------------
-- events tables
--

-- Most important line
Events = {}

Events.IntelEvent_Intro = 
{ 
	{ 
		{"Sound_EnableAllSpeech( 1 )",""}, 
		{"Sound_EnterIntelEvent()",""}, 
		{"Universe_EnableSkip(1)",""}, 
		HW2_LocationCardEvent( mission_text_card, 5 ),
	}, 
	{ 
		HW2_Wait( 2 ), 
		HW2_Letterbox( 1 ), 
		HW2_Wait( 2 ), 
	}, 
	{ 
		HW2_SubTitleEvent( Actor_FleetCommand, "Welcome to the Postmortem campaign. This is " .. sectorName .. ".", 5 ), 
	}, 
	{
		HW2_Wait( 1 ),
	}, 
	{
		{"obj_prim_newobj_id = Objective_Add( mission_text_short, OT_Primary )",""},
		{"Objective_AddDescription( obj_prim_newobj_id, mission_text_long)",""},
		HW2_SubTitleEvent( Actor_FleetIntel, mission_text_long, 4 ),
	},
	{
		HW2_Wait( 1 ), 
	},
	{
		HW2_Letterbox( 0 ), 
		HW2_Wait( 2 ), 
		{"Universe_EnableSkip(0)",""},
		{"Sound_ExitIntelEvent()",""},
	},
}
Events.IntelEvent_Finale = 
{
	{ 
		{"Sound_EnterIntelEvent()",""}, 
		{"Universe_EnableSkip(1)",""}, 
	}, 
	{ 
		HW2_Wait( 2 ), 
		HW2_Letterbox( 1 ), 
		HW2_Wait( 2 ), 
	}, 
	{ 
		HW2_SubTitleEvent( Actor_FleetCommand, mission_text_success, 5 ), 
	},
	{
		HW2_Wait( 1 ), 
	},
	{
		HW2_Letterbox( 0 ), 
		HW2_Wait( 2 ), 
		{"Universe_EnableSkip(0)",""},
		{"Sound_ExitIntelEvent()",""},
	},
}
Events.IntelEvent_AlreadyDone = 
{
	{ 
		{"Sound_EnterIntelEvent()",""}, 
		{"Universe_EnableSkip(1)",""}, 
	}, 
	{ 
		HW2_Wait( 2 ), 
		HW2_Letterbox( 1 ), 
		HW2_Wait( 2 ), 
	},
	{ 
		{"obj_prim_newobj_id = Objective_Add( mission_text_short, OT_Primary )",""},
		{"Objective_AddDescription( obj_prim_newobj_id, mission_text_clear)",""},
		{"Objective_SetState( obj_prim_newobj_id, OS_Complete )",""},
		HW2_SubTitleEvent( Actor_FleetCommand, mission_text_clear, 5 ), 
	},
	{
		HW2_Wait( 1 ), 
	},
	{
		HW2_Letterbox( 0 ), 
		HW2_Wait( 2 ), 
		{"Universe_EnableSkip(0)",""},
		{"Sound_ExitIntelEvent()",""},
	},
}
