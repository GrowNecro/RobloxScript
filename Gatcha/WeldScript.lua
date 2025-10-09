-- TEMPORARY SCRIPT TO WELD PET PARTS (RUN THIS ONCE IN STUDIO, THEN DELETE)
local model = script.Parent
local primaryPart = model.PrimaryPart

if primaryPart then
	for _, part in ipairs(model:GetChildren()) do
		-- Check if the item is a base part and is not the PrimaryPart itself
		if part:IsA("BasePart") and part ~= primaryPart then
			local weld = Instance.new("WeldConstraint")
			weld.Part0 = primaryPart
			weld.Part1 = part
			weld.Parent = part
		end
	end
	print("Kiwi pet parts successfully welded! You can delete this script now.")
	-- Delete the script after it runs (optional, but good practice)
	script:Destroy()
else
	warn("PrimaryPart not set! Welding aborted.")
end