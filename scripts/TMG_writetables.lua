-- ThoughtDump v1.5.1
-- Updated: 2017/08/07
-- *******************
-- Created by Thought (http://hw2.tproc.org)
-- Updated by Mikali

-- DESCRIPTION
-- ***********
-- Parses the globals table and writes its contents to a file. Can also be used 
-- to parse and clean (i.e., pretty-print) generic tables in some cases.

-- Note: functions & variables must actually be declared in order to be parsed. 
-- Otherwise, they are ignored.
-- Note: the outputted table values may be in a different order than was 
-- originally written. Values with numerical indices are moved to the "top" of 
-- the table, followed by values with string indices, followed by other tables. 
-- Functions appear in different locations, depending on whether they are 
-- indexed using a number or a string.
-- Note: nil values are also handled.
-- Note: even though functions may be referenced within tables, a function will 
-- only be parsed correctly if it is indexed using a string that is the same as
-- the name of the function.
-- Note: setting the "numbers" parameter to 0 can cause problems with tables 
-- whose indices are numbers if the items within those tables were added using 
-- the "tinsert" Lua function. Setting the "numbers" parameter to 1 solves this 
-- problem.

function __TDParse(name, value, level, verbose, numbers, collapse)
	-- should check for first four characters equaling "__TD" instead
	if ((name == "__TDParse") or (name == "__TDSortHash") or (name == "__TDPrint") or (name == "__TDWriteGlobals()")) then
		return
	end
	local Element = nil
	local ValType = type(value)
	local NamType = type(name)
	local PreLevel = ""
	if (collapse == 0) then
		for i = 1, level do
			PreLevel = PreLevel .. "\t"
		end
	end
	local ComLevel = ""
	if (level ~= 0) then
		ComLevel = ","
	end
	if ((ValType == "function") or (ValType == "userdata")) then
		if (NamType == "string") then
			Element = PreLevel .. name .. " = " .. name .. ComLevel
		elseif (numbers == 1) then
			Element = PreLevel .. "[" .. name .. "] = " .. name .. ComLevel
		else
			Element = PreLevel .. name .. ComLevel
		end
	elseif (ValType == "string") then
		value = gsub(value, [[%"]], [[\"]])
		if (NamType == "string") then
			Element = PreLevel .. name .. " = \"" .. value .. "\"" .. ComLevel
		elseif (numbers == 1) then
			Element = PreLevel .. "[" .. name .. "] = \"" .. value .. "\"" .. ComLevel
		else
			Element = PreLevel .. "\"" .. value .. "\"" .. ComLevel
		end
	elseif (ValType == "number") then
		if (NamType == "string") then
			Element = PreLevel .. name .. " = " .. value .. ComLevel
		elseif (numbers == 1) then
			Element = PreLevel .. "[" .. name .. "] = " .. value .. ComLevel
		else
			Element = PreLevel .. value .. ComLevel
		end
	elseif (ValType == "table") then
		if (NamType == "string") then
			Element = PreLevel .. name .. " ="
		elseif (numbers == 1) then
			Element = PreLevel .. "[" .. name .. "] ="
		else
			Element = ""
		end
	elseif (ValType == "nil") then
		if (NamType == "string") then
			Element = PreLevel .. name .. " = nil" .. ComLevel
		elseif (numbers == 1) then
			Element = PreLevel .. "[" .. name .. "] = nil" .. ComLevel
		else
			Element = PreLevel .. "nil" .. ComLevel
		end
	else
		Element = PreLevel .. "-- unknown object type " .. ValType .. " for object " .. name
	end
	if (verbose == 1) then
		Element = Element .. "	-- " .. ValType .. ", tag: " .. tag(value)
	end
	if (((ValType == "table") and (NamType == "number") and (numbers == 0)) or (collapse == 1)) then
		__TDPrint(Element, 0)
	else
		__TDPrint(Element, 1)
	end
	if (ValType == "table") then
		__TDPrint(PreLevel .. "{", collapse == 0)
		__TDSortHash(__TDParse, value, level + 1, verbose, numbers, collapse)
		__TDPrint(PreLevel .. "}" .. ComLevel, 1)
	end
end

function __TDSortHash(func, tabl, level, verbose, numbers, collapse)
	local typesarray = {}
	local typescount = {}
	local keycount = 1
	local keyarray = {}
	for i, iCount in tabl do
		local thistype = type(iCount)
		if not (typesarray[thistype]) then
			typescount[thistype] = 0
			typesarray[thistype] = {}
		end
		typescount[thistype] = typescount[thistype] + 1
		typesarray[thistype][typescount[thistype]] = i
	end
	sort(typesarray)
	for i, iCount in typesarray do
		sort(iCount)
		for j, jCount in iCount do
			keyarray[keycount] = tostring(jCount)
			keycount = keycount + 1
		end
	end
	for i, iCount in keyarray do
		local tempcount = tonumber(iCount)
		if (tempcount) then
			iCount = tempcount
		end
		func(iCount, tabl[iCount], level, verbose, numbers, collapse)
	end
end

function __TDPrint(instring, newline)
	write(instring)
	if (newline == 1) then
		write("\n")
	end
end

function __TDWriteGlobals()
	local WriteFile = "$test_globals_write.lua"
	writeto(WriteFile)
	__TDPrint("globals =", 1)
	__TDPrint("{", 1)
	__TDSortHash(__TDParse, globals(), 1, 0, 1, 0)
	__TDPrint("}\n", 1)
	writeto()
end

function WriteQuestsStatus()
	__TDPrint("questsStatus =", 1)
	__TDPrint("{", 1)
	__TDSortHash(__TDParse, questsStatus, 1, 0, 1, 0)
	__TDPrint("}\n", 1)
end

function WriteSquadShips()
	__TDPrint("squadShips =", 1)
	__TDPrint("{", 1)
	__TDSortHash(__TDParse, squadShips, 1, 0, 1, 0)
	__TDPrint("}\n", 1)
end

function WriteLocalShips()
	__TDPrint("localShips =", 1)
	__TDPrint("{", 1)
	__TDSortHash(__TDParse, localShips, 1, 0, 1, 0)
	__TDPrint("}\n", 1)
end

function WriteLocalSobgroups()
	__TDPrint("localSobgroups =", 1)
	__TDPrint("{", 1)
	__TDSortHash(__TDParse, localSobgroups, 1, 0, 1, 0)
	__TDPrint("}\n", 1)
end

function WriteSectorsExplored()
	__TDPrint("sectorsExplored =", 1)
	__TDPrint("{", 1)
	__TDSortHash(__TDParse, sectorsExplored, 1, 0, 0, 1)
	__TDPrint("}\n", 1)
end

function WriteObjectivesClear()
	__TDPrint("objectivesClear =", 1)
	__TDPrint("{", 1)
	__TDSortHash(__TDParse, objectivesClear, 1, 0, 0, 1)
	__TDPrint("}\n", 1)
end

function WriteDialogueStatus()
	__TDPrint("dialogueStatus =", 1)
	__TDPrint("{", 1)
	__TDSortHash(__TDParse, dialogueStatus, 1, 0, 1, 0)
	__TDPrint("}\n", 1)
end

function WriteGlobalTimeQueue()
	__TDPrint("globalTimeQueue =", 1)
	__TDPrint("{", 1)
	__TDSortHash(__TDParse, globalTimeQueue, 1, 0, 1, 0)
	__TDPrint("}\n", 1)
end
