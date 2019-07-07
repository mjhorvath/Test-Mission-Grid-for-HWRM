-- Sector C1: Gather Resources
obj_prim_newobj_id = 0
oldPlayerRUs = 0

function OnInit()
	Rule_Add( "Rule_Init" )
end

function Rule_Init()
	StartMission()
	if (questsStatus.c1_RUsHaveBeenGathered ~= 1) then
		oldPlayerRUs = Player_GetRU(0)
		Event_Start( "IntelEvent_Intro" )
		Rule_AddInterval( "Rule_PlayerWins", 2 )
	else
		objectivesClear[currentSectorRow][currentSectorCol] = 1
		Event_Start( "IntelEvent_AlreadyDone" )
		Rule_Add( "Rule_EnableExits" )
	end
	Rule_Remove( "Rule_Init" )
end

function Rule_PlayerWins()
	if ((Player_GetRU(0) - oldPlayerRUs) >= 200) then
		questsStatus.c1_RUsHaveBeenGathered = 1
		Objective_SetState(obj_prim_newobj_id, OS_Complete)
		objectivesClear[currentSectorRow][currentSectorCol] = 1
		Event_Start( "IntelEvent_Finale" )
		Rule_Remove("Rule_PlayerWins")
	end 
end

Events = {}
Events.IntelEvent_Intro = 
{ 
	{ 
		{
			"Sound_EnableAllSpeech( 1 )",
			""
		}, 
		{
			"Sound_EnterIntelEvent()",
			""
		}, 
		{
			"Universe_EnableSkip(1)",
			""
		}, 
		HW2_LocationCardEvent( mission_text_card, 5 ), 
	}, 
	{ 
		HW2_Letterbox( 1 ), 
		HW2_Wait( 2 ), 
	}, 
	{
		{
			"obj_prim_newobj_id = Objective_Add( mission_text_short, OT_Primary )",
			""
		}, 
		{
			"Objective_AddDescription( obj_prim_newobj_id, mission_text_long)",
			""
		}, 
		HW2_SubTitleEvent( Actor_FleetIntel, mission_text_long, 4 ),
	},
	{
		HW2_Wait( 1 ), 
	},
	{
		HW2_Letterbox( 0 ), 
		HW2_Wait( 2 ), 
		{
			"Universe_EnableSkip(0)",
			""
		},
		{
			"Sound_ExitIntelEvent()",
			""
		},
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
