--// SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LP = Players.LocalPlayer

-- Hapus kalau ada
if LP.PlayerGui:FindFirstChild("WindModern") then
	LP.PlayerGui.WindModern:Destroy()
end

--// GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LP.PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "WindModern"

--------------------------------------------------
-- MAIN WINDOW (SLIGHTLY TALLER)
--------------------------------------------------

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.fromScale(0.48,0.55) -- lebih tinggi
Main.Position = UDim2.fromScale(0.5,0.5)
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.BackgroundColor3 = Color3.fromRGB(0,0,0)
Main.BackgroundTransparency = 0.15
Main.BorderSizePixel = 0
Instance.new("UICorner",Main).CornerRadius = UDim.new(0,18)

local Stroke = Instance.new("UIStroke",Main)
Stroke.Color = Color3.fromRGB(0,120,255)
Stroke.Thickness = 1.8

--------------------------------------------------
-- HEADER
--------------------------------------------------

local Header = Instance.new("Frame",Main)
Header.Size = UDim2.new(1,0,0,50)
Header.BackgroundTransparency = 1

-- LOGO IMAGE (HEADER)
local HeaderLogo = Instance.new("ImageLabel",Header)
HeaderLogo.Size = UDim2.fromOffset(30,30)
HeaderLogo.Position = UDim2.new(0,15,0.5,-15)
HeaderLogo.BackgroundTransparency = 1
HeaderLogo.Image = "rbxassetid://73349555895759"

local Title = Instance.new("TextLabel",Header)
Title.Size = UDim2.new(0.6,0,1,0)
Title.Position = UDim2.new(0,55,0,0)
Title.BackgroundTransparency = 1
Title.Text = "WindUI Modern"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 17
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- EXPAND BUTTON
local Expand = Instance.new("TextButton",Header)
Expand.Size = UDim2.fromOffset(30,30)
Expand.Position = UDim2.new(1,-70,0.5,-15)
Expand.Text = "+"
Expand.TextColor3 = Color3.new(1,1,1)
Expand.BackgroundColor3 = Color3.fromRGB(25,25,25)
Expand.BorderSizePixel = 0
Instance.new("UICorner",Expand).CornerRadius = UDim.new(0,8)

local ExpandStroke = Instance.new("UIStroke",Expand)
ExpandStroke.Color = Color3.fromRGB(0,120,255)
ExpandStroke.Thickness = 1

-- CLOSE BUTTON
local Close = Instance.new("TextButton",Header)
Close.Size = UDim2.fromOffset(30,30)
Close.Position = UDim2.new(1,-35,0.5,-15)
Close.Text = "X"
Close.TextColor3 = Color3.new(1,1,1)
Close.BackgroundColor3 = Color3.fromRGB(120,0,0)
Close.BorderSizePixel = 0
Instance.new("UICorner",Close).CornerRadius = UDim.new(0,8)




--------------------------------------------------
-- EXPAND SYSTEM (SMOOTH)
--------------------------------------------------

local expanded = false
local smallSize = UDim2.fromScale(0.48,0.55)
local bigSize = UDim2.fromScale(0.85,0.80)

Expand.MouseButton1Click:Connect(function()
	expanded = not expanded
	
	if expanded then
		TweenService:Create(Main,TweenInfo.new(0.25),{Size = bigSize}):Play()
	else
		TweenService:Create(Main,TweenInfo.new(0.25),{Size = smallSize}):Play()
	end
end)

--------------------------------------------------
-- CLOSE → FLOATING IMAGE LOGO (SQUARE)
--------------------------------------------------

local Logo = Instance.new("ImageButton",ScreenGui)
Logo.Size = UDim2.fromOffset(65,65)
Logo.Position = UDim2.new(0,20,0.5,-32)
Logo.BackgroundColor3 = Color3.fromRGB(0,0,0)
Logo.BackgroundTransparency = 0.15
Logo.Image = "rbxassetid://73349555895759"
Logo.Visible = false
Logo.BorderSizePixel = 0
Instance.new("UICorner",Logo).CornerRadius = UDim.new(0,14) -- kotak rounded, bukan lingkaran

local LogoStroke = Instance.new("UIStroke",Logo)
LogoStroke.Color = Color3.fromRGB(0,120,255)
LogoStroke.Thickness = 1.8

Close.MouseButton1Click:Connect(function()
	Main.Visible = false
	Logo.Visible = true
end)

Logo.MouseButton1Click:Connect(function()
	Main.Visible = true
	Logo.Visible = false
end)

--------------------------------------------------
-- DRAG WINDOW
--------------------------------------------------

local dragging = false
local dragStart
local startPos

Header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		
		dragging = true
		dragStart = input.Position
		startPos = Main.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and 
	   (input.UserInputType == Enum.UserInputType.MouseMovement
	   or input.UserInputType == Enum.UserInputType.Touch) then
		
		local delta = input.Position - dragStart
		
		Main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

--------------------------------------------------
-- DRAG FLOATING LOGO
--------------------------------------------------

local logoDrag = false
local logoStart
local logoPos

Logo.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		
		logoDrag = true
		logoStart = input.Position
		logoPos = Logo.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				logoDrag = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if logoDrag and 
	   (input.UserInputType == Enum.UserInputType.MouseMovement
	   or input.UserInputType == Enum.UserInputType.Touch) then
		
		local delta = input.Position - logoStart
		
		Logo.Position = UDim2.new(
			logoPos.X.Scale,
			logoPos.X.Offset + delta.X,
			logoPos.Y.Scale,
			logoPos.Y.Offset + delta.Y
		)
	end
end)
