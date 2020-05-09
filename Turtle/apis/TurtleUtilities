-- Turtle utilities

local FUEL_SAFETY_MARGIN = 1.2

local fuelValues = {
	["minecraft:coal"] = 80,
	["minecraft:reeds"] = 2,
	["minecraft:lava_bucket"] = 1000,
	["minecraft:blaze_rod"] = 120,
	["minecraft:planks"] = 15,
	["minecraft:stick"] = 5,
	["railcraft:fuel_coke"] = 160,
	["ic2:coke"] = 160
}

function FindItem(itemName)
	for i = 1, 16 do
		local item = turtle.getItemDetail(i)
		if item ~= nil and item.name == itemName then
			return i
		end		
	end
	return -1
end

-- Check if fuel level is higher then level, else wait until enough fuel is provided in slot 2
function Refuel(level)
	level = level or -1
	
	if level == -1 then
		local fuelSlot = findFuel()
		while fuelSlot >= 0 do
			turtle.select(fuelSlot)
			turtle.refuel()
			fuelSlot = findFuel()
		end
		return true	
	end

	if turtle.getFuelLevel() < level * FUEL_SAFETY_MARGIN then
		while turtle.getFuelLevel() < level * FUEL_SAFETY_MARGIN do
			local fuelSlot = findFuel()
			if fuelSlot >= 0 then
				turtle.select(fuelSlot)
				turtle.refuel(1)
			else
				return false
			end
		end
	end
	
	return true
end

function findFuel()
	for i = 1, 16 do
		local item = turtle.getItemDetail(i)
		if item ~= nil and fuelValues[item.name] ~= nil then
			return i
		end		
	end
	return -1
end