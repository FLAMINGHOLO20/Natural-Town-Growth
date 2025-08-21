local config = require "config"
local lfs = require "lfs"  -- LuaFileSystem for dynamic config reload
local lastConfigTimestamp = nil
local lastDebugUpdate = -1

-- Safe wrapper for optional data
local function safe(value, default)
    if value == nil then return default end
    return value
end

-- Dynamic config reload
local function reloadConfig()
    local attr = lfs.attributes(config.configFilePath)
    if attr and attr.modification > (lastConfigTimestamp or 0) then
        package.loaded["config"] = nil
        config = require "config"
        lastConfigTimestamp = attr.modification
        print("Natural Town Growth v2.0: Config reloaded.")
    end
end

-- Helper functions
local function historicalBias(town)
    return 1.0 - (safe(town.ageMonths,0)/600) * config.historicalWeight
end

local function infrastructureFactor(town, data)
    return math.max(1.0 + (safe(data.reachability,1)-1.0)*config.infrastructureWeight, 0.5)
end

local function geographyFactor(town, data)
    local terrainBonus = safe(data.coastal,false) and 1.2 or 1.0
    local resourceBonus = (safe(data.resources,0))*0.05
    return 1.0 + (terrainBonus-1.0) + resourceBonus*config.geographyWeight
end

local function trafficFactor(data)
    return math.max(1.0 - safe(data.trafficLoad,0)*config.trafficWeight*0.5,0.5)
end

local function industryFactor(data)
    return math.max(1.0 + safe(data.industrialOutput,0)/1000 * config.industryWeight, 0.5)
end

local function randomEventFactor()
    if config.enableRandomEvents then
        local change = (math.random()*2 -1) * config.randomEventMagnitude
        return 1.0 + change
    end
    return 1.0
end

-- Main growth calculation
function calculateGrowth(town, data)
    local initialCapacity = safe(data.initialCapacity,100)
    local baseGrowth = (safe(data.residential,0)+safe(data.commercial,0)+safe(data.industrial,0))*config.baseGrowthRate
    local blendedGrowth = (baseGrowth*config.growthBlendFactor) + (initialCapacity*(1-config.growthBlendFactor))

    local cargoFactor = safe(data.cargoDelivered,0)*config.cargoInfluence
    local reachFactor = safe(data.reachability,1)*config.reachabilityWeight
    local totalGrowth = blendedGrowth + cargoFactor + reachFactor

    -- Traffic penalty
    if config.trafficPenalty and safe(data.trafficLoad,0) > 0.8 then
        totalGrowth = totalGrowth * 0.7
    end

    -- Decay / shrinkage
    if config.decayEnabled and safe(data.cargoDelivered,0) < 0.2 then
        totalGrowth = totalGrowth - (safe(data.population,0)*config.decayRate)
    end

    -- Custom growth profile
    local profile = config.growthProfiles[config.growthProfile] or config.growthProfiles["Balanced"]
    totalGrowth = totalGrowth +
                  safe(data.residential,0)*config.baseGrowthRate*(profile.res or 1.0) +
                  safe(data.commercial,0)*config.baseGrowthRate*(profile.com or 1.0) +
                  safe(data.industrial,0)*config.baseGrowthRate*(profile.ind or 1.0)

    -- Apply all factors
    totalGrowth = totalGrowth * historicalBias(town)
    totalGrowth = totalGrowth * infrastructureFactor(town,data)
    totalGrowth = totalGrowth * geographyFactor(town,data)
    totalGrowth = totalGrowth * trafficFactor(data)
    totalGrowth = totalGrowth * industryFactor(data)
    totalGrowth = totalGrowth * randomEventFactor()

    -- Difficulty multiplier
    local diffMult = config.difficultyMultiplier[safe(config.difficultyMode,"Normal")] or 1.0
    totalGrowth = totalGrowth * diffMult

    -- Clamp max town size
    totalGrowth = math.min(totalGrowth, config.maxTownSize)
    return totalGrowth
end

-- Update all towns
local lastUpdateMonth = -1
function updateGrowth(gameTime, towns)
    reloadConfig()  -- dynamic reload

    local currentMonth = math.floor(gameTime.month)
    if lastUpdateMonth == -1 or currentMonth - lastUpdateMonth >= config.updateIntervalMonths then
        for _, town in pairs(towns) do
            if not config.performanceMode or (safe(town.data.population,0) > 50) then
                local growth = calculateGrowth(town, town.data)
                town:setGrowth(growth)
            end
        end
        lastUpdateMonth = currentMonth
    end

    -- Debug overlays
    if config.debugMode and currentMonth - lastDebugUpdate >= config.debugUpdateInterval then
        for _, town in pairs(towns) do
            local data = town.data
            print(string.format("DEBUG: %s | Pop: %d | Growth: %.2f | Cargo: %.2f | Traffic: %.2f | Industry: %.2f",
                  town.name, safe(data.population,0), calculateGrowth(town,data),
                  safe(data.cargoDelivered,0), safe(data.trafficLoad,0), safe(data.industrialOutput,0)))
        end
        lastDebugUpdate = currentMonth
    end
end

function data()
    return {
        updateFn = function(gameTime)
            local towns = api.engine.system.townSystem.getTowns()
            updateGrowth(gameTime, towns)
        end
    }
end
