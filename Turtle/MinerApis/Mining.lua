-- Mining

local ENDER_CHEST_NAME = "enderstorage:ender_storage"

local function forward()
	while not turtle.forward() do
		turtle.dig()
	end
end

local function up()
	while not turtle.up() do
		turtle.digUp()
	end
end

local function down()
	while not turtle.down() do
		turtle.digDown()
	end
end

--Return to wherever dig() started
local function returnToStart(x,z)
	if math.fmod(x,2) == 0 then
		turtle.turnRight()
		for i=1,x-1 do
			forward()
		end
		turtle.turnRight()
	else
		turtle.turnLeft()
		for i=1,x-1 do
			forward()
		end
		turtle.turnLeft()
		for i=1,z-1 do
			forward()
		end
		turtle.turnLeft()
		turtle.turnLeft()
	end
end

local function emptyInventory()
	local rot = 0
	while turtle.detect() and rot < 4 do
		turtle.turnRight()
		rot = rot + 1
	end
	if rot == 4 then
		for i=1,rot do
			turtle.turnLeft()
		end
		return false
	end
	local chestSlot = TurtleUtilities.FindItem(ENDER_CHEST_NAME)
	if chestSlot == -1 then
		return false
	end
	turtle.select(chestSlot)
	turtle.place()
	for i=1,16 do
		turtle.select(i)
		turtle.drop()
	end
	turtle.dig()
	for i=1,rot do
		turtle.turnLeft()
	end
	return true
end

local function emptyInventoryIfFull()
	if turtle.getItemCount(16) > 0 then
		return emptyInventory()
	end
	return false
end

local function dig(x,z,h,useEnderChest)
	if not TurtleUtilities.Refuel(x*z+x+z) then
		return false
	end	
	
	local rot = 0
	for i=1,x-1 do
		for j=1,z-1 do
			if h >= 2 then turtle.digUp() end			
			if h >= 3 then turtle.digDown() end
			if useEnderChest then emptyInventoryIfFull() end
			forward()
		end
		if rot == 0 then
			turtle.turnRight()
			if h >= 2 then turtle.digUp() end			
			if h >= 3 then turtle.digDown() end
			forward()
			turtle.turnRight()
			rot = 1
		else
			turtle.turnLeft()
			if h >= 2 then turtle.digUp() end			
			if h >= 3 then turtle.digDown() end
			forward()
			turtle.turnLeft()
			rot = 0
		end
	end
	for j=1,z-1 do
		if h >= 2 then turtle.digUp() end			
		if h >= 3 then turtle.digDown() end
		if useEnderChest then emptyInventoryIfFull() end
		forward()
	end
	if h >= 2 then turtle.digUp() end			
	if h >= 3 then turtle.digDown() end
	
	return true
end

function Tunnel(h, l, useEnderChest)
	local fuelNeeded = 2*l + 10

	if h ~= 1 then
		fuelNeeded = 2*l + 3 + 10
	end
	
	if not TurtleUtilities.Refuel(fuelNeeded) then 
		return false
	end
	
	if not dig(0,l,3,useEnderChest) then return false end
	
	if h == 1 then
		turtle.turnLeft()
		turtle.turnLeft()
		local pos = 0
		while pos < l do
			forward()		
			pos = pos + 1
		end
		if useEnderChest then emptyInventory() end
	else 
		for i=0,2 do
			up()
		end
		
		turtle.turnLeft()
		turtle.turnLeft()
		
		if not dig(0,l,3) then return false end
		
		for i=0,2 do
			turtle.down()
		end
		turtle.turnLeft()
		turtle.turnLeft()
		if useEnderChest then emptyInventory() end
	end
	
	return true
end

function Area(x,y,z, useEnderChest)	
	local h = y
	
	local fuelNeeded = x * z * math.ceil(z / 3)
	if not TurtleUtilities.Refuel(fuelNeeded) then
		return false
	end
	
	while h > 0 do
		if h > 3 then	
			up()
			dig(x,z,3,useEnderChest)
			returnToStart(x,z)
			up()
			up()
			h = h - 3
		elseif h == 3 then
			up()
			dig(x,z,3,useEnderChest)
			returnToStart(x,z)
			if useEnderChest then emptyInventory() end
			return true
		elseif h == 2 then
			dig(x,z,2, useEnderChest)
			returnToStart(x,z)
			if useEnderChest then emptyInventory() end
			return true
		elseif h == 1 then
			dig(x,z,1,useEnderChest)
			returnToStart(x,z)
			if useEnderChest then emptyInventory() end
			return true
		end
	end
end