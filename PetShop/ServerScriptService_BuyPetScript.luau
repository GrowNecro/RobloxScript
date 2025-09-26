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
		local randomX = math.random(spawnBox.Position.X - spawnBox.Size.X/2, spawnBox.Position.X + spawnBox.Size.X/2)
		local randomZ = math.random(spawnBox.Position.Z - spawnBox.Size.Z/2, spawnBox.Position.Z + spawnBox.Size.Z/2)

		newPet:SetPrimaryPartCFrame(CFrame.new(randomX, spawnBox.Position.Y, randomZ))
		newPet.Parent = workspace

		-- You might want to weld the pet to the player's character or set up its AI here
	end
end

BuyPetEvent.OnServerEvent:Connect(function(player, petFrameName, price)
	-- Check if the player can afford the pet (you'd need to implement this)
	-- For example: if player.leaderstats.Coins.Value >= price then

	-- For a simple example, we'll just spawn it
	spawnPet(petFrameName, player)

	-- Example for simple currency deduction:
	-- player.leaderstats.Coins.Value = player.leaderstats.Coins.Value - price
	-- end
end)