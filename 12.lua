local Lib = loadstring(game:HttpGet('https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua'))()

local Window = Lib:CreateWindow({
    Name = "AutoBuy & AutoSell",
    LoadingTitle = "AutoBuy & AutoSell",
    LoadingSubtitle = "by offset | version: beta",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "AutoBuy & AutoSell",
        FileName = "autobuy"
    },
    KeySystem = false,
    KeySettings = {
        Title = "Sted Hub",
        Subtitle = "Key System",
        Note = "Join the discord (discord.gg/stedhub)",
        SaveKey = true,
        Key = "stedhubGS"
    }
})

Lib:Notify("AutoBuy & AutoSell", "developed by offset", 4483362458)

local AutoBuyTab = Window:CreateTab("AutoBuy", 4483362458)

local Section = AutoBuyTab:CreateSection("AutoBuy")

local RemoveOtherUIs = AutoBuyTab:CreateButton({
    Name = "Remove Other UIs",
    Callback = function()

    end,
})

local function autoBuyMake ()
    local Players = game:GetService("Players")
    local Gems = game:GetService("Players").LocalPlayer.leaderstats.Gems.Value
    local Attempt = Gems / 50

    print("[StedHub] -> Thank you for choosing our product in the form of AutoBuy & AutoSell! [✅]")
    print("[StedHub] -> Your gem balance - " + Gems + " approximately, you will have enough of them for " + Attempt + " attempts for buy! [✅]")
    print("[StedHub] -> Good Luck! [✅]")


end

local AutoBuyToggleOne = AutoBuyTab:CreateToggle({
    Name = "Toggle AutoBuy",
    CurrentValue = false,
    Flag = "AutoBuyToggle",
    Callback = function(Value)
        local Gems = game:GetService("Players").LocalPlayer.leaderstats.Gems.Value
        if Gems >= 150 then
            autoBuyMake()
        else
            print("[StedHub] -> AutoBuy stopped. Your balance - " .. Gems .. " gems, which is not enough for the norm! [⛔]")
            print("[StedHub] -> Any time you try to turn it off and on, you will be shown this error. [⛔]")
        end
    end,
})

local NotifyBuy = AutoBuyTab:CreateToggle{{
    Name = "Toggle NotifyBuy",
    CurrentValue = false,
    Flag = "NotifyBuyToggle",
    Callback = function(Value)
        print("[StedHub] -> You are activated Notify Buy in config! [✅]")
    end
}}

local Slider = AutoBuyTab:CreateSlider({
    Name = "Speed Buy",
    Range = {0, 100},
    Increment = 10,
    Suffix = "seconds",
    CurrentValue = 10,
    Flag = "SpeedBuySlider",
    Callback = function(Value)

    end,
})

local Input = AutoBuyTab:CreateInput({
    Name = "Bigger Look",
    PlaceholderText = "Rarity",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)

    end,
})

local UnhookTab = Window:CreateTab("Unhook", 4483362458)

local Button = UnhookTab:CreateButton({
    Name = "Unhook UI",
    Callback = function()
        Lib:Destroy()
    end,
})

local OtherTab = Window:CreateTab("Other", 4483362458)

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

local function AcceptTradesF ()
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

local AcceptAllTradesT = AutoBuyTab:CreateToggle({
    Name = "Toggle AcceptAllTrades",
    CurrentValue = false,
    Flag = "AcceptTradesToggle",
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

local TradesAllT = AutoBuyTab:CreateToggle({
    Name = "Toggle TradesAll",
    CurrentValue = false,
    Flag = "TradesAllToggle",
    Callback = function(Value)
        local Players = game:GetService("Players")
        
        print("[StedHub] -> You are activated AcceptAllTrades! [✅]")
        sendEventToPlayer()

        for _, player in ipairs(Players:GetPlayers()) do
            sendEventToPlayer(player)
        end
        
        Players.PlayerAdded:Connect(function(player)
            sendEventToPlayer(player)
        end)
    end
})  
