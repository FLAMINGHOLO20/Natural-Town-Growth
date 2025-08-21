local config = require "config"
local api = api  -- Transport Fever 2 Lua API

local UI = {}

-- UI state
local uiState = {
    visible = false,
}

-- Toggle UI
function UI.toggle()
    uiState.visible = not uiState.visible
end

-- Draw Config Editor Panel
function UI.drawEditor()
    if not uiState.visible or not config.enableUI then return end

    -- Example panel using TFE2 UI functions
    local panel = api.gui.createPanel()
    panel:setTitle("Town Growth Config Editor")

    -- Example sliders & dropdowns
    panel:addSlider("Growth Blend", 0, 1, config.growthBlendFactor, function(value)
        config.growthBlendFactor = value
    end)

    panel:addDropdown("Growth Profile", {"Balanced", "DenseMetro", "SprawlingSuburb", "IndustrialHub"}, config.growthProfile, function(value)
        config.growthProfile = value
    end)

    panel:addCheckbox("Enable Debug", config.debugMode, function(value)
        config.debugMode = value
    end)

    panel:addButton("Apply", function()
        print("[Natural Town Growth] Config applied.")
    end)

    panel:addButton("Reset Defaults", function()
        dofile("config.lua")
        print("[Natural Town Growth] Config reset.")
    end)

    panel:show()
end

-- Draw Town Overlays
function UI.drawOverlays(town)
    if not config.showGrowthOverlay then return end

    local x, y = town:getPosition()
    local color = {r=0, g=1, b=0}  -- default green

    if town.growth < 0 then
        color = {r=1, g=0, b=0}  -- shrinking town
    elseif town.growth > 100 then
        color = {r=0, g=0.5, b=1} -- booming town
    end

    api.gui.drawCircle(x, y, 10, color) -- simple visual marker
end

return UI
