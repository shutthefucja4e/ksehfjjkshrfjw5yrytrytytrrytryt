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
    KeySystem = false
})

Lib:Notify("AutoBuy & AutoSell", "developed by offset", 4483362458)

local AutoBuyTab = Window:CreateTab("AutoBuy", 4483362458)

local Section = AutoBuyTab:CreateSection("AutoBuy")

local charactersToBuy = {
    ["Car Speakerman"] = 5,
    ["Summer Crate"] = 500,
    ["Clock Spider"] = 500
}

local function findCharacterObject(characterName)
    local allUnits = game:GetService("Players").LocalPlayer.PlayerGui.Lobby.MarketplaceFrame.MarketplaceMain.MainFrame.BuyMenu.AllUnits
    for i, unit in ipairs(allUnits:GetChildren()) do
        if unit:IsA("Frame") then
            local mainFrame = unit:FindFirstChild("MainFrame")
            if mainFrame then
                local unitInfo = mainFrame:FindFirstChild("UnitInfo")
                if unitInfo then
                    local unitName = unitInfo:FindFirstChild("UnitName")
                    if unitName and unitName:IsA("TextLabel") then
                        local unitNameText = unitName.Text
                        print("Checking unit " .. i .. ": " .. unitNameText)
                        if unitNameText:find(characterName) then
                            return unit
                        end
                    end
                end
            end
        end
    end
    print("Character not found: " .. characterName)
    return nil
end

local function getRarity(characterObject)
    local rarityLabels = {"Uncommon", "Ultimate", "Rare", "Mythic", "Legendary", "Godly", "Exclusive", "Epic", "Basic"}
    for _, rarity in ipairs(rarityLabels) do
        if characterObject.MainFrame:FindFirstChild(rarity) then
            return rarity
        end
    end
    return nil
end

local function buyCharacter(characterObject)
    local priceLabel = characterObject.MainFrame.UnitInfo.BestPrice.BestPrice
    local price = tonumber(priceLabel.Text:match("%d+"))
    local maxPrice = charactersToBuy[characterObject.MainFrame.UnitInfo.NameLabel.Text]
    
    if price and price <= maxPrice then
        local buyButton = characterObject.MainFrame.UnitInfo.Buttons.BuyUnit.BuyButton
        print("Attempting to buy " .. characterObject.MainFrame.UnitInfo.NameLabel.Text)
    end
end

local function switchToTab(tabName)
    local filterBar = game:GetService("Players").LocalPlayer.PlayerGui.Lobby.MarketplaceFrame.MarketplaceMain.MainFrame.BuyMenu.FilterBar.Rarities
    local tabButton = filterBar:FindFirstChild(tabName).FilterButton
    print("Switching to " .. tabName .. " tab")
end

local function autoBuy()
    for characterName, _ in pairs(charactersToBuy) do
        local characterObject = findCharacterObject(characterName)
        if characterObject then
            local rarity = getRarity(characterObject)
            if rarity then
                switchToTab(rarity)
                wait(1)
                buyCharacter(characterObject)
            else
                print("Rarity not found for: " .. characterName)
            end
        else
            print("Character not found: " .. characterName)
        end
        wait(1)
    end
end

local AutoBuyToggle = AutoBuyTab:CreateToggle({
    Name = "Toggle AutoBuy",
    CurrentValue = false,
    Flag = "AutoBuyToggle",
    Callback = function(Value)
        if Value then
            while Value do
                autoBuy()
                wait(10)
            end
        end
    end,
})

local NotifyBuy = AutoBuyTab:CreateToggle({
    Name = "Toggle NotifyBuy",
    CurrentValue = false,
    Flag = "NotifyBuyToggle",
    Callback = function(Value)
        print("[StedHub] -> You are activated Notify Buy in config!")
    end
})

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

local AcceptAllTradesT = AutoBuyTab:CreateToggle({
    Name = "Toggle AcceptAllTrades",
    CurrentValue = false,
    Flag = "AcceptTradesToggle",
    Callback = function(Value)
        local Players = game:GetService("Players")
        print("[StedHub] -> You are activated AcceptAllTrades! [?]")
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
        print("[StedHub] -> You are activated AcceptAllTrades! [?]")
        sendEventToPlayer()
        for _, player in ipairs(Players:GetPlayers()) do
            sendEventToPlayer(player)
        end
        Players.PlayerAdded:Connect(function(player)
            sendEventToPlayer(player)
        end)
    end
})
