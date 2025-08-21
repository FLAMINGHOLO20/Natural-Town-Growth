local config = require "config"
local lfs = require "lfs"  -- LuaFileSystem for monitoring config

local lastConfigTimestamp = nil

-- Function to reload config dynamically
local function reloadConfig()
    local attr = lfs.attributes(config.configFilePath)
    if attr and attr.modification > (lastConfigTimestamp or 0) then
        package.loaded["config"] = nil
        config = require "config"
        lastConfigTimestamp = attr.modification
        print("Natural Town Growth: Config reloaded.")
    end
end

-- Helper functions (historical, infrastructure, geography, traffic, industry)
local function historicalBias(town)
    if town.ageMonths then
        local factor = 1.0 - (town.ageMonths / 600) * config.historicalWeight
        return math.max(factor, 0.5)
    end
    return 1.0
end

local function infrastructureFactor(town, data)
    local factor = 1.0 + ((data.reachability or 1.0) - 1.0) * config.infrastructureWeight
    return math.max(factor, 0.5)
end

local function geographyFactor(town, data)
    local terrainBonus = data.coastal and 1.2 or 1.0
    local resourceBonus = (data.resources or 0) * 0.05
    return 1.0 + (terrainBonus - 1.0) + resourceBonus * config.geographyWeight
end

local function trafficFactor(data)
    local factor = 1.0
    if data.trafficLoad then
        factor = 1.0 - (data.trafficLoad * config.trafficWeight * 0.5)
    end
    return math.max(factor, 0.5)
end

local function industryFactor(data)
    local factor = 1.0 + ((data.industrialOutput or 0) / 1000) * config.industryWeight
    return math.max(factor, 0.5)
end

local function randomEventFactor()
    if config.enableRandomEvents then
        local change = (math.random() * 2 - 1) * config.randomEventMagnitude
        return 1.0 + change
    end
    return 1.0
end

-- Main growth calculation
function calculateGrowth(town, data)
    -- Base growth calculation
    local initialCapacity = data.initialCapacity or 100
    local baseGrowth = (data.residential + data.commercial + data.industrial) * config.baseGrowthRate
    local blendedGrowth = (baseGrowth * config.growthBlendFactor) + (initialCapacity * (1 - config.growthBlendFactor))

    local cargoFactor = data.cargoDelivered * config.cargoInfluence
    local reachFactor = data.reachability * config.reachabilityWeight
    local totalGrowth = blendedGrowth + cargoFactor + reachFactor

    -- Traffic penalty
    if config.trafficPenalty and data.trafficLoad and data.trafficLoad > 0.8 then
        totalGrowth = totalGrowth * 0.7
    end

    -- Decay / shrinkage
    if config.decayEnabled and data.cargoDelivered < 0.2 then
        totalGrowth = totalGrowth - (data.population * config.decayRate)
    end

    -- Custom growth profile
    local profile = config.growthProfiles[config.growthProfile] or config.growthProfiles["Balanced"]
    local resGrowth = (data.residential * config.baseGrowthRate) * (profile.res or 1.0)
    local comGrowth = (data.commercial * config.baseGrowthRate) * (profile.com or 1.0)
    local indGrowth = (data.industrial * config.baseGrowthRate) * (profile.ind or 1.0)
    totalGrowth = totalGrowth + resGrowth + comGrowth + indGrowth

    -- Apply all factors
    totalGrowth = totalGrowth * historicalBias(town)
    totalGrowth = totalGrowth * infrastructureFactor(town, data)
    totalGrowth = totalGrowth * geographyFactor(town, data)
    totalGrowth = totalGrowth * trafficFactor(data)
    totalGrowth = totalGrowth * industryFactor(data)
    totalGrowth = totalGrowth * randomEventFactor()

    -- Difficulty multiplier
    local diffMult = config.difficultyMultiplier[config.difficultyMode] or 1.0
    totalGrowth = totalGrowth * diffMult

    -- Clamp max town size
    totalGrowth = math.min(totalGrowth, config.maxTownSize)
    return totalGrowth
end

-- Update all towns
local lastUpdateMonth = -1
function updateGrowth(gameTime, towns)
    reloadConfig()  -- dynamic config reload

    local currentMonth = math.floor(gameTime.month)
    if lastUpdateMonth == -1 or currentMonth - lastUpdateMonth >= config.updateIntervalMonths then
        for _, town in pairs(towns) do
            -- Skip tiny towns if performanceMode enabled
            if not config.performanceMode or (town.data.population or 0) > 50 then
                local growth = calculateGrowth(town, town.data)
                town:setGrowth(growth)
            end
        end
        lastUpdateMonth = currentMonth
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
