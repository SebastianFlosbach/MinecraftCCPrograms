shell.run("cd /")
shell.run("mkdir MinerApis")
shell.run("mkdir MinerApis/MenuClasses")

files = {
  "Miner.lua",
  "MinerApis/Menus.lua",
  "MinerApis/Mining.lua",
  "MinerApis/Settings.lua",
  "MinerApis/TurtleUtilities.lua",
  "MinerApis/MenuClasses/MenuArea.lua",
  "MinerApis/MenuClasses/MenuAreaSettings.lua",
  "MinerApis/MenuClasses/MenuBase.lua",
  "MinerApis/MenuClasses/MenuMain.lua",
  "MinerApis/MenuClasses/MenuRefuelPrompt.lua",
  "MinerApis/MenuClasses/MenuRefueling.lua",
  "MinerApis/MenuClasses/MenuSettings.lua",
  "MinerApis/MenuClasses/MenuTunnel.lua",
  "MinerApis/MenuClasses/MenuTunnelSettings.lua"
}


for i,v in pairs(files) do
  shell.run("wget https://github.com/SebastianFlosbach/MinecraftCCPrograms/raw/master/Turtle/" + v + " " + v)
end
