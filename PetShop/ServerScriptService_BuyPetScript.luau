-- Script inside ServerScriptService
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local BuyPetEvent = ReplicatedStorage:WaitForChild("BuyPetEvent")

local function spawnPet(petFrameName, player)
	-- Assume you have a folder in ReplicatedStorage or ServerStorage with your pet models
	local petModelsFolder = ReplicatedStorage:WaitForChild("PetModels")

	-- Find the corresponding pet model based on the name
	local petModel = petModelsFolder:FindFirstChild(petFrameName)

	if petModel then
		local newPet = petModel:Clone()
		local character = player.Character or player.CharacterAdded:Wait()
		local spawnBox = workspace:WaitForChild("SpawnBox") -- Assuming you have a part named 'SpawnBox'

		-- Position the pet randomly inside the spawn box
		local randomX =
			math.random(spawnBox.Position.X - spawnBox.Size.X / 2, spawnBox.Position.X + spawnBox.Size.X / 2)
		local randomZ =
			math.random(spawnBox.Position.Z - spawnBox.Size.Z / 2, spawnBox.Position.Z + spawnBox.Size.Z / 2)

		newPet:SetPrimaryPartCFrame(CFrame.new(randomX, spawnBox.Position.Y, randomZ))
		newPet.Parent = workspace

		-- You might want to weld the pet to the player's character or set up its AI here
	end
end

BuyPetEvent.OnServerEvent:Connect(function(player, petFrameName, price)
	-- 1. Get the player's current coin value
	local leaderstats = player:FindFirstChild("leaderstats")

	-- Safety check to ensure leaderstats and Coins exist
	if not leaderstats or not leaderstats:FindFirstChild("Coins") then
		warn("Player " .. player.Name .. " does not have 'Coins' in leaderstats.")
		return -- Stop execution if coins aren't set up
	end

	local coinsValue = leaderstats.Coins

	-- 2. Check if the player can afford the pet
	if coinsValue.Value >= price then
		-- COIN DECREASE IMPLEMENTATION
		coinsValue.Value = coinsValue.Value - price

		-- 3. Spawn the pet
		spawnPet(petFrameName, player)
	else
		-- Optional: Provide feedback to the player (e.g., using a RemoteEvent to display a UI message)
		print(player.Name .. " tried to buy " .. petFrameName .. " but cannot afford the price of " .. price)
		-- You could fire a RemoteEvent here: ReplicatedStorage.SendNotification:FireClient(player, "Not enough coins!")
	end
end)
