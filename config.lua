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

    -- Custom Growth Curves
    modVersion = "v1.4-update5-8",
    growthProfile = "Balanced",  -- Options: Balanced, DenseMetro, SprawlingSuburb, IndustrialHub
    growthProfiles = {
        Balanced = { res = 1.0, com = 1.0, ind = 1.0 },
        DenseMetro = { res = 1.5, com = 1.2, ind = 0.8 },
        SprawlingSuburb = { res = 1.3, com = 0.8, ind = 0.7 },
        IndustrialHub = { res = 0.7, com = 0.9, ind = 1.5 }
    },

    -- Historical Bias & Infrastructure
    historicalWeight = 0.5,
    infrastructureWeight = 1.0,

    -- New factors for v1.4
    geographyWeight = 1.0,        -- Influence of terrain/resources
    trafficWeight = 1.0,          -- Influence of congestion
    industryWeight = 1.0,         -- Influence of local industry output
    difficultyMode = "Normal",    -- Options: Easy, Normal, Hard
    difficultyMultiplier = { Easy = 1.2, Normal = 1.0, Hard = 0.8 },
}
return config
