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
    modVersion = "v1.5-update9-11",
    growthProfile = "Balanced",
    growthProfiles = {
        Balanced = { res = 1.0, com = 1.0, ind = 1.0 },
        DenseMetro = { res = 1.5, com = 1.2, ind = 0.8 },
        SprawlingSuburb = { res = 1.3, com = 0.8, ind = 0.7 },
        IndustrialHub = { res = 0.7, com = 0.9, ind = 1.5 }
    },

    -- Historical & Infrastructure
    historicalWeight = 0.5,
    infrastructureWeight = 1.0,

    -- Geography, Traffic, Industry, Difficulty
    geographyWeight = 1.0,
    trafficWeight = 1.0,
    industryWeight = 1.0,
    difficultyMode = "Normal",
    difficultyMultiplier = { Easy = 1.2, Normal = 1.0, Hard = 0.8 },

    -- New for Events & Randomness
    enableRandomEvents = true,
    randomEventMagnitude = 0.1, -- ±10% growth change per month

    -- Dynamic Config Reload
    configFilePath = "config.lua"
}
return config
