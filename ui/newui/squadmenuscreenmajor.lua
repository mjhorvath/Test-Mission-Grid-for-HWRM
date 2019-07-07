--print("Reloading SquadMenuScreenMajor")
gametypeScope = "major"
dofilepath("data:ui\\newui\\Styles\\HWRM_Style\\HWRMDefines.lua")
dofilepath("data:scripts\\utilfunc.lua")
dofilepath("data:scripts\\TMG_objectdata.lua")
dofilepath("data:scripts\\TMG_initialstate.lua")
dofilepath("data:scripts\\TMG_initialfleet.lua")
dofilepath("player:TestMissionGrid\\TMG_savegame.lua")
dofilepath("player:TestMissionGrid\\TMG_tempsquadmenu.lua")
dofilepath("player:TestMissionGrid\\TMG_tempsectormap.lua")
dofilepath("data:scripts\\TMG_interfacescripts.lua")
dofilepath("data:scripts\\TMG_squadmenu.lua")

gapX = 8
gapY = 8
outerWid = 800 + gapX * 4
outerHgh = 600 + gapY * 2
sectionWidLft = 500
sectionWidRgt = 300
sectionHgh = 600

labelWid = 30
buttonsNum = 5
headerHgh = 36
locationHgh = headerHgh
listHgh = sectionHgh - locationHgh - headerHgh
colLabels = {"A","B","C","D","E","F","G","H",}		-- sector column labels
humanPlayer = squadShips[1]

SquadButtonFrame =
{
	type = "Frame",
	name = "frmSquadButtonFrame",
	Layout =
	{
		pivot_XY = { 0.0, 0.0 },
		pos_XY = { x = 0.0, y = 0.0, xr = "px", yr = "px" },
--		size_WH = {w = 300, h = 300, wr = "px", hr = "px",},
	},
	autosize = 1,
	autoarrange = 1,
	arrangetype = "vert",
}

-- buttons
local this_index = 1
-- FRAME
SquadButtonFrame[this_index] =
{
	type = "Frame",		
	name = "blah",	
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = 0, y = 0, xr = "px", yr = "px",},
		size_WH = {w = sectionWidLft, h = 30, wr = "px", hr = "px",},
	},
	autosize = 1,
	autoarrange = 1,
	arrangetype = "horiz",
}
-- INDEX
SquadButtonFrame[this_index][1] =
{
	type = "TextLabel",
	name = "lblIndex_" .. this_index,
	Layout =
	{
		pivot_XY = { 0.0, 0.0 },
		pos_XY = { x = 0, y = 0, xr = "px", yr = "px" },
		size_WH = { w = labelWid, h = 30, wr = "px", hr = "px" },
	},
	Text =
	{
		text = "",
		font = "ListBoxItemFont",
		hAlign = "Center",
		vAlign = "Center",
		color = {255,255,255,255},
	},
}
-- TASK
SquadButtonFrame[this_index][2] =
{
	type = "TextLabel",
	name = "lblJob_" .. this_index,
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = 0, y = 0, xr="px", yr="px",},
		size_WH = {w = (sectionWidLft/buttonsNum - labelWid/buttonsNum) * 1.5, h = 30, wr = "px", hr = "px"},
	},
	Text = 
	{
		text = "Task",
		textStyle = "IGHeading1",
		color = {255,255,255,255},
		hAlign = "Center",
		vAlign = "Center",
	},
}
-- ARRIVAL TIME
SquadButtonFrame[this_index][3] =
{
	type = "TextLabel",
	name = "lblEta_" .. this_index,
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = 0, y = 0, xr="px", yr="px",},
		size_WH = {w = (sectionWidLft/buttonsNum - labelWid/buttonsNum) * 1.5, h = 30, wr = "px", hr = "px"},
	},
	Text = 
	{
		text = "ETA",
		textStyle = "IGHeading1",
		color = {255,255,255,255},
		hAlign = "Center",
		vAlign = "Center",
	},
}
-- DESTINATION
SquadButtonFrame[this_index][4] =
{
	type = "TextLabel",
	name = "lblLoc_" .. this_index,
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = 0, y = 0, xr="px", yr="px",},
		size_WH = {w = sectionWidLft/buttonsNum - labelWid/buttonsNum, h = 30, wr = "px", hr = "px"},
	},
	Text = 
	{
		text = "Dest",
		textStyle = "IGHeading1",
		color = {255,255,255,255},
		hAlign = "Center",
		vAlign = "Center",
	},
}
-- LIST
SquadButtonFrame[this_index][5] =
{
	type = "TextLabel",
	name = "lblList_" .. this_index,
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = 0, y = 0, xr="px", yr="px",},
		size_WH = {w = (sectionWidLft/buttonsNum - labelWid/buttonsNum) * 1.0, h = 30, wr = "px", hr = "px"},
	},
	Text = 
	{
		text = "List",
		textStyle = "IGHeading1",
		color = {255,255,255,255},
		hAlign = "Center",
		vAlign = "Center",
	},
}

for i = 1, squadMax do
	local this_squad = humanPlayer[i]
	local this_index = i + 1
	-- FRAME
	SquadButtonFrame[this_index] =
	{
		type = "Frame",		
		name = "blah",	
		Layout =
		{
			pivot_XY = {0.0, 0.0},
			pos_XY = {x = 0, y = 0, xr = "px", yr = "px",},
			size_WH = {w = sectionWidLft, h = 30, wr = "px", hr = "px",},
		},
		autosize = 1,
		autoarrange = 1,
		arrangetype = "horiz",
	}
	-- INDEX
	SquadButtonFrame[this_index][1] =
	{
		type = "TextLabel",
		name = "lblIndex_" .. this_index,
		Layout =
		{
			pivot_XY = { 0.0, 0.0 },
			pos_XY = { x = 0, y = 0, xr = "px", yr = "px" },
			size_WH = { w = labelWid, h = 30, wr = "px", hr = "px" },
		},
		Text =
		{
			text = i .. ". ",
			font = "ListBoxItemFont",
			hAlign = "Center",
			vAlign = "Center",
			color = {255,255,255,255},
		},
	}
	if (this_squad ~= nil) then
		local this_path = this_squad.travel.path
		local path_length = getn(this_path)
		local this_destination = this_path[path_length]
		local this_destination_row = this_destination[1]
		local this_destination_col = this_destination[2]
		local this_destination_code = "(" .. colLabels[this_destination_col] .. this_destination_row .. ")"
		local this_arrivaltime = disp_time(this_squad.travel.arrivaltime)
		local this_taskname = this_squad.task.type
		-- TASK
--		SquadButtonFrame[this_index][2] =
--		{
--			type = "DropDownListBox",
--			dropDownListBoxStyle = "FEDropDownListBoxStyle",
--			Layout =
--			{
--				pivot_XY = { 0.0, 0.0 },
--				pos_XY = {x = 0, y = 0, xr="px", yr="px",},
--				size_WH = {w = (sectionWidLft/buttonsNum - labelWid/buttonsNum) * 1.5, h = 30, wr = "px", hr = "px"},
--			},
--			ListBox = 
--			{
--				backgroundColor = {0,0,0,255,},
--				listBoxStyle = "FEListBoxStyle",
--				selected = 0,
--				enabled = 0,
--				;
--				{
--					type = "TextListBoxItem",
--					buttonStyle = "FEListBoxItemButtonStyle",
--					resizeToListBox = 1,
--					Text = 
--					{
--						text = "N/A",
--						textStyle = "FEListBoxItemTextStyle",
--					},
--				},
--			},
--		}
		-- TASK
		SquadButtonFrame[this_index][2] =
		{
			type = "TextLabel",
			name = "lblJob_" .. this_index,
			Layout =
			{
				pivot_XY = { 0.0, 0.0 },
				pos_XY = {x = 0, y = 0, xr="px", yr="px",},
				size_WH = {w = (sectionWidLft/buttonsNum - labelWid/buttonsNum) * 1.5, h = 30, wr = "px", hr = "px"},
			},
			BackgroundGraphic = BORDER_GRAPHIC_BUTTON_OUTLINE,
			Text = 
			{
				text = this_taskname,
				textStyle = "IGHeading1",
				color = {255,255,255,255},
				hAlign = "Center",
				vAlign = "Center",
			},
		}
		-- ARRIVAL TIME
		SquadButtonFrame[this_index][3] =
		{
			type = "TextLabel",
			name = "lblEta_" .. this_index,
			Layout =
			{
				pivot_XY = {0.0, 0.0},
				pos_XY = {x = 0, y = 0, xr="px", yr="px",},
				size_WH = {w = (sectionWidLft/buttonsNum - labelWid/buttonsNum) * 1.5, h = 30, wr = "px", hr = "px"},
			},
			BackgroundGraphic = BORDER_GRAPHIC_BUTTON_OUTLINE,
			Text = 
			{
				text = this_arrivaltime,
				textStyle = "IGHeading1",
				color = {255,255,255,255},
				hAlign = "Center",
				vAlign = "Center",
			},
		}
		-- DESTINATION
		SquadButtonFrame[this_index][4] =
		{
			type = "TextLabel",
			name = "lblLoc_" .. this_index,
			Layout =
			{
				pivot_XY = {0.0, 0.0},
				pos_XY = {x = 0, y = 0, xr="px", yr="px",},
				size_WH = {w = sectionWidLft/buttonsNum - labelWid/buttonsNum, h = 30, wr = "px", hr = "px"},
			},
			BackgroundGraphic = BORDER_GRAPHIC_BUTTON_OUTLINE,
			Text = 
			{
				text = this_destination_code,
				textStyle = "IGHeading1",
				color = {255,255,255,255},
				hAlign = "Center",
				vAlign = "Center",
			},
		}
		-- LIST
		SquadButtonFrame[this_index][5] =
		{
			type = "TextButton",
			name = "btnList_" .. this_index,
			buttonStyle = "FEButtonStyle1_Outlined_Chipped",
			Layout =
			{
				pivot_XY = { 0.0, 0.0 },
				pos_XY = {x = 0, y = 0, xr="px", yr="px",},
				size_WH = {w = sectionWidLft/buttonsNum - labelWid/buttonsNum, h = 30, wr = "px", hr = "px"},
			},	
			helpTip = "List all ships in the fleet.",
			helpTipTextLabel = "txtLblHELPTEXT",
			Text =
			{
				text = "List",
			},
			onMouseClicked = "MainUI_ScarEvent(\"ListSquad(" .. i .. ")\")",
			enabled = 1,
		}
	end
end

local this_index = squadMax + 2
-- FRAME
SquadButtonFrame[this_index] =
{
	type = "Frame",		
	name = "blah",	
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = 0.0, y = 0.0, xr = "px", yr = "px",},
		size_WH = {w = sectionWidLft, h = 30, wr = "px", hr = "px",},
		pad_LT = {l = 0, t = 16, lr = "px", tr = "px",},
		pad_RB = {r = 0, b = 16, rr = "px", br = "px",},
	},
	autosize = 1,
	autoarrange = 1,
	arrangetype = "horiz",
}
-- INDEX
SquadButtonFrame[this_index][1] =
{
	type = "Frame",
	name = "lblIndex_" .. 0,
	Layout =
	{
		pivot_XY = { 0.0, 0.0 },
		pos_XY = { x = 0.0, y = 0.0, xr = "px", yr = "px" },
		size_WH = { w = labelWid, h = 30, wr = "px", hr = "px" },
	},
}
-- SPACER
SquadButtonFrame[this_index][2] =
{
	type = "TextLabel",
	name = "lblSpacer_" .. 0,
	Layout =
	{
		pivot_XY = { 0.0, 0.0 },
		pos_XY = { x = 0.0, y = 0.0, xr = "px", yr = "px" },
		size_WH = { w = (sectionWidLft/buttonsNum - labelWid/buttonsNum) * 4, h = 30, wr = "px", hr = "px" },
	},
	Text =
	{
		text = "LOOSE SHIPS NOT IN A FLEET: ",
		font = "ListBoxItemFont",
		hAlign = "Center",
		vAlign = "Center",
		color = {255,255,255,255},
	},
}
-- LIST
SquadButtonFrame[this_index][3] =
{
	type = "TextButton",
	name = "btnList_" .. 0,
	buttonStyle = "FEButtonStyle1_Outlined_Chipped",
	Layout =
	{
		pivot_XY = { 0.0, 0.0 },
		pos_XY = {x = 0.0, y = 0.0, xr="px", yr="px",},
		size_WH = {w = sectionWidLft/buttonsNum - labelWid/buttonsNum, h = 30, wr = "px", hr = "px"},
	},	
	helpTip = "List all ships in no fleet.",
	helpTipTextLabel = "txtLblHELPTEXT",
	Text =
	{
		text = "List",
	},
	onMouseClicked = "MainUI_ScarEvent(\"ListSquad(" .. 0 .. ")\")",
	enabled = 1,
}

if (listedSquad > 0) then
	SquadButtonFrame[listedSquad + 1][5].buttonStyle = "FEButtonStyle1_Alert_Outlined_Chipped"
else
	SquadButtonFrame[squadMax + 2][3].buttonStyle = "FEButtonStyle1_Alert_Outlined_Chipped"
end

-- list
SquadListFrame =
{
	type = "ListBox",
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = 0, y = 0, xr = "px", yr = "px",},
		size_WH = {w = sectionWidRgt, h = sectionHgh - headerHgh - locationHgh, wr = "px", hr = "px",},
	},
	listBoxStyle = "FEListBoxStyle_Bordered",
	selected = 0,
	arrangedir = -1,	-- does not work
}

function ListTheseShips(ship_table, ship_count, stack_level)
	for i = 1, getn(ship_table) do
		local this_ship = ship_table[i]
		local ship_play = this_ship.playerindex
		-- only show player-owned ships
		if (ship_play == 0) then
			local ship_type = this_ship.type	-- make sure this is always lower case!
			local list_ship = objectData.ships[ship_type]
			local ship_prettyname = list_ship.prettyname
			local ship_canhyperspace = list_ship.canhyperspace
			local ship_candock = list_ship.candock
			local ship_canbuildhypermodule = list_ship.canbuildhypermodule
			local ship_canmove = list_ship.canmove
			local ship_textstyle = "FEListBoxItemTextStyle"
			if (ship_candock == 1) then
				ship_textstyle = "FEListBoxItemTextStyle_GREEN"
			elseif (ship_canbuildhypermodule == 1) then
				ship_textstyle = "FEListBoxItemTextStyle_BLUE"
			elseif (ship_canhyperspace == 1) then
				ship_textstyle = "FEListBoxItemTextStyle_YELLOW"
			elseif (canmove == 0) then
				ship_textstyle = "FEListBoxItemTextStyle_RED"
			end
			local ship_textpadding = strrep("    ", stack_level - 1)
			SquadListFrame[ship_count] =
			{
				type = "TextListBoxItem",
				buttonStyle = "FEListBoxItemButtonStyle",
				resizeToListBox = 1,
				arrangedir = -1,	-- does not work
				enabled = 0,		-- I may enable this again if I decide to add buttons to add/subtract ships based on your selection in the list box
				Text = 
				{
					text = ship_textpadding .. ship_prettyname,
					textStyle = ship_textstyle,
				},
			}
			local ship_shiphold = this_ship.shiphold
			ship_count = ListTheseShips(ship_shiphold, ship_count + 1, stack_level + 1)
		end
	end
	return ship_count
end

if (listedSquad > 0) then
	local this_ships = humanPlayer[listedSquad].ships
	ListTheseShips(this_ships, 1, 1)
else
	local this_ships = localShips[currentSectorRow][currentSectorCol]
	ListTheseShips(this_ships, 1, 1)
end

if (listedSquad > 0) then
	local this_squad = humanPlayer[listedSquad]
	local this_path = this_squad.travel.path
	local this_destination = this_path[1]
	local this_destination_row = this_destination[1]
	local this_destination_col = this_destination[2]
	local this_inhyperspace = this_squad.travel.inhyperspace
	ListHeaderText = "FLEET LIST (FLEET " .. listedSquad .. ")"
	if (this_inhyperspace == 1) then
		LocationText = "EN ROUTE: SECTOR " .. colLabels[this_destination_col] .. this_destination_row
	else
		LocationText = "LOCATION: SECTOR " .. colLabels[this_destination_col] .. this_destination_row
	end
else
	ListHeaderText = "FLEET LIST (LOOSE SHIPS)"
	LocationText = "LOCATION: SECTOR " .. colLabels[currentSectorCol] .. currentSectorRow
end

-- todo: I tried using "RmWindow" type, but reloading the screen makes it jump around for whatever reason
SquadMenuScreenMajor = 
{
	stylesheet = "HW2StyleSheet",
	soundOnShow = "SFX_ObjectiveMenuONOFF",
--	soundOnHide = "SFX_ObjectiveMenuONOFF",
	Layout =
	{
		pos_XY = {x = 0.5, y = 0.5, xr = "scr", yr = "scr",},
		pivot_XY = { 0.5, 0.5 },
		size_WH = {w = 1.0, h = 1.0, wr = "scr", hr = "scr",},
	},
	pixelUVCoords = 1,
	;
	{
		type = "Frame",
		Layout =
		{
			pivot_XY = {0.5, 0.5},
			pos_XY = {x = 0.5, y = 0.5, xr = "par", yr = "par",},
			size_WH = {w = 1.0, h = 1.0, wr = "scr", hr = "scr",},
		},
		BackgroundGraphic =
		{
			type = "Graphic",
			--size = {2048, 1024},
			--textureUV = { 0, 0, 2048, 1024},
			uvRect = { 0, 1, 1, 0 },
			texture = "Data:UI\\NewUI\\Background\\main_bg.tga", -- multires texture
		
		},
		autosize = 0,
		;
		{
			type = "Frame",
			Layout =
			{
				pivot_XY = {0.5, 0.5},
				pos_XY = {x = 0.5, y = 0.5, xr = "par", yr = "par",},
				size_WH = {w = outerWid, h = outerHgh, wr = "px", hr = "px",},
			},
			backgroundColor = "FEColorBackground2",
			autosize = 0,
			;
			{
				type = "Frame",		
				name = "blah",	
				Layout =
				{
					pivot_XY = {0.5, 0.5},
					pos_XY = {x = 0.5, y = 0.5, xr = "par", yr = "par",},
					size_WH = {w = outerWid, h = outerHgh, wr = "px", hr = "px",},
				},
				autosize = 0,
				;

				------------------------------------------------------------------------------------
				-- START LEFT FRAME
				------------------------------------------------------------------------------------

				{
					type = "Frame",
					name = "frmContainsLeft",
					Layout =
					{
						pivot_XY = {0.0, 0.0},
						pos_XY = {x = gapX, y = gapY, xr = "px", yr = "px",},
						size_WH = {w = sectionWidLft, h = sectionHgh, wr = "px", hr = "px",},
					},
					BackgroundGraphic = BORDER_GRAPHIC_FRAME,
					backgroundColor = COLOR_BACKGROUND_PANEL,
		--			autosize = 1,
					autoarrange = 1,
					arrangetype = "vert",
					;
					{
						type = "TextLabel",
						Layout =
						{
							pivot_XY = {0.0, 0.0},
							pos_XY = {x = 0, y = 0, xr="px", yr="px",},
							size_WH = {w = sectionWidLft, h = headerHgh, wr = "px", hr = "px",},
							pad_LT = {l = 8, t = 8, lr = "px", tr = "px",},
							pad_RB = {r = 8, b = 8, rr = "px", br = "px",},
						},
						name = "lblTitle",
						Text = 
						{
							text = "FLEET MANAGEMENT",
							textStyle = "IGHeading1",
							color = {255,255,255,255},
							hAlign = "Left",
							vAlign = "Top",
						},
					},

					------------------------------------------------------------------------------------
					-- START SQUAD CONTROLS
					------------------------------------------------------------------------------------

					SquadButtonFrame,

					------------------------------------------------------------------------------------
					-- END SQUAD CONTROLS
					------------------------------------------------------------------------------------

					{
						type = "Frame",		
						name = "blah",	
						Layout =
						{
							pivot_XY = {0.0, 0.0},
							pos_XY = {x = 0.0, y = 0.0, xr = "px", yr = "px",},
							size_WH = {w = sectionWidLft, h = 60, wr = "px", hr = "px",},
						},
					},

					------------------------------------------------------------------------------------
					-- START BUTTONS
					------------------------------------------------------------------------------------

					-- SWITCH TABS
					{
						type = "TextButton",
						name = "m_btnSectorMap",
						buttonStyle = "FEButtonStyle1_Outlined_Chipped",
						Layout =
						{
							pivot_XY = { 0.5, 0.0 },
							pos_XY = {x = 0.5, y = 0.0, xr="par", yr="px",},
							size_WH = {w = 1.0, h = STD_BUTTON_HEIGHT, wr = "par", hr = "scr"},
						},	
						helpTip = "Switch to the sector map screen. (BACKSLASH)",
						helpTipTextLabel = "txtLblHELPTEXT",
						Text =
						{
							text = "Sector Map",
						},
						hotKeyID = 177,			-- doesn't work
						onMouseClicked = SectorMapSquadMenuSwitch,
					},
--					-- TEST BUTTON
--					{
--						type = "TextButton",
--						name = "m_btnTestButton",
--						buttonStyle = "FEButtonStyle1_Outlined",
--						Layout =
--						{
--							pivot_XY = { 0.5, 0.0 },
--							pos_XY = {x=0.5, y=0.0, xr="par", yr="px",},
--							size_WH = {w = 1.0, h = STD_BUTTON_HEIGHT, wr = "par", hr = "scr"},
--						},	
--						helpTip = "Runs some test code for testing purposes.",
--						helpTipTextLabel = "txtLblHELPTEXT",
--						Text =
--						{
--							text = "Test Button",
--						},
--						onMouseClicked = "MainUI_ScarEvent(\"GUITestButtonAction()\")",
--					},
--					-- RELOAD SCREEN
--					{
--						type = "TextButton",
--						name = "m_btnReloadScreen",
--						buttonStyle = "FEButtonStyle1_Outlined",
--						Layout =
--						{
--							pivot_XY = { 0.5, 0.0 },
--							pos_XY = {x=0.5, y=0.0, xr="par", yr="px",},
--							size_WH = {w = 1.0, h = STD_BUTTON_HEIGHT, wr = "par", hr = "scr"},
--						},	
--						helpTip = "Reloads the current screen for testing purposes.",
--						helpTipTextLabel = "txtLblHELPTEXT",
--						Text =
--						{
--							text = "Reload Screen",
--						},
--						onMouseClicked = "MainUI_ScarEvent(\"ReloadVisibleScreens()\")",
--					},

					------------------------------------------------------------------------------------
					-- END BUTTONS
					------------------------------------------------------------------------------------
				},

				------------------------------------------------------------------------------------
				-- END LEFT FRAME, START RIGHT FRAME
				------------------------------------------------------------------------------------

				{
					type = "Frame",		
					name = "frmContainsRight",	
					Layout =
					{
						pivot_XY = {0.0, 0.0},
						pos_XY = {x = sectionWidLft + gapX * 3, y = gapY, xr = "px", yr = "px",},
						size_WH = {w = sectionWidRgt, h = sectionHgh, wr = "px", hr = "px",},
					},
					BackgroundGraphic = BORDER_GRAPHIC_FRAME,
					backgroundColor = COLOR_BACKGROUND_PANEL,
					autosize = 1,
					autoarrange = 1,
					arrangetype = "vert",
					;
					{
						type = "TextLabel",
						Layout =
						{
							pivot_XY = {0.0, 0.0},
							pos_XY = {x = 0, y = 0, xr="px", yr="px",},
							size_WH = {w = sectionWidRgt, h = headerHgh, wr = "px", hr = "px",},
							pad_LT = {l = 8, t = 8, lr = "px", tr = "px",},
							pad_RB = {r = 8, b = 8, rr = "px", br = "px",},
						},
						name = "lblTitle",
						Text = 
						{
							text = ListHeaderText,
							textStyle = "IGHeading1",
							color = {255,255,255,255},
							hAlign = "Left",
							vAlign = "Top",
						},
					},
					SquadListFrame,
					{
						type = "TextLabel",
						Layout =
						{
							pivot_XY = {0.0, 0.0},
							pos_XY = {x = 0, y = listHgh, xr="px", yr="px",},
							size_WH = {w = sectionWidRgt, h = headerHgh, wr = "px", hr = "px",},
							pad_LT = {l = 8, t = 8, lr = "px", tr = "px",},
							pad_RB = {r = 8, b = 8, rr = "px", br = "px",},
						},
						name = "lblTitle",
						Text = 
						{
							text = LocationText,
							textStyle = "IGHeading1",
							color = {255,255,255,255},
							hAlign = "Left",
							vAlign = "Top",
						},
					},
				},

				------------------------------------------------------------------------------------
				-- END RIGHT FRAME
				------------------------------------------------------------------------------------
			},
		},
	},
}
