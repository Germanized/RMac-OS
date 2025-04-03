-- src/Core/InstanceManager.lua
-- Manages the creation and potential cleanup of Roblox GUI Instances

local InstanceManager = {}
InstanceManager.__index = InstanceManager

-- Stores all instances created through this manager, keyed by the instance itself
local trackedInstances = {}

-- A designated ScreenGui or container layer for all UI elements
-- This should be set during library initialization
local defaultParent = nil

-- Function to set the main UI container (e.g., a ScreenGui)
function InstanceManager:SetDefaultParent(parent)
	if parent and parent:IsA("GuiBase2d") then -- Ensure it's a valid UI container
		defaultParent = parent
		print("InstanceManager: Default parent set to", parent:GetFullName()) -- Debugging
	else
		warn("InstanceManager: Invalid default parent provided:", parent)
		defaultParent = nil
	end
end

--[[
	Creates a new Roblox Instance with specified properties.

	@param className (string): The ClassName of the instance to create (e.g., "Frame", "TextButton").
	@param properties (table): A dictionary of properties to set on the new instance.
	                          Special Handling:
	                          - 'Parent': If not provided, defaults to `defaultParent`.
	                          - 'Children': A table of instances to parent to this new one.
	@return (Instance): The newly created instance, or nil if creation failed.
]]
function InstanceManager:Create(className, properties)
	-- Basic validation
	if typeof(className) ~= "string" or not RobloxScriptSecurity then
		warn("InstanceManager:Create - Invalid className:", className)
		return nil
	end

	local instance = Instance.new(className)
	trackedInstances[instance] = true -- Track the instance immediately

	-- Set properties safely
	local propsToSet = {}
	local children = nil
	local targetParent = defaultParent -- Default parent

	if typeof(properties) == "table" then
		for key, value in pairs(properties) do
			if key == "Children" and typeof(value) == "table" then
				children = value -- Store children to add later
			elseif key == "Parent" then
				targetParent = value -- Use explicitly provided parent
			else
				propsToSet[key] = value -- Add other properties to set directly
			end
		end
	end

	-- Apply properties using task.spawn for safety against protected properties
    -- In exploit context pcall might be needed but this is better generally
	local success, err = pcall(function()
		for key, value in pairs(propsToSet) do
			instance[key] = value
		end
	end)

	if not success then
		warn("InstanceManager:Create - Error setting properties for", className, ":", err)
        instance:Destroy() -- Cleanup partially created instance on error
        trackedInstances[instance] = nil
        return nil
	end


    -- Parent the instance (important to do this after setting core properties like Size/Position)
    if targetParent and targetParent:IsA("Instance") then
         instance.Parent = targetParent
    elseif defaultParent then -- Fallback if provided parent was invalid/nil but default exists
         instance.Parent = defaultParent
    else
        -- If no parent available, maybe warn or decide on behavior.
        -- For now, it will remain unparented if no valid parent found.
         warn("InstanceManager:Create - No valid parent found for new", className, ". Instance remains unparented.")
    end

	-- Add any specified children
	if children then
		for _, child in ipairs(children) do
			if child and child:IsA("Instance") then
                pcall(function() child.Parent = instance end) -- Parent child safely
			end
		end
	end


	return instance
end

--[[
	Destroys a specific instance that was tracked by the manager.

	@param instance (Instance): The instance to destroy.
]]
function InstanceManager:Destroy(instance)
	if instance and trackedInstances[instance] then
		trackedInstances[instance] = nil -- Untrack
        pcall(function() instance:Destroy() end) -- Destroy safely
	end
end


--[[
	Destroys ALL instances created and tracked by this manager.
    Useful for library cleanup.
]]
function InstanceManager:DestroyAll()
	print("InstanceManager: Destroying all tracked instances...") -- Debugging
	local count = 0
	for instance, _ in pairs(trackedInstances) do
        pcall(function() instance:Destroy() end)
		count = count + 1
	end
	trackedInstances = {} -- Clear the tracking table
	print("InstanceManager: Destroyed", count, "instances.") -- Debugging
    defaultParent = nil -- Reset default parent on full cleanup
end

return InstanceManager
