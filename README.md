Natural Town Growth — v2.0 (Final Release)

This release completes the Natural Town Growth mod for Transport Fever 2, adding Debug & Visualization Tools and a Compatibility Layer, while retaining all previous features from v1.5 and earlier.

✨ Features

Smooth, realistic town growth with multiple influencing factors

Custom Growth Curves (Balanced, DenseMetro, SprawlingSuburb, IndustrialHub)

Historical Growth Bias (age-based growth adjustment)

Decay & Shrinkage (optional town reduction when undersupplied or isolated)

Infrastructure Influence (roads, rail, and connectivity)

Geography-Based Growth (terrain, water access, resources)

Traffic & Congestion penalties

Industry Dependency (local industrial output affects growth)

Difficulty Modes: Easy, Normal, Hard

Dynamic Config Reload (edit config.lua externally, changes apply in real-time)

Events & Randomness (random growth events, seasonal/economic variations)

Performance Optimizations (skip tiny towns, cache calculations)

Debug & Visualization Tools (show town growth metrics in console/log)

Compatibility Layer (safe handling of missing data, mod and map compatibility)

⚙️ Configuration

Edit the config.lua file to customize gameplay. Example parameters:

-- Basic growth settings
growthBlendFactor = 0.5
maxTownSize = 5000
updateIntervalMonths = 3
baseGrowthRate = 1.0
cargoInfluence = 1.0
reachabilityWeight = 1.0
trafficPenalty = true
decayEnabled = false
decayRate = 0.05

-- Growth profiles
growthProfile = "Balanced"
growthProfiles = {
    Balanced = { res=1.0, com=1.0, ind=1.0 },
    DenseMetro = { res=1.5, com=1.2, ind=0.8 },
    SprawlingSuburb = { res=1.3, com=0.8, ind=0.7 },
    IndustrialHub = { res=0.7, com=0.9, ind=1.5 }
}

-- Historical & Infrastructure
historicalWeight = 0.5
infrastructureWeight = 1.0

-- Geography, Traffic, Industry, Difficulty
geographyWeight = 1.0
trafficWeight = 1.0
industryWeight = 1.0
difficultyMode = "Normal"  -- Easy, Normal, Hard

-- Random Events
enableRandomEvents = true
randomEventMagnitude = 0.1  -- ±10% monthly growth change

-- Dynamic Config Reload
configFilePath = "config.lua"

-- Debug & Visualization
debugMode = false           -- show town growth metrics
debugUpdateInterval = 12    -- months between debug outputs

-- Performance
performanceMode = true      -- skip very small towns for CPU optimization

📥 Installation

Backup previous mod files.

Extract the folder to:

C:/Users/<YourName>/Documents/Transport Fever 2/mods/


Rename the folder if needed (e.g., flamingholo20_natural_town_growth_v2).

Enable the mod in-game.

🔹 How to Use

Edit config.lua to tweak growth behavior.

Changes to config.lua are applied in real-time (Dynamic Config Reload).

Enable debugMode to see town metrics in the console.

Adjust randomEventMagnitude and other weights to balance gameplay.

📝 Changelog
v2.0 (Final Release)

Added Debug & Visualization Tools for in-game town growth metrics

Added Compatibility Layer for safe calculations and mod/map compatibility

Retained all previous features (v1.5 and earlier)

v1.5 (Updates 9–11)

Dynamic Config Reload

Events & Randomness

Performance Optimizations

v1.4 (Updates 5–8)

Geography-Based Growth

Traffic & Congestion

Industry Dependency

Difficulty Modes

v1.3 (Updates 2–4)

Historical Growth Bias

Decay & Shrinkage

Infrastructure Influence

v1.2 (Update 1)

Custom Growth Curves

v1.1

Initial mod improvements, traffic penalty, optional decay, performance optimization

🔮 Notes

Inspired by the original Natural Town Growth by MrWolfZ

Maintained by FlamingHolo20 (mod.io edition)

Designed for maximum configurability, realism, and performance

Future updates may include in-game GUI for configuration
