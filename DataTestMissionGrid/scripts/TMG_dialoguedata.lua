--print("GUI: Parsing dialogue scripts....")

-- initialize the table
dialogueStatus =
{
	node = "none",
	actor = "none",
	history = {},
}

ActorNames =
{
	none = "Unknown Actor",
	SobanGroup = "Captain Soban",
	ElohimGroup = "Shipyard Nabaal",
}

DialogueScripts =
{
	none =
	{
		-- "onloadaction" doesn't do anything yet, use "ActorsScripts" instead for now
		onloadaction = function ()
		end,
		actortext = [[You should not be reading this.]],
		actorname = "Ship",
		flavortext = [[You must select a named ship, such as Captain Soban or Shipyard Nabaal, before initiating dialogue.]],
		-- there can be any number of dialogue options, with each having a different effect
		options =
		{
			{
				buttontext = [["Sorry!"]],
				buttonaction = function ()
					CloseDialogueWindow()
				end,
			},
		},
	},
	a1 =
	{
		onloadaction = function ()
		end,
		actortext = [["Talk to Shipyard Nabaal."]],
		actorname = "Captain Soban",
		flavortext = [[You see a shipyard and marine frigate in the middle of empty space. You have no idea what they are doing here. You decide to approach them and see what they are up to.]],
		options =
		{
			{
				buttontext = [["Will do."]],
				buttonaction = function ()
					if (questsStatus.d3_HasTalkedToSoban ~= 1) then
						questsStatus.d3_HasTalkedToSoban = 1
						Ping_Remove(ping_soban)
						ping_elohim = Ping_AddSobGroup("Shipyard Elohim", "anomaly", "ElohimGroup")
					end
					CloseDialogueWindow()
				end,
			},
		},
	},
	a2 =
	{
		onloadaction = function ()
		end,
		actortext = [["Goodbye, as well."]],
		actorname = "Captain Soban",
		flavortext = [[You see a shipyard and marine frigate in the middle of empty space. You have no idea what they are doing here. You decide to approach them and see what they are up to.]],
		options =
		{
			{
				buttontext = [["See you later!"]],
				buttonaction = function ()
					CloseDialogueWindow()
				end,
			},
		},
	},
	b1 =
	{
		onloadaction = function ()
		end,
		actortext = [["I am Shipyard Nabaal. My friend Captain Soban is unfortunately not very talkative."]],
		actorname = "Shipyard Nabaal",
		flavortext = [[You see a shipyard and marine frigate in the middle of empty space. You have no idea what they are doing here. You decide to approach them and see what they are up to.]],
		options =
		{
			{
				buttontext = [["I noticed."]],
				buttonaction = function ()
					if (questsStatus.d3_HasTalkedToElohim ~= 1) then
						questsStatus.d3_HasTalkedToElohim = 1
						UpdateDialogueActor("ElohimGroup")
					end
					-- don't close window!!
				end,
			},
		},
	},
	b2 =
	{
		onloadaction = function ()
		end,
		actortext = [["Please make a choice between A and B."]],
		actorname = "Shipyard Nabaal",
		flavortext = [[You see a shipyard and marine frigate in the middle of empty space. You have no idea what they are doing here. You decide to approach them and see what they are up to.]],
		options =
		{
			{
				buttontext = [["I choose A."]],
				buttonaction = function ()
					if (questsStatus.d3_HasChosenBetweenAB ~= 1) then
						questsStatus.d3_HasChosenBetweenAB = 1
						questsStatus.d3_ChosenValue = "A"
						UpdateDialogueActor("ElohimGroup")
					end
				end,
			},
			{
				buttontext = [["I choose B."]],
				buttonaction = function ()
					if (questsStatus.d3_HasChosenBetweenAB ~= 1) then
						questsStatus.d3_HasChosenBetweenAB = 1
						questsStatus.d3_ChosenValue = "B"
						UpdateDialogueActor("ElohimGroup")
					end
				end,
			},
		},
	},
	b3 =
	{
		onloadaction = function ()
		end,
		actortext = [["A is a superb choice!"]],
		actorname = "Shipyard Nabaal",
		flavortext = [[You see a shipyard and marine frigate in the middle of empty space. You have no idea what they are doing here. You decide to approach them and see what they are up to.]],
		options =
		{
			{
				buttontext = [["Thanks!"]],
				buttonaction = function ()
					if (questsStatus.d3_HasElohimCongratulated ~= 1) then
						questsStatus.d3_HasElohimCongratulated = 1
						UpdateDialogueActor("ElohimGroup")
					end
				end,
			},
		},
	},
	b4 =
	{
		onloadaction = function ()
		end,
		actortext = [["B is a superb choice!"]],
		actorname = "Shipyard Nabaal",
		flavortext = [[You see a shipyard and marine frigate in the middle of empty space. You have no idea what they are doing here. You decide to approach them and see what they are up to.]],
		options =
		{
			{
				buttontext = [["Thanks!"]],
				buttonaction = function ()
					if (questsStatus.d3_HasElohimCongratulated ~= 1) then
						questsStatus.d3_HasElohimCongratulated = 1
						UpdateDialogueActor("ElohimGroup")
					end
				end,
			},
		},
	},
	b5 =
	{
		onloadaction = function ()
		end,
		actortext = [["But now that we have spoken, I must say goodbye."]],
		actorname = "Shipyard Nabaal",
		flavortext = [[You see a shipyard and marine frigate in the middle of empty space. You have no idea what they are doing here. You decide to approach them and see what they are up to.]],
		options =
		{
			{
				buttontext = [["You too!"]],
				buttonaction = function ()
					if (questsStatus.d3_HasSaidGoodbyeToElohim ~= 1) then
						questsStatus.d3_HasSaidGoodbyeToElohim = 1
						Ping_Remove(ping_elohim)
						Rule_AddInterval("Rule_PlayerWins", 2)
					end
					CloseDialogueWindow()
				end,
			},
		},
	},
}

ActorScripts =
{
	none = function ()
		dialogueStatus.node = "none"
	end,
	SobanGroup = function ()
		if (questsStatus.d3_HasSaidGoodbyeToElohim == 1) then
			dialogueStatus.node = "a2"
		else
			dialogueStatus.node = "a1"
		end
	end,
	ElohimGroup = function ()
		if (questsStatus.d3_HasTalkedToElohim == 1) then
			if (questsStatus.d3_HasChosenBetweenAB == 1) then
				if (questsStatus.d3_HasElohimCongratulated == 1) then
					dialogueStatus.node = "b5"
				else
					if (questsStatus.d3_ChosenValue == "A") then
						dialogueStatus.node = "b3"
					else
						dialogueStatus.node = "b4"
					end
				end
			else
				dialogueStatus.node = "b2"
			end
		else
			dialogueStatus.node = "b1"
		end
	end,
}

--print("GUI: Done parsing dialogue scripts!")
