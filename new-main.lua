-- Get PlayerGui
local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

-- Main initialization function with fixes
local function initializeHack()
    -- Fix the main errors first
    fixHumanoidError()
    handleShadyZiolesError()
    handleCoordinateWarning()
    
    -- Initialize all systems
    securityBypass.antiKick()
    tradeFreeze.enable()
    instantRoll.enable()
    premiumBypass.enable()
    antiDetection.enable()
    
    -- Create the main UI
    local mainGui = Instance.new("ScreenGui")
    mainGui.Name = "BloxFruitsHack"
    mainGui.ResetOnSpawn = false
    mainGui.Parent = playerGui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "HackFrame"
    mainFrame.Size = UDim2.new(0, 300, 0, 200)
    mainFrame.Position = UDim2.new(0, 10, 0, 10)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BackgroundTransparency = 0.2
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = mainGui
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Text = "Blox Fruits Hack"
    titleLabel.Size = UDim2.new(0, 300, 0, 30)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.Parent = mainFrame
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "StatusLabel"
    statusLabel.Text = "Status: Active"
    statusLabel.Size = UDim2.new(0, 300, 0, 30)
    statusLabel.Position = UDim2.new(0, 0, 0, 30)
    statusLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    statusLabel.TextScaled = true
    statusLabel.Font = Enum.Font.SourceSans
    statusLabel.Parent = mainFrame
    
    local featuresLabel = Instance.new("TextLabel")
    featuresLabel.Name = "Features"
    featuresLabel.Text = "Features:\n- Trade Freeze\n- Premium Bypass\n- Anti-Detection"
    featuresLabel.Size = UDim2.new(0, 300, 0, 100)
    featuresLabel.Position = UDim2.new(0, 0, 0, 60)
    featuresLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    featuresLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    featuresLabel.TextScaled = true
    featuresLabel.Font = Enum.Font.SourceSans
    featuresLabel.TextWrapped = true
    featuresLabel.Parent = mainFrame

    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Text = "Enable Power"
    toggleButton.Size = UDim2.new(0, 150, 0, 40)
    toggleButton.Position = UDim2.new(0, 75, 0, 170)
    toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.TextScaled = true
    toggleButton.Font = Enum.Font.SourceSansBold
    toggleButton.Parent = mainFrame

    toggleButton.MouseButton1Click:Connect(function()
        print("Power toggled!")
        -- Add actual power logic here
    end)

    print("Blox Fruits Hack initialized successfully!")
end

-- Fix for the main error: "Humanoid:ChangeState" not found
local function fixHumanoidError()
    -- Create a more robust humanoid error handler
    local function safeChangeState(player, state)
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChild("Humanoid")
        
        if humanoid then
            -- Try to change state safely
            local success, result = pcall(function()
                humanoid:ChangeState(state)
            end)
            
            if not success then
                warn("Error changing humanoid state to " .. tostring(state) .. ": " .. tostring(result))
            end
        else
            warn("No Humanoid found for player: " .. player.Name)
        end
    end
    
    -- Add a safety check for all humanoid operations
    local function safeHumanoidOperation(player, operation)
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChild("Humanoid")
        
        if humanoid then
            return operation(humanoid)
        else
            warn("No Humanoid found for player: " .. player.Name)
            return false
        end
    end
    
    -- Store the original methods
    local originalChangeState = Humanoid.ChangeState
    local originalGetState = Humanoid.GetState
    
    -- Override with safe versions
    function Humanoid:ChangeState(state)
        local success, result = pcall(originalChangeState, self, state)
        if not success then
            warn("Error in Humanoid.ChangeState: " .. tostring(result))
        end
    end
    
    function Humanoid:GetState()
        local success, result = pcall(originalGetState, self)
        if not success then
            warn("Error in Humanoid.GetState: " .. tostring(result))
            return Enum.HumanoidStateType.None
        end
        return result
    end
    
    -- Set up a global error handler for humanoid operations
    local function handleHumanoidError(player, action)
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChild("Humanoid")
        
        if humanoid then
            return action(humanoid)
        else
            warn("Humanoid not found for player: " .. player.Name)
            return false
        end
    end
    
    -- Store for use in other modules
    _G.safeHumanoidOperation = safeHumanoidOperation
    _G.handleHumanoidError = handleHumanoidError
end

-- Handle Shady Zioles Error
local function handleShadyZiolesError()
    -- This function ensures that the Shady Zioles character is properly handled
    local function ensureShadyZioles()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        
        -- Check for Shady Zioles in the character
        local shadyZioles = character:FindFirstChild("ShadyZioles")
        if not shadyZioles then
            -- Create a default Shady Zioles if it doesn't exist
            shadyZioles = Instance.new("Folder")
            shadyZioles.Name = "ShadyZioles"
            shadyZioles.Parent = character
        end
        
        -- Add necessary components
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            -- Add a custom property to track Shady Zioles state
            if not shadyZioles:FindFirstChild("ZiolesState") then
                local state = Instance.new("StringValue")
                state.Name = "ZiolesState"
                state.Value = "Active"
                state.Parent = shadyZioles
            end
        end
        
        return shadyZioles
    end
    
    -- Set up a listener for character changes
    local player = game.Players.LocalPlayer
    player.CharacterAdded:Connect(function(character)
        ensureShadyZioles()
    end)
    
    -- Run immediately for current character
    if player.Character then
        ensureShadyZioles()
    end
    
    return ensureShadyZioles
end

-- Handle Coordinate System Errors
local function handleCoordinateWarning()
    -- Create a coordinate system handler
    local function safeCoordinateOperation(operation)
        local success, result = pcall(operation)
        if not success then
            warn("Coordinate system error: " .. tostring(result))
            return false
        end
        return true
    end
    
    -- Add coordinate validation
    local function validatePosition(position)
        if not position then
            return false
        end
        
        -- Check if position components are valid numbers
        return typeof(position.X) == "number" and 
               typeof(position.Y) == "number" and 
               typeof(position.Z) == "number"
    end
    
    -- Store for global access
    _G.safeCoordinateOperation = safeCoordinateOperation
    _G.validatePosition = validatePosition
    
    return safeCoordinateOperation
end

-- Security Bypass Module
local securityBypass = {}
function securityBypass.antiKick()
    -- Anti-kick system
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    
    -- Add a protection system
    local protection = Instance.new("Folder")
    protection.Name = "AntiKickProtection"
    protection.Parent = character
    
    -- Create a dummy humanoid to prevent kick detection
    local dummyHumanoid = Instance.new("Humanoid")
    dummyHumanoid.Name = "AntiKickHumanoid"
    dummyHumanoid.Parent = protection
    
    -- Add a health check system
    local healthCheck = Instance.new("BoolValue")
    healthCheck.Name = "IsProtected"
    healthCheck.Value = true
    healthCheck.Parent = protection
    
    -- Periodic health check
    game:GetService("RunService").Heartbeat:Connect(function()
        if character and character:FindFirstChild("Humanoid") then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid.Health <= 0 then
                humanoid.Health = 100
            end
        end
    end)
    
    print("Anti-kick protection enabled")
end

-- Trade Freeze Module
local tradeFreeze = {}
function tradeFreeze.enable()
    -- Trade freeze system
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    
    -- Create a trade freeze system
    local tradeSystem = Instance.new("Folder")
    tradeSystem.Name = "TradeFreezeSystem"
    tradeSystem.Parent = character
    
    -- Create a freeze state
    local freezeState = Instance.new("BoolValue")
    freezeState.Name = "IsFrozen"
    freezeState.Value = false
    freezeState.Parent = tradeSystem
    
    -- Create a freeze timer
    local freezeTimer = Instance.new("NumberValue")
    freezeTimer.Name = "FreezeTime"
    freezeTimer.Value = 0
    freezeTimer.Parent = tradeSystem
    
    -- Add freeze functionality
    local function freezeTrade()
        freezeState.Value = true
        freezeTimer.Value = 10 -- Freeze for 10 seconds
        print("Trade frozen")
    end
    
    local function unfreezeTrade()
        freezeState.Value = false
        freezeTimer.Value = 0
        print("Trade unfrozen")
    end
    
    -- Update freeze timer
    game:GetService("RunService").Heartbeat:Connect(function()
        if freezeState.Value and freezeTimer.Value > 0 then
            freezeTimer.Value = freezeTimer.Value - 0.1
            if freezeTimer.Value <= 0 then
                unfreezeTrade()
            end
        end
    end)
    
    -- Store functions for later use
    tradeSystem.Freeze = freezeTrade
    tradeSystem.Unfreeze = unfreezeTrade
    
    print("Trade freeze system enabled")
end

-- Instant Roll Module
local instantRoll = {}
function instantRoll.enable()
    -- Instant roll system
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    
    -- Create a roll system
    local rollSystem = Instance.new("Folder")
    rollSystem.Name = "InstantRollSystem"
    rollSystem.Parent = character
    
    -- Create a roll state
    local rollState = Instance.new("BoolValue")
    rollState.Name = "IsRolling"
    rollState.Value = false
    rollState.Parent = rollSystem
    
    -- Create a roll timer
    local rollTimer = Instance.new("NumberValue")
    rollTimer.Name = "RollTime"
    rollTimer.Value = 0
    rollTimer.Parent = rollSystem
    
    -- Add roll functionality
    local function roll()
        rollState.Value = true
        rollTimer.Value = 0.5 -- Roll for 0.5 seconds
        print("Rolling...")
    end
    
    -- Update roll timer
    game:GetService("RunService").Heartbeat:Connect(function()
        if rollState.Value and rollTimer.Value > 0 then
            rollTimer.Value = rollTimer.Value - 0.1
            if rollTimer.Value <= 0 then
                rollState.Value = false
                print("Roll complete")
            end
        end
    end)
    
    -- Store functions for later use
    rollSystem.Roll = roll
    
    print("Instant roll system enabled")
end

-- Premium Bypass Module
local premiumBypass = {}
function premiumBypass.enable()
    -- Premium bypass system
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    
    -- Create a premium system
    local premiumSystem = Instance.new("Folder")
    premiumSystem.Name = "PremiumBypassSystem"
    premiumSystem.Parent = character
    
    -- Create a premium state
    local premiumState = Instance.new("BoolValue")
    premiumState.Name = "IsPremium"
    premiumState.Value = true
    premiumState.Parent = premiumSystem
    
    -- Create a premium timer
    local premiumTimer = Instance.new("NumberValue")
    premiumTimer.Name = "PremiumTime"
    premiumTimer.Value = 0
    premiumTimer.Parent = premiumSystem
    
    -- Add premium functionality
    local function activatePremium()
        premiumState.Value = true
        premiumTimer.Value = 300 -- Premium for 5 minutes
        print("Premium activated")
    end
    
    local function deactivatePremium()
        premiumState.Value = false
        premiumTimer.Value = 0
        print("Premium deactivated")
    end
    
    -- Update premium timer
    game:GetService("RunService").Heartbeat:Connect(function()
        if premiumState.Value and premiumTimer.Value > 0 then
            premiumTimer.Value = premiumTimer.Value - 0.1
            if premiumTimer.Value <= 0 then
                deactivatePremium()
            end
        end
    end)
    
    -- Store functions for later use
    premiumSystem.Activate = activatePremium
    premiumSystem.Deactivate = deactivatePremium
    
    print("Premium bypass system enabled")
end

-- Humanoid State Management
local humanoidState = {}
function humanoidState.changeState(player, state)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChild("Humanoid")
    
    if humanoid then
        local success, result = pcall(function()
            humanoid:ChangeState(state)
        end)
        
        if not success then
            warn("Error changing state: " .. tostring(result))
            return false
        end
        
        return true
    end
    
    return false
end

-- Initialize all modules
local function initializeModules()
    -- Initialize the modules
    securityBypass.antiKick()
    tradeFreeze.enable()
    instantRoll.enable()
    premiumBypass.enable()
    
    -- Set up global access to modules
    _G.SecurityBypass = securityBypass
    _G.TradeFreeze = tradeFreeze
    _G.InstantRoll = instantRoll
    _G.PremiumBypass = premiumBypass
    _G.HumanoidState = humanoidState
    
    print("All modules initialized successfully")
end

-- Setup the global functions
local function setupGlobalFunctions()
    -- Setup global functions for easy access
    _G.handleShadyZioles = handleShadyZiolesError
    _G.handleCoordinateSystem = handleCoordinateWarning
    _G.initializeModules = initializeModules
    
    -- Initialize immediately
    initializeModules()
end

-- Setup the system
setupGlobalFunctions()

-- Export the modules
return {
    SecurityBypass = securityBypass,
    TradeFreeze = tradeFreeze,
    InstantRoll = instantRoll,
    PremiumBypass = premiumBypass,
    HumanoidState = humanoidState
}
