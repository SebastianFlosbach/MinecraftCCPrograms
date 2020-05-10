-- Miner

MINER_VERSION = "0.3.1"
MINER_DATE = "10/05/2020"

local API_PATH_BASE = ""
if not fs.exists("MinerApis") then
	API_PATH_BASE = "rom/programs/turtle/"
end

local API_PATH_SETTINGS = "MinerApis/Settings.lua"
local API_PATH_TURTLEUTILITIES = "MinerApis/TurtleUtilities.lua"
local API_PATH_MINING = "MinerApis/Mining.lua"
local API_PATH_MENUS = "MinerApis/Menus.lua"

if not turtle then
	error("Cannot run on computer")
end

-- Wait for key input
function waitKey()
	local event, key = os.pullEvent("key")
	return key
end


function main()
	if not os.loadAPI(API_PATH_BASE .. API_PATH_SETTINGS) then
		print("Could not load 'Settings'")
		return
	end
	if not os.loadAPI(API_PATH_BASE .. API_PATH_TURTLEUTILITIES) then
		print("Could not load 'TurtleUtilities'")
		return
	end
	if not os.loadAPI(API_PATH_BASE .. API_PATH_MINING) then
		print("Could not load 'Mining'")
		return
	end
	if not os.loadAPI(API_PATH_BASE .. API_PATH_MENUS) then
		print("Could not load 'Menus'")
		return
	end
	
	Settings.Initialize(
		"miner",
		"-- Miner Settings \n" ..
		"-- General \n" ..
		"UseEnderChest false \n" ..
		"-- Tunnel \n" ..
		"TunnelLength 100 \n" ..
		"TunnelHeight 1 \n" ..
		"-- Area \n" ..
		"AreaWidth 10 \n" ..
		"AreaHeight 10 \n" ..
		"AreaLength 10 \n"	
	)
	
	Menus.Header = "Miner v" .. MINER_VERSION .. " " .. MINER_DATE
	
	while true do
		Menus.Print()		
		local event, key = os.pullEvent("key")
		if key == keys.up  then
			Menus.SelectionUp()
		elseif key == keys.down then
			Menus.SelectionDown()
		elseif key == keys.enter then
			Menus.Enter()
		elseif key == keys.backspace then
			Menus.Escape()
		end
	end
end

-- Run program
main()