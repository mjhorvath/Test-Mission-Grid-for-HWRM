function Rule_TestStuff()
	print("Testing stuff.")
--	TestStuff_01()
--	TestStuff_02()
--	TestStuff_03()
	TestStuff_04()
--	TestStuff_05()
	Rule_Remove("Rule_TestStuff")
end

-- test the difference between shallow and deep table copies
function TestStuff_01()
	local table_a = {first = {second = {third = 7}}}
--	local table_b = table_a			-- not a copy but a direct reference
	local table_b = tcopy(table_a)		-- shallow copy
	table_b.first.second.third = 6
	print("table_a.first.second.third = " .. table_a.first.second.third)
	print("table_b.first.second.third = " .. table_b.first.second.third)
end

-- test path finding
function TestStuff_02()
	dofilepath("data:scripts\\TMG_breadthfirstsearch.lua")

	-- Create a 4x4 mapGrid
	-- Represent the mapGrid as a 2-dimensional array
	local testGridSize = 4
	local testGrid = {}
	for i = 1, testGridSize do
		testGrid[i] = {}
		for j = 1, testGridSize do
			testGrid[i][j] = "Empty"
		end
	end

	-- Think of the first index as "distance from the top row"
	-- Think of the second index as "distance from the left-most column"

	-- This is how we would represent the mapGrid with obstacles above
	testGrid[2][2] = "Obstacle"
	testGrid[2][3] = "Obstacle"
	testGrid[2][4] = "Obstacle"
	testGrid[3][2] = "Obstacle"

	-- 1 = East, 2 = South, 3 = West, 4 = North
	local testResult = findShortestPath({1,1}, {3,3}, testGrid)
	for i = 1, getn(testResult) do
		print("-----------------------------------")
		print("testResult[i][1] = " .. testResult[i][1])
		print("testResult[i][2] = " .. testResult[i][2])
		print("testResult[i][3] = " .. testResult[i][3])
	end
end

function TestStuff_03()
	local inn_sobgroup = "Player_Ships0"
	local ship_name_sub = "TESTSHIP_"
	local ship_count = SobGroup_Separate(ship_name_sub, inn_sobgroup)
	for j = 1, 1 do
		local ship_name = ship_name_sub .. (j-1)
		local inn_coor = SobGroup_GetCoordSys(ship_name)
		local out_coor = Matrix3_Transpose(inn_coor)	-- has no effect?
		SobGroup_SetTransform(ship_name, out_coor)
		local inn_text = "{"
		local out_text = "{"
		for k = 1, getn(inn_coor) do
			inn_text = inn_text .. inn_coor[k]
			out_text = out_text .. out_coor[k]
		end
		inn_text = inn_text .. "}"
		out_text = out_text .. "}"
		print(inn_text)
		print(out_text)
	end
end

function TestStuff_04()
	for i = 1, 9 do
		local inn_angles = {random() * 360, random() * 360, random() * 360}
		local med_matrix = EulerToMatrix(inn_angles)
		local out_angles = MatrixToEuler(med_matrix)
		print("inn_angles = " .. vstr(inn_angles))
		print("out_angles = " .. vstr(out_angles))
	end
end

function TestStuff_05()
	local test_stuff_table =
	{
		tinsert = 5,
		getn = 4,
		type = 3,
		print = 2,
	}

	for i, item in test_stuff_table do
		print("i = " .. i)
	end
end
