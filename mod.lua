local config = require "config"

-- Calculate growth for a given town using base factors + profile multipliers
function calculateGrowth(town, data)
    local initialCapacity = data.initialCapacity or 100
    local calculatedGrowth = (data.residential + data.commercial + data.industrial) * config.baseGrowthRate

    local blendedGrowth = (calculatedGrowth * config.growthBlendFactor) + (initialCapacity * (1 - config.growthBlendFactor))

    local cargoFactor = data.cargoDelivered * config.cargoInfluence
    local reachFactor = data.reachability * config.reachabilityWeight
    local totalGrowth = blendedGrowth + cargoFactor + reachFactor

    if config.trafficPenalty and data.trafficLoad > 0.8 then
        totalGrowth = totalGrowth * 0.7
    end

    if config.decayEnabled and data.cargoDelivered < 0.2 then
        totalGrowth = totalGrowth - (data.population * config.decayRate)
    end

    -- Apply growth profile multipliers from config
    local profile = config.growthProfiles[config.growthProfile] or config.growthProfiles["Balanced"]
    local resGrowth = (data.residential * config.baseGrowthRate) * (profile.res or 1.0)
    local comGrowth = (data.commercial * config.baseGrowthRate) * (profile.com or 1.0)
    local indGrowth = (data.industrial * config.baseGrowthRate) * (profile.ind or 1.0)

    -- Merge into total growth
    totalGrowth = totalGrowth + resGrowth + comGrowth + indGrowth

    totalGrowth = math.min(totalGrowth, config.maxTownSize)
    return totalGrowth
end

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
