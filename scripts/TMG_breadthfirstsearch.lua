-- Adapted from "A BASIC PATHFINDING ALGORITHM (IMPLEMENTED IN JAVASCRIPT)"
-- http://gregtrowbridge.com/a-basic-pathfinding-algorithm/
-- Greg Trowbridge

function findShortestPath(start_coordinates, final_coordinates, map_grid)
	-- stop right now if the positions are equal
	if ((start_coordinates[1] == final_coordinates[1]) and (start_coordinates[2] == final_coordinates[2])) then
		return {start_coordinates}
	end

	-- initialize the starting and final coordinates
	map_grid[start_coordinates[1]][start_coordinates[2]] = "Start"
	map_grid[final_coordinates[1]][final_coordinates[2]] = "Goal"

	-- Each "location" will store its coordinates
	-- and the shortest path required to arrive there
	local startLocation =
	{
		distanceFromTop = start_coordinates[1] - 1,
		distanceFromLft = start_coordinates[2] - 1,
		path = {{start_coordinates[1], start_coordinates[2], 0}},
		status = "Start",
	}
	-- not used
	local finalLocation =
	{
		distanceFromTop = final_coordinates[1] - 1,
		distanceFromLft = final_coordinates[2] - 1,
		path = {},		-- todo: need previous loc
		status = "Goal",
	}

	-- Initialize the queue with the start location already inside
	local queue = {startLocation}

	-- Loop through the map_grid searching for the goal
	while (getn(queue) > 0) do
		-- Take the first location off the queue
		local currentLocation = {}
		local queue_temp_table = {}
		local queue_temp_count = 1
		for i = 1, getn(queue) do
			if (i == 1) then
				currentLocation = queue[i]
			else
				queue_temp_table[queue_temp_count] = queue[i]
				queue_temp_count = queue_temp_count + 1
			end
		end
		queue = queue_temp_table

		-- Explore East
		local newLocation = exploreInDirection(currentLocation, 1, map_grid)
		if (newLocation.status == "Goal") then
			return newLocation.path
		elseif (newLocation.status == "Valid") then
			queue[getn(queue) + 1] = newLocation
		end

		-- Explore South
		local newLocation = exploreInDirection(currentLocation, 2, map_grid)
		if (newLocation.status == "Goal") then
			return newLocation.path
		elseif (newLocation.status == "Valid") then
			queue[getn(queue) + 1] = newLocation
		end

		-- Explore West
		local newLocation = exploreInDirection(currentLocation, 3, map_grid)
		if (newLocation.status == "Goal") then
			return newLocation.path
		elseif (newLocation.status == "Valid") then
			queue[getn(queue) + 1] = newLocation
		end

		-- Explore North
		local newLocation = exploreInDirection(currentLocation, 4, map_grid)
		if (newLocation.status == "Goal") then
			return newLocation.path
		elseif (newLocation.status == "Valid") then
			queue[getn(queue) + 1] = newLocation
		end
	end

	-- No valid path found
	return false

end

-- This function will check a location's status
-- (a location is "valid" if it is on the map_grid, is not an "obstacle",
-- and has not yet been visited by our algorithm)
-- Returns "Valid", "Invalid", "Blocked", or "Goal"
function locationStatus(location, map_grid)
	local gridSize = getn(map_grid)
	local dft = location.distanceFromTop
	local dfl = location.distanceFromLft

	if (
		(location.distanceFromLft < 0) or
		(location.distanceFromLft >= gridSize) or
		(location.distanceFromTop < 0) or
		(location.distanceFromTop >= gridSize)
	) then
		-- location is not on the map_grid--return false
		return "Invalid"
	elseif (map_grid[dft+1][dfl+1] == "Goal") then
		-- location is the destination
		return "Goal"
	elseif (map_grid[dft+1][dfl+1] ~= "Empty") then
		-- location is either an obstacle or has been visited
		return "Blocked"
	else
		return "Valid"
	end
end


-- Explores the map_grid from the given location in the given
-- direction
function exploreInDirection(currentLocation, direction, map_grid)
	local dft = currentLocation.distanceFromTop
	local dfl = currentLocation.distanceFromLft

	-- East
	if (direction == 1) then
		dfl = dfl + 1
	-- South
	elseif (direction == 2) then
		dft = dft + 1
	-- West
	elseif (direction == 3) then
		dfl = dfl - 1
	-- North
	elseif (direction == 4) then
		dft = dft - 1
	end

	local newPath = tcopy(currentLocation.path)		-- is tcopy really necessary?
	local pathLength = getn(newPath)
	newPath[pathLength + 1] = {dft+1, dfl+1, tranDirections[direction]}

	local newLocation =
	{
		distanceFromTop = dft,
		distanceFromLft = dfl,
		path = newPath,
		status = "Unknown",
	}
	newLocation.status = locationStatus(newLocation, map_grid)

	-- If this new location is valid, mark it as "Visited"
	if (newLocation.status == "Valid") then
		map_grid[dft+1][dfl+1] = "Visited"
	end

	return newLocation
end
