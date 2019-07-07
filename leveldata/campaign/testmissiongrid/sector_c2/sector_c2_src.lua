-- Sector C2: Defend the Allied Ship
obj_prim_newobj_id = 0
pingid = 0

function OnInit()
	Rule_Add("Rule_Init")
end

function Rule_Init()
	StartMission()
	if (questsStatus.c2_HasDefendedShip ~= 1) then
		Event_Start( "IntelEvent_Intro" )
		pingid = Ping_AddSobGroup("Friendly Ship", "anomaly", "CRGroup")
		Rule_AddInterval( "Rule_PlayerWins", 2 )
		Rule_AddInterval( "Enemy_Attack", 10 )
	else
		objectivesClear[currentSectorRow][currentSectorCol] = 1
		Event_Start( "IntelEvent_AlreadyDone" )
	end
	Rule_Remove( "Rule_Init" )
end

function Enemy_Attack()
	SobGroup_Attack(1, "EnyGroup", "CRGroup")
	Rule_Remove( "Enemy_Attack" )
end

function Rule_PlayerWins()
	if (SobGroup_Empty("CRGroup") == 1) then
		Ping_Remove(pingid)
		questsStatus.c2_HasDefendedShip = 1
		Objective_SetState( obj_prim_newobj_id, OS_Failed )	
		objectivesClear[currentSectorRow][currentSectorCol] = 1	
		Event_Start( "IntelEvent_Failure" )
		Rule_Remove( "Rule_PlayerWins" )
	elseif (SobGroup_Empty("EnyGroup") == 1) then
		Ping_Remove(pingid)
		questsStatus.c2_HasDefendedShip = 1
		Objective_SetState( obj_prim_newobj_id, OS_Complete )
		objectivesClear[currentSectorRow][currentSectorCol] = 1
		Event_Start( "IntelEvent_Finale" )
		Rule_Remove( "Rule_PlayerWins" )
	end
end

Events = {}
Events.IntelEvent_Intro = 
{
	{
		{
			[[Sound_EnableAllSpeech(0)]],
			[[]]
		},
		{
			[[Sound_EnterIntelEvent()]],
			[[]]
		},
		{
			[[Universe_EnableSkip(1)]],
			[[]]
		},
		HW2_LocationCardEvent(mission_text_card, 5),
	},
	{
		HW2_Letterbox(1),
		HW2_Wait(2),
	},
	{
		{
			[[obj_prim_newobj_id = Objective_Add(mission_text_short, OT_Primary)]],
			[[]]
		},
		{
			[[Objective_AddDescription(obj_prim_newobj_id, mission_text_long)]],
			[[]]
		},
		HW2_SubTitleEvent(Actor_FleetIntel, mission_text_long, 4),
	},
	{
		HW2_Wait(2),
	},
	{
		HW2_Letterbox(0),
		HW2_Wait(2),
		{
			[[Universe_EnableSkip(0)]],
			[[]]
		},
		{
			[[Sound_ExitIntelEvent()]],
			[[]]
		},
		{
			[[Sound_EnableAllSpeech(1)]],
			[[]]
		},
	},
}
Events.IntelEvent_Failure =
{
	{
		HW2_LocationCardEvent("MISSION FAILED", 4),
	},
	{
		HW2_Wait(2),
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
