dofilepath("data:ui\\newui\\Styles\\HWRM_Style\\HWRMDefines.lua")		-- the in-game map screen should not load this
dofilepath("data:scripts\\TMG_campaigndata.lua")			-- the in-game map screen should not load this
dofilepath("data:scripts\\TMG_interfacescripts.lua")		-- the in-game map screen should not load this

numMissionCols = campaignTable.numMissionCols
numMissionRows = campaignTable.numMissionRows
missionRecord = campaignTable.record
useThumbnails = campaignTable.useThumbnails
useBackground = campaignTable.useBackground
backgroundImg = campaignTable.background
backgroundUV = campaignTable.backgroundUV

missionTable = {}
for j = 1, numMissionRows do
	missionTable[j] = {}
	for k = 1, numMissionCols do
		local this_mission = campaignTable.missions[j][k]
		missionTable[j][k] = {}
		missionTable[j][k].title = this_mission.displayName
		missionTable[j][k].description = this_mission.description
		missionTable[j][k].thumbnail = this_mission.thumb
		missionTable[j][k].thumbuv = this_mission.thumbUV
	end
end

paneX = 768-32
paneY = 768-32
gridX = numMissionCols
gridY = numMissionRows
sizeX = paneX/gridX
sizeY = paneY/gridY
headLftX = 32
headLftY = sizeY
headTopX = sizeX
headTopY = 32
labelHgh = 24
colLabels = {"A","B","C","D","E","F","G","H",}

innerWid = 1024
innerHgh =  768
gapX = 8
gapY = 8
outerWid = 1024 + gapX * 2
outerHgh =  768 + gapY * 2

headCol1 = {255*2/3, 215*2/3, 0, 255}
headCol2 = {255*3/3, 215*3/3, 0, 255}
--headCol1 = {108, 31, 0, 255}
--headCol2 = {27, 69, 85, 255}


--------------------------------------------------------------------------------
-- BOTTOM LAYER, TOP LAYER AND GALAXY MAP
--------------------------------------------------------------------------------

listBot =
{
	type = "Frame",		
	name = "frmBackgroundImageLayer",
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = headLftX, y = headTopY, xr="px", yr="px",},
		size_WH = {w = paneX, h = paneY, wr = "px", hr = "px",},
	},
	BackgroundGraphic =
	{
		type = "Graphic",
		texture = backgroundImg,
		textureUV = backgroundUV,
	},
}

listTop =
{
	type = "Frame",		
	name = "frmMouseShieldLayer",
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = headLftX, y = headTopY, xr="px", yr="px",},
		size_WH = {w = paneX, h = paneY, wr = "px", hr = "px",},
	},
}

if (useBackground == 44) then
	listBot.BackgroundGraphic =
	{
		type = "Graphic",
		texture = backgroundImg,
		textureUV = backgroundUV,
	}
end


--------------------------------------------------------------------------------
-- COLUMN AND ROW HEADERS
--------------------------------------------------------------------------------

listHead =
{
	type = "Frame",		
	name = "frmCellHeader",
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = 0, y = 0, xr="px", yr="px",},
		size_WH = {w = paneX + headLftX, h = paneY + headTopY, wr = "px", hr = "px",},
	},
	backgroundColor = "IGColorButton",
}

-- vertical headers
countCell = 1
for j = 1, numMissionRows do
	local countY = j - 1
	local headBack = {}
	-- change the appearance based on whether the player is in that sector
	if (j == currentSectorRow) then
		headBack = headCol1
	else
		headBack = headCol1
	end

	listHead[countCell] =
	{
		type = "TextLabel",
		name = "headerLabelVert_" .. j,
		Layout =
		{
			pivot_XY = {0.0, 0.0},
			pos_XY = {x = 0 + 2, y = countY * headLftY + 2 + headTopY, xr="px", yr="px",},
			size_WH = {w = headLftX - 4, h = headLftY - 4, wr = "px", hr = "px",},
		},
		autosize = 0,
		wrapping = 0,	
		backgroundColor = headBack,
		Text =
		{
			text = j,
			textStyle = "FEButtonTextStyle",
			color = {0,0,0,255},
			hAlign = "Center",
			vAlign = "Center",
		},
		;
	}
	countCell = countCell + 1
end

-- horizontal headers
for k = 1, numMissionCols do
	local countX = k - 1
	local headBack = {}
	-- change the appearance based on whether the player is in that sector
	if (k == currentSectorCol) then
		headBack = headCol1
	else
		headBack = headCol1
	end

	listHead[countCell] =
	{
		type = "TextLabel",
		name = "headerLabelHorz_" .. k,
		Layout =
		{
			pivot_XY = {0.0, 0.0},
			pos_XY = {x = countX * headTopX + 2 + headLftX, y = 0 + 2, xr="px", yr="px",},
			size_WH = {w = headTopX - 4, h = headTopY - 4, wr = "px", hr = "px",},
		},
		autosize = 0,
		wrapping = 0,	
		backgroundColor = headBack,
		Text =
		{
			text = colLabels[k],
			textStyle = "FEButtonTextStyle",
			color = {0,0,0,255},
			hAlign = "Center",
			vAlign = "Center",
		},
		;
	}
	countCell = countCell + 1
end

-- corner header
listHead[1 + numMissionRows + numMissionCols] =
{
	type = "TextLabel",
	name = "headerLabelCorner",
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = 2, y = 2, xr="px", yr="px",},
		size_WH = {w = headLftX - 4, h = headTopY - 4, wr = "px", hr = "px",},
	},
	autosize = 0,
	wrapping = 0,	
	backgroundColor = headCol1,
	Text =
	{
		text = "",
		textStyle = "FEButtonTextStyle",
		color = {0,0,0,255},
		hAlign = "Center",
		vAlign = "Center",
	},
	visible = 0,
	;
}


--------------------------------------------------------------------------------
-- LARGE ARROWS AND TARGET
--------------------------------------------------------------------------------

arrowSize = sizeX/3 * 2

listArrw =
{
	type = "Frame",
	name = "frmArrow",
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = headLftX, y = headTopY, xr="px", yr="px",},
		size_WH = {w = paneX, h = paneY, wr = "px", hr = "px",},
	},
}

-- the first row and column should not be visible for the South and East arrows
-- the last row and column should not be visible for the North and West arrows
countCell = 1
for j = 1, numMissionRows do
	local transY = j - 0.5
	local transYS = j
	local transYN = j - 1
	for k = 1, numMissionCols do
		local transX = k - 0.5
		local transXE = k
		local transXW = k - 1
		local arrow_visibility = {0,0,0,0,0}
		local arrow_count =  {0,0,0,0,0}
--		----------------------------------------------------------------
--		if ((j == 2) and (k == 2)) then
--			arrow_visibility = {1,1,1,1,1}
--			arrow_count =  {1,1,1,1,1}
--		end
--		----------------------------------------------------------------
		local player_index = 0
		local this_player = squadShips[player_index + 1]
		for i, this_squad in this_player do
			if (this_squad ~= nil) then
				local this_path = this_squad.travel.path
				local this_path_length = getn(this_path)
				local this_destination = this_path[1]
				local this_destination_row = this_destination[1]
				local this_destination_col = this_destination[2]
				local this_direction = this_destination[3]		-- 0 = loose, 1 = East, 2 = South, 3 = West, 4 = North, 5 = center
				local this_inhyperspace = this_squad.travel.inhyperspace
				if ((this_destination_row == j) and (this_destination_col == k)) then
					if (this_inhyperspace == 0) then
						this_direction = 5
					end
					arrow_visibility[this_direction] = 1
					arrow_count[this_direction] = arrow_count[this_direction] + 1
				end
			end
		end
		-- 0 = loose, 1 = East, 2 = South, 3 = West, 4 = North, 5 = center
		for i = 1, 5 do
			local arrow_xy = {}
			if (i == 1) then
				arrow_xy = {x = transXE * sizeX, y = transY * sizeY + labelHgh/2, xr="px", yr="px",}
			elseif (i == 2) then
				arrow_xy = {x = transX * sizeX, y = transYS * sizeY, xr="px", yr="px",}
			elseif (i == 3) then
				arrow_xy = {x = transXW * sizeX, y = transY * sizeY + labelHgh/2, xr="px", yr="px",}
			elseif (i == 4) then
				arrow_xy = {x = transX * sizeX, y = transYN * sizeY, xr="px", yr="px",}
			elseif (i == 5) then
				arrow_xy = {x = transX * sizeX, y = transY * sizeY + labelHgh/2, xr="px", yr="px",}
			end
			listArrw[countCell] =
			{
				type = "Frame",
				name = "frmArrow_" .. j .. "_" .. k .. "_" .. i,
				Layout =
				{
					pivot_XY = {0.5, 0.5},
					pos_XY = arrow_xy,
					size_WH = {w = arrowSize, h = arrowSize, wr = "px", hr = "px",},
				},
				-- todo: make sure that TGA images are saved without compression, and with the "bottom up" setting
				BackgroundGraphic =
				{
					type = "Graphic",
					texture = "data:ui\\newui\\ingameicons\\double_arrow_" .. i .. ".tga",
					textureUV = {0,0,512,512},
				},
				visible = arrow_visibility[i],
				;
				{
					type = "TextLabel",
					name = "lblNumber_" .. j .. "_" .. k .. "_" .. i,
					Layout =
					{
						pivot_XY = { 0.5, 0.5 },
						pos_XY = { x = 0.5, y = 0.5, xr = "par", yr = "par" },
						size_WH = { w = arrowSize, h = arrowSize, wr = "px", hr = "px" },
					},
					BackgroundGraphic =
					{
						type = "Graphic",
						texture = "data:ui\\newui\\ingameicons\\text_background.tga",
						textureUV = {0,0,512,512},
					},
					Text =
					{
						text = arrow_count[i],
						font = "ListBoxItemFont",
						hAlign = "Center",
						vAlign = "Center",
						color = {255,255,255,255},
					},
				}
			}
			countCell = countCell + 1
		end
	end
end


--------------------------------------------------------------------------------
-- SMALL ARROWS AND LINES
--------------------------------------------------------------------------------

if (gametypeScope == "major") then
	listLine =
	{
		type = "Frame",
		name = "frmLines",
		Layout =
		{
			pivot_XY = {0.0, 0.0},
			pos_XY = {x = headLftX, y = headTopY, xr="px", yr="px",},
			size_WH = {w = paneX, h = paneY, wr = "px", hr = "px",},
		},
	}

	countCell = 1
	for j = 1, numMissionRows do
		local transY = j - 0.5
		for k = 1, numMissionCols do
			local transX = k - 0.5
			-- 0 == loose, 1 = East, 2 = South, 3 = West, 4 = North, 5 = center
			for l = 1, 5 do
				-- 0 == loose, 1 = East, 2 = South, 3 = West, 4 = North, 5 = center
				for m = 1, 5 do
					if (l ~= m) then
						listLine[countCell] =
						{
							type = "Frame",
							name = "frmLine_" .. j .. "_" .. k .. "_" .. l .. "_" .. m,
							Layout =
							{
								pivot_XY = {0.5, 0.5},
								pos_XY = {x = transX * sizeX, y = transY * sizeY + labelHgh/2, xr="px", yr="px",},
								size_WH = {w = sizeX, h = sizeY, wr = "px", hr = "px",},
							},
							BackgroundGraphic =
							{
								type = "Graphic",
								texture = "data:ui\\newui\\ingameicons\\line_" .. abbvDirections[l] .. "_" .. abbvDirections[m] .. ".tga",
								textureUV = {0,0,256,256},
							},
							visible = 0,
						}
						countCell = countCell + 1
					end
				end
			end
			listLine[countCell] =
			{
				type = "Frame",
				name = "frmLine_" .. j .. "_" .. k .. "_" .. 5 .. "_" .. 5,
				Layout =
				{
					pivot_XY = {0.5, 0.5},
					pos_XY = {x = transX * sizeX, y = transY * sizeY + labelHgh/2, xr="px", yr="px",},
					size_WH = {w = sizeX, h = sizeY, wr = "px", hr = "px",},
				},
				BackgroundGraphic =
				{
					type = "Graphic",
					texture = "data:ui\\newui\\ingameicons\\line_" .. abbvDirections[5] .. "_" .. abbvDirections[5] .. ".tga",
					textureUV = {0,0,256,256},
				},
				visible = 0,
			}
			countCell = countCell + 1
		end
	end
end

--------------------------------------------------------------------------------
-- SHIP PIPS
-- docked ships inside docked ships will cause this routine to fail (though it could easily be made to work)
--------------------------------------------------------------------------------

pips_per_row = 24
pip_rows = 0
pip_cols = 0
pip_padd = 6

listPip =
{
	type = "Frame",
	name = "frmArrow",
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = headLftX, y = headTopY, xr="px", yr="px",},
		size_WH = {w = paneX, h = paneY, wr = "px", hr = "px",},
	},
}

function CountLocalShips(ships_table, j, k)
	for i = 1, getn(ships_table) do
		local this_ship = ships_table[i]
		local this_type = this_ship.type
		local this_play = this_ship.playerindex
		local this_hold = this_ship.shiphold
		local this_hasshiphold = objectData.ships[this_type].hasshiphold
		local this_canhyperspace = objectData.ships[this_type].canhyperspace
		local this_candock = objectData.ships[this_type].candock
		local this_size = 1
		if (this_hasshiphold == 1) then
			this_size = 4
		elseif (this_canhyperspace == 1) then
			this_size = 3
		elseif (this_candock == 1) then
			this_size = 2
		end
		local_pips_table[j][k][this_play + 1][this_size] = local_pips_table[j][k][this_play + 1][this_size] + 1
		CountLocalShips(this_hold, j, k)
	end
end

function CountSquadShips(ships_table, j, k)
	for i = 1, getn(ships_table) do
		local this_ship = ships_table[i]
		local this_type = this_ship.type
		local this_play = this_ship.playerindex
		local this_hold = this_ship.shiphold
		local this_hasshiphold = objectData.ships[this_type].hasshiphold
		local this_canhyperspace = objectData.ships[this_type].canhyperspace
		local this_candock = objectData.ships[this_type].candock
		local this_size = 1
		if (this_hasshiphold == 1) then
			this_size = 4
		elseif (this_canhyperspace == 1) then
			this_size = 3
		elseif (this_candock == 1) then
			this_size = 2
		end
		squad_pips_table[j][k][this_play + 1][this_size] = squad_pips_table[j][k][this_play + 1][this_size] + 1
		CountSquadShips(this_hold, j, k)
	end
end

-- tables
local_pips_table = {}
squad_pips_table = {}
for j = 1, numMissionRows do
	local_pips_table[j] = {}
	squad_pips_table[j] = {}
	for k = 1, numMissionCols do
		local_pips_table[j][k] = {}		-- need to expand this when adding additional players
		squad_pips_table[j][k] = {}		-- need to expand this when adding additional players
		for l = 1, playerMax do
			local_pips_table[j][k][l] = {}
			squad_pips_table[j][k][l] = {}
			for m = 1, shipSizes do
				local_pips_table[j][k][l][m] = 0
				squad_pips_table[j][k][l][m] = 0
			end
		end
	end
end

-- local ships
for j = 1, numMissionRows do
	local this_row = localShips[j]
	for k = 1, numMissionCols do
		local this_sector = this_row[k]
		CountLocalShips(this_sector, j, k)
	end
end

-- squad ships
for j, this_player in squadShips do
	for k, this_squad in this_player do
		if (this_squad ~= nil) then
			local this_path = this_squad.travel.path
			local this_destination = this_path[1]
			local this_destination_row = this_destination[1]
			local this_destination_col = this_destination[2]
			local this_inhyperspace = this_squad.travel.inhyperspace
			local this_ships = this_squad.ships
			if (j == 1) then
				if (this_inhyperspace == 0) then
					CountSquadShips(this_ships, this_destination_row, this_destination_col)
				end
			else
				CountSquadShips(this_ships, this_destination_row, this_destination_col)
			end
		end
	end
end

-- map cells
countCell = 1
for j = 1, numMissionRows do
	local this_row = localShips[j]
	for k = 1, numMissionCols do
		local count_pips = 1
		local this_sector = this_row[k]
		for l = 1, playerMax do
			for m = 1, shipSizes do
				local this_graph = ""
				if (m == 1) then
					if     (l == 1) then
						this_graph = [[data:ui\newui\ingameicons\pip_solid_green.tga]]
					elseif (l == 2) then
						this_graph = [[data:ui\newui\ingameicons\pip_solid_red.tga]]
					elseif (l == 3) then
						this_graph = [[data:ui\newui\ingameicons\pip_solid_yellow.tga]]
					end
				elseif (m == 2) then
					if     (l == 1) then
						this_graph = [[data:ui\newui\ingameicons\pip_trig_green.tga]]
					elseif (l == 2) then
						this_graph = [[data:ui\newui\ingameicons\pip_trig_red.tga]]
					elseif (l == 3) then
						this_graph = [[data:ui\newui\ingameicons\pip_trig_yellow.tga]]
					end
				elseif (m == 3) then
					if     (l == 1) then
						this_graph = [[data:ui\newui\ingameicons\pip_cross_green.tga]]
					elseif (l == 2) then
						this_graph = [[data:ui\newui\ingameicons\pip_cross_red.tga]]
					elseif (l == 3) then
						this_graph = [[data:ui\newui\ingameicons\pip_cross_yellow.tga]]
					end
				elseif (m == 4) then
					if     (l == 1) then
						this_graph = [[data:ui\newui\ingameicons\pip_open_green.tga]]
					elseif (l == 2) then
						this_graph = [[data:ui\newui\ingameicons\pip_open_red.tga]]
					elseif (l == 3) then
						this_graph = [[data:ui\newui\ingameicons\pip_open_yellow.tga]]
					end
				end
				local pips_num = local_pips_table[j][k][l][m] + squad_pips_table[j][k][l][m]
				for n = 1, pips_num do
					pip_row = ceil(count_pips/pips_per_row)
					pip_col = mod(count_pips, pips_per_row)
					listPip[countCell] =
					{
						type = "Frame",
						name = "frmShipPip_" .. j .. "_" .. k .. "_" .. count_pips,
						Layout =
						{
							pivot_XY = {0.5, 0.5},
							pos_XY = {x = k * sizeX - pip_col * pip_padd, y = j * sizeY - pip_row * pip_padd, xr="px", yr="px",},
							size_WH = {w = 4, h = 4, wr = "px", hr = "px",},
						},
						BackgroundGraphic =
						{
							type = "Graphic",
							texture = this_graph,
							textureUV = {0,0,4,4},
						},
						visible = 1,
					}
					count_pips = count_pips + 1
					countCell = countCell + 1
				end
			end
		end
	end
end


-------------------------------------------------------------------------------
-- BUTTONS, TEXTS AND GRAYISH TOP LAYER
--------------------------------------------------------------------------------

listWarn =
{
	type = "Frame",		
	name = "frmMapWar",
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = headLftX, y = headTopY, xr="px", yr="px",},
		size_WH = {w = paneX, h = paneY, wr = "px", hr = "px",},
	},
}

listBut =
{
	type = "Frame",		
	name = "frmMapBut",
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = headLftX, y = headTopY, xr="px", yr="px",},
		size_WH = {w = paneX, h = paneY, wr = "px", hr = "px",},
	},
}

listTxt =
{
	type = "Frame",
	name = "frmMapTxt",
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = headLftX, y = headTopY, xr="px", yr="px",},
		size_WH = {w = paneX, h = paneY, wr = "px", hr = "px",},
	},
}

listSel =
{
	type = "Frame",
	name = "frmMapTop",
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = headLftX, y = headTopY, xr="px", yr="px",},
		size_WH = {w = paneX, h = paneY, wr = "px", hr = "px",},
	},
}

listShd =
{
	type = "Frame",
	name = "frmMapTop",
	Layout =
	{
		pivot_XY = {0.0, 0.0},
		pos_XY = {x = headLftX, y = headTopY, xr="px", yr="px",},
		size_WH = {w = paneX, h = paneY, wr = "px", hr = "px",},
	},
}

countCell = 1
for j = 1, numMissionRows do
	for k = 1, numMissionCols do
		local kCount = missionTable[j][k]
		local squad_pips = squad_pips_table[j][k][1]
		local squad_num = squad_pips[1] + squad_pips[2] + squad_pips[3] + squad_pips[4]
		local local_pips = local_pips_table[j][k][1]
		local local_num = local_pips[1] + local_pips[2] + local_pips[3] + local_pips[4]
		local countX = k - 1
		local countY = j - 1
		local cellHelpTip = ""
		local headBack = {}
		local popuBack = {}
		local overBack = {255,255,255,32}
		local toggleSelected = 0
		-- change the appearance based on whether the sector is selected/pressed
		if ((j == currentSectorRow) and (k == currentSectorCol)) then
			toggleSelected = 1
		else
			toggleSelected = 0
		end
		-- change the appearance based on whether there are any squads in the sector
		if (squad_num > 0) then
			headBack = {255, 215, 0, 255}
			bordBack = {255, 215, 0, 255}
		else
			headBack = {112, 157, 180, 255}
			bordBack = {255, 215, 0, 255}
		end
		-- change the appearance based on whether the sector has been visited
		if (sectorsExplored[j][k] == 1) then
--			popuBack = {255,255,255,32}
			popuBack = {255,255,255,0}
		else
--			popuBack = {0,0,0,32}
			popuBack = {0,0,0,192}
		end

		listWarn[countCell] =
		{
			type = "TextButton",
			buttonStyle = "FEButtonStyle1_CombatWarning",
			toggleButton = 1,
			name = "missionWarn_" .. j .. "_" .. k,
			Layout =
			{
				pivot_XY = {0.5, 0.5},
				pos_XY = {x = (countX+1/2) * sizeX, y = (countY+1/2) * sizeY + labelHgh/2, xr="px", yr="px",},
				size_WH = {w = sizeX/3, h = sizeY/3, wr = "px", hr = "px",},
			},
			Text =
			{
				text = "!",
				textStyle = "RM_MenuButton_TextStyle",
				hAlign = "Center",
				vAlign = "Center",
			},
			visible = 0,
		}

		listBut[countCell] =
		{
			type = "Button",
			name = "missionBut_" .. j .. "_" .. k,
			Layout =
			{
				pivot_XY = {0.0, 0.0},
				pos_XY = {x = countX * sizeX, y = countY * sizeY, xr="px", yr="px",},
				size_WH = {w = sizeX, h = sizeY, wr = "px", hr = "px",},
			},
			backgroundColor = {0,0,0,0},
			borderColor = {0,0,0,0},
			borderWidth = 0,
			helpTip = cellHelpTip,
			helpTipTextLabel = "txtLblHELPTEXT",
			soundOnClicked = "SFX_MissionSelectClick",
			onMousePressed	= "MainUI_ScarEvent(\"MouseClickSectorMapButton(" .. j .. ", " .. k .. ")\")",
			onMouseEnter	= "MainUI_ScarEvent(\"MouseEnterSectorMapButton(" .. j .. ", " .. k .. ")\")",
			onMouseExit	= "MainUI_ScarEvent(\"MouseExitSectorMapButton(" .. j .. ", " .. k .. ")\")",
		}

		listTxt[countCell] =
		{
			type = "Frame",
			name = "missionTxt_" .. j .. "_" .. k,
			Layout =
			{
				pivot_XY = {0.0, 0.0},
				pos_XY = {x = countX * sizeX + 2, y = countY * sizeY + 2, xr="px", yr="px",},
				size_WH = {w = sizeX - 4, h = sizeY - 4, wr = "px", hr = "px",},
			},
			;
			-- SECTOR HEADER
			{
				type = "TextLabel",
				name = "txtLblTutHead_" .. j .. "_" .. k,
				Layout =
				{
					pivot_XY = {0.0, 0.0},
					pos_XY = {x = 0, y = 0, xr="px", yr="px",},
					size_WH = {w = sizeX - 4, h = labelHgh, wr = "px", hr = "px",},
				},
				autosize = 0,
				wrapping = 1,	
				backgroundColor = headBack,
				marginWidth = 4,
				marginHeight = 2,
				Text =
				{
					-- I want to concatenate this with Localization ID number $3495, but don't know how.
					text = kCount.title,
					textStyle = "FEButtonTextStyle",
					color = {0,0,0,255},
					hAlign = "Left",
					offset = {4,0},
				},
				;
			},
			-- SECTOR DESCRIPTION
			{
				type = "TextLabel",
				name = "txtLblTutDesc_" .. j .. "_" .. k,
				Layout =
				{
					pivot_XY = {0.0, 0.0},
					pos_XY = {x = 0, y = 28, xr="px", yr="px",},
					size_WH = {w = sizeX - 4, h = sizeY - labelHgh, wr = "px", hr = "px",},
				},
				autosize = 0,
				wrapping = 1,	
				marginWidth = 4,
				marginHeight = 2,
				dropShadow = 1,
				Text =
				{
					text = kCount.description,		
					textStyle = "FEButtonTextStyle",
					color = {255,255,255,255},
					hAlign = "Left",
					vAlign = "Top",
				},
				;
			},
		}
		if (useThumbnails == 1) then
			listTxt[countCell].BackgroundGraphic =
			{
				type = "Graphic",
				texture = kCount.thumbnail,
				textureUV = kCount.thumbuv,
			}
		end

		listSel[countCell] =
		{
			type = "Button",
			name = "missionTop_" .. j .. "_" .. k,
			Layout =
			{
				pivot_XY = {0.0, 0.0},
				pos_XY = {x = countX * sizeX, y = countY * sizeY, xr="px", yr="px",},
				size_WH = {w = sizeX, h = sizeY, wr = "px", hr = "px",},
			},
			backgroundColor = overBack,
			borderColor = bordBack,
			borderWidth = 1,
			visible = toggleSelected,
		}

		listShd[countCell] =
		{
			type = "Button",
			name = "missionShd_" .. j .. "_" .. k,
			Layout =
			{
				pivot_XY = {0.0, 0.0},
				pos_XY = {x = countX * sizeX, y = countY * sizeY, xr="px", yr="px",},
				size_WH = {w = sizeX, h = sizeY, wr = "px", hr = "px",},
			},
			backgroundColor = popuBack,
			borderColor = {0,0,0,0},
			borderWidth = 0,
		}

		countCell = countCell + 1
	end
end
