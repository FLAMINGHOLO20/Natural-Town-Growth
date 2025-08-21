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
    modVersion = "v1.3-update2-4",
    growthProfile = "Balanced",  -- Options: Balanced, DenseMetro, SprawlingSuburb, IndustrialHub
    growthProfiles = {
        Balanced = { res = 1.0, com = 1.0, ind = 1.0 },
        DenseMetro = { res = 1.5, com = 1.2, ind = 0.8 },
        SprawlingSuburb = { res = 1.3, com = 0.8, ind = 0.7 },
        IndustrialHub = { res = 0.7, com = 0.9, ind = 1.5 }
    },

    -- New parameters for Updates 2-4
    historicalWeight = 0.5,       -- weight for historical growth bias
    infrastructureWeight = 1.0,   -- weight for roads/rail influence
}
return config
