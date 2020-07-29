--------------------------------------------------------------------------------
-- Dialogue functions
-- currently are loaded only in Sector D3
--

function Rule_CheckIfActorHasBeenSelected()
	local NewLevelActor = "none"
	for i = 1, getn(LevelActors) do
		local this_actor = LevelActors[i]
		if (SobGroup_Selected(this_actor) == 1) then
			NewLevelActor = this_actor
			break
		end
	end
	local sobg_count = Player_FillProximitySobGroup(sobg_dial, 0, NewLevelActor, 10000)
	if ((NewLevelActor == "none") or (sobg_count == 0)) then
		if (UI_IsNamedElementVisible("NewTaskbar", "btnDialogue") == 1) then
			UI_SetElementVisible("NewTaskbar", "btnDialogue", 0)
		end
		CloseDialogueWindow()
	elseif (sobg_count > 0) then
		if (UI_IsNamedElementVisible("NewTaskbar", "btnDialogue") == 0) then
			UI_SetElementVisible("NewTaskbar", "btnDialogue", 1)
		end
	end
	if (NewLevelActor ~= OldLevelActor) then
		UpdateDialogueActor(NewLevelActor)
		OldLevelActor = NewLevelActor
	end
end

function GiveResponse(response)
	local this_dialogue = DialogueScripts[dialogueStatus.node]
	local this_option = this_dialogue.options[response]
	this_option.buttonaction()

	-- todo: I may deprecate this
	local log_count = getn(dialogueStatus.history)
	dialogueStatus.history[log_count + 1] = {}
	dialogueStatus.history[log_count + 1][1] = this_dialogue.actorname
	dialogueStatus.history[log_count + 1][2] = this_dialogue.actortext
	dialogueStatus.history[log_count + 2] = {}
	dialogueStatus.history[log_count + 2][1] = "Karan S'jet"		-- todo: this should change depending on the captain!!
	dialogueStatus.history[log_count + 2][2] = this_option.buttontext

	WriteDialogueStatusFile()
	UI_ReloadScreen("DialogueScreen")
end

function UpdateDialogueActor(sActor)
	dialogueStatus.actor = sActor
	ActorScripts[sActor]()
	UI_SetButtonTextHotkey("NewTaskbar", "btnDialogue", "Speak with " .. ActorNames[sActor], 666)

	WriteDialogueStatusFile()
	UI_ReloadScreen("DialogueScreen")
end

function CloseDialogueWindow()
	if (UI_IsScreenActive("DialogueScreen") == 1) then
		if (UI_IsScreenActive("SectorMapScreenMinor") == 0) then
			Universe_AllowClicks(1)
			Universe_Pause(0, 0)
		end
		UI_HideScreen("DialogueScreen")
	end
end

function WriteDialogueStatusFile()
	local WriteFile = "$TMG_tempdialoguestatus.lua"
	writeto(WriteFile)
	WriteDialogueStatus()
	writeto()
end
