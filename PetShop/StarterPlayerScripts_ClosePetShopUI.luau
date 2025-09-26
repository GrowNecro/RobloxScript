-- LocalScript in StarterPlayerScripts
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Wait for the PlayerGui to load and then wait for the PetShopUI ScreenGui
local petShopUI = player:WaitForChild("PlayerGui"):WaitForChild("PetShopUI")

-- Assuming your main window frame is named 'Frame' inside the ScreenGui
local mainFrame = petShopUI:WaitForChild("Frame")

-- Set the Visible property to false
mainFrame.Visible = false

-- Note: If you have set the Visible property to false in Studio,
-- this script is redundant but ensures the state if you had it set to true.
