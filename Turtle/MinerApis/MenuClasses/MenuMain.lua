-- Main

local API_PATH_BASE = ""
if not fs.exists("MinerApis") then
	API_PATH_BASE = "rom/programs/turtle/"
end

os.loadAPI(API_PATH_BASE .. "MinerApis/MenuClasses/MenuTunnel.lua")
os.loadAPI(API_PATH_BASE .. "MinerApis/MenuClasses/MenuArea.lua")
os.loadAPI(API_PATH_BASE .. "MinerApis/MenuClasses/MenuRefueling.lua")
os.loadAPI(API_PATH_BASE .. "MinerApis/MenuClasses/MenuSettings.lua")

Selection = 1

Options = {
	{ "Tunnel", function() return MenuTunnel end },
	{ "Area", function() return MenuArea end }, 
	{ "Refuel", function() return MenuRefueling end },
	{ "Settings", function() return MenuSettings end }
}

SelectionUp = function()
	if Selection > 1 then
		Selection = Selection - 1
	end
end

SelectionDown = function()
	if Selection < table.getn(Options) then
		Selection = Selection + 1
	end
end

Print = function()
	for i,v in ipairs(Options) do
		if Selection == i then
			print("[",v[1],"]")
		else
			print(v[1])
		end
	end
end

Enter = function()
	if Options[Selection][2] ~= nil then
		return Options[Selection][2]()
	end
end

Escape = function()
	-- Has no escape function
end
