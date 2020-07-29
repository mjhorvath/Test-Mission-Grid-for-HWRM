dofilepath("data:scripts\\utilfunc.lua")

Events = {}


function OnInit()
	Rule_Add("Rule_Init")
end

function Rule_Init()
--	test_rotation_angles()
	test_motherships()
--	Universe_Pause(1, 0)
	Rule_Remove("Rule_Init")
end

function test_motherships()
	Volume_AddSphere("entryname", {0,0,0}, 1)
	local angle_1 = {45,45,0}
	local angle_2 = {30,60,0}
	local matrix_1 = EulerToMatrix(angle_1)
	local matrix_2 = EulerToMatrix(angle_2)
	local pos_1 = {0,0,0}
	local pos_2 = {random() * 10000, random() * 10000, random() * 10000}
	SobGroup_SetPosition("mommysobg_1", pos_1)
--	SobGroup_SetPosition("mommysobg_2", pos_2)
	SobGroup_SetTransform("mommysobg_1", matrix_1)
--	SobGroup_SetTransform("mommysobg_2", matrix_2)
end

function test_rotation_angles()
	for i = 1, 9 do
		local test_matrx_2 = SobGroup_GetCoordSys("mommysobg_" .. i)
		local test_euler_2 = MatrixToEuler(test_matrx_2)
		print("euler_2_" .. i .. " = " .. vstr(test_euler_2))
	end
	for i = 1, 9 do
		local test_matrx_2 = SobGroup_GetCoordSys("mommysobg_" .. i)
		print("matrx_2_" .. i .. " = " .. vstr(test_matrx_2))
	end
end

function Rule_CheckDock()
	local is_docked = SobGroup_IsDockedSobGroup("interceptorsobg", "carriersobg")
	print("is_docked = " .. is_docked)
end

Events = {}
