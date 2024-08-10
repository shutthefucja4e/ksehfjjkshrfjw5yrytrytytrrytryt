local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "AutoBuy & AutoSell",
    SubTitle = "by offset | version: beta",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

Fluent:Notify({
    Title = "AutoBuy & AutoSell",
    Content = "developed by offset",
    Duration = 5
})

local AutoBuyTab = Window:AddTab({ Title = "AutoBuy", Icon = "rbxassetid://4483362458" })

local AutoBuySection = AutoBuyTab:AddSection("AutoBuy")

AutoBuySection:AddButton({
    Title = "Remove Other UIs",
    Callback = function()
        -- Add your remove UI logic here
    end
})

local function autoBuyMake()
    local Players = game:GetService("Players")
    local Gems = Players.LocalPlayer.leaderstats.Gems.Value
    local Attempt = Gems / 50

    print("[StedHub] -> Thank you for choosing our product in the form of AutoBuy & AutoSell! [✅]")
    print("[StedHub] -> Your gem balance - " .. Gems .. " approximately, you will have enough of them for " .. Attempt .. " attempts for buy! [✅]")
    print("[StedHub] -> Good Luck! [✅]")
end

AutoBuySection:AddToggle("AutoBuyToggle", {
    Title = "Toggle AutoBuy",
    Default = false,
    Callback = function(Value)
        local Gems = game:GetService("Players").LocalPlayer.leaderstats.Gems.Value
        if Gems >= 150 then
            autoBuyMake()
        else
            print("[StedHub] -> AutoBuy stopped. Your balance - " .. Gems .. " gems, which is not enough for the norm! [⛔]")
            print("[StedHub] -> Any time you try to turn it off and on, you will be shown this error. [⛔]")
        end
    end
})

AutoBuySection:AddToggle("NotifyBuyToggle", {
    Title = "Toggle NotifyBuy",
    Default = false,
    Callback = function(Value)
        print("[StedHub] -> You are activated Notify Buy in config! [✅]")
    end
})

AutoBuySection:AddSlider("SpeedBuySlider", {
    Title = "Speed Buy",
    Default = 10,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Callback = function(Value)
        -- Add your speed buy logic here
    end
})

AutoBuySection:AddInput("BiggerLook", {
    Title = "Bigger Look",
    Default = "",
    Placeholder = "Rarity",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        -- Add your bigger look logic here
    end
})

local UnhookTab = Window:AddTab({ Title = "Unhook", Icon = "rbxassetid://4483362458" })

UnhookTab:AddButton({
    Title = "Unhook UI",
    Callback = function()
        Fluent:Destroy()
    end
})

local OtherTab = Window:AddTab({ Title = "Other", Icon = "rbxassetid://4483362458" })

local function sendEventToPlayer(player)
    local dataRemoteEvent = game:GetService("ReplicatedStorage").dataRemoteEvent
    local args = {
        [1] = {
            [1] = {
                [1] = "0",
                [2] = player
            },
            [2] = "40"
        }
    }
    dataRemoteEvent:FireServer(unpack(args))
end

local function AcceptTradesF()
    local dataRemoteEvent = game:GetService("ReplicatedStorage").dataRemoteEvent
    local args = {
        [1] = {
            [1] = {
                [1] = "0",
                [2] = true
            },
            [2] = "4v"
        }
    }
    dataRemoteEvent:FireServer(unpack(args))
end

AutoBuySection:AddToggle("AcceptTradesToggle", {
    Title = "Toggle AcceptAllTrades",
    Default = false,
    Callback = function(Value)
        local Players = game:GetService("Players")
        print("[StedHub] -> You are activated AcceptAllTrades! [✅]")
        if Value then
            while true do
                AcceptTradesF()
                wait(1)
            end
        end
    end
})

AutoBuySection:AddToggle("TradesAllToggle", {
    Title = "Toggle TradesAll",
    Default = false,
    Callback = function(Value)
        local Players = game:GetService("Players")
        local dataRemoteEvent = game:GetService("ReplicatedStorage").dataRemoteEvent

        local function sendEventToPlayer(player)
            local args = {
                [1] = {
                    [1] = {
                        [1] = "0",
                        [2] = player
                    },
                    [2] = "40"
                }
            }
            dataRemoteEvent:FireServer(unpack(args))
        end

        if Value then
            print("[StedHub] -> You have activated TradesAll! [✅]")

            -- Send event to all current players
            for _, player in ipairs(Players:GetPlayers()) do
                sendEventToPlayer(player)
            end

            -- Set up connection for new players
            local connection
            connection = Players.PlayerAdded:Connect(function(player)
                sendEventToPlayer(player)
            end)

            -- Store the connection in the toggle's state
            AutoBuySection.Options.TradesAllToggle.Connection = connection
        else
            print("[StedHub] -> You have deactivated TradesAll! [❌]")

            -- Disconnect the PlayerAdded event if it exists
            if AutoBuySection.Options.TradesAllToggle.Connection then
                AutoBuySection.Options.TradesAllToggle.Connection:Disconnect()
                AutoBuySection.Options.TradesAllToggle.Connection = nil
            end
        end
    end
})

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("AutoBuy & AutoSell")
SaveManager:BuildConfigSection(Window.Tabs.Settings)
InterfaceManager:BuildInterfaceSection(Window.Tabs.Settings)

SaveManager:LoadAutoloadConfig()
