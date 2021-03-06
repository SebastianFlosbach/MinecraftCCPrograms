-- Refuel Prompt

-- Currently selected menu option
Selection = 1
ReturnMenu = nil

-- Return previous menu
Escape = function()
	if MenuRefuelPrompt.ReturnMenu == nil then
		return MenuMain
	else
		local menu = MenuRefuelPrompt.ReturnMenu
		MenuRefuelPrompt.ReturnMenu = nil
		return menu
	end
end

-- Avalable menu options { "name", function() "doStuffOnEnter" end }
Options = {
	{"Ok", function() return Escape() end}
}

-- Move selection up if possible
SelectionUp = function()
	if Selection > 1 then
		Selection = Selection - 1
	end
end

-- Move selection down if possible
SelectionDown = function()
	if Selection < table.getn(Options) then
		Selection = Selection + 1
	end
end

-- Print menu with current selection
Print = function()
	print("Missing Fuel!")
	for i,v in ipairs(Options) do
		if Selection == i then
			print("[",v[1],"]")
		else
			print(v[1])
		end
	end
end

-- Call enter function of selected option
Enter = function()
	if Options[Selection][2] ~= nil then
		return Options[Selection][2]()
	end
end
