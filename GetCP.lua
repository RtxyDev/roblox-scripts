local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local GetChildren = game.GetChildren
local GetPlayers = Players.GetPlayers
local WorldToScreen = Camera.WorldToScreenPoint
local WorldToViewportPoint = Camera.WorldToViewportPoint
local GetPartsObscuringTarget = Camera.GetPartsObscuringTarget
local UserInputService = game:GetService("UserInputService")
local GetMouseLocation = UserInputService.GetMouseLocation
local ValidTargetParts = {"Head", "HumanoidRootPart"}

local function IsPlayerVisible(Player,Part)
    local PlayerCharacter = Player.Character
    local LocalPlayerCharacter = LocalPlayer.Character
    
    if not (PlayerCharacter or LocalPlayerCharacter) then return end 
    
    local PlayerRoot = FindFirstChild(PlayerCharacter, Part) or FindFirstChild(PlayerCharacter, "HumanoidRootPart")
    
    if not PlayerRoot then return end 
    
    local CastPoints, IgnoreList = {PlayerRoot.Position, LocalPlayerCharacter, PlayerCharacter}, {LocalPlayerCharacter, PlayerCharacter}
    local ObscuringObjects = #GetPartsObscuringTarget(Camera, CastPoints, IgnoreList)
    
    return ((ObscuringObjects == 0 and true) or (ObscuringObjects > 0 and false))
end


local function getMousePosition()
    return GetMouseLocation(UserInputService)
end

local function getPositionOnScreen(Vector)
    local Vec3, OnScreen = WorldToScreen(Camera, Vector)
    return Vector2.new(Vec3.X, Vec3.Y), OnScreen
end



getgenv().getClosestPlayer = function(TeamCheck,Raidus)
    TeamCheck = TeamCheck or false
    Raidus = Raidus or 1/0

    local ClosestDistance, ClosestPlayer = Raidus, nil;
    for _, Player in next, game:GetService("Players"):GetPlayers() do
        if Player ~= LocalPlayer then
            
            if TeamCheck and Player.Team == LocalPlayer.Team then continue end

            local Character = Player.Character
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
            local Humanoid = Character:FindFirstChild("Humanoid")

            if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end

            if Character and Humanoid.Health > 1 then
                local ScreenPosition, IsVisibleOnViewPort = Camera:WorldToViewportPoint(HumanoidRootPart.Position)
                if IsVisibleOnViewPort then
                    local MDistance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(ScreenPosition.X, ScreenPosition.Y)).Magnitude
                    if MDistance < ClosestDistance then
                        ClosestPlayer = Player
                        ClosestDistance = MDistance
                    end
                end
            end
        end
    end
    return ClosestPlayer
  
end
