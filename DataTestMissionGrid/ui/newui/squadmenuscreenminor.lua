--print("Reloading SquadMenuScreenMinor")
gametypeScope = "minor"
dofilepath("data:ui\\newui\\Styles\\HWRM_Style\\HWRMDefines.lua")
dofilepath("data:scripts\\utilfunc.lua")
dofilepath("data:scripts\\TMG_objectdata.lua")
dofilepath("data:scripts\\TMG_initialstate.lua")
dofilepath("data:scripts\\TMG_initialfleet.lua")
dofilepath("player:TestMissionGrid\\TMG_savegame.lua")
dofilepath("player:TestMissionGrid\\TMG_tempsquadmenu.lua")
dofilepath("data:scripts\\TMG_interfacescripts.lua")
dofilepath("data:scripts\\TMG_squadmenu.lua")

sectionWidLft = 500
sectionWidRgt = 300
sectionHgh = 600
gapX = 8
gapY = 8
outerWid = 800 + gapX * 4
outerHgh = 600 + gapY * 2
labelWid = 30
buttonNum = 5
buttonWid = sectionWidLft/buttonNum - labelWid/buttonNum
headerHgh = 36
locationHgh = headerHgh
listHgh = sectionHgh - locationHgh - headerHgh
colLabels = {"A", "B", "C", "D", "E", "F", "G", "H",}		-- sector column labels

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
for i = 1, squadMax do
	local this_player = squadShips[1]
	local this_squad = this_player[i]
	-- FRAME
	SquadButtonFrame[i] =
	{
		type = "Frame",		
		name = "blah",	
		Layout =
		{
			pivot_XY = {0.0, 0.0},
			pos_XY = {x = 0.0, y = 0.0, xr = "px", yr = "px",},
			size_WH = {w = sectionWidLft, h = 30, wr = "px", hr = "px",},
		},
		autosize = 1,
		autoarrange = 1,
		arrangetype = "horiz",
	}
	-- INDEX
	SquadButtonFrame[i][1] =
	{
		type = "TextLabel",
		name = "lblIndex_" .. i,
		Layout =
		{
			pivot_XY = { 0.0, 0.0 },
			pos_XY = { x = 0.0, y = 0.0, xr = "px", yr = "px" },
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
	if (this_squad == nil) then
		-- SET
		SquadButtonFrame[i][2] =
		{
			type = "TextButton",
			name = "btnSet_" .. i,
			buttonStyle = "FEButtonStyle1_Outlined_Chipped",
			Layout =
			{
				pivot_XY = { 0.0, 0.0 },
				pos_XY = {x = 0.0, y = 0.0, xr="px", yr="px",},
				size_WH = {w = buttonWid, h = 30, wr = "px", hr = "px"},
			},	
			helpTip = "Set the fleet to the current ship selection.",
			helpTipTextLabel = "txtLblHELPTEXT",
			Text =
			{
				text = "Set",
			},
			onMouseClicked = "MainUI_ScarEvent(\"SetSquad(" .. i .. ")\")",
			enabled = 1,
		}
	elseif (this_squad ~= nil) then
		local this_path = this_squad.travel.path
		local this_destination = this_path[1]
		local this_destination_row = this_destination[1]
		local this_destination_col = this_destination[2]
		local this_inhyperspace = this_squad.travel.inhyperspace
		local is_enabled = 0
		if ((this_destination_row == currentSectorRow) and (this_destination_col == currentSectorCol) and (this_inhyperspace == 0)) then
			is_enabled = 1
		end
		-- SET
		SquadButtonFrame[i][2] =
		{
			type = "TextButton",
			name = "btnSet_" .. i,
			buttonStyle = "FEButtonStyle1_Outlined_Chipped",
			Layout =
			{
				pivot_XY = { 0.0, 0.0 },
				pos_XY = {x = 0.0, y = 0.0, xr="px", yr="px",},
				size_WH = {w = buttonWid, h = 30, wr = "px", hr = "px"},
			},	
			helpTip = "Set the fleet to the current ship selection.",
			helpTipTextLabel = "txtLblHELPTEXT",
			Text =
			{
				text = "Set",
			},
			onMouseClicked = "MainUI_ScarEvent(\"SetSquad(" .. i .. ")\")",
			enabled = is_enabled,
		}
		-- ADD
		SquadButtonFrame[i][3] =
		{
			type = "TextButton",
			name = "btnSelect_" .. i,
			buttonStyle = "FEButtonStyle1_Outlined_Chipped",
--				buttonStyle = "FEButtonStyle1",
			Layout =
			{
				pivot_XY = { 0.0, 0.0 },
				pos_XY = {x = 0.0, y = 0.0, xr="px", yr="px",},
				size_WH = {w = buttonWid/2, h = 30, wr = "px", hr = "px"},
			},		
			helpTip = "Add the selected ships to the fleet.",
			helpTipTextLabel = "txtLblHELPTEXT",
			Text =
			{
				text = "+",
			},
			onMouseClicked = "MainUI_ScarEvent(\"AddToSquad(" .. i .. ")\")",
			enabled = is_enabled,
		}
		-- SUBTRACT
		SquadButtonFrame[i][4] =
		{
			type = "TextButton",
			name = "btnSelect_" .. i,
			buttonStyle = "FEButtonStyle1_Outlined_Chipped",
--				buttonStyle = "FEButtonStyle1",
			Layout =
			{
				pivot_XY = { 0.0, 0.0 },
				pos_XY = {x = 0.0, y = 0.0, xr="px", yr="px",},
				size_WH = {w = buttonWid/2, h = 30, wr = "px", hr = "px"},
			},		
			helpTip = "Subtract the selected ships from the fleet.",
			helpTipTextLabel = "txtLblHELPTEXT",
			Text =
			{
				text = "-",
			},
			onMouseClicked = "MainUI_ScarEvent(\"SubtractFromSquad(" .. i .. ")\")",
			enabled = is_enabled,
		}
		-- SELECT
		SquadButtonFrame[i][5] =
		{
			type = "TextButton",
			name = "btnSelect_" .. i,
			buttonStyle = "FEButtonStyle1_Outlined_Chipped",
--				buttonStyle = "FEButtonStyle1",
			Layout =
			{
				pivot_XY = { 0.0, 0.0 },
				pos_XY = {x = 0.0, y = 0.0, xr="px", yr="px",},
				size_WH = {w = buttonWid, h = 30, wr = "px", hr = "px"},
			},		
			helpTip = "Select all ships in the fleet.",
			helpTipTextLabel = "txtLblHELPTEXT",
			Text =
			{
				text = "Select",
			},
			onMouseClicked = "MainUI_ScarEvent(\"SelectSquad(" .. i .. ")\")",
			enabled = is_enabled,
		}
		-- CLEAR
		SquadButtonFrame[i][6] =
		{
			type = "TextButton",
			name = "btnClear_" .. i,
			buttonStyle = "FEButtonStyle1_Outlined_Chipped",
			Layout =
			{
				pivot_XY = { 0.0, 0.0 },
				pos_XY = {x = 0.0, y = 0.0, xr="px", yr="px",},
				size_WH = {w = buttonWid, h = 30, wr = "px", hr = "px"},
			},	
			helpTip = "Clear all ships from the fleet.",
			helpTipTextLabel = "txtLblHELPTEXT",
			Text =
			{
				text = "Clear",
			},
			onMouseClicked = "MainUI_ScarEvent(\"ClearSquad(" .. i .. ")\")",
			enabled = is_enabled,
		}
		-- LIST
		SquadButtonFrame[i][7] =
		{
			type = "TextButton",
			name = "btnList_" .. i,
			buttonStyle = "FEButtonStyle1_Outlined_Chipped",
			Layout =
			{
				pivot_XY = { 0.0, 0.0 },
				pos_XY = {x = 0.0, y = 0.0, xr="px", yr="px",},
				size_WH = {w = buttonWid, h = 30, wr = "px", hr = "px"},
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


-- FRAME
SquadButtonFrame[squadMax + 1] =
{
	type = "Frame",		
	name = "blah",	
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = 0.0, y = 0.0, xr = "px", yr = "px",},
		size_WH = {w = sectionWidLft, h = 30, wr = "px", hr = "px",},
		pad_LT = {l = 16, t = 16, lr = "px", tr = "px",},
		pad_RB = {r = 16, b = 16, rr = "px", br = "px",},
	},
	autosize = 1,
	autoarrange = 1,
	arrangetype = "horiz",
}
-- INDEX
SquadButtonFrame[squadMax + 1][1] =
{
	type = "TextLabel",
	name = "lblIndex_" .. 0,
	Layout =
	{
		pivot_XY = { 0.0, 0.0 },
		pos_XY = { x = 0.0, y = 0.0, xr = "px", yr = "px" },
		size_WH = { w = labelWid + buttonWid, h = 30, wr = "px", hr = "px" },
	},
	Text =
	{
		text = "LOOSE SHIPS: ",
		font = "ListBoxItemFont",
		hAlign = "Center",
		vAlign = "Center",
		color = {255,255,255,255},
	},
}

-- SELECT
SquadButtonFrame[squadMax + 1][2] =
{
	type = "TextButton",
	name = "btnSelect_" .. 0,
	buttonStyle = "FEButtonStyle1_Outlined_Chipped",
--				buttonStyle = "FEButtonStyle1",
	Layout =
	{
		pivot_XY = { 0.0, 0.0 },
		pos_XY = {x = 0.0, y = 0.0, xr="px", yr="px",},
		size_WH = {w = buttonWid, h = 30, wr = "px", hr = "px"},
	},		
	helpTip = "Select all loose ships in the fleet.",
	helpTipTextLabel = "txtLblHELPTEXT",
	Text =
	{
		text = "Select",
	},
	onMouseClicked = "MainUI_ScarEvent(\"SelectSquad(" .. 0 .. ")\")",
	enabled = is_enabled,
}
-- LIST
SquadButtonFrame[squadMax + 1][3] =
{
	type = "TextButton",
	name = "btnList_" .. 0,
	buttonStyle = "FEButtonStyle1_Outlined_Chipped",
	Layout =
	{
		pivot_XY = { 0.0, 0.0 },
		pos_XY = {x = 0.0, y = 0.0, xr="px", yr="px",},
		size_WH = {w = buttonWid, h = 30, wr = "px", hr = "px"},
	},	
	helpTip = "List all loose ships in the fleet.",
	helpTipTextLabel = "txtLblHELPTEXT",
	Text =
	{
		text = "List",
	},
	onMouseClicked = "MainUI_ScarEvent(\"ListSquad(" .. 0 .. ")\")",
	enabled = 1,
}

if (listedSquad > 0) then
	SquadButtonFrame[listedSquad][7].buttonStyle = "FEButtonStyle1_Alert_Outlined_Chipped"
else
	SquadButtonFrame[squadMax + 1][3].buttonStyle = "FEButtonStyle1_Alert_Outlined_Chipped"
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
		if (ship_play == 0) then
			local ship_type = this_ship.type	-- make sure this is always lower case!
			local list_ship = objectData.ships[ship_type]
			local ship_prettyname = list_ship.prettyname
			local ship_canhyperspace = list_ship.canhyperspace
			local ship_candock = list_ship.candock
			local ship_hasshiphold = list_ship.hasshiphold
			local ship_canmove = list_ship.canmove
			local ship_textstyle = "FEListBoxItemTextStyle_RED"
			if (ship_candock == 1) then
				ship_textstyle = "FEListBoxItemTextStyle_GREEN"
			elseif (ship_hasshiphold == 1) then
				ship_textstyle = "FEListBoxItemTextStyle_BLUE"
			elseif (ship_canhyperspace == 1) then
				ship_textstyle = "FEListBoxItemTextStyle_YELLOW"
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
			ship_count = ship_count + 1
			local ship_shiphold = this_ship.shiphold
			ship_count = ListTheseShips(ship_shiphold, ship_count, stack_level + 1)
		end
	end
	return ship_count
end

if (listedSquad > 0) then
	local player_index = 0
	local this_player = squadShips[player_index + 1]
	local this_ships = this_player[listedSquad].ships
	ListTheseShips(this_ships, 1, 1)
else
	local this_ships = localShips[currentSectorRow][currentSectorCol]
	ListTheseShips(this_ships, 1, 1)
end

if (listedSquad > 0) then
	local player_index = 0
	local this_player = squadShips[player_index + 1]
	local this_squad = this_player[listedSquad]
	local this_path = this_squad.travel.path
	local this_destination = this_path[1]
	local this_destination_row = this_destination[1]
	local this_destination_col = this_destination[2]
	ListHeaderText = "FLEET LIST (FLEET " .. listedSquad .. ")"
	if ((this_destination_row == currentSectorRow) and (this_destination_col == currentSectorCol)) then
		LocationText = "LOCATION: SECTOR " .. colLabels[this_destination_col] .. this_destination_row
	else
		LocationText = "LOCATION: OUT OF SECTOR"
	end
else
	ListHeaderText = "FLEET LIST (LOOSE SHIPS)"
	LocationText = "LOCATION: SECTOR " .. colLabels[currentSectorCol] .. currentSectorRow
end

-- todo: I tried using "RmWindow" type, but reloading the screen makes it jump around for whatever reason
SquadMenuScreenMinor = 
{
	stylesheet = "HW2StyleSheet",
	Layout =
	{
		pos_XY = {x = 0.5, y = 0.5, xr = "scr", yr = "scr",},
		pivot_XY = { 0.5, 0.5 },
		size_WH = {w = outerWid, h = outerHgh, wr = "px", hr = "px",},
	},
	soundOnShow = "SFX_ObjectiveMenuONOFF",
--	soundOnHide = "SFX_ObjectiveMenuONOFF",
	pixelUVCoords = 1,
	;
	{
		type = "Frame",
		Layout =
		{
			pivot_XY = {0.0, 0.0},
			pos_XY = {x = 0.0, y = 0.0, xr = "par", yr = "par",},
			size_WH = {w = outerWid, h = outerHgh, wr = "px", hr = "px",},
		},
		backgroundColor = "FEColorBackground2",
--		autosize = 1,
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
					size_WH = {w = sectionWidLft, h = 15, wr = "px", hr = "px",},
				},
			},

			------------------------------------------------------------------------------------
			-- START BUTTONS
			------------------------------------------------------------------------------------

			-- SWITCH TABS
			{
				type = "TextButton",
				name = "m_btnSectorMap",
				buttonStyle = "FEButtonStyle1_Outlined",
				Layout =
				{
					pivot_XY = { 0.5, 0.0 },
					pos_XY = {x=0.5, y=0.0, xr="par", yr="px",},
					size_WH = {w = 1.0, h = STD_BUTTON_HEIGHT, wr = "par", hr = "scr"},
				},	
				helpTip = "Switch to the sector map screen.",
				helpTipTextLabel = "txtLblHELPTEXT",
				Text =
				{
					text = "Sector Map",
				},
				onMouseClicked = SectorMapSquadMenuSwitch,
			},
			-- REFRESH
			{
				type = "TextButton",
				name = "btnRefresh",
				buttonStyle = "FEButtonStyle1_Outlined_Chipped",
				Layout =
				{
					pivot_XY = { 0.5, 0.0 },
					pos_XY = {x=0.5, y=0.0, xr="par", yr="px",},
					size_WH = {w = 1.0, h = STD_BUTTON_HEIGHT, wr = "par", hr = "scr"},
				},		
				helpTip = "Refresh the list of loose ships.",
				helpTipTextLabel = "txtLblHELPTEXT",
				Text =
				{
					text = "Refresh Lists",
				},
				onMouseClicked = "MainUI_ScarEvent(\"RefreshShipsList()\")",
				enabled = is_enabled,
			},
--			-- TEST BUTTON
--			{
--				type = "TextButton",
--				name = "m_btnTestButton",
--				buttonStyle = "FEButtonStyle1_Outlined",
--				Layout =
--				{
--					pivot_XY = { 0.5, 0.0 },
--					pos_XY = {x=0.5, y=0.0, xr="par", yr="px",},
--					size_WH = {w = 1.0, h = STD_BUTTON_HEIGHT, wr = "par", hr = "scr"},
--				},	
--				helpTip = "Runs some test code for testing purposes.",
--				helpTipTextLabel = "txtLblHELPTEXT",
--				Text =
--				{
--					text = "Test Button",
--				},
--				onMouseClicked = "MainUI_ScarEvent(\"GUITestButtonAction()\")",
--			},
--			-- RELOAD SCREEN
--			{
--				type = "TextButton",
--				name = "m_btnReloadScreen",
--				buttonStyle = "FEButtonStyle1_Outlined",
--				Layout =
--				{
--					pivot_XY = { 0.5, 0.0 },
--					pos_XY = {x=0.5, y=0.0, xr="par", yr="px",},
--					size_WH = {w = 1.0, h = STD_BUTTON_HEIGHT, wr = "par", hr = "scr"},
--				},	
--				helpTip = "Reloads the current screen for testing purposes.",
--				helpTipTextLabel = "txtLblHELPTEXT",
--				Text =
--				{
--					text = "Reload Screen",
--				},
--				onMouseClicked = "MainUI_ScarEvent(\"ReloadVisibleScreens()\")",
--			},
			-- CLOSE
			{
				type = "TextButton",
				name = "m_btnCancel",
				buttonStyle = "FEButtonStyle1_Alert_Outlined_Chipped",
				Layout =
				{
					pivot_XY = { 0.5, 0.0 },
					pos_XY = {x = 0.5, y = 0.0, xr="par", yr="px",},
					size_WH = {w = 1.0, h = STD_BUTTON_HEIGHT, wr = "par", hr = "scr"},
				},	
				helpTip = "Close the squad menu screen.",
				helpTipTextLabel = "txtLblHELPTEXT",
				Text =
				{
					text = "Close",
				},
				hotKeyID = 177,			-- doesn't work
				onMouseClicked = SquadMenuScreenToggle,
			},

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
}
