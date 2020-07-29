dofilepath("data:scripts\\utilfunc.lua")
dofilepath("data:scripts\\TMG_objectdata.lua")
dofilepath("data:scripts\\TMG_initialstate.lua")
dofilepath("data:scripts\\TMG_initialfleet.lua")
dofilepath("player:TestMissionGrid\\TMG_savegame.lua")
dofilepath("data:scripts\\TMG_sectormap_proto.lua")

padAmount = 8
labelWid = 24
headerHgh = 36
sectionWidRgt = 256 - padAmount * 2
sectionWidRgtInnr = sectionWidRgt - padAmount * 2

main_button_text = ""
if (campaignIsStarted == 1) then
	main_button_text = "CONTINUE"
else
	main_button_text = "START"
end

MissionSelect =
{
	stylesheet = "HW2StyleSheet",
	Layout =
	{	
		pivot_XY = {0.5, 0.5},
		pos_XY = {x = 0.5, y = 0.5, xr = "scr", yr = "scr",},
		size_WH = {w = outerWid, h = outerHgh, wr = "px", hr = "px",},
	},
	pixelUVCoords = 1,
	;
	{
		type = "Frame",
		name = "frmTheRoot",
		Layout =
		{
			pivot_XY = {0.0, 0.0},
			pos_XY = {x = 0, y = 0, xr = "px", yr = "px",},
			size_WH = {w = outerWid, h = outerHgh, wr = "px", hr = "px",},
		},		
		autosize = 0,
		backgroundColor = "FEColorBackground2",
		;
		{
			type = "Frame",		
			name = "blah",	
			Layout =
			{
				pivot_XY = {0.0, 0.0},
				pos_XY = {x = gapX, y = gapY, xr = "px", yr = "px",},
				size_WH = {w = innerWid, h = innerHgh, wr = "px", hr = "px",},
			},
			;

			------------------------------------------------------------------------------------
			-- START MAP GRID
			------------------------------------------------------------------------------------

			--DEFINITION FOR: (frmRoot) (The window)
			{
				type = "Frame",		
				name = "frmRootMissionBox",	
				backgroundColor = "IGColorButton",
				Layout =
				{
					pivot_XY = {0.0, 0.0},
					pos_XY = {x = 0, y = 0, xr="px", yr="px",},
					size_WH = {w = innerHgh, h = innerHgh, wr = "px", hr = "px",},
				},
				;
				listHead,
				listBot,
				listShd,
--				listSel,
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
			-- START NAVIGATION BUTTON FRAME
			------------------------------------------------------------------------------------

			{
				type = "Frame",
				name = "frmRootbottombigfrm",
				Layout =
				{
					pivot_XY = {0.0, 0.0},
					pos_XY = {x = innerHgh + padAmount * 2, y = 0, xr = "px", yr = "px",},
					size_WH = {w = sectionWidRgt, h = innerHgh, wr = "px", hr = "px",},
				},
				BackgroundGraphic = BORDER_GRAPHIC_FRAME,
				backgroundColor = COLOR_BACKGROUND_PANEL,
				;

				-- START BUTTONS
				{
					type = "Frame",
					name = "frmRootbottombigfrmBlargl",
					Layout =
					{
						pivot_XY = {0.5, 0.5},
						pos_XY = {x = 0.5, y = 0.5, xr = "par", yr = "par",},
						size_WH = {w = sectionWidRgt, h = 0, wr = "px", hr = "px",},
						pad_LT = {l = padAmount, t = padAmount, lr = "px", tr = "px"},
						pad_RB = {r = padAmount, b = padAmount, rr = "px", br = "px"},
					},
					autosize = 1,
					autoarrange = 1,
					arrangetype = "vert",
					;

--					-- RELOAD SCREEN
--					{
--						type = "TextButton",
--						name = "m_btnScreen",
--						buttonStyle = "FEButtonStyle1_Outlined",
--						enabled = 1,
--						visible = 1,
--						ignored = 1,
--						Layout =
--						{
--							pivot_XY = { 0.5, 0.0 },		
--							pos_XY = {x = 0.5, y = 0, xr="par", yr="px",},
--							size_WH = {w = sectionWidRgtInnr, h = 36, wr = "px", hr = "px"},
--						},	
--						helpTip = "RELOADS THE CURRENT SCREEN FOR TESTING PURPOSES. MAY CAUSE THE GAME TO CRASH.",
--						helpTipTextLabel = "txtLblHELPTEXT",
--						Text =
--						{
--							text = "RELOAD SCREEN",
--						},
--						onMouseClicked = "UI_ReloadCurrentScreen()",
--						;
--					},

					-- GO BACK
					{
						type = "TextButton",
						name = "m_btnBack",
						buttonStyle = "FEButtonStyle1_Outlined",	
						Layout =
						{
							pivot_XY = { 0.5, 0.0 },		
							pos_XY = {x = 0.5, y = 0, xr="par", yr="px",},
							size_WH = {w = sectionWidRgtInnr, h = 36, wr = "px", hr = "px"},
						},	
						helpTip = "$3468",
						helpTipTextLabel = "txtLblHELPTEXT",
						Text =
						{
							text = "$2610", -- BACK
						},
						--onMouseClicked = "UI_ShowScreen(\"NewMainMenu\", eTransition)",
						;
					},



					-- START/CONTINUE MISSION
					{
						type = "TextButton",
						buttonStyle = "FEButtonStyle1_Alert_Outlined_Chipped",
						Layout =
						{
							pivot_XY = { 0.5, 0.0 },		
							pos_XY = {x = 0.5, y = 0, xr="par", yr="px",},
							size_WH = {w = sectionWidRgtInnr, h = 36, wr = "px", hr = "px"},
						},	
						name = "btnStartMission",
						helpTip = "CONTINUE THE CAMPAIGN",
						helpTipTextLabel = "txtLblHELPTEXT",
						Text =
						{
							text = main_button_text,
							--textStyle = "FEButtonTextStyle",
						},
						;
					},
					-- GAME TIME
					{
						type = "TextLabel",
						Layout =
						{
							pivot_XY = { 0.5, 0.0 },		
							pos_XY = {x = 0.5, y = 0, xr="par", yr="px",},
							size_WH = {w = sectionWidRgtInnr, h = 36, wr = "px", hr = "px"},
							pad_LT = {l = padAmount * 2, t = padAmount * 2, lr = "px", tr = "px"},
							pad_RB = {r = padAmount * 2, b = padAmount * 2, rr = "px", br = "px"},
						},
						autosize = 1,
						wrapping = 1,	
						name = "txtGameTimer",
						Text =
						{
							text = "GAME TIME: " .. disp_time(currentGameTime, 1),
							textStyle = "FEButtonTextStyle",
							color = {255,255,255,255},
							hAlign = "Center",
							vAlign = "Center",
						},
						;
					},
				},

				-- END BUTTONS
			},

			------------------------------------------------------------------------------------
			-- END NAVIGATION BUTTON FRAME
			------------------------------------------------------------------------------------

		},

		------------------------------------------------------------------------------------
		-- START HIDDEN - This frame can't be deleted, otherwise the game will crash. It needs to be hidden instead.
		------------------------------------------------------------------------------------

		{
			type = "Frame",
			size = {0,0},
			autosize = 0,
			visible = 0,
			ignored = 1,
			;			
			{
				type = "Frame",
				Layout = {
					size_WH = {	w = .75, h = 240/540, wr = "scr", hr = "scr" },
	--					size_WH = {	w = .75, h = .75, wr = "scr", hr = "scr" },
				},
				arrangetype = "horiz",
				arrangeSep = {	x=PANEL_PAD_HORIZ, y=PANEL_PAD_VERT, xr="scr", yr="scr",},
				;
				{
					type = "RmWindow",
					WindowTemplate = PANEL_WINDOWSTYLE,
					name = "lvlSelectInfoPanel",
					Layout = {
						size_WH = {	w = .35, h = 1, wr = "par", hr = "par" },
					},
					--backgroundColor = COLOR_BLUE_SOLID,
					arrangetype = "vert",
					;
					--DEFINITION FOR: (frm) Map
					{
						type = "Frame",
						Layout = {		
							size_WH = {	w = 1, h = 600.0, wr = "par", hr = "px" },
							lockAspect = 2,	
						},
						name = "frmMap",
						--backgroundColor = COLOR_GREEN_SOLID,
						;
						--DEFINITION FOR: (frmgr) 1m_mapb.tga
						{
							name = "frmgr1mmapbtga",
							type = "Frame",
							BackgroundGraphic = {
								type = "Graphic",
								texture = "Data:LevelData\\Multiplayer\\DefaultMapThumbnail.tga",
								uvRect = { 0, 1, 1, 0 },
							},

							Layout = {	size_WH = {	w = 1.0, h = 1.0, wr = "par", hr = "par" },},
							;
						},
					},

					--DEFINITION FOR: (frm) MapSub
					{
						type = "Frame",
						name = "frmMapSub",
						Layout =
						{
							size_WH = {	w = 1.0, h = 1.0, wr = "par", hr = "px" },
						},
						--backgroundColor = COLOR_RED_SOLID,
						arrangeweight = 1,
						;
					},
				},
				{
					type = "RmWindow",
					name = "txtLblChooseLevel",
					WindowTemplate = PANEL_WINDOWSTYLE,
					TitleText = Campaign_Choose_Text,
					Layout =
					{
						size_WH = {	w = 1, h = 1, wr = "px", hr = "par" },
					},
					arrangeweight=1,
					;
					-- This is the list box that will hold all of the mission items
					{
						type = "ListBox",
						listBoxStyle = "FEListBoxStyle_Bordered",
						Layout =
						{
							size_WH = {	w = 1, h = 1, wr = "par", hr = "par" },
						},
						name = "listTutorials",
						scrollBarSpace = 0,
						hugBottom = 1,
						;
					},
				},
			},
			-- LOAD SAVED CAMPAIGN
			-- todo: deleting this button completely causes an access violation when starting the game
			{
				type = "TextButton",
				name = "btnLoadSavedMission",	
				buttonStyle = "FEButtonStyle1_Outlined",
				enabled = 0,		-- has no effect for some reason
				visible = 0,		-- has no effect for some reason
				ignored = 1,		-- has no effect for some reason	
				Layout =
				{
					pivot_XY = { 0.5, 0.0 },		
					pos_XY = {x = 0.5, y = 0, xr="par", yr="px",},
					size_WH = {w = sectionWidRgtInnr, h = 36, wr = "px", hr = "px"},
				},	
				helpTip = "$3494",
				helpTipTextLabel = "txtLblHELPTEXT",
				Text =
				{
					text = "$3493",
					--textStyle = "FEButtonTextStyle",
				},
				;
			},
				
			-- RESET
			-- todo: would like to delete the custom save file using this button, but the necessary I/O functions are out-of-scope
			-- todo: deleting this button completely causes an access violation when starting the game
			{
				type = "TextButton",
				buttonStyle = "FEButtonStyle1_Outlined",
				enabled = 0,
				visible = 0,		-- has no effect for some reason
				ignored = 1,		-- has no effect for some reason
				Layout =
				{
					pivot_XY = { 0.5, 0.0 },		
					pos_XY = {x = 0.5, y = 0, xr="par", yr="px",},
					size_WH = {w = sectionWidRgtInnr, h = 36, wr = "px", hr = "px"},
				},	
				name = "txtBtnRESET",
				helpTip = "$3469",
				helpTipTextLabel = "txtLblHELPTEXT",
				Text =
				{
					text = "$3459",
					--textStyle = "FEButtonTextStyle",
				},
				onMouseClicked = "print('I CLICKED!!!')",
				;
			},
		},

		------------------------------------------------------------------------------------
		-- END HIDDEN
		------------------------------------------------------------------------------------

		------------------------------------------------------------------------------------
		-- START CLONE
		------------------------------------------------------------------------------------

		-- This is the list box item to clone that will contain all the information regarding the a tutorial		
		{
			type = "ListBoxItem",
			helpTipTextLabel = "txtLblHELPTEXT",
			autosize = 1,
			name = "itemTutorialToClone",
			visible = 0,
			pressedColor = {255,255,255,50,},
			pressedBorderColor = "FEColorHeading3",
			borderWidth = 1,
			allowDoubleClicks = 1,
			soundOnClicked = "SFX_MissionSelectClick",
			;
			{
				type = "Button",
				position = {5,5,},
				autosize = 1,
				;
				--DEFINITION FOR: (txtLbl) TutName
				{
					type = "TextLabel",
					position = {4,0,},
					size = {443,13,},
					name = "txtLblTutName",
					Text = 
					{
						textStyle = "FEButtonTextStyle",
						color = {0,0,0,255,},
						hAlign = "Left",
						offset = {4,0,},
					},
					;
				},
				--DEFINITION FOR: (txtLbl) TutDesc
				{
					type = "TextLabel",
					position = {4,15,},
					size = {452,35,},
					autosize = 1,
					wrapping = 1,
					minSize = {0,39,},
					name = "txtLblTutDesc",
					marginWidth = 4,
					marginHeight = 2,
					Text = 
					{
						textStyle = "FEButtonTextStyle",
						color = {255,255,255,255,},
						hAlign = "Left",
						vAlign = "Top",
					},
					;
				},
			},
		},

		------------------------------------------------------------------------------------
		-- END CLONE
		------------------------------------------------------------------------------------

	}
}
