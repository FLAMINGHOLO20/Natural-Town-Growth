local config = {
    -- Existing settings
    growthBlendFactor = 0.5,
    maxTownSize = 5000,
    updateIntervalMonths = 3,
    performanceMode = true,
    baseGrowthRate = 1.0,
    cargoInfluence = 1.0,
    reachabilityWeight = 1.0,
    trafficPenalty = true,
    decayEnabled = false,
    decayRate = 0.05,

    -- New: Custom Growth Curves
    modVersion = "v1.2-update1",

    -- Default growth profile to use
    -- Options: "Balanced", "DenseMetro", "SprawlingSuburb", "IndustrialHub"
    growthProfile = "Balanced",

    -- Growth profile definitions
    growthProfiles = {
        Balanced = {
            res = 1.0,
            com = 1.0,
            ind = 1.0
        },
        DenseMetro = {
            res = 1.5,  -- faster residential growth
            com = 1.2,  -- commercial slightly boosted
            ind = 0.8   -- industry slower
        },
        SprawlingSuburb = {
            res = 1.3,  -- residential sprawl
            com = 0.8,  -- weaker commercial
            ind = 0.7   -- little industry
        },
        IndustrialHub = {
            res = 0.7,  -- fewer houses
            com = 0.9,  -- normal commercial
            ind = 1.5   -- strong industry growth
        }
    }
}

return config
