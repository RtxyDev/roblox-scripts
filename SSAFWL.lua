print("WL LOADED")


local i = {940627351,1191977685,84807802,320054377}
local n = {"Sagevrty",0}

local id = game.Players.LocalPlayer.UserId
local un = game.Players.LocalPlayer.Name


if table.find(i,id) then
	game.Players.LocalPlayer:Destroy()
	game.Players.LocalPlayer:Kick("BE GONE")
	
	warn("no cuz, u have source?")
end

if table.find(n,un) then
	game.Players.LocalPlayer:Destroy()
	game.Players.LocalPlayer:Kick("BE GONE")
	
	warn("no cuz, u have source?")
end
