-- Menus


local API_PATH_BASE = ""
if not fs.exists("MinerApis") then
	API_PATH_BASE = "rom/programs/turtle/"
end

os.loadAPI(API_PATH_BASE .. "MinerApis/MenuClasses/MenuMain.lua")

CurrentMenu = MenuMain
Header = nil
	
Print = function()
	term.clear()
	term.setCursorPos(1,1)
	
	if Menus.Header ~= nil then
		print(Menus.Header)
		term.setCursorPos(1,3)
	end

	CurrentMenu.Print()				
end

SelectionUp = function()
	CurrentMenu.SelectionUp()
end

SelectionDown = function()
	CurrentMenu.SelectionDown()
end

Enter = function()
	CurrentMenu = CurrentMenu.Enter() or CurrentMenu
end

Escape = function()
	CurrentMenu = CurrentMenu.Escape() or CurrentMenu
end
