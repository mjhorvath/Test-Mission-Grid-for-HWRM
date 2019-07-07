-- Sector D3: Meet New People
obj_prim_newobj_id = 0
ping_soban = 0
ping_elohim = 0

function OnInit()
	Rule_Add("Rule_Init")
end

function Rule_Init()
	StartMission()
	if ((questsStatus.d3_HasTalkedToSoban ~= 1) and (questsStatus.d3_HasTalkedToElohim ~= 1) and (questsStatus.d3_HasElohimCongratulated ~= 1) and (questsStatus.d3_HasSaidGoodbyeToElohim ~= 1)) then
		questsStatus.d3_HasTalkedToSoban = 0
		questsStatus.d3_HasTalkedToElohim = 0
		questsStatus.d3_ChosenValue = nil
		questsStatus.d3_HasElohimCongratulated = 0
		questsStatus.d3_HasSaidGoodbyeToElohim = 0
		ping_soban = Ping_AddSobGroup("Captain Soban", "anomaly", "SobanGroup")
		Event_Start("IntelEvent_Intro")
--		Rule_AddInterval("Rule_PlayerWins", 2)		-- this is triggered in DialogueScripts.b2 instead of here
	else
		objectivesClear[currentSectorRow][currentSectorCol] = 1
		Event_Start("IntelEvent_AlreadyDone")
	end
	SetAlliance(0, 2)
	SetAlliance(2, 0)
	CPU_Enable(2, 0)
	Rule_Add("Rule_CheckIfActorHasBeenSelected")
	Rule_Remove("Rule_Init")
end

function Rule_PlayerWins()
	Objective_SetState(obj_prim_newobj_id, OS_Complete)
	objectivesClear[currentSectorRow][currentSectorCol] = 1
	Event_Start("IntelEvent_Finale")
	Rule_Remove("Rule_PlayerWins")
end


-------------------------------------------------------------------------------
-- 

Events = {}
Events.IntelEvent_Intro = 
{ 
	{ 
		{
			[[Sound_EnableAllSpeech( 1 )]],
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
		HW2_LocationCardEvent( mission_text_card, 5 ), 
	}, 
	{ 
		HW2_Letterbox( 1 ), 
		HW2_Wait( 2 ), 
	}, 
	{
		{
			[[obj_prim_newobj_id = Objective_Add( mission_text_short, OT_Primary )]],
			[[]]
		}, 
		{
			[[Objective_AddDescription( obj_prim_newobj_id, mission_text_long)]],
			[[]]
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
			[[Universe_EnableSkip(0)]],
			[[]]
		},
		{
			[[Sound_ExitIntelEvent()]],
			[[]]
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
