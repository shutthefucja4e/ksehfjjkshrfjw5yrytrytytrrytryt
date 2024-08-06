-- beta (version 1.2)

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleButton = Instance.new("TextButton")
local ActionButton = Instance.new("TextButton")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Frame.Position = UDim2.new(0.5, -100, 0.5, -75)
Frame.Size = UDim2.new(0, 200, 0, 150)

Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Мой UI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

ToggleButton.Parent = Frame
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleButton.Position = UDim2.new(0.1, 0, 0.3, 0)
ToggleButton.Size = UDim2.new(0.8, 0, 0, 30)
ToggleButton.Font = Enum.Font.SourceSans
ToggleButton.Text = "Переключатель: Выкл"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 14

ActionButton.Parent = Frame
ActionButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ActionButton.Position = UDim2.new(0.1, 0, 0.6, 0)
ActionButton.Size = UDim2.new(0.8, 0, 0, 30)
ActionButton.Font = Enum.Font.SourceSans
ActionButton.Text = "Выполнить действие"
ActionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ActionButton.TextSize = 14

local toggleState = false
ToggleButton.MouseButton1Click:Connect(function()
    toggleState = not toggleState
    ToggleButton.Text = "Переключатель: " .. (toggleState and "Вкл" or "Выкл")
end)

ActionButton.MouseButton1Click:Connect(function()
    print("Действие выполнено!")
end)