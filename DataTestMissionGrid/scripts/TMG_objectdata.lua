-- tells which ships count as squad leaders
-- these ships should all have shipholds
flagShips =
{
	"hgn_mothership",
	"hgn_battlecruiser",
	"hgn_carrier",
	"hgn_shipyard",
	"hgn_shipyard_elohim",
	"hgn_shipyard_spg",
	"vgr_mothership",
	"vgr_mothership_makaan",
	"vgr_battlecruiser",
	"vgr_carrier",
	"vgr_shipyard",
}

hyperMods =
{
	"hgn_ms_module_hyperspace",
	"hgn_c_module_hyperspace",
	"vgr_ms_module_hyperspace",
	"vgr_c_module_hyperspace",
}

objectData =
{
	ships =
	{
		hgn_mothership =
		{
			prettyname = "Hiigaran Mothership",
			subsystems =
			{
				"hgn_ms_production_fighter",
				"hgn_ms_production_corvette",
				"hgn_ms_production_corvettemover",
				"hgn_ms_production_frigate",
				"hgn_ms_production_capship",
				"hgn_ms_module_platformcontrol",
				"hgn_ms_module_research",
				"hgn_ms_module_researchadvanced",
				"hgn_ms_module_hyperspace",
				"hgn_ms_module_hyperspaceinhibitor",
				"hgn_ms_module_cloakgenerator",
				"hgn_ms_module_firecontrol",
				"hgn_ms_sensors_detecthyperspace",
				"hgn_ms_sensors_advancedarray",
				"hgn_ms_sensors_detectcloaked",
			},
			squadronsize = 1,
			candock = 0,
			hasshiphold = 1,
			canhyperspace = 1,
			canbuildhypermodule = 1,
			canmove = 1,
			hyperspeed = 40,
		},
		hgn_battlecruiser =
		{
			prettyname = "Hiigaran Battlecruiser",
			subsystems =
			{
				"hgn_c_module_hyperspace",
				"hgn_c_module_cloakgenerator",
				"hgn_c_module_hyperspaceinhibitor",
				"hgn_c_module_firecontrol",
			},
			squadronsize = 1,
			candock = 0,
			hasshiphold = 1,
			canhyperspace = 1,
			canbuildhypermodule = 1,
			canmove = 1,
			hyperspeed = 79,
		},
		hgn_carrier =
		{
			prettyname = "Hiigaran Carrier",
			subsystems =
			{
				"hgn_c_production_fighter",
				"hgn_c_production_corvette",
				"hgn_c_production_frigate",
				"hgn_c_module_platformcontrol",
				"hgn_c_module_research",
				"hgn_c_module_researchadvanced",
				"hgn_c_module_hyperspace",
				"hgn_c_module_hyperspaceinhibitor",
				"hgn_c_module_cloakgenerator",
				"hgn_c_module_firecontrol",
				"hgn_c_sensors_detecthyperspace",
				"hgn_c_sensors_advancedarray",
				"hgn_c_sensors_detectcloaked",
			},
			squadronsize = 1,
			candock = 0,
			hasshiphold = 1,
			canhyperspace = 1,
			canbuildhypermodule = 1,
			canmove = 1,
			hyperspeed = 81,
		},
		hgn_shipyard =
		{
			prettyname = "Hiigaran Shipyard",
			subsystems =
			{
				"hgn_ms_production_fighter",
				"hgn_ms_production_corvette",
				"hgn_ms_production_frigate",
				"hgn_ms_production_frigateadvanced",
				"hgn_sy_production_capship",
				"hgn_ms_module_research",
				"hgn_ms_module_hyperspace",
				"hgn_ms_module_platformcontrol",
				"hgn_ms_module_cloakgenerator",
				"hgn_ms_module_hyperspaceinhibitor",
				"hgn_ms_module_firecontrol",
				"hgn_ms_module_researchadvanced",
				"hgn_ms_sensors_detecthyperspace",
				"hgn_ms_sensors_advancedarray",
				"hgn_ms_sensors_detectcloaked",
			},
			squadronsize = 1,
			candock = 0,
			hasshiphold = 1,
			canhyperspace = 1,
			canbuildhypermodule = 1,
			canmove = 1,
			hyperspeed = 20,
		},
		hgn_shipyard_elohim =
		{
			prettyname = "Elohim (Hiigaran Shipyard)",
			subsystems =
			{
				"hgn_ms_production_fighter",
				"hgn_ms_production_corvette",
				"hgn_ms_production_frigate",
				"hgn_ms_production_frigateadvanced",
				"hgn_sy_production_capship",
				"hgn_ms_module_research",
				"hgn_ms_module_hyperspace",
				"hgn_ms_module_platformcontrol",
				"hgn_ms_module_cloakgenerator",
				"hgn_ms_module_hyperspaceinhibitor",
				"hgn_ms_module_firecontrol",
				"hgn_ms_module_researchadvanced",
				"hgn_ms_sensors_detecthyperspace",
				"hgn_ms_sensors_advancedarray",
				"hgn_ms_sensors_detectcloaked",
			},
			squadronsize = 1,
			candock = 0,
			hasshiphold = 1,
			canhyperspace = 1,
			canbuildhypermodule = 1,
			canmove = 1,
			hyperspeed = 20,
		},
		hgn_shipyard_spg =
		{
			prettyname = "Hiigaran Shipyard",
			subsystems =
			{
				"hgn_ms_production_fighter",
				"hgn_ms_production_corvette",
				"hgn_ms_production_frigate",
				"hgn_ms_production_frigateadvanced",
				"hgn_sy_production_capship",
				"hgn_ms_module_research",
				"hgn_ms_module_hyperspace",
				"hgn_ms_module_platformcontrol",
				"hgn_ms_module_cloakgenerator",
				"hgn_ms_module_hyperspaceinhibitor",
				"hgn_ms_module_firecontrol",
				"hgn_ms_module_researchadvanced",
				"hgn_ms_sensors_detecthyperspace",
				"hgn_ms_sensors_advancedarray",
				"hgn_ms_sensors_detectcloaked",
			},
			squadronsize = 1,
			candock = 0,
			hasshiphold = 1,
			canhyperspace = 1,
			canbuildhypermodule = 1,
			canmove = 1,
			hyperspeed = 20,
		},
		hgn_destroyer = {prettyname = "Hiigaran Destroyer", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 1, canbuildhypermodule = 0, canmove = 1, hyperspeed = 120,},
		hgn_assaultfrigate = {prettyname = "Hiigaran Flak Frigate", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 1, canbuildhypermodule = 0, canmove = 1, hyperspeed = 178,},
		hgn_defensefieldfrigate = {prettyname = "Hiigaran Defense Field Frigate", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 1, canbuildhypermodule = 0, canmove = 1, hyperspeed = 177,},
		hgn_ioncannonfrigate = {prettyname = "Hiigaran Ion Frigate", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 1, canbuildhypermodule = 0, canmove = 1, hyperspeed = 165,},
		hgn_marinefrigate = {prettyname = "Hiigaran Marine Frigate", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 1, canbuildhypermodule = 0, canmove = 1, hyperspeed = 230,},
		hgn_marinefrigate_soban = {prettyname = "Hiigaran Marine Frigate", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 1, canbuildhypermodule = 0, canmove = 1, hyperspeed = 230,},
		hgn_torpedofrigate = {prettyname = "Hiigaran Torpedo Frigate", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 1, canbuildhypermodule = 0, canmove = 1, hyperspeed = 176,},
		hgn_assaultcorvette = {prettyname = "Hiigaran Gunship", subsystems = {}, squadronsize = 3, candock = 1, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 1, hyperspeed = 0,},
		hgn_pulsarcorvette = {prettyname = "Hiigaran Pulsar Gunship", subsystems = {}, squadronsize = 3, candock = 1, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 1, hyperspeed = 0,},
		hgn_minelayercorvette = {prettyname = "Hiigaran Minelayer", subsystems = {}, squadronsize = 1, candock = 1, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 1, hyperspeed = 0,},
		hgn_scout = {prettyname = "Hiigaran Scout", subsystems = {}, squadronsize = 3, candock = 1, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 1, hyperspeed = 0,},
		hgn_attackbomber = {prettyname = "Hiigaran Bomber", subsystems = {}, squadronsize = 5, candock = 1, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 1, hyperspeed = 0,},
		hgn_interceptor = {prettyname = "Hiigaran Interceptor", subsystems = {}, squadronsize = 5, candock = 1, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 1, hyperspeed = 0,},
		hgn_gunturret = {prettyname = "Hiigaran Gun Platform", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 0, hyperspeed = 0,},
		hgn_ionturret = {prettyname = "Hiigaran Ion Beam Platform", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 0, hyperspeed = 0,},
		hgn_resourcecollector = {prettyname = "Hiigaran Resource Collector", subsystems = {}, squadronsize = 1, candock = 1, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 1, hyperspeed = 0,},
		hgn_resourcecontroller = {prettyname = "Hiigaran Mobile Refinery", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 1, canbuildhypermodule = 0, canmove = 1, hyperspeed = 225,},
		hgn_proximitysensor = {prettyname = "Hiigaran Proximity Sensor", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 0, hyperspeed = 0,},
		hgn_ecmprobe = {prettyname = "Hiigaran Sensors Distortion Probe", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 0, hyperspeed = 0,},
		hgn_probe = {prettyname = "Hiigaran Probe", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 0, hyperspeed = 0,},
		vgr_mothership =
		{
			prettyname = "Vaygr Mothership",
			subsystems =
			{
				"vgr_ms_production_fighter",
				"vgr_ms_production_corvette",
				"vgr_ms_production_frigate",
				"vgr_ms_module_platformcontrol",
				"vgr_ms_production_capship",
				"vgr_ms_module_research",
				"vgr_ms_module_cloakgenerator",
				"vgr_ms_module_hyperspaceinhibitor",
				"vgr_ms_module_firecontrol",
				"vgr_ms_module_hyperspace",
				"vgr_ms_sensors_advancedarray",
				"vgr_ms_sensors_detecthyperspace",
			},
			squadronsize = 1,
			candock = 0,
			hasshiphold = 1,
			canhyperspace = 1,
			canbuildhypermodule = 1,
			canmove = 1,
			hyperspeed = 40,
		},
		vgr_mothership_makaan =
		{
			prettyname = "Makaan (Vaygr Mothership)",
			subsystems =
			{
				"vgr_ms_production_fighter",
				"vgr_ms_production_corvette",
				"vgr_ms_production_frigate",
				"vgr_ms_module_platformcontrol",
				"vgr_ms_production_capship",
				"vgr_ms_module_research",
				"vgr_ms_module_cloakgenerator",
				"vgr_ms_module_hyperspaceinhibitor",
				"vgr_ms_module_firecontrol",
				"vgr_ms_module_hyperspace",
				"vgr_ms_sensors_advancedarray",
				"vgr_ms_sensors_detecthyperspace",
			},
			squadronsize = 1,
			candock = 0,
			hasshiphold = 1,
			canhyperspace = 1,
			canbuildhypermodule = 1,
			canmove = 1,
			hyperspeed = 40,
		},
		vgr_battlecruiser =
		{
			prettyname = "Vaygr Battlecruiser",
			subsystems =
			{
				"vgr_c_module_hyperspace",
				"vgr_c_module_cloakgenerator",
				"vgr_c_module_hyperspaceinhibitor",
				"vgr_c_module_firecontrol",
			},
			squadronsize = 1,
			candock = 0,
			hasshiphold = 1,
			canhyperspace = 1,
			canbuildhypermodule = 1,
			canmove = 1,
			hyperspeed = 79,
		},
		vgr_carrier =
		{
			prettyname = "Vaygr Carrier",
			subsystems =
			{
				"vgr_c_production_fighter",
				"vgr_c_production_corvette",
				"vgr_c_production_frigate",
				"vgr_c_module_platformcontrol",
				"vgr_c_module_research",
				"vgr_c_module_cloakgenerator",
				"vgr_c_module_hyperspaceinhibitor",
				"vgr_c_module_firecontrol",
				"vgr_c_module_hyperspace",
				"vgr_c_sensors_advancedarray",
				"vgr_c_sensors_detecthyperspace",
			},
			squadronsize = 1,
			candock = 0,
			hasshiphold = 1,
			canhyperspace = 1,
			canbuildhypermodule = 1,
			canmove = 1,
			hyperspeed = 81,
		},
		vgr_shipyard =
		{
			prettyname = "Vaygr Shipyard",
			subsystems =
			{
				"vgr_ms_production_fighter",
				"vgr_ms_production_corvette",
				"vgr_ms_production_frigate",
				"vgr_sy_production_capship",
				"vgr_ms_module_research",
				"vgr_ms_module_cloakgenerator",
				"vgr_ms_module_platformcontrol",
				"vgr_ms_module_firecontrol",
				"vgr_ms_module_hyperspaceinhibitor",
				"vgr_ms_module_hyperspace",
				"vgr_ms_sensors_advancedarray",
				"vgr_ms_sensors_detecthyperspace",
				"vgr_ms_sensors_detectcloaked",
			},
			squadronsize = 1,
			candock = 0,
			hasshiphold = 1,
			canhyperspace = 1,
			canbuildhypermodule = 1,
			canmove = 1,
			hyperspeed = 20,
		},
		vgr_destroyer = {prettyname = "Vaygr Destroyer", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 1, canbuildhypermodule = 0, canmove = 1, hyperspeed = 120,},
		vgr_assaultfrigate = {prettyname = "Vaygr Assault Frigate", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 1, canbuildhypermodule = 0, canmove = 1, hyperspeed = 176,},
		vgr_heavymissilefrigate = {prettyname = "Vaygr Heavy Missile Frigate", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 1, canbuildhypermodule = 0, canmove = 1, hyperspeed = 165,},
		vgr_infiltratorfrigate = {prettyname = "Vaygr Infiltrator Frigate", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 1, canbuildhypermodule = 0, canmove = 1, hyperspeed = 230,},
		vgr_lasercorvette = {prettyname = "Vaygr Laser Corvette", subsystems = {}, squadronsize = 4, candock = 1, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 1, hyperspeed = 0,},
		vgr_missilecorvette = {prettyname = "Vaygr Missile Corvette", subsystems = {}, squadronsize = 4, candock = 1, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 1, hyperspeed = 0,},
		vgr_commandcorvette = {prettyname = "Vaygr Command Corvette", subsystems = {}, squadronsize = 1, candock = 1, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 1, hyperspeed = 0,},
		vgr_minelayercorvette = {prettyname = "Vaygr Minelayer", subsystems = {}, squadronsize = 1, candock = 1, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 1, hyperspeed = 0,},
		vgr_scout = {prettyname = "Vaygr Survey Scout", subsystems = {}, squadronsize = 3, candock = 1, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 1, hyperspeed = 0,},
		vgr_bomber = {prettyname = "Vaygr Bomber", subsystems = {}, squadronsize = 6, candock = 1, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 1, hyperspeed = 0,},
		vgr_interceptor = {prettyname = "Vaygr Assault Craft", subsystems = {}, squadronsize = 7, candock = 1, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 1, hyperspeed = 0,},
		vgr_lancefighter = {prettyname = "Vaygr Lance Fighter", subsystems = {}, squadronsize = 5, candock = 1, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 1, hyperspeed = 0,},
		vgr_weaponplatform_gun = {prettyname = "Vaygr Gun Platform", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 0, hyperspeed = 0,},
		vgr_weaponplatform_missile = {prettyname = "Vaygr Heavy Missile Platform", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 0, hyperspeed = 0,},
		vgr_hyperspace_platform = {prettyname = "Vaygr Hyperspace Gate", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 0, hyperspeed = 0,},
		vgr_resourcecollector = {prettyname = "Vaygr Resource Collector", subsystems = {}, squadronsize = 1, candock = 1, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 1, hyperspeed = 0,},
		vgr_resourcecontroller = {prettyname = "Vaygr Mobile Refinery", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 1, canbuildhypermodule = 0, canmove = 1, hyperspeed = 225,},
		vgr_probe_prox = {prettyname = "Vaygr Proximity Sensor", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 0, hyperspeed = 0,},
		vgr_probe_ecm = {prettyname = "Vaygr Sensors Distortion Probe", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 0, hyperspeed = 0,},
		vgr_probe = {prettyname = "Vaygr Probe", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 0, hyperspeed = 0,},
		kpr_sajuuk = {prettyname = "Keeper Sajuuk", subsystems = {}, squadronsize = 1, candock = 0, hasshiphold = 0, canhyperspace = 0, canbuildhypermodule = 0, canmove = 1, hyperspeed = 70,},
	},
}

enemyReinforcements =
{
	vaygr_small_carrier_group =
	{
		{
			type = "vgr_carrier",
			name = "",
			subsystems =
			{
			},
			position = {0,0,0},
			rotation = {0,0,0},
			playerindex = 1,
			shiphold =
			{
			},
			sobgroups = {},
		},
		{
			type = "vgr_assaultfrigate",
			name = "",
			subsystems = {},
			position = {0,0,0},
			rotation = {0,0,0},
			playerindex = 1,
			shiphold = {},
			sobgroups = {},
		},
		{
			type = "vgr_assaultfrigate",
			name = "",
			subsystems = {},
			position = {0,0,0},
			rotation = {0,0,0},
			playerindex = 1,
			shiphold = {},
			sobgroups = {},
		},
		{
			type = "vgr_heavymissilefrigate",
			name = "",
			subsystems = {},
			position = {0,0,0},
			rotation = {0,0,0},
			playerindex = 1,
			shiphold = {},
			sobgroups = {},
		},
		{
			type = "vgr_heavymissilefrigate",
			name = "",
			subsystems = {},
			position = {0,0,0},
			rotation = {0,0,0},
			playerindex = 1,
			shiphold = {},
			sobgroups = {},
		},
	},
}