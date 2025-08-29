local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local followSpeed = 0.1
local followDistance = 5
local heightOffset = 2
local rotationSpeed = 0.1 -- How fast the model rotates to face the player direction

-- Get the model's PrimaryPart (main part used for positioning)
local model = script.Parent
local primaryPart = model.PrimaryPart

-- If no PrimaryPart is set, try to find a part named "HumanoidRootPart" or use the first part
if not primaryPart then
	primaryPart = model:FindFirstChild("HumanoidRootPart") or 
		model:FindFirstChild("Torso") or 
		model:FindFirstChild("Root") or
		model:FindFirstChildOfClass("Part")
end

-- Error handling if no suitable part is found
if not primaryPart then
	warn("No suitable primary part found in model. Please set a PrimaryPart or ensure the model has parts.")
	return
end

-- Set as PrimaryPart if it wasn't already set
if not model.PrimaryPart then
	model.PrimaryPart = primaryPart
end

RunService.Heartbeat:Connect(function()
	local player = Players:GetPlayers()[1]
	if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local playerRoot = player.Character.HumanoidRootPart
		local playerPosition = playerRoot.Position
		local playerDirection = playerRoot.CFrame.LookVector

		-- Calculate target position behind the player
		local targetPos = playerPosition - (playerDirection * followDistance) + Vector3.new(0, heightOffset, 0)

		-- Get current model position and rotation
		local currentCFrame = model.PrimaryPart.CFrame
		local currentPosition = currentCFrame.Position

		-- Calculate new position (smooth movement)
		local newPosition = currentPosition:Lerp(targetPos, followSpeed)

		-- Calculate target rotation to face the same direction as player
		local targetRotation = CFrame.lookAt(Vector3.new(0, 0, 0), playerDirection)
		local currentRotation = currentCFrame - currentCFrame.Position
		local newRotation = currentRotation:Lerp(targetRotation, rotationSpeed)

		-- Apply the new CFrame to the model
		local newCFrame = CFrame.new(newPosition) * newRotation
		model:SetPrimaryPartCFrame(newCFrame)
	end
end)