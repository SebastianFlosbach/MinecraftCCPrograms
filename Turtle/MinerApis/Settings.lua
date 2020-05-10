-- Settings

local SETTINGS_FOLDER = "settings"

local path = ""

function Initialize(name, settings)
	path = SETTINGS_FOLDER .. "/" .. name
	
	if not fs.exists(path) then
		fs.makeDir(SETTINGS_FOLDER)
		
		file = fs.open(path, "w")
		file.write(settings)
		file.close()
	end
end

local function readFile()
	local file = fs.open(path, "r")
	local line = file.readLine()
	local content = {}
	
	while line ~= nil do
		table.insert(content, line)
		
		line = file.readLine()
	end
	
	file.close()
	
	return content
end

local function writeFile(content)
	local file = fs.open(path,"w")
	for i,v in ipairs(content) do
		file.writeLine(v)
	end
	file.close()
end

function GetValue(key)
	local content = readFile()
	
	for i,v in ipairs(content) do
		if string.match(v, key) ~= nil then
			return string.sub(v, string.len(key) + 2)
		end
	end
end

function SetValue(key,value)
	local content = readFile()
	
	for i,v in ipairs(content) do
		if string.match(v, key) ~= nil then
			content[i] = string.sub(v, 1, string.len(key) + 1) .. tostring(value)
		end
	end
	
	writeFile(content)
end