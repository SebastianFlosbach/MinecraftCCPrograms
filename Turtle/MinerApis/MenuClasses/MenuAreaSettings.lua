-- MenuAreaSettings

-- Currently selected menu option
Selection = 1

local isSettingOption = false

-- Avalable menu options { "name", function() "doStuffOnEnter" end }
Options = {
	{"Width", function() isSettingOption = true end, function() return Settings.GetValue("AreaWidth") end, function(value) Settings.SetValue("AreaWidth", value) end},
	{"Height", function() isSettingOption = true end, function() return Settings.GetValue("AreaHeight") end, function(value) Settings.SetValue("AreaHeight", value) end},
	{"Length", function() isSettingOption = true end, function() return Settings.GetValue("AreaLength") end, function(value) Settings.SetValue("AreaLength", value) end}

}

-- Move selection up if possible
SelectionUp = function()
	if isSettingOption then
		return
	end

	if Selection > 1 then
		Selection = Selection - 1
	end
end

-- Move selection down if possible
SelectionDown = function()
	if isSettingOption then
		return
	end

	if Selection < table.getn(Options) then
		Selection = Selection + 1
	end
end

-- Print menu with current selection
Print = function()
	local x
	local y
	
	for i,v in ipairs(Options) do
		if Selection == i then
			print("[",v[1],"] ", v[3]())
			if isSettingOption then
				x, y = term.getCursorPos()
			end
		else
			print(v[1], " ", v[3]())
		end
	end
	
	if isSettingOption then
		term.setCursorPos(x, y - 1)
		term.clearLine()
		term.write("[" .. Options[Selection][1] .. "] ")

		local newValue = tonumber(io.read())
		
		while newValue == nil do
			newValue = tonumber(io.read())
		end
		
		Options[Selection][4](newValue)
		
		isSettingOption = false
	end
end

-- Call enter function of selected option
Enter = function()
	if Options[Selection][2] ~= nil then
		return Options[Selection][2]()
	end
end

-- Return previous menu
Escape = function()
	return MenuArea
end
