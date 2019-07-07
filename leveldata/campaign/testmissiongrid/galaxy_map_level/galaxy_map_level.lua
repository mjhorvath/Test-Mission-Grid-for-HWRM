function OnInit()
	print("Gametype: Starting galaxy map level!")
	Rule_AddInterval("Rule_Init", 0)
end

function Rule_Init()
	StartMission()
	Rule_Remove("Rule_Init")
end

Events = {}
