local crystal = script.Parent
local health = crystal:WaitForChild("Health")
local maxHealth = crystal:WaitForChild("MaxHealth")
local proximityPrompt = crystal:WaitForChild("ProximityPrompt")
local billboardGui = crystal:WaitForChild("BillboardGui")
local healthBar = billboardGui.Background.HealthBar

-- Read the damage amount directly from the crystal's Attributes
local damageAmount = crystal:GetAttribute("Damage")

-- This function updates the health bar's size
local function updateHealthBar()
	local percentage = health.Value / maxHealth.Value
	healthBar.Size = UDim2.new(percentage, 0, 1, 0)
end

-- Connect the health bar update to the 'Value' changing
health:GetPropertyChangedSignal("Value"):Connect(updateHealthBar)

-- This function reduces the crystal's health when a player interacts with it
local function damageCrystal(player)
	health.Value = health.Value - damageAmount

	-- Check if the crystal's health is at or below zero
	if health.Value <= 0 then
		print("Crystal has been destroyed!")
		crystal:Destroy() -- Destroys the crystal
	end
end

-- Connect the damage function to the ProximityPrompt
proximityPrompt.Triggered:Connect(damageCrystal)

-- Set the initial health bar size when the game starts
updateHealthBar()