local config = require "config"

-- Helper: compute historical growth factor
local function historicalBias(town)
    if town.ageMonths then
        -- Older towns grow slower, younger towns faster
        local factor = 1.0 - (town.ageMonths / 600) * config.historicalWeight
        return math.max(factor, 0.5)  -- clamp to minimum 0.5
    end
    return 1.0
end

-- Helper: compute infrastructure factor
local function infrastructureFactor(town, data)
    -- Example: use reachability (roads/rail) as infrastructure metric
    local factor = 1.0 + ((data.reachability or 1.0) - 1.0) * config.infrastructureWeight
    return math.max(factor, 0.5)  -- clamp minimum
end

-- Main growth calculation
function calculateGrowth(town, data)
    local initialCapacity = data.initialCapacity or 100
    local baseGrowth = (data.residential + data.commercial + data.industrial) * config.baseGrowthRate

    local blendedGrowth = (baseGrowth * config.growthBlendFactor) + (initialCapacity * (1 - config.growthBlendFactor))

    local cargoFactor = data.cargoDelivered * config.cargoInfluence
    local reachFactor = data.reachability * config.reachabilityWeight
    local totalGrowth = blendedGrowth + cargoFactor + reachFactor

    -- Apply traffic penalty
    if config.trafficPenalty and data.trafficLoad > 0.8 then
        totalGrowth = totalGrowth * 0.7
    end

    -- Apply decay/shrinkage
    if config.decayEnabled and data.cargoDelivered < 0.2 then
        totalGrowth = totalGrowth - (data.population * config.decayRate)
    end

    -- Apply growth profile multipliers
    local profile = config.growthProfiles[config.growthProfile] or config.growthProfiles["Balanced"]
    local resGrowth = (data.residential * config.baseGrowthRate) * (profile.res or 1.0)
    local comGrowth = (data.commercial * config.baseGrowthRate) * (profile.com or 1.0)
    local indGrowth = (data.industrial * config.baseGrowthRate) * (profile.ind or 1.0)

    totalGrowth = totalGrowth + resGrowth + comGrowth + indGrowth

    -- Apply historical bias
    totalGrowth = totalGrowth * historicalBias(town)

    -- Apply infrastructure influence
    totalGrowth = totalGrowth * infrastructureFactor(town, data)

    totalGrowth = math.min(totalGrowth, config.maxTownSize)
    return totalGrowth
end

-- Update all towns
local lastUpdateMonth = -1
function updateGrowth(gameTime, towns)
    local currentMonth = math.floor(gameTime.month)
    if lastUpdateMonth == -1 or currentMonth - lastUpdateMonth >= config.updateIntervalMonths then
        for _, town in pairs(towns) do
            local growth = calculateGrowth(town, town.data)
            town:setGrowth(growth)
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
