dofilepath("data:scripts\\SCAR\\SCAR_Util.lua")
dofilepath("data:scripts\\scar\\restrict.lua")

function OnInit()
	MPRestrict()
	StartMission()
	objectivesClear[currentSectorRow][currentSectorCol] = 1
	Rule_AddInterval("MainRule", 1)
end


-------------------------------------------------------------------------------
-- main rule to call for this game type
--
function MainRule()
	local playerCount = Universe_PlayerCount() - 1
	local numAlive = 0
	local numEnemies = 0
	local gameOver = 1
	-- check to see if ALL of our enemies are dead, then gameOver
	for playerIndex = 0, playerCount do
		if (Player_IsAlive(playerIndex) == 1) then
			-- kill the player if the player has no production capability
			if (Player_HasShipWithBuildQueue(playerIndex) == 0) then
				Player_Kill(playerIndex)
			-- only process 'alive' players
			else
				-- compare this player against all others
				for otherPlayerIndex = 0, playerCount do
					-- are enemies?
					if (AreAllied(playerIndex, otherPlayerIndex) == 0) then
						-- is the enemy alive - if so the game is still on
						if (Player_IsAlive(otherPlayerIndex) == 1) then
							gameOver = 0
						else
							numEnemies = numEnemies + 1
						end
					end
				end
				numAlive = numAlive + 1
			end
		end
	end
	-- if gameOver flag is still set then the game is OVER
	if (gameOver == 1) then
		Rule_Add("waitForEnd")
		Event_Start("endGame")
		Rule_Remove("MainRule")
	end
end

function waitForEnd()
	if (Event_IsDone("endGame")) then
		-- if the human player has survived
		if (Player_IsAlive(0) == 1) then
			setMissionComplete(1)		-- success!
		else
			setMissionComplete(0)		-- failure!
		end
		Rule_Remove("waitForEnd")
	end
end

-- EVENTS Create the events table. The name of this table must always be 'Events' because this is what the game looks for.
Events =
{
	endGame =
	{
		{
			{"wID = Wait_Start(5)", "Wait_End(wID)"},
		},
	},
}
