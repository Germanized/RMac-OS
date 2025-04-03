-- src/Theme.lua
-- Defines the visual styling for the UI Library (macOS Dark Theme Approximation)

local Theme = {}

--[[ Color Palette ]]
Theme.Colors = {
	-- Backgrounds
	WindowBackground = Color3.fromRGB(30, 30, 30),       -- Dark grey main background
	ContentBackground = Color3.fromRGB(45, 45, 45),     -- Slightly lighter for content areas (tabs, sections)
	TitleBar = Color3.fromRGB(55, 55, 55),            -- Title bar background

	-- Accent (Example: Blue)
	Accent = Color3.fromRGB(10, 132, 255),             -- Standard macOS blue accent
	AccentHover = Color3.fromRGB(60, 150, 255),           -- Lighter blue on hover
	AccentPressed = Color3.fromRGB(0, 110, 230),         -- Darker blue when pressed

	-- Text
	Text = Color3.fromRGB(230, 230, 230),              -- Primary text (almost white)
	TextSecondary = Color3.fromRGB(170, 170, 170),      -- Lighter grey for less important text
	TextDisabled = Color3.fromRGB(100, 100, 100),       -- Darker grey for disabled elements
	TextOnAccent = Color3.fromRGB(255, 255, 255),       -- Text on top of accent color (e.g., buttons)

	-- Controls (Buttons, Inputs etc.)
	ControlBackground = Color3.fromRGB(75, 75, 75),       -- Background for buttons, inputs
	ControlHover = Color3.fromRGB(95, 95, 95),          -- Hover state for controls
	ControlPressed = Color3.fromRGB(60, 60, 60),        -- Pressed state for controls
	ControlBorder = Color3.fromRGB(100, 100, 100),        -- Subtle border for inputs
	ControlBorderActive = Color3.fromRGB(10, 132, 255), -- Border for active/focused inputs (Accent color)

	-- Other
	Border = Color3.fromRGB(65, 65, 65),                -- Borders between sections or subtle outlines
	Shadow = Color3.fromRGB(0, 0, 0),                  -- Base color for shadows (Transparency will be key)
	CloseButton = Color3.fromRGB(255, 95, 86),          -- Red close button ('traffic light')
	MinimizeButton = Color3.fromRGB(255, 189, 46),      -- Yellow minimize button
	MaximizeButton = Color3.fromRGB(40, 205, 65),       -- Green maximize/zoom button
}

--[[ Fonts ]]
-- Note: Roblox doesn't have San Francisco. SourceSans is a decent alternative.
Theme.Fonts = {
	UI = Enum.Font.SourceSans,          -- Default UI font
	UIBold = Enum.Font.SourceSansBold,
	UISemiBold = Enum.Font.SourceSansSemibold, -- Good for titles
	Code = Enum.Font.Code,              -- Monospaced font if needed
}

--[[ Sizes ]]
Theme.Sizes = {
	Text = 13,                          -- Default text size
	TitleText = 14,                     -- Window title text size
	SectionTitleText = 13,              -- Section header text size

	Padding = 10,                       -- General internal padding for containers
	ItemSpacing = 8,                    -- Vertical space between UI elements (buttons, labels etc.)
	InlineSpacing = 5,                  -- Horizontal space between elements on the same line

	TitleBarHeight = 30,                -- Height of the window title bar
	DefaultControlHeight = 28,          -- Standard height for buttons, textboxes
	ScrollBarThickness = 8,

	WindowMinWidth = 250,
	WindowMinHeight = 150,
}

--[[ Corner Radii ]]
Theme.Radii = {
	Window = 6,                         -- Corner radius for the main window
	Control = 4,                        -- Corner radius for buttons, inputs
	Section = 5,                        -- Corner radius for section backgrounds
	Tab = 4,                            -- Corner radius for tab buttons
}

--[[ Other Visuals ]]
Theme.ShadowTransparency = 0.4          -- Transparency for drop shadows (0 = invisible, 1 = fully opaque)
Theme.ShadowSize = 5                    -- How far the shadow extends (used with UIStroke or offsets)


return Theme
