-- Sector A4: Avoid the Enemy Ship
obj_prim_newobj_id = 0
enemy_ping = 0

function OnInit()
	Rule_Add("Rule_Init")
end

function Rule_Init()
	StartMission()
	Event_Start( "IntelEvent_AvoidShip" )
	enemy_ping = Ping_AddSobGroup("Enemy Ship", "anomaly", "EnyGroup")
	objectivesClear[currentSectorRow][currentSectorCol] = 1
	Rule_Remove( "Rule_Init" )
end

Events = {}
Events.IntelEvent_AvoidShip = 
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
		{"Objective_AddDescription( obj_prim_newobj_id, mission_text_long)",""}, 
		HW2_SubTitleEvent( Actor_FleetCommand, mission_text_long, 4 ), 
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
