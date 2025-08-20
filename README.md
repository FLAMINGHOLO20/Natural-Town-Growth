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

---

Inspired by the original **Natural Town Growth** by MrWolfZ. This is the **mod.io edition** maintained by FlamingHolo20.
