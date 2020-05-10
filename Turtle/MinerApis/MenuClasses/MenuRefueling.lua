-- MenuRefueling

-- Currently selected menu option
Selection = 1

-- Avalable menu options { "name", function() "doStuffOnEnter" end }
Options = {
	{"Refuel", function() TurtleUtilities.Refuel() end, function() return turtle.getFuelLevel() .. "/" .. turtle.getFuelLimit() end}
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
	for i,v in ipairs(Options) do
		if Selection == i then
			print("[",v[1],"]",v[3]())
		else
			print(v[1], " ", v[3]())
		end
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
	return MenuMain
end
