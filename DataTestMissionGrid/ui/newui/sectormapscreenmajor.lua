--print("Reloading SectorMapScreenMajor")
gametypeScope = "major"
dofilepath("data:scripts\\utilfunc.lua")
dofilepath("data:scripts\\TMG_objectdata.lua")
dofilepath("data:scripts\\TMG_initialstate.lua")
dofilepath("data:scripts\\TMG_initialfleet.lua")
dofilepath("player:TestMissionGrid\\TMG_savegame.lua")
dofilepath("player:TestMissionGrid\\TMG_tempsquadmenu.lua")
dofilepath("player:TestMissionGrid\\TMG_tempsectormap.lua")
dofilepath("data:scripts\\TMG_sectormap_proto.lua")
--dofilepath("data:scripts\\TMG_interfacescripts.lua")		-- already loaded

padAmount = 8
labelWid = 24
headerHgh = 36
sectionWidRgt = 256 - padAmount * 2
sectionWidRgtInnr = sectionWidRgt - padAmount * 2
buttonsWid = {labelWid, 50, 75, 75}
enter_bool = 0
locationText = "LOCATION: SECTOR " .. colLabels[currentSectorCol] .. currentSectorRow

SquadButtonFrame =
{
	type = "Frame",
	name = "frmSquadButtonFrame",
	Layout =
	{
		pivot_XY = { 0.0, 0.0 },
		pos_XY = { x = 0.0, y = 0.0, xr = "px", yr = "px" },
		size_WH = {w = sectionWidRgt, h = 0, wr = "px", hr = "px",},
		pad_LT = {l = padAmount, t = padAmount, lr = "px", tr = "px"},
		pad_RB = {r = padAmount, b = padAmount, rr = "px", br = "px"},
	},
	autosize = 1,
	autoarrange = 1,
	arrangetype = "vert",
}

-- HEADER FRAME
SquadButtonFrame[1] =
{
	type = "Frame",		
	name = "blah",	
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = 0.0, y = 0.0, xr = "px", yr = "px",},
		size_WH = {w = sectionWidRgtInnr, h = 30, wr = "px", hr = "px",},
	},
	autosize = 1,
	autoarrange = 1,
	arrangetype = "horiz",
}
-- HEADER INDEX
SquadButtonFrame[1][1] =
{
	type = "TextLabel",
	name = "lblIndex_" .. 0,
	Layout =
	{
		pivot_XY = { 0.0, 0.0 },
		pos_XY = { x = 0.0, y = 0.0, xr = "px", yr = "px" },
		size_WH = { w = buttonsWid[1], h = 30, wr = "px", hr = "px" },
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
-- HEADER LOCATION
SquadButtonFrame[1][2] =
{
	type = "TextLabel",
	name = "lblTitle",
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = 0, y = 0, xr="px", yr="px",},
		size_WH = {w = buttonsWid[2], h = 30, wr = "px", hr = "px",},
	},
	Text = 
	{
		text = "Loc",
		textStyle = "IGHeading1",
		color = {255,255,255,255},
		hAlign = "Center",
		vAlign = "Center",
	},
}
-- HEADER MOVE TO
SquadButtonFrame[1][3] =
{
	type = "TextLabel",
	name = "lblTitle",
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = 0, y = 0, xr="px", yr="px",},
		size_WH = {w = buttonsWid[3], h = 30, wr = "px", hr = "px",},
	},
	Text = 
	{
		text = "Move",
		textStyle = "IGHeading1",
		color = {255,255,255,255},
		hAlign = "Center",
		vAlign = "Center",
	},
}
-- HEADER STOP
SquadButtonFrame[1][4] =
{
	type = "TextLabel",
	name = "lblTitle",
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = 0, y = 0, xr="px", yr="px",},
		size_WH = {w = buttonsWid[4], h = 30, wr = "px", hr = "px",},
	},
	Text = 
	{
		text = "Stop",
		textStyle = "IGHeading1",
		color = {255,255,255,255},
		hAlign = "Center",
		vAlign = "Center",
	},
}

local player_index = 0
local this_player = squadShips[player_index + 1]
for i = 1, squadMax do
	local this_squad = this_player[i]
	-- FRAME
	SquadButtonFrame[i+1] =
	{
		type = "Frame",		
		name = "blah",	
		Layout =
		{
			pivot_XY = {0.0, 0.0},
			pos_XY = {x = 0.0, y = 0.0, xr = "px", yr = "px",},
			size_WH = {w = sectionWidRgt, h = 30, wr = "px", hr = "px",},
		},
		autosize = 1,
		autoarrange = 1,
		arrangetype = "horiz",
	}
	-- INDEX
	SquadButtonFrame[i+1][1] =
	{
		type = "TextLabel",
		name = "lblIndex_" .. i,
		Layout =
		{
			pivot_XY = { 0.0, 0.0 },
			pos_XY = { x = 0.0, y = 0.0, xr = "px", yr = "px" },
			size_WH = { w = buttonsWid[1], h = 30, wr = "px", hr = "px" },
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
		local this_destination = this_path[1]
		local this_destination_row = this_destination[1]
		local this_destination_col = this_destination[2]
		local this_inhyperspace = this_squad.travel.inhyperspace
		local this_escaping = this_squad.travel.escaping
		local this_canhyperspace = this_squad.travel.cantravel
		local this_intransit = this_squad.travel.intransit
		local this_count_ships = getn(this_squad.ships)
		local this_location_txt = ""
		if ((this_destination_row > 0) and (this_destination_col > 0)) then
			this_location_txt = colLabels[this_destination_col] .. this_destination_row
		else
			this_location_txt = "--"
		end
		local move_bool = 0
		local stop_bool = 0
		if ((this_destination_row == currentSectorRow) and (this_destination_col == currentSectorCol) and (this_escaping == 0) and (this_count_ships > 0)) then
			if (this_intransit == 0) then
				if (this_canhyperspace == 1) then
					move_bool = 1
				end
				enter_bool = 1
			else
				stop_bool = 1
			end
		end
		-- LOCATION
		SquadButtonFrame[i+1][2] =
		{
			type = "TextLabel",
			name = "lblTitle",
			Layout =
			{
				pivot_XY = {0.0, 0.0},
				pos_XY = {x = 0, y = 0, xr="px", yr="px",},
				size_WH = {w = buttonsWid[2], h = 30, wr = "px", hr = "px",},
			},
			BackgroundGraphic = BORDER_GRAPHIC_BUTTON_OUTLINE,
			Text = 
			{
				text = this_location_txt,
				textStyle = "IGHeading1",
				color = {255,255,255,255},
				hAlign = "Center",
				vAlign = "Center",
			},
		}
		-- MOVE TO (BLUE)
		SquadButtonFrame[i+1][3] =
		{
			type = "TextButton",
			name = "btnMoveBlu_" .. i,
			buttonStyle = "FEButtonStyle1_Outlined_Chipped",
			Layout =
			{
				pivot_XY = { 0.0, 0.0 },
				pos_XY = {x = 0.0, y = 0.0, xr="px", yr="px",},
				size_WH = {w = buttonsWid[3], h = 30, wr = "px", hr = "px"},
			},	
			helpTip = "Move the squad to a different sector.",
			helpTipTextLabel = "txtLblHELPTEXT",
			Text =
			{
				text = "To",
			},
			onMouseClicked = "MainUI_ScarEvent(\"MouseClickMoveButton(" .. i .. ")\")",
			enabled = move_bool,
			ignored = 1,
			visible = 1,
		}
		-- MOVE TO (RED)
		SquadButtonFrame[i+1][4] =
		{
			type = "TextButton",
			name = "btnMoveRed_" .. i,
			buttonStyle = "FEButtonStyle1_Alert_Outlined_Chipped",
			Layout =
			{
				pivot_XY = { 0.0, 0.0 },
				pos_XY = {x = 0.0, y = 0.0, xr="px", yr="px",},
				size_WH = {w = buttonsWid[3], h = 30, wr = "px", hr = "px"},
			},	
			helpTip = "Move the squad to a different sector.",
			helpTipTextLabel = "txtLblHELPTEXT",
			Text =
			{
				text = "To",
			},
			onMouseClicked = "MainUI_ScarEvent(\"MouseClickMoveButton(" .. i .. ")\")",
			enabled = move_bool,
			ignored = 1,
			visible = 0,
		}
		-- STOP
		SquadButtonFrame[i+1][5] =
		{
			type = "TextButton",
			name = "btnStop_" .. i,
			buttonStyle = "FEButtonStyle1_Outlined_Chipped",
			Layout =
			{
				pivot_XY = { 0.0, 0.0 },
				pos_XY = {x = 0.0, y = 0.0, xr="px", yr="px",},
				size_WH = {w = buttonsWid[4], h = 30, wr = "px", hr = "px"},
			},	
			helpTip = "Stop moving forward and return to the previous sector.",
			helpTipTextLabel = "txtLblHELPTEXT",
			Text =
			{
				text = "Stop",
			},
			onMouseClicked = "MainUI_ScarEvent(\"MouseClickStopButton(" .. i .. ")\")",
			enabled = stop_bool,
			ignored = 1,
			visible = 1,
		}
	end
end


SectorMapScreenMajor = 
{
	stylesheet = "HW2StyleSheet",
	onShow = UpdateTimeLabel,
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
		name = "frmTheRoot",
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
			name = "frmTheRoot",
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
					size_WH = {w = innerWid, h = innerHgh, wr = "px", hr = "px",},
				},
				autosize = 0,
				;

				------------------------------------------------------------------------------------
				-- START MAP GRID
				------------------------------------------------------------------------------------

				{
					type = "Frame",
					name = "frmRootMissionBox",
					backgroundColor = "IGColorButton",
					Layout =
					{
						pivot_XY = {0.0, 0.5},
						pos_XY = {x = 0, y = 0.5, xr="px", yr="par",},
						size_WH = {w = innerHgh, h = innerHgh, wr = "px", hr = "px",},
					},
					;
					listHead,
					listBot,
					listShd,
					listSel,
					listTxt,
					listPip,
					listArrw,
					listLine,
					listWarn,
					listBut,
				},

				------------------------------------------------------------------------------------
				-- END MAP GRID
				------------------------------------------------------------------------------------

				------------------------------------------------------------------------------------
				-- START RIGHT SIDE FRAME
				------------------------------------------------------------------------------------

				{
					type = "Frame",
					name = "frmRightSide",
					Layout =
					{
						pivot_XY = {0.0, 0.5},
						pos_XY = {x = innerHgh + padAmount * 2, y = 0.5, xr = "px", yr = "par",},
						size_WH = {w = 256 - padAmount * 2, h = innerHgh, wr = "px", hr = "px",},
					},
					BackgroundGraphic = BORDER_GRAPHIC_FRAME,
					backgroundColor = COLOR_BACKGROUND_PANEL,
					autoarrange = 1,
					arrangetype = "vert",
					;
					-- START LOCATION TEXT
					{
						type = "TextLabel",
						name = "lblLocationLabel",
						Layout =
						{
							pivot_XY = {0.0, 0.0},
							pos_XY = {x = 0, y = 0, xr="px", yr="px",},
							size_WH = {w = sectionWidRgt, h = headerHgh, wr = "px", hr = "px",},
							pad_LT = {l = padAmount, t = padAmount, lr = "px", tr = "px"},
							pad_RB = {r = padAmount, b = padAmount, rr = "px", br = "px"},
						},
						Text = 
						{
							text = locationText,
							textStyle = "IGHeading1",
							color = {255,255,255,255},
							hAlign = "Left",
							vAlign = "Top",
						},
					},
					-- END LOCATION TEXT

					-- START SQUAD LIST
					SquadButtonFrame,
					-- END SQUAD LIST

					-- START BUTTONS
					{
						type = "Frame",
						name = "frmRightSideButtons",
						Layout =
						{
							pivot_XY = {0.0, 0.0},
							pos_XY = {x = 0, y = 0, xr = "px", yr = "px",},
							size_WH = {w = sectionWidRgt, h = 0, wr = "px", hr = "px",},
							pad_LT = {l = padAmount, t = padAmount, lr = "px", tr = "px"},
							pad_RB = {r = padAmount, b = padAmount, rr = "px", br = "px"},
						},
						autosize = 1,
						autoarrange = 1,
						arrangetype = "vert",
						;
						-- ENTER SECTOR
						{
							type = "TextButton",
							name = "m_btnLeaveMap",
							buttonStyle = "FEButtonStyle1_Alert_Outlined_Chipped",
							Layout =
							{
								pivot_XY = { 0.5, 0.0 },		
								pos_XY = {x = 0.5, y = 0, xr="par", yr="px",},
								size_WH = {w = sectionWidRgtInnr, h = 36, wr = "px", hr = "px"},
							},	
							helpTip = "Enter the selected sector.",
							helpTipTextLabel = "txtLblHELPTEXT",
							Text =
							{
								text = "Enter Sector",
							},
							onMouseClicked = "MainUI_ScarEvent(\"EnterSectorFromGalaxyMap()\")",
							enabled = enter_bool,
						},
						-- SQUAD MANAGER
						{
							type = "TextButton",
							name = "m_btnSquadMan",
							buttonStyle = "FEButtonStyle1_Outlined_Chipped",
							Layout =
							{
								pivot_XY = { 0.5, 0.0 },
								pos_XY = {x = 0.5, y = 0, xr="par", yr="px",},
								size_WH = {w = sectionWidRgtInnr, h = 36, wr = "px", hr = "px"},
							},	
							helpTip = "Switch to the fleet management screen. (BACKSLASH)",
							helpTipTextLabel = "txtLblHELPTEXT",
							Text =
							{
								text = "Fleet Manager",
							},
							hotKeyID = 177,			-- doesn't work
							onMouseClicked = SectorMapSquadMenuSwitch,
						},
						-- MAIN MENU
						{
							type = "TextButton",
							name = "m_btnMainMenu",
							buttonStyle = "FEButtonStyle1_Outlined",
							Layout =
							{
								pivot_XY = { 0.5, 0.0 },
								pos_XY = {x = 0.5, y = 0, xr="par", yr="px",},
								size_WH = {w = sectionWidRgtInnr, h = 36, wr = "px", hr = "px"},
							},	
							helpTip = "Open the main menu.",
							helpTipTextLabel = "txtLblHELPTEXT",
							Text =
							{
								text = "Main Menu",
							},
							onMouseClicked = "MainUI_UserEvent(eMenu)",
						},
						-- SAVE GAME
						{
							type = "TextButton",
							name = "m_btnSaveGame",
							buttonStyle = "FEButtonStyle1_Outlined",
							Layout =
							{
								pivot_XY = { 0.5, 0.0 },
								pos_XY = {x = 0.5, y = 0, xr="par", yr="px",},
								size_WH = {w = sectionWidRgtInnr, h = 36, wr = "px", hr = "px"},
							},	
							helpTip = "Save the game.",
							helpTipTextLabel = "txtLblHELPTEXT",
							Text =
							{
								text = "Save Game",
							},
							onMouseClicked = SaveGameMouseClick,
						},
						-- RELOAD GAME
						{
							type = "TextButton",
							name = "m_btnReloadGame",
							buttonStyle = "FEButtonStyle1_Outlined",
							Layout =
							{
								pivot_XY = { 0.5, 0.0 },
								pos_XY = {x = 0.5, y = 0, xr="par", yr="px",},
								size_WH = {w = sectionWidRgtInnr, h = 36, wr = "px", hr = "px"},
							},
							helpTip = "Reload the game from the last save.",
							helpTipTextLabel = "txtLblHELPTEXT",
							Text =
							{
								text = "Reload Game",
							},
							onMouseClicked = LoadGameMouseClick,
						},
--						-- TEST BUTTON
--						{
--							type = "TextButton",
--							name = "m_btnTestButton",
--							buttonStyle = "FEButtonStyle1_Outlined",
--							Layout =
--							{
--								pivot_XY = { 0.5, 0.0 },
--								pos_XY = {x = 0.5, y = 0, xr="par", yr="px",},
--								size_WH = {w = sectionWidRgtInnr, h = 36, wr = "px", hr = "px"},
--							},	
--							helpTip = "Runs some test code for testing purposes.",
--							helpTipTextLabel = "txtLblHELPTEXT",
--							Text =
--							{
--								text = "Test Button",
--							},
--							onMouseClicked =
--							[[
--								MainUI_ScarEvent("GUITestButtonAction()")
--							]],
--						},
						-- RELOAD SCREEN
						{
							type = "TextButton",
							name = "m_btnReloadScreen",
							buttonStyle = "FEButtonStyle1_Outlined",
							Layout =
							{
								pivot_XY = { 0.5, 0.0 },
								pos_XY = {x = 0.5, y = 0, xr="par", yr="px",},
								size_WH = {w = sectionWidRgtInnr, h = 36, wr = "px", hr = "px"},
							},	
							helpTip = "Reloads the current screen for testing purposes.",
							helpTipTextLabel = "txtLblHELPTEXT",
							Text =
							{
								text = "Reload Screen",
							},
							onMouseClicked = "MainUI_ScarEvent(\"ReloadVisibleScreens()\")",
						},
					},
					-- END BUTTONS

					-- START GAME TIME
					{
						type = "Frame",
						name = "frmRightSideTimeControls",
						Layout =
						{
							pivot_XY = {0.0, 0.0},
							pos_XY = {x = 0, y = 0, xr = "px", yr = "px",},
							size_WH = {w = sectionWidRgt, h = 0, wr = "px", hr = "px",},
							pad_LT = {l = padAmount, t = 0, lr = "px", tr = "px"},
							pad_RB = {r = padAmount, b = 0, rr = "px", br = "px"},
						},
						autosize = 1,
						autoarrange = 1,
						arrangetype = "vert",
						;
						-- CURRENT TIME DISPLAY
						{
							type = "TextLabel",
							name = "txtGameTimer",
							Layout =
							{
								pivot_XY = {0.0, 0.0},
								pos_XY = {x = 0, y = 0, xr = "px", yr = "px",},
								size_WH = {w = 1.0, h = 48, wr = "par", hr = "px",},
								pad_LT = {l = 16, t = 0, lr = "px", tr = "px"},
								pad_RB = {r = 16, b = 0, rr = "px", br = "px"},
							},
							autosize = 0,
							Text =
							{
								text = "GAME TIME: " .. disp_time(currentGameTime, 1),
								textStyle = "FEButtonTextStyle",
								color = {255,255,255,255},
								hAlign = "Center",
								vAlign = "Center",
							},
						},
						-- TIME BUTTONS
						{
							type = "Frame",
							name = "txtTimerButtons",
							Layout =
							{
								pivot_XY = {0.0, 0.0},
								pos_XY = {x = 0, y = 0, xr = "px", yr = "px",},
								size_WH = {w = 1.0, h = 48, wr = "par", hr = "px",},
								pad_LT = {l = 16, t = 0, lr = "px", tr = "px"},
								pad_RB = {r = 16, b = 0, rr = "px", br = "px"},
							},
							autoarrange = 1,
							arrangetype = "horiz",
							;
							-- TIME PAUSE
							{
								type = "Button",
								name = "m_btnTimePause",
								buttonStyle = "",
								Layout =
								{
									pivot_XY = { 0.0, 0.0 },
									pos_XY = {x = 0, y = 0, xr="px", yr="px",},
									size_WH = {w = 32, h = 32, wr = "px", hr = "px"},
								},
								BackgroundGraphic =
								{
									type = "Graphic",
									texture = [[data:ui\newui\ingameicons\time_pause_normal.tga]],
									textureUV = {0,0,256,256},
								},
								OverGraphic =
								{
									type = "Graphic",
									texture = [[data:ui\newui\ingameicons\time_pause_over.tga]],
									textureUV = {0,0,256,256},
								},
								PressedGraphic =
								{
									type = "Graphic",
									texture = [[data:ui\newui\ingameicons\time_pause_pressed.tga]],
									textureUV = {0,0,256,256},
								},
								helpTip = "Pause time.",
								helpTipTextLabel = "txtLblHELPTEXT",
								soundOnClicked = "SFX_MissionSelectClick",
								onMouseClicked = GameTimePauseClick,
							},
							-- TIME SLOWER
							{
								type = "Button",
								name = "m_btnTimeSlower",
								buttonStyle = "",
								Layout =
								{
									pivot_XY = { 0.0, 0.0 },
									pos_XY = {x = 0, y = 0, xr="px", yr="px",},
									size_WH = {w = 32, h = 32, wr = "px", hr = "px"},
								},
								BackgroundGraphic =
								{
									type = "Graphic",
									texture = [[data:ui\newui\ingameicons\time_reverse_normal.tga]],
									textureUV = {0,0,256,256},
								},
								OverGraphic =
								{
									type = "Graphic",
									texture = [[data:ui\newui\ingameicons\time_reverse_over.tga]],
									textureUV = {0,0,256,256},
								},
								PressedGraphic =
								{
									type = "Graphic",
									texture = [[data:ui\newui\ingameicons\time_reverse_pressed.tga]],
									textureUV = {0,0,256,256},
								},
								helpTip = "Slow down time.",
								helpTipTextLabel = "txtLblHELPTEXT",
								soundOnClicked = "SFX_MissionSelectClick",
								onMouseClicked = GameTimeSlowDownClick,
							},
							-- TIME RATE DISPLAY
							{
								type = "TextLabel",
								name = "txtTimeShowRate",
								Layout =
								{
									pivot_XY = {0.0, 0.0},
									pos_XY = {x = 0, y = 0, xr = "px", yr = "px",},
									size_WH = {w = 96, h = 32, wr = "px", hr = "px",},
								},
								autosize = 0,
								Text =
								{
									text = "",
									textStyle = "FEButtonTextStyle",
									color = {255,255,255,255},
									hAlign = "Center",
									vAlign = "Center",
								},
							},
							-- TIME FASTER
							{
								type = "Button",
								name = "m_btnTimeFaster",
								buttonStyle = "",
								Layout =
								{
									pivot_XY = { 0.0, 0.0 },
									pos_XY = {x = 0, y = 0, xr="px", yr="px",},
									size_WH = {w = 32, h = 32, wr = "px", hr = "px"},
								},
								BackgroundGraphic =
								{
									type = "Graphic",
									texture = [[data:ui\newui\ingameicons\time_forward_normal.tga]],
									textureUV = {0,0,256,256},
								},
								OverGraphic =
								{
									type = "Graphic",
									texture = [[data:ui\newui\ingameicons\time_forward_over.tga]],
									textureUV = {0,0,256,256},
								},
								PressedGraphic =
								{
									type = "Graphic",
									texture = [[data:ui\newui\ingameicons\time_forward_pressed.tga]],
									textureUV = {0,0,256,256},
								},
								helpTip = "Speed up time.",
								helpTipTextLabel = "txtLblHELPTEXT",
								soundOnClicked = "SFX_MissionSelectClick",
								onMouseClicked = GameTimeSpeedUpClick,
							},
						},
					},
					-- END GAME TIME
				},

				------------------------------------------------------------------------------------
				-- END RIGHT SIDE FRAME
				------------------------------------------------------------------------------------

			},
		},
	},
}
