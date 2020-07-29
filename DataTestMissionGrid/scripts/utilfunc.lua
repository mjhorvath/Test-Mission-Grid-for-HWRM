-- Author: Mikali
-- Last updated: 2017/09/01

--------------------------------------------------------------------------------
-- Random number functions.
--

-- Randomly returns either 1 or -1.
function randomSign()
	if (random() > 0.5) then
		return 1
	else
		return -1
	end
end

-- Randomly returns either 1 or 0.
function randomBit()
	if (random() > 0.5) then
		return 1
	else
		return 0
	end
end

-- Works just like random(), but can accept zero as an argument.
function random2(fVal1, fVal2)
	if (fVal2) then
		if ((fVal2 - fVal1) == 0) then
			return fVal2
		else
			return random(fVal1, fVal2)
		end
	elseif (fVal1) then
		if (fVal1 == 0) then
			return 0
		else
			return random(fVal1)
		end
	else
		return random()
	end
end

-- Works just like random(), but can accept zero as an argument and always returns a float value, not an integer.
function random3(fVal1, fVal2)
	if (fVal2) then
		return fVal1 + random() * (fVal2 - fVal1)
	elseif (fVal1) then
		return random() * fVal1
	else
		return random()
	end
end

-- For each argument, returns a random float value between 0 and the argument.
function randomSet(...)
	local v = {}
	for i = 1, getn(arg) do
		v[i] = random3(arg[i])
	end
	if arg[5] then
		return v[1], v[2], v[3], v[4], v[5]
	elseif arg[4] then
		return v[1], v[2], v[3], v[4]
	elseif arg[3] then
		return v[1], v[2], v[3]
	elseif arg[2] then
		return v[1], v[2]
	elseif arg[1] then
		return v[1]
	end
end

-- For every two arguments, returns a random float value between the former argument and the latter argument.
function randomSet2(...)
	local v = {}
	for i = 2, getn(arg), 2 do
		v[i/2] = random3(arg[i-1], arg[i])
	end
	if arg[10] then
		return v[1], v[2], v[3], v[4], v[5]
	elseif arg[8] then
		return v[1], v[2], v[3], v[4]
	elseif arg[6] then
		return v[1], v[2], v[3]
	elseif arg[4] then
		return v[1], v[2]
	elseif arg[2] then
		return v[1]
	end
end

-- Creates a new seed for seeded functions such as srandom().
-- Make sure seednum is negative.
function newseed(seednum)
	return {seed = seednum}
end

-- rough adaptation of Knuth float generator
-- Note: seedobj must be a table with a field named `seed`;
-- this field must be negative; after the first number has
-- been generated, the seedobj table will be populated with
-- additional state needed to generate numbers; changing its
-- `seed` field to a negative number will reinitialize the
-- generator and start a new pseudorandom sequence.
-- Adapted from code at https://stackoverflow.com/questions/18689186/lua-4-0-random-number-generator
function srandom( seedobj, fVal1, fVal2 )
	local B =  4000000
	local ma = seedobj.ma
	local seed = seedobj.seed
	local mj, mk
	if seed < 0 or not ma then
		ma = {}
		seedobj.ma = ma
		mj = abs( 1618033 - abs( seed ) )
		mj = mod( mj, B )
		ma[55] = mj
		mk = 1
		for i = 1, 54 do
			local ii = mod( 21 * i,  55 )
			ma[ii] = mk
			mk = mj - mk
			if mk < 0 then
				mk = mk + B
			end
			mj = ma[ii]
		end
		for k = 1, 4 do
			for i = 1, 55 do
				ma[i] = ma[i] - ma[ 1 + mod( i + 30,  55) ]
				if ma[i] < 0 then
					ma[i] = ma[i] + B
				end
			end
		end
		seedobj.inext = 0
		seedobj.inextp = 31
		seedobj.seed = 1
	end -- if
	local inext = seedobj.inext
	local inextp = seedobj.inextp
	inext = inext + 1
	if inext == 56 then
		inext = 1
	end
	seedobj.inext = inext
	inextp = inextp + 1
	if inextp == 56 then
		inextp = 1
	end
	seedobj.inextp = inextp
	mj = ma[ inext ] - ma[ inextp ]
	if mj < 0 then
		mj = mj + B
	end
	ma[ inext ] = mj
	local temp_rand = mj / B
	if fVal2 then
		return floor( fVal1 + 0.5 + temp_rand * ( fVal2 - fVal1 ) )
	elseif fVal1 then
		return floor( temp_rand * fVal1 ) + 1
	else
		return temp_rand
	end
end

-- Works like random(), except you provide your own seed as the first argument.
-- The results are that maps appear the same each time you run the game, but desyncs may possibly be avoided.
function srandom_old(seedobj, fVal1, fVal2)
	seedobj[1] = mod(seedobj[1] * seedobja + seedobjc, seedobjm)
	local temp_rand = seedobj[1] / (seedobjm - 1)
	if (fVal2) then
		return floor(fVal1 + 0.5 + temp_rand * (fVal2 - fVal1))
	elseif (fVal1) then
		return floor(temp_rand * fVal1) + 1
	else
		return temp_rand
	end
end

-- Randomly returns either 1 or -1. Seeded.
function srandomSign(seedobj)
	if (srandom(seedobj) > 0.5) then
		return 1
	else
		return -1
	end
end

-- Randomly returns either 1 or 0. Seeded.
function srandomBit(seedobj)
	if (srandom(seedobj) > 0.5) then
		return 1
	else
		return 0
	end
end

-- Works just like random(), but can accept zero as an argument. Seeded.
function srandom2(seedobj, fVal1, fVal2)
	if (fVal2) then
		if ((fVal2 - fVal1) == 0) then
			return fVal2
		else
			return srandom(seedobj, fVal1, fVal2)
		end
	elseif (fVal1) then
		if (fVal1 == 0) then
			return 0
		else
			return srandom(seedobj, fVal1)
		end
	else
		return srandom(seedobj)
	end
end

-- Works just like random(), but can accept zero as an argument and always returns a float value, not an integer. Seeded.
function srandom3(seedobj, fVal1, fVal2)
	if (fVal2) then
		return fVal1 + srandom(seedobj) * (fVal2 - fVal1)
	elseif (fVal1) then
		return srandom(seedobj) * fVal1
	else
		return srandom(seedobj)
	end
end

-- For each argument, returns a random float value between 0 and the argument. Seeded.
function srandomSet(seedobj, ...)
	local v = {}
	for i = 1, getn(arg) do
		v[i] = srandom3(seedobj, arg[i])
	end
	if arg[5] then
		return v[1], v[2], v[3], v[4], v[5]
	elseif arg[4] then
		return v[1], v[2], v[3], v[4]
	elseif arg[3] then
		return v[1], v[2], v[3]
	elseif arg[2] then
		return v[1], v[2]
	elseif arg[1] then
		return v[1]
	end
end

-- For every two arguments, returns a random float value between the former argument and the latter argument. Seeded.
function srandomSet2(seedobj, ...)
	local v = {}
	for i = 2, getn(arg), 2 do
		v[i/2] = srandom3(seedobj, arg[i-1], arg[i])
	end
	if arg[10] then
		return v[1], v[2], v[3], v[4], v[5]
	elseif arg[8] then
		return v[1], v[2], v[3], v[4]
	elseif arg[6] then
		return v[1], v[2], v[3]
	elseif arg[4] then
		return v[1], v[2]
	elseif arg[2] then
		return v[1]
	end
end

-- Returns a vector with random components.
function vrand(tVecIn)
	local tVecOut = {}
	for i = 1, getn(tVecIn) do
		tinsert(tVecOut, random(tVecIn[i]))
	end
	return tVecOut
end

-- Returns a vector with random components. Seeded.
function svrand(seedobj, tVecIn)
	local tVecOut = {}
	for i = 1, getn(tVecIn) do
		tinsert(tVecOut, srandom(seedobj, tVecIn[i]))
	end
	return tVecOut
end

-- Returns a vector with random components.
function vrand2(tVecIn)
	local tVecOut = {}
	for i = 1, getn(tVecIn) do
		tinsert(tVecOut, random2(tVecIn[i][1], tVecIn[i][2]))
	end
	return tVecOut
end

-- Returns a vector with random components. Seeded.
function svrand2(seedobj, tVecIn)
	local tVecOut = {}
	for i = 1, getn(tVecIn) do
		tinsert(tVecOut, srandom2(seedobj, tVecIn[i][1], tVecIn[i][2]))
	end
	return tVecOut
end

-- Returns a vector with random components.
function vrand3(tVecIn)
	local tVecOut = {}
	for i = 1, getn(tVecIn) do
		tinsert(tVecOut, random3(tVecIn[i][1], tVecIn[i][2]))
	end
	return tVecOut
end

-- Returns a vector with random components. Seeded.
function svrand3(seedobj, tVecIn)
	local tVecOut = {}
	for i = 1, getn(tVecIn) do
		tinsert(tVecOut, srandom3(seedobj, tVecIn[i][1], tVecIn[i][2]))
	end
	return tVecOut
end


--------------------------------------------------------------------------------
-- Trigonometric functions.
--

-- Returns the hyperbolic cosine of an angle.
function cosh(fAng)
	return (exp(fAng) + exp(-fAng))/2
end

-- Returns the hyperbolic sine of an angle.
function sinh(fAng)
	return (exp(fAng) - exp(-fAng))/2
end

-- Returns the hyperbolic tangent of an angle.
function tanh(fAng)
	return (exp(fAng) - exp(-fAng))/(exp(fAng) + exp(-fAng))
end

-- Returns the hyperbolic cosecant of an angle.
function csch(fAng)
	return 1/sinh(fAng)
end

-- Returns the hyperbolic secant of an angle.
function sech(fAng)
	return 1/cosh(fAng)
end

-- Returns the hyperbolic cotangent of an angle.
function coth(fAng)
	return 1/tanh(fAng)
end

-- Returns the cosecant of an angle.
function csc(fAng)
	return 1/sin(fAng)
end

-- Returns the secant of an angle.
function sec(fAng)
	return 1/cos(fAng)
end

-- Returns the cotangent of an angle.
function cot(fAng)
	return 1/tan(fAng)
end

-- Returns the exsecant of an angle.
function exsec(fAng)
	return sec(fAng) - 1
end

-- Returns the coexsecant of an angle.
function coexsec(fAng)
	return csc(fAng) - 1
end

-- Returns the versesine of an angle.
function vers(fAng)
	return 1 - cos(fAng)
end

-- Returns the coversesine of an angle.
function covers(fAng)
	return 1 - sin(fAng)
end

-- Returns the half-versesine of an angle.
function hav(fAng)
	return vers(fAng)/2
end


--------------------------------------------------------------------------------
-- Other mathematical functions.
--

-- Rounds a number to the nearest integer.
function round(fVal)
	return floor(fVal + 0.5)
end

-- Converts a decimal value into a fraction.
function decimal_to_fraction(fNumber)
	local fullNumber = floor(fNumber)
	local iNumerator = fNumber - fullNumber
	local iDenominator = 1
	while (iNumerator ~= floor(iNumerator)) do
		iNumerator = iNumerator * 10
		iDenominator = iDenominator * 10
	end
	iNumerator = floor(iNumerator)
	for i = 2, floor(sqrt(iNumerator)) do
		while ((mod(iNumerator, i) == 0) and (mod(iDenominator, i) == 0)) do
			iNumerator = iNumerator / i
			iDenominator = iDenominator / i
		end
	end
	iNumerator = iNumerator + fullNumber * iDenominator
--	print(fNumber .. " = " .. iNumerator .. "/" .. iDenominator)
	return iNumerator, iDenominator
end


--------------------------------------------------------------------------------
-- Vector functions.
--

-- Returns true if the length of the vector is zero.
function viszero(vVal)
	if (vVal[1] + vVal[2] + vVal[3] == 0) then
		return 1
	end
	return 0
end

-- Rounds a vector's components to the nearest integer.
function vround(vVal)
	return {floor(vVal[1] + 0.5), floor(vVal[2] + 0.5), floor(vVal[3] + 0.5)}
end

-- Returns the normalized form of a vector.
function vnormalize(tVec)
	return vdivide(tVec, vlength(tVec))
end

-- Returns the length of a vector.
function vlength(tVec)
	return sqrt(vsum(vpower(tVec, 2)))
end

-- Returns the distance between two vectors.
function vdistance(tVec1, tVec2)
	return vlength(vsubtractV(tVec2, tVec1))
end

-- Returns the dot product of two vectors.
function vdot(tVec1, tVec2)
	return vsum(vmultiplyV(tVec1, tVec2))
end

-- Returns the angle between two vectors.
function vangle(tVec1, tVec2)
	return acos(vdot(vnormalize(tVec1), vnormalize(tVec2)))
end

-- Returns the cross product of two vectors as a new vector.
function vcross(tVec1, tVec2)
	return
	{
		tVec1[2] * tVec2[3] - tVec1[3] * tVec2[2],
		tVec1[3] * tVec2[1] - tVec1[1] * tVec2[3],
		tVec1[1] * tVec2[2] - tVec1[2] * tVec2[1],
	}
end

-- tests whether two vectors are equal
function veq(tVec1, tVec2)
	if (tVec1[1] == tVec2[1]) and (tVec1[2] == tVec2[2]) and (tVec1[3] == tVec2[3]) then
		return 1
	else
		return 0
	end
end

-- returns the midpoint of two points as a new point
function vmidpoint(tVec1, tVec2)
	return
	{
		(tVec1[1] + tVec2[1]) / 2,
		(tVec1[2] + tVec2[2]) / 2,
		(tVec1[3] + tVec2[3]) / 2,
	}
end

-- Adds an amount to each vector component, then returns the resulting vector.
function vadd(tVec, fVal)
	local tmpVec = {}
	for i, tTab in tVec do
		tmpVec[i] = tVec[i] + fVal
	end
	return tmpVec
end

-- Adds the components of the second vector to the components of the first vector, then returns the resulting vector.
function vaddV(tVec1, tVec2)
	local tmpVec = {}
	for i, tTab in tVec2 do
		tmpVec[i] = tVec1[i] + tTab
	end
	return tmpVec
end

-- Subtracts an amount from each vector component, then returns the resulting vector.
function vsubtract(tVec, fVal)
	local tmpVec = {}
	for i, tTab in tVec do
		tmpVec[i] = tVec[i] - fVal
	end
	return tmpVec
end

-- Subtracts the components of the second vector from the components of the first vector, then returns the resulting vector.
function vsubtractV(tVec1, tVec2)
	local tmpVec = {}
	for i, tTab in tVec2 do
		tmpVec[i] = tVec1[i] - tTab
	end
	return tmpVec
end

-- Multiplies each vector component by some amount, then returns the resulting vector.
function vmultiply(tVec, fVal)
	local tmpVec = {}
	for i, tTab in tVec do
		tmpVec[i] = tTab * fVal
	end
	return tmpVec
end

-- Multiplies the components of the first vector by the components of the second vector, then returns the resulting vector.
function vmultiplyV(tVec1, tVec2)
	local tmpVec = {}
	for i, tTab in tVec2 do
		tmpVec[i] = tVec1[i] * tTab
	end
	return tmpVec
end

-- Divides each vector component by some amount, then returns the resulting vector.
function vdivide(tVec, fVal)
	local tmpVec = {}
	for i, tTab in tVec do
		tmpVec[i] = tTab/fVal
	end
	return tmpVec
end

-- Divides the components of the first vector by the components of the second vector, then returns the resulting vector.
function vdivideV(tVec1, tVec2)
	local tmpVec = {}
	for i, tTab in tVec2 do
		tmpVec[i] = tVec1[i]/tTab
	end
	return tmpVec
end

-- Raises each vector component to the some power, then returns the new vector.
function vpower(tVec, fVal)
	local tmpVec = {}
	for i, tTab in tVec do
		tmpVec[i] = tTab^fVal
	end
	return tmpVec
end

-- Raises the components of the first vector to the power specified by the components the second vector, then returns the new vector.
function vpowerV(tVec1, tVec2)
	local tmpVec = {}
	for i, tTab in tVec2 do
		tmpVec[i] = tVec1[i]^tTab
	end
	return tmpVec
end

-- Returns the sum of all the vector's components.
function vsum(tVec1)
	local tmpVal = 0
	for i, tTab in tVec1 do
		tmpVal = tmpVal + tTab
	end
	return tmpVal
end

-- Returns a vector converted into a string.
function vstr(tVec)
	local tmpStr = "{"
	for i, tTab in tVec do
		tmpStr = tmpStr .. tTab .. ", "
	end
	tmpStr = tmpStr .. "}"
	return tmpStr
end

function vfloor(tVec)
	local tmpVec = {}
	for i, tTab in tVec do
		tmpVec[i] = floor(tVec[i])
	end
	return tmpVec
end

-- Rotates a vector around the origin by the specified Euler angles, then returns the resulting vector.
-- Rotates around the Z-axis first, followed by the X-axis and the Y-axis.
function vrotate(tVec, tAng)
	tVec =
	{
		tVec[1] * cos(tAng[3]) - tVec[2] * sin(tAng[3]),
		tVec[1] * sin(tAng[3]) + tVec[2] * cos(tAng[3]),
		tVec[3],
	}
	tVec =
	{
		tVec[1],
		tVec[2] * cos(tAng[1]) - tVec[3] * sin(tAng[1]),
		tVec[2] * sin(tAng[1]) + tVec[3] * cos(tAng[1]),
	}
	tVec =
	{
		tVec[1] * cos(tAng[2]) + tVec[3] * sin(tAng[2]),
		tVec[2],
		-1 * tVec[1] * sin(tAng[2]) + tVec[3] * cos(tAng[2]),
	}
	return tVec
end

-- Returns an array containing the vector's Euler angles, relative to the vertical Z-axis.
-- To reproduce the original vector, rotate a point located on the Z-axis by the returned angles using vrotate.
-- Any rotations around the Z axis will be ignored.
function vanglesXY(tVec2)
	local fSgnX, fSgnY, tPrjB1 = 1, 1, vnormalize({tVec2[1], 0, tVec2[3],})
	if (tPrjB1[1] ~= 0) then
		fSgnX = tPrjB1[1]/abs(tPrjB1[1]) * -1
	end
	tPrjB1[3] = max(min(tPrjB1[3],1),-1)
	local fAngY = acos(tPrjB1[3]) * fSgnX
	local tPrjB2 = vnormalize(vrotate(tVec2, {0, fAngY, 0,}))
	if (tPrjB2[2] ~= 0) then
		fSgnY = tPrjB2[2]/abs(tPrjB2[2])
	end
	tPrjB2[3] = max(min(tPrjB2[3],1),-1)
	local fAngX = acos(tPrjB2[3]) * fSgnY
	fAngX = mod(fAngX * -1, 360)
	fAngY = mod(fAngY * -1, 360)
	if (fAngX < 0) then
		fAngX = fAngX + 360
	end
	if (fAngY < 0) then
		fAngY = fAngY + 360
	end
	return {fAngX, fAngY, 0,}
end

-- Rotates the first vector around the second vector by some amount, then returns the resulting vector.
function vaxis_rotate(tVec1, tVec2, fAngZ)
	local tAng = vanglesXY(tVec2)
	return vrotate(vrotate(vrotate(vrotate(tVec1, {0, tAng[2], 0,}), {tAng[1], 0, 0,}), {0, 0, fAngZ,}), vmultiply(tAng, -1))
end


--------------------------------------------------------------------------------
-- Table manipulation functions.
--

-- Returns the length of a table. Useful where the 'getn' function is normally unavailable.
if not getn then
	function getn(tTable)
		local nCount = 0
		for i, iCount in tTable do
			-- be careful in case the table has an "n" parameter that someone added for other reasons than counting
			if i ~= "n" then
				nCount = nCount + 1
			end
		end
		return nCount
	end
end

-- Inserts an item into a table. Useful where the 'tinsert' function is normally unavailable.
-- The standard Lua 'tinsert' function may also add an "n" parameter to count.
if not tinsert then
	function tinsert(tTable, Arg1, Arg2)
		if (Arg2) then
			local TempTable = {}
			for i = Arg1, getn(tTable) do
				TempTable[i + 1] = tTable[i]
			end
			for i = Arg1, getn(tTable) do
				tTable[i + 1] = TempTable[i + 1]
			end
			tTable[Arg1] = Arg2
		else
			tTable[getn(tTable) + 1] = Arg1
		end
	end
end

-- Compares two tables and returns true if they're equal and false if they're not.
function tcomp(tTable1, tTable2)
	local same = 1
	if (getn(tTable1) ~= getn(tTable2)) then
		same = 0
	else
		for i, k in tTable1 do
			if (type(tTable1[i]) == "table") and (type(tTable2[i]) == "table") then
				same = tcomp(tTable1[i], tTable2[i])
				if (same == 0) then
					break
				end
			elseif (tTable1[i] ~= tTable2[i]) then
				same = 0
				break
			end
		end
	end
	return same
end

-- Creates a copy of the input table.
-- Adapted from http://lua-users.org/wiki/CopyTable
function tcopy(orig)
	local orig_type = type(orig)
	local copy
	-- a table
	if (orig_type == "table") then
		copy = {}
		for orig_key, orig_value in orig do
			copy[orig_key] = tcopy(orig_value)
		end
	-- number, string, boolean, etc
	else
		copy = orig
	end
	return copy
end

-- remove the first item in the table
function ttrim(tTable)
	local temp_table = {}
	for i = 2, getn(tTable) do
		local temp_length = getn(temp_table)
		temp_table[temp_length + 1] = tTable[i]
	end
	return temp_table
end


--------------------------------------------------------------------------------
-- Time functions
--

function disp_time(total_seconds, show_seconds)
--	local show_seconds	= 1
	local time_days		= floor(total_seconds / 86400)
	local time_hours	= floor(mod(total_seconds, 86400) / 3600)
	local time_minutes	= floor(mod(total_seconds, 3600) / 60)
	local time_seconds	= floor(mod(total_seconds, 60))
	if (time_hours < 10) then
		time_hours = "0" .. time_hours
	end
	if (time_minutes < 10) then
		time_minutes = "0" .. time_minutes
	end
	if (time_seconds < 10) then
		time_seconds = "0" .. time_seconds
	end
	if (show_seconds == 1) then
		return time_days .. ":" .. time_hours .. ":" .. time_minutes .. ":" .. time_seconds
	else
		return time_days .. ":" .. time_hours .. ":" .. time_minutes
	end
end


--------------------------------------------------------------------------------
-- String manipulation functions

if not strrep then
	function strrep(in_string, num_repeat)
		local out_string = ""
		for i = 1, num_repeat do
			out_string = out_string .. in_string
		end
		return out_string
	end
end


--------------------------------------------------------------------------------
-- Miscellaneous functions

function debug_print(sMessage)
	if (debug_text == true) then
		print(sMessage)
	end
end

-- Adapted from https://www.geometrictools.com/Documentation/EulerAngles.pdf, section 2.6
function MatrixToEuler(in_matrix)
	local r00 = in_matrix[9]
	local r01 = in_matrix[8]
	local r02 = in_matrix[7]
	local r10 = in_matrix[6]
	local r11 = in_matrix[5]
	local r12 = in_matrix[4]
	local r20 = in_matrix[3]
	local r21 = in_matrix[2]
	local r22 = in_matrix[1]
	local angleX = 0
	local angleY = 0
	local angleZ = 0
	if (r20 < 1) then
		if (r20 > -1) then
			angleX = atan2(r10, r00)
			angleY = asin(-r20)
			angleZ = atan2(r21, r22)
		else
			angleX = -atan2(-r12, r11)
			angleY = 90
			angleZ = 0
		end
	else
		angleX = atan2(-r12, r11)
		angleY = -90
		angleZ = 0
	end
	if (angleX < 0) then
		angleX = angleX + 360
	end
	if (angleY < 0) then
		angleY = angleY + 360
	end
	if (angleZ < 0) then
		angleZ = angleZ + 360
	end
	return {angleX, angleY, angleZ}
end

-- Adapted from https://www.geometrictools.com/Documentation/EulerAngles.pdf, section 2.6
function EulerToMatrix(in_euler)
	local angleX = in_euler[1]
	local angleY = in_euler[2]
	local angleZ = in_euler[3]
	local c1 = cos(angleX)
	local c2 = cos(angleY)
	local c3 = cos(angleZ)
	local s1 = sin(angleX)
	local s2 = sin(angleY)
	local s3 = sin(angleZ)
	local r00 =  c1 * c2
	local r01 =  c1 * s2 * s3 - c3 * s1
	local r02 =  s1 * s3 + c1 * c3 * s2
	local r10 =  c2 * s1
	local r11 =  c1 * c3 + s1 * s2 * s3
	local r12 =  c3 * s1 * s2 - c1 * s3
	local r20 = -s2
	local r21 =  c2 * s3
	local r22 =  c2 * c3
	return {r22,r21,r20,r12,r11,r10,r02,r01,r00}
end


--------------------------------------------------------------------------------
-- Notes:
--	With a ship sitting at the origin and pointing in the positive Z direction toward the 180 mark on the level disc:
--	* The X axis points to the left. The Y axis points upward. The Z axis points forward.
--	* Rotating the ship around the X axis by 90 degrees results in the ship facing downward.
--	* Rotating the ship around the Y axis by 90 degrees results in the ship facing to the left along the positive X axis.
--	* Rotating the ship around the Z axis by 90 degrees results in the ship laying on its right side still facing the positive Z direction.
--	* When rotating around the Y angle and the Z angle, the ship is rotated around the Y angle before the Z angle.
--	* When rotating around the X angle and the Y angle, the ship is rotated around the X angle before the Y angle.
--	* When rotating around the X angle and the Z angle, the ship is rotated around the X angle before the Z angle.

--	Using vrotate and a ship initially positioned at 10000 meters along the Z axis:
--	* Rotating the ship in space around the X axis results in the ship ending up along the negative Y axis.
--	* Rotating the ship in space around the Y axis results in the ship ending up along the positive X axis.
--	* Rotating the ship in space around the Z axis results in the ship remaining along the positive Z axis.
--	* When rotating around the Y angle and the Z angle, the ship is rotated around the Z angle before the Y angle.
--	* When rotating around the X angle and the Y angle, the ship is rotated around the X angle before the Y angle.
--	* When rotating around the X angle and the Z angle, the ship is rotated around the Z angle before the X angle.
