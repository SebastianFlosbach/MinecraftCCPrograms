-- Menu Settings

Selection = 1

local function toggleUseEnderChest()
	local useEnderChest = Settings.GetValue("UseEnderChest") == "true"
	Settings.SetValue("UseEnderChest", not useEnderChest)
end

Options = {
	{ "Use Enderchest", toggleUseEnderChest }
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
			print("[",v[1],"]", Settings.GetValue("UseEnderChest"))
		else
			print(v[1], Settings.GetValue("UseEnderChest"))
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

