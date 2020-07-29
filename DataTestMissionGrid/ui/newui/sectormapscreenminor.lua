--print("Reloading SectorMapScreenMinor")
gametypeScope = "minor"
dofilepath("data:scripts\\utilfunc.lua")
dofilepath("data:scripts\\TMG_objectdata.lua")
dofilepath("data:scripts\\TMG_initialstate.lua")
dofilepath("data:scripts\\TMG_initialfleet.lua")
dofilepath("player:TestMissionGrid\\TMG_savegame.lua")
dofilepath("player:TestMissionGrid\\TMG_tempsquadmenu.lua")
dofilepath("player:TestMissionGrid\\TMG_tempsectormap.lua")
dofilepath("data:scripts\\TMG_sectormap_proto.lua")

SectorMapScreenMinor = 
{
	soundOnShow = "SFX_ObjectiveMenuONOFF",
--	soundOnHide = "SFX_ObjectiveMenuONOFF",
	Layout =
	{	
--		pivot_XY = {0.0, 0.0},
--		pos_XY = {x = 0.0, y = 0.0, xr = "scr", yr = "scr",},
--		size_WH = {w = 1.0, h = 1.0, wr = "scr", hr = "scr",},
		pivot_XY = {0.5, 0.5},
		pos_XY = {x = 0.5, y = 0.5, xr = "par", yr = "par",},
		size_WH = {w = outerWid, h = outerHgh, wr = "px", hr = "px",},
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
			arrangetype = "horiz",
			;

			------------------------------------------------------------------------------------
			-- START MAP GRID
			------------------------------------------------------------------------------------

			{
				type = "Frame",
				--size = {742,338},
				name = "frmRootMissionBox",
				--backgroundColor = "FEColorBackground1",
				backgroundColor = "IGColorButton",
				autosize = 1,
				Layout =
				{
					pivot_XY = {0.0, 0.5},
					pos_XY = {x = 0.0, y = 0.5, xr="par", yr="par",},
					size_WH = {w = 768, h = 768, wr = "px", hr = "px",},
				},
				;
				listHead,
				listBot,
				listShd,
				listSel,
				listTxt,
				listPip,
				listArrw,
				listBut,
				listTop,
			},

			------------------------------------------------------------------------------------
			-- END MAP GRID
			------------------------------------------------------------------------------------

			------------------------------------------------------------------------------------
			-- START RIGHT SIDE FRAME
			------------------------------------------------------------------------------------

			{
				type = "Frame",
				name = "frmRootbottombigfrm",
				Layout =
				{
					pivot_XY = {0.0, 0.5},
					pos_XY = {x = 0.0, y = 0.5, xr = "px", yr = "par",},
					size_WH = {w = 256, h = 768, wr = "px", hr = "px",},
					pad_LT = {l = PANEL_PAD_HORIZ * 2, t = PANEL_PAD_VERT * 2, lr = "scr", tr = "scr"},
					pad_RB = {r = PANEL_PAD_HORIZ * 2, b = PANEL_PAD_VERT * 2, rr = "scr", br = "scr"},
				},
				autosize = 1,
				autoarrange = 1,
				arrangetype = "vert",
				;
				-- START BUTTONS
				{
					type = "Frame",
					name = "frmRootbottombigfrmBlargl",
					Layout =
					{
						pivot_XY = {0.0, 0.0},
						pos_XY = {x = 0.0, y = 0, xr = "par", yr = "px",},
						pad_LT = {l = PANEL_PAD_HORIZ, t = PANEL_PAD_VERT, lr = "scr", tr = "scr"},
						pad_RB = {r = PANEL_PAD_HORIZ, b = PANEL_PAD_VERT, rr = "scr", br = "scr"},
					},
					autosize = 1,
					BackgroundGraphic = BORDER_GRAPHIC_FRAME,
					backgroundColor = COLOR_BACKGROUND_PANEL,
					arrangetype = "vert",
					;
					-- LEAVE MAP
					{
						type = "TextButton",
						name = "m_btnLeaveMap",
						buttonStyle = "FEButtonStyle1_Alert_Outlined_Chipped",
						Layout =
						{
							pivot_XY = { 0.5, 0.0 },		
							pos_XY = {x = 0.5, y = 0, xr="par", yr="px",},
							size_WH = {w = NAVIGATION_BUTTON_WIDTH, h = STD_BUTTON_HEIGHT, wr = "scr", hr = "scr"},
						},	
						helpTip = "Switch to the galactic map.",
						helpTipTextLabel = "txtLblHELPTEXT",
						Text =
						{
							text = "Leave Map",
						},
						onMouseClicked = LeaveTheMapButton,
						enabled = allowedToLeaveMap,
					},
					-- SWITCH TABS
					{
						type = "TextButton",
						name = "m_btnSquadMan",
						buttonStyle = "FEButtonStyle1_Outlined_Chipped",
						Layout =
						{
							pivot_XY = { 0.5, 0.0 },
							pos_XY = {x = 0.5, y = 0, xr="par", yr="px",},
							size_WH = {w = NAVIGATION_BUTTON_WIDTH, h = STD_BUTTON_HEIGHT, wr = "scr", hr = "scr"},
						},	
						helpTip = "Switch to the fleet management screen.",
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
							pos_XY = {x=0.5, y=0.0, xr="par", yr="px",},
							size_WH = {w = NAVIGATION_BUTTON_WIDTH, h = STD_BUTTON_HEIGHT, wr = "scr", hr = "scr"},
						},	
						helpTip = "Open the main menu.",
						helpTipTextLabel = "txtLblHELPTEXT",
						Text =
						{
							text = "Main Menu",
						},
						onMouseClicked = "MainUI_UserEvent(eMenu)",
					},
--					-- SAVE GAME
--					{
--						type = "TextButton",
--						name = "m_btnSaveGame",
--						buttonStyle = "FEButtonStyle1_Outlined",
--						Layout =
--						{
--							pivot_XY = { 0.5, 0.0 },
--							pos_XY = {x=0.5, y=0.0, xr="par", yr="px",},
--							size_WH = {w = NAVIGATION_BUTTON_WIDTH, h = STD_BUTTON_HEIGHT, wr = "scr", hr = "scr"},
--						},
--						helpTip = "Save the game.",
--						helpTipTextLabel = "txtLblHELPTEXT",
--						Text =
--						{
--							text = "Save Game",
--						},
--						onMouseClicked = SaveGameMouseClick,
--					},
--					-- RELOAD GAME
--					{
--						type = "TextButton",
--						name = "m_btnReloadGame",
--						buttonStyle = "FEButtonStyle1_Outlined",
--						Layout =
--						{
--							pivot_XY = { 0.5, 0.0 },
--							pos_XY = {x=0.5, y=0.0, xr="par", yr="px",},
--							size_WH = {w = NAVIGATION_BUTTON_WIDTH, h = STD_BUTTON_HEIGHT, wr = "scr", hr = "scr"},
--						},	
--						helpTip = "Reload the game from the last save.",
--						helpTipTextLabel = "txtLblHELPTEXT",
--						Text =
--						{
--							text = "Reload Game",
--						},
--						onMouseClicked = LoadGameMouseClick,
--					},
					-- SPACER
					{
						type = "Frame",
						name = "m_btnSpacer",
						Layout =
						{
							pivot_XY = { 0.5, 0.0 },
							pos_XY = {x=0.5, y=0.0, xr="par", yr="px",},
							size_WH = {w = NAVIGATION_BUTTON_WIDTH, h = STD_BUTTON_HEIGHT, wr = "scr", hr = "scr"},
						},	
					},
--					-- TEST BUTTON
--					{
--						type = "TextButton",
--						name = "m_btnReloadScreen",
--						buttonStyle = "FEButtonStyle1_Outlined",
--						Layout =
--						{
--							pivot_XY = { 0.5, 0.0 },
--							pos_XY = {x=0.5, y=0.0, xr="par", yr="px",},
--							size_WH = {w = NAVIGATION_BUTTON_WIDTH, h = STD_BUTTON_HEIGHT, wr = "scr", hr = "scr"},
--						},	
--						helpTip = "Runs some test code for testing purposes.",
--						helpTipTextLabel = "txtLblHELPTEXT",
--						Text =
--						{
--							text = "Test Button",
--						},
--						onMouseClicked =
--						[[
--							MainUI_ScarEvent("GUITestButtonAction()")
--						]],
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
--							size_WH = {w = NAVIGATION_BUTTON_WIDTH, h = STD_BUTTON_HEIGHT, wr = "scr", hr = "scr"},
--						},	
--						helpTip = "Reloads the current screen for testing purposes.",
--						helpTipTextLabel = "txtLblHELPTEXT",
--						Text =
--						{
--							text = "Reload Screen",
--						},
--						onMouseClicked = "MainUI_ScarEvent(\"ReloadVisibleScreens()\")",
--					},
					-- CLOSE
					{
						type = "TextButton",
						name = "m_btnCancel",
						buttonStyle = "FEButtonStyle1_Alert_Outlined_Chipped",
						Layout =
						{
							pivot_XY = { 0.5, 0.0 },
							pos_XY = {x=0.5, y=0.0, xr="par", yr="px",},
							size_WH = {w = NAVIGATION_BUTTON_WIDTH, h = STD_BUTTON_HEIGHT, wr = "scr", hr = "scr"},
						},	
						helpTip = "Close the map screen.",
						helpTipTextLabel = "txtLblHELPTEXT",
						Text =
						{
							text = "Close",
						},
						hotKeyID = 177,			-- doesn't work
						onMouseClicked = SectorMapScreenToggle,
					},
				},
				-- END BUTTONS
				-- START GAME TIME
				{
					type = "TextLabel",
					Layout =
					{
						pivot_XY = {0.0, 0.0},
						pos_XY = {x = 0, y = 0, xr = "px", yr = "px",},
						size_WH = {w = 1.0, h = 100, wr = "par", hr = "px",},
						pad_LT = {l = PANEL_PAD_HORIZ, t = PANEL_PAD_VERT, lr = "scr", tr = "scr"},
						pad_RB = {r = PANEL_PAD_HORIZ, b = PANEL_PAD_VERT, rr = "scr", br = "scr"},
					},
					autosize = 0,
					name = "txtGameTimer",
					Text =
					{
						text = "GAME TIME: " .. legibleGameTime,
						textStyle = "FEButtonTextStyle",
						color = {255,255,255,255},
						hAlign = "Center",
						vAlign = "Center",
					},
					;
				},
				-- END GAME TIME
			},

			------------------------------------------------------------------------------------
			-- END RIGHT SIDE FRAME
			------------------------------------------------------------------------------------

		},
	},
}
