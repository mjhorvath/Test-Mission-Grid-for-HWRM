--print("GUI: Parsing dialogue screen...")
dofilepath("data:ui\\newui\\Styles\\HWRM_Style\\HWRMDefines.lua")
dofilepath("data:scripts\\utilfunc.lua")
dofilepath("data:scripts\\TMG_dialoguedata.lua")
dofilepath("data:scripts\\TMG_interfacescripts.lua")
dofilepath("player:TestMissionGrid\\TMG_tempdialoguestatus.lua")

--print("And the winner is... " .. dialogueStatus.current .. "!")
thisNode = dialogueStatus.node
thisActor = dialogueStatus.actor
thisHistory = {}				-- dialogueStatus.history	-- disabled for the time being
thisDialogue = DialogueScripts[thisNode]
thisOptions = thisDialogue.options

historyCount = getn(thisHistory)
historyContainerID = 3
buttonCount = getn(thisOptions)
buttonContainerID = 4		-- the position of the response container box in the DialogueScreen table

DialogueScreen = 
{
	soundOnShow = "SFX_ObjectiveMenuONOFF",
	soundOnHide = "SFX_ObjectiveMenuONOFF",
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = 0.0, y = 0.0, xr="scr", yr="scr",},
		size_WH = {w = 1.0, h = 1.0, wr = "scr", hr = "scr",},
	},
	stylesheet = "HW2StyleSheet",
	pixelUVCoords = 1,
	;
	{
		type = "Frame",
		name = "frmTheRoot",
		Layout =
		{
			pivot_XY = {0.5, 0.5},
			pos_XY = {x = 0.5, y = 0.5, xr = "par", yr = "par",},
			size_WH = {w = 800, h = 600, wr = "px", hr = "px",},
		},
		backgroundColor = "FEColorBackground2",
		autosize = 0,
		;
		-- 1. Window title 
		{
			type = "TextLabel",
			Layout =
			{
				pivot_XY = {0.0, 0.0},
				pos_XY = {x = 8, y = 8, xr="px", yr="px",},
				size_WH = {w = 388, h = 36, wr = "px", hr = "px",},
			},
			name = "lblTitle",
			Text = 
			{
				text = "DIALOGUE",
				textStyle = "IGHeading1",
				--color = {255,255,255,255},
				hAlign = "Left",
				vAlign = "Top",
			},
		},
		-- 2. Actor name
		{
			type = "TextLabel",
			Layout =
			{
				pivot_XY = {0.0, 0.0},
				pos_XY = {x = 8, y = 44, xr="px", yr="px",},
				size_WH = {w = 388, h = 36, wr = "px", hr = "px",},
			},
			name = "actorNameText",
			Text =
			{
				text = thisDialogue.actorname,
				textStyle = "FEButtonTextStyle",
				color = {255,255,255,255},
				hAlign = "Left",
				vAlign = "Top",
			},
		},
		-- 3. History - this must be the third item or the script will fail!
		{
			type = "Frame",
			Layout =
			{
				pivot_XY = {0.0, 0.0},
				pos_XY = {x = 8, y = 80, xr="px", yr="px",},
				size_WH = {w = 388, h = 500, wr = "px", hr = "px",},
				pad_LT = {l = 8, t = 8, lr = "px", tr = "px",},
				pad_RB = {r = 8, b = 8, rr = "px", br = "px",},
			},
			name = "mainHistoryLog",
			borderColor = "IGColorOutline",
			outerBorderWidth = 1,
			autosize = 0,
			autoarrange = 1,
			arrangetype = "vert",
			arrangedir = -1,	-- 1, -1, or 0 according to my research, seems to have no effect
		},
		-- 4. Buttons - this must be the fourth item or the script will fail!
		{
			type = "Frame",
			Layout =
			{
				pivot_XY = {0.0, 0.0},
				pos_XY = {x = 404, y = 80, xr="px", yr="px",},
				size_WH = {w = 388, h = 500, wr = "px", hr = "px",},
				pad_LT = {l = 8, t = 8, lr = "px", tr = "px",},
				pad_RB = {r = 8, b = 8, rr = "px", br = "px",},
			},
			name = "mainDialogueChoices",
			borderColor = "IGColorOutline",		-- todo: outdated HW2 style
			outerBorderWidth = 1,
			autosize = 0,
			autoarrange = 1,
			arrangetype = "vert",
			arrangedir = 1,	
		},
	},
}


-- dialogue responses in the form of clickable buttons
for i = 1, buttonCount do
	local temp_text = i .. ". " .. thisOptions[i].buttontext
	DialogueScreen[1][buttonContainerID][i] = CreateNewDialogueButton(i, temp_text, "MainUI_ScarEvent(\"GiveResponse(" .. i .. ")\")")
end

extraButtonCount = buttonCount + 3
for i = buttonCount + 1, extraButtonCount do
	local temp_text = i .. ". Dummy option. Clicking on this button will not do anything. This text should wrap across several lines. The button container currently does not scroll, however."
	DialogueScreen[1][buttonContainerID][i] = CreateNewDialogueButton(i, temp_text, "")
end

local i = extraButtonCount + 1
local temp_text = i .. ". Cancel"
DialogueScreen[1][buttonContainerID][i] = CreateNewDialogueButton(i, temp_text, "MainUI_ScarEvent(\"CloseDialogueWindow()\")")

-- dialogue history

--for i = 1, historyCount do
--	local temp_text = thisHistory[i][1] .. ": " .. thisHistory[i][2]
--	DialogueScreen[1][historyContainerID][i] = CreateNewLogMessage(i, temp_text, {255,215,0,255})
--end
--extraHistoryCount = historyCount + 1
--for i = historyCount + 1, extraHistoryCount do
--	local temp_text = "Here is some fake text meant to represent something that was said earlier. This is a really long text so it should wrap. The color of the text has been changed, too. Ideally this container would scroll to the newest message."
--	DialogueScreen[1][historyContainerID][i] = CreateNewLogMessage(i, temp_text, {255,215,0,255})
--end

-- flavor text

local i = 1
local temp_text = thisDialogue.flavortext
DialogueScreen[1][historyContainerID][i] = CreateNewLogMessage(i, temp_text, {255,215,0,255})

local i = 2
local temp_text = thisDialogue.actorname .. ": " .. thisDialogue.actortext
DialogueScreen[1][historyContainerID][i] = CreateNewLogMessage(i, temp_text, {255,255,255,255})

--print("GUI: Done parsing dialogue screen!")
