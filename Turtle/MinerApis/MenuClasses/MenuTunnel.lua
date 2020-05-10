-- Tunnel

local API_PATH_BASE = ""
if not fs.exists("MinerApis") then
	API_PATH_BASE = "rom/programs/turtle/"
end

os.loadAPI(API_PATH_BASE .. "MinerApis/MenuClasses/MenuRefuelPrompt.lua")
os.loadAPI(API_PATH_BASE .. "MinerApis/MenuClasses/MenuTunnelSettings.lua")

Selection = 1

local function run()
	local height = tonumber(Settings.GetValue("TunnelHeight"))
	local length = tonumber(Settings.GetValue("TunnelLength"))
	local useEnderChest = Settings.GetValue("UseEnderChest") == "true"
	
	if not Mining.Tunnel(height, length, useEnderChest) then
		MenuRefuelPrompt.ReturnMenu = MenuTunnel
		return MenuRefuelPrompt
	end
end

Options = {
	{ "Run", run },
	{ "Settings", function() return MenuTunnelSettings end }
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
	return MenuMain
end
