
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = game:GetService("Workspace").CurrentCamera


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
