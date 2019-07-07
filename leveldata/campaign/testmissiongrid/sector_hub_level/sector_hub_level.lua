-- TEMP FILES SHOULD NOT BE LOADED FROM HERE
print("Gametype: Parsing gametype...")
--dofilepath("data:scripts\\HW2_ThoughtDump_b.lua")
dofilepath("data:scripts\\utilfunc.lua")
dofilepath("data:scripts\\SCAR\\SCAR_Util.lua")
dofilepath("data:scripts\\TMG_campaigndata.lua")
dofilepath("data:scripts\\TMG_initialstate.lua")
dofilepath("data:scripts\\TMG_initialfleet.lua")
dofilepath("player:TestMissionGrid\\TMG_savegame.lua")
dofilepath("data:scripts\\TMG_objectdata.lua")
dofilepath("data:scripts\\TMG_dialoguedata.lua")
dofilepath("data:scripts\\TMG_dialoguescripts.lua")
dofilepath("data:scripts\\TMG_writetables.lua")
dofilepath("data:scripts\\TMG_interfacescripts.lua")
dofilepath("data:scripts\\TMG_squadmenu.lua")
dofilepath("data:scripts\\TMG_sectormap.lua")
dofilepath("data:scripts\\TMG_globaltimequeue.lua")
dofilepath("data:scripts\\TMG_gametypeshared.lua")
dofilepath("data:scripts\\TMG_ruleteststuff.lua")

if (loadSectorMap == 1) then
	dofilepath("data:scripts\\TMG_gametypemajor.lua")
	dofilepath("data:leveldata\\campaign\\testmissiongrid\\galaxy_map_level\\galaxy_map_level.lua")
else
	dofilepath("data:scripts\\TMG_gametypeminor.lua")
	dofilepath("data:leveldata\\campaign\\testmissiongrid\\sector_" .. sectorCode .. "\\sector_" .. sectorCode .. "_src.lua")
end

print("Gametype: Done parsing gametype!")
