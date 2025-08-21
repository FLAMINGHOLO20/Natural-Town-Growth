# Natural Town Growth (Mod.io Edition)

This mod enhances the **Natural Town Growth** system for Transport Fever 2 by making it configurable, performance-friendly, and more balanced.

## ✨ Features
- Smooth growth progression (no runaway exponential growth)
- Configurable max town size and growth rate
- Performance-friendly update intervals
- Growth influenced by cargo delivery and transport reachability
- Optional decay system (towns shrink if undersupplied or isolated)
- Traffic penalty slows growth when roads are congested

## ⚙️ Configuration
Edit the `config.lua` file to customize gameplay.

Example parameters:
```lua
growthBlendFactor = 0.5    -- Blend between starting capacity and calculated growth
maxTownSize = 5000         -- Cap for town population
updateIntervalMonths = 3   -- Update frequency (higher = better performance)
cargoInfluence = 1.0       -- Cargo delivery effect
reachabilityWeight = 1.0   -- Connectivity effect
trafficPenalty = true      -- Enable slowdown if traffic >80%
decayEnabled = false       -- Enable town shrinking when isolated
```

## 📥 Installation
1. Extract the folder to:
   ```
   C:/Users/<YourName>/Documents/Transport Fever 2/mods/
   ```
2. Rename the folder if needed, e.g., `flamingholo20_natural_town_growth_1`.
3. Enable the mod in-game.

## 📝 Changelog
### v1.1 (Updated)
- Added `config.lua` for customization
- Blended growth for smoother progression
- Added max town size cap
- Added traffic penalty & optional decay system
- Optimized update frequency for performance

# Natural Town Growth — v1.2 (Update 1: Custom Growth Curves)

This release adds **Custom Growth Curves**, allowing players to select different city growth styles via `config.lua`. Each profile changes how Residential, Commercial, and Industrial zones expand.

---

## 🔹 New in v1.2
- Added **growth profiles** in `config.lua`:
  - **Balanced** (default): Equal growth across all zones.
  - **DenseMetro**: Fast residential, boosted commercial, weaker industrial.
  - **SprawlingSuburb**: Strong residential sprawl, weaker commercial/industrial.
  - **IndustrialHub**: Strong industrial, weaker residential, normal commercial.
- Modified `mod.lua` to apply selected profile multipliers to town growth.

---

## 🔧 How to Use
1. Open `config.lua`.
2. Set the desired profile:
   ```lua
   growthProfile = "DenseMetro"  -- or "Balanced", "SprawlingSuburb", "IndustrialHub"

# Natural Town Growth — v1.3 (Update 2–4: Historical Bias, Decay & Infrastructure)

This release adds **Historical Growth Bias**, **Decay & Shrinkage**, and **Infrastructure Influence**, building on the Custom Growth Curves introduced in v1.2. Town growth is now more dynamic and realistic.

---

## 🔹 New Features in v1.3
1. **Historical Growth Bias**  
   - Towns grow differently depending on their **age** or past growth patterns.  
   - Older towns grow more slowly; younger towns can expand faster.  

2. **Decay & Shrinkage**  
   - Towns may **shrink** if underperforming (low cargo delivery, low population).  
   - Works together with `decayEnabled` and `decayRate` settings in `config.lua`.  

3. **Infrastructure Influence**  
   - Town growth is influenced by **roads, rail, and connectivity**.  
   - Well-connected towns grow faster; isolated towns grow slower.  

4. **Custom Growth Curves** (from v1.2)  
   - Choose growth profiles for different playstyles: `Balanced`, `DenseMetro`, `SprawlingSuburb`, `IndustrialHub`.  

---

## 🔧 How to Use
1. Open `config.lua` to set parameters:
   ```lua
   growthProfile = "DenseMetro"          -- choose growth curve
   historicalWeight = 0.5                -- historical bias influence
   infrastructureWeight = 1.0            -- infrastructure influence
   decayEnabled = true                   -- enable shrinkage
   decayRate = 0.05                       -- shrinkage rate

---

# Natural Town Growth — v1.4 (Updates 5–8: Geography, Traffic, Industry, Difficulty)

This release significantly improves town growth realism by adding **Geography-Based Growth**, **Traffic & Congestion**, **Industry Dependency**, and **Difficulty Modes**, building on the previous updates including Custom Growth Curves, Historical Bias, Decay, and Infrastructure Influence.

---

## 🔹 New Features in v1.4

1. **Geography-Based Growth**
   - Town growth is influenced by **terrain, water access, and nearby resources**.
   - Coastal towns, riverside towns, and resource-rich areas grow faster.
   - Inland or resource-poor towns grow slower.

2. **Traffic & Congestion**
   - Town growth affected by **traffic levels**.
   - High traffic slows growth; low congestion boosts growth.
   - Works together with the existing `trafficPenalty` setting.

3. **Industry Dependency**
   - Towns’ growth depends on **local industrial output**.
   - Strong industrial activity attracts residential and commercial expansion.
   - Weak industrial output can limit growth.

4. **Difficulty Modes**
   - Adjust town growth based on difficulty: `Easy`, `Normal`, `Hard`.
   - Easy → faster growth, fewer penalties.
   - Hard → slower growth, more decay/shrinkage penalties.

5. **Previous Features Retained**
   - Custom Growth Curves (Balanced, DenseMetro, SprawlingSuburb, IndustrialHub)
   - Historical Growth Bias (town age-based)
   - Decay & Shrinkage
   - Infrastructure Influence

---

## 🔧 How to Use

1. Open `config.lua` to configure new parameters:
   ```lua
   growthProfile = "DenseMetro"           -- growth curve
   historicalWeight = 0.5                 -- influence of historical growth
   infrastructureWeight = 1.0             -- roads/rail influence
   geographyWeight = 1.0                  -- terrain/resource influence
   trafficWeight = 1.0                     -- congestion influence
   industryWeight = 1.0                    -- industrial output influence
   decayEnabled = true                     -- enable shrinkage
   decayRate = 0.05                        -- shrinkage rate
   difficultyMode = "Normal"               -- Easy, Normal, Hard

Inspired by the original **Natural Town Growth** by MrWolfZ. This is the **mod.io edition** maintained by FlamingHolo20.
