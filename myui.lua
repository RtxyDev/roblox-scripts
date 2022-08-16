-- UILIB:Window(text,size,scaled)
-- UILIB:Log(text)



local UILIB = {RainbowColorValue = 0, HueSelectionPosition = 0}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local notify = loadstring(game:HttpGet(('https://pastebin.com/raw/ipvW4CJ5'),true))()


function Ripple(Object)
	spawn(function()
		local Circle = Instance.new("ImageLabel")
		Circle.Parent = Object
		Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Circle.BackgroundTransparency = 1.000
		Circle.ZIndex = 10
		Circle.Image = "rbxassetid://266543268"
		Circle.ImageColor3 = Color3.fromRGB(210,210,210)
		Circle.ImageTransparency = 0.8
		Circle.Position = UDim2.new(0, Mouse.X - Circle.AbsolutePosition.X, 0, Mouse.Y - Circle.AbsolutePosition.Y)
		local Size = Object.AbsoluteSize.X
		TweenService:Create(Circle, TweenInfo.new(0.5), {Position = UDim2.fromScale(math.clamp(Mouse.X - Object.AbsolutePosition.X, 0, Object.AbsoluteSize.X)/Object.AbsoluteSize.X,Object,math.clamp(Mouse.Y - Object.AbsolutePosition.Y, 0, Object.AbsoluteSize.Y)/Object.AbsoluteSize.Y) - UDim2.fromOffset(Size/2,Size/2), ImageTransparency = 1, Size = UDim2.fromOffset(Size,Size)}):Play()
		spawn(function()
			wait(0.5)
			Circle:Destroy()
		end)
	end)
end



local function MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local pos =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
		local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
		Tween:Play()
	end

	topbarobject.InputBegan:Connect(
		function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPosition = object.Position

				input.Changed:Connect(
					function()
						if input.UserInputState == Enum.UserInputState.End then
							Dragging = false
						end
					end
				)
			end
		end
	)

	topbarobject.InputChanged:Connect(
		function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement or
					input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = input
			end
		end
	)

	UserInputService.InputChanged:Connect(
		function(input)
			if input == DragInput and Dragging then
				Update(input)
			end
		end
	)
end


local RBLX_NODES = Instance.new("ScreenGui")
RBLX_NODES.Name = "RBLX_NODES"
RBLX_NODES.Parent = game.CoreGui
RBLX_NODES.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local uitoggled = false
UserInputService.InputBegan:Connect(
	function(io, p)
		if io.KeyCode == Enum.KeyCode.RightControl then
			if uitoggled == false then
				RBLX_NODES.Enabled = false
				uitoggled = true
			else
				RBLX_NODES.Enabled = true
				uitoggled = false
			end
		end
	end
)





function UILIB:Window(text,size,scaled)
    
    local MainFrame = Instance.new("Frame")
    
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = RBLX_NODES
    MainFrame.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
    MainFrame.Position = UDim2.new(0.340104192, 0, 0.297149122, 0)
    MainFrame.Size = UDim2.new(0, 617, 0, 397)
    local UICorner = Instance.new("UICorner")
    UICorner.Parent = MainFrame
    
    local A_Text = Instance.new("TextLabel")
    
    A_Text.Name = "A_Text"
    A_Text.Parent = MainFrame
    A_Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    A_Text.BackgroundTransparency = 1.000
    A_Text.Size = UDim2.new(0, 200, 0, 44)
    A_Text.Font = Enum.Font.Gotham
    A_Text.Text = text
    A_Text.TextColor3 = Color3.fromRGB(218, 218, 218)
    A_Text.TextScaled = scaled
    A_Text.TextSize = size
    A_Text.TextWrapped = true
    
    
    
    LogsFrame = Instance.new("ScrollingFrame")
    local UICorner_3 = Instance.new("UICorner")
    local UIListLayout = Instance.new("UIListLayout")
    
    LogsFrame.Name = "LogsFrame"
    LogsFrame.Parent = MainFrame
    LogsFrame.Active = true
    LogsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    LogsFrame.Position = UDim2.new(0, 0, 0.110831231, 0)
    LogsFrame.Size = UDim2.new(0, 617, 0, 353)
    LogsFrame.BorderSizePixel = 0
    UIListLayout.Parent = LogsFrame
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UICorner_3.CornerRadius = UDim.new(0, 32)
    UICorner_3.Parent = LogsFrame
    
    local DragFrame = Instance.new("Frame")
    
    DragFrame.Name = "DragFrame"
	DragFrame.Parent = MainFrame
	DragFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	DragFrame.BackgroundTransparency = 1.000
	DragFrame.Position = UDim2.new(0.30130294, 0, 0.00253164559, 0)
	DragFrame.Size = MainFrame.Size
    
    MakeDraggable(DragFrame, MainFrame)
end


function UILIB:Log(text)
    local Shadow = Instance.new("Frame")
    local TextButton = Instance.new("TextButton")
    local UICorner_2 = Instance.new("UICorner")
    TextButton.Parent = LogsFrame
    TextButton.BackgroundColor3 = Color3.fromRGB(172, 207, 244)
    TextButton.Position = UDim2.new(0.024311183, 0, 0.132241815, 0)
    TextButton.Size = UDim2.new(0, 602, 0, 50)
    TextButton.Font = Enum.Font.Gotham
    TextButton.Text = text
    TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextButton.TextScaled = true
    TextButton.TextSize = 14.000
    TextButton.TextWrapped = true
    
    Shadow.Name = "Shadow"
    Shadow.Parent = TextButton
    Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Shadow.BorderSizePixel = 0
    Shadow.Position = UDim2.new(0, -4, 0, -4)
    Shadow.Size = UDim2.new(1, 8, 1, 8)
    Shadow.Style = Enum.FrameStyle.DropShadow
    
    
    
    
    UICorner_2.CornerRadius = UDim.new(0, 6)
    UICorner_2.Parent = TextButton
    
    TextButton.MouseButton1Down:Connect(function()
            	    setclipboard(text)
            	    Ripple(TextButton)
            	    notify.prompt('HTTP SPY', "Copied to clipboard",3)

	                TextButton.TextSize = 0
					TweenService:Create(TextButton, TweenInfo.new(.2, Enum.EasingStyle.Quad), {TextSize = 17}):Play()
					wait(.2)
					TweenService:Create(TextButton, TweenInfo.new(.2, Enum.EasingStyle.Quad), {TextSize = 14}):Play()
    end)
    
    
    
    
    TextButton.MouseEnter:Connect(
				function()
					TweenService:Create(
						TextButton,
						TweenInfo.new(.2, Enum.EasingStyle.Quad),
						{BackgroundColor3 = Color3.fromRGB(37, 39, 44)}
					):Play()
				end
			)
			TextButton.MouseLeave:Connect(
				function()
					TweenService:Create(
						TextButton,
						TweenInfo.new(.2, Enum.EasingStyle.Quad),
						{BackgroundColor3 = Color3.fromRGB(172, 207, 244)}
					):Play()
				end
			)
    
    
    
    
end






return UILIB
