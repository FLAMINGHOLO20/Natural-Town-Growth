local config = {
    -- Core growth settings
    growthBlendFactor = 0.5,
    maxTownSize = 5000,
    updateIntervalMonths = 3,
    baseGrowthRate = 1.0,
    cargoInfluence = 1.0,
    reachabilityWeight = 1.0,
    trafficPenalty = true,
    decayEnabled = false,
    decayRate = 0.05,
    growthProfile = "Balanced",
    growthProfiles = {
        Balanced = { res=1.0, com=1.0, ind=1.0 },
        DenseMetro = { res=1.5, com=1.2, ind=0.8 },
        SprawlingSuburb = { res=1.3, com=0.8, ind=0.7 },
        IndustrialHub = { res=0.7, com=0.9, ind=1.5 }
    },

    -- Factor weights
    historicalWeight = 0.5,
    infrastructureWeight = 1.0,
    geographyWeight = 1.0,
    trafficWeight = 1.0,
    industryWeight = 1.0,
    difficultyMode = "Normal", -- Easy, Normal, Hard

    -- Random events
    enableRandomEvents = true,
    randomEventMagnitude = 0.1,

    -- Performance & debug
    performanceMode = true,
    debugMode = false,
    debugUpdateInterval = 12,

    -- UI settings
    enableUI = true,             -- toggle in-game UI
    uiTheme = "Colorful",        -- Minimalist, Colorful, Classic
    showGrowthOverlay = true,     -- visual indicators on towns
    showCargoOverlay = true,      -- cargo delivered overlay
    showTrafficOverlay = true     -- traffic congestion overlay
}

return config
