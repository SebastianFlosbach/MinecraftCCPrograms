-- MenuArea

local API_PATH_BASE = ""
if not fs.exists("MinerApis") then
	API_PATH_BASE = "rom/programs/turtle/"
end

os.loadAPI(API_PATH_BASE .. "MinerApis/MenuClasses/MenuAreaSettings.lua")

-- Currently selected menu option
Selection = 1

-- Avalable menu options { "name", function() "doStuffOnEnter" end }
local function run()
	local width = tonumber(Settings.GetValue("AreaWidth"))
	local height = tonumber(Settings.GetValue("AreaHeight"))
	local length = tonumber(Settings.GetValue("AreaLength"))
	local useEnderChest = Settings.GetValue("UseEnderChest") == "true"
	
	if not Mining.Area(width, height, length, useEnderChest) then
		MenuRefuelPrompt.ReturnMenu = MenuArea
		return MenuRefuelPrompt
	end
end

Options = {
	{ "Run", run },
	{ "Settings", function() return MenuAreaSettings end }
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

-- Return previous menu
Escape = function()
	return MenuMain
end
