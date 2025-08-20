local api = require "res/scripts/ntg_api"
local compat = require "res/scripts/util/compat"

local function runFn(settings)
  local mode = settings.growth_mode or 0

  local config = {}
  if mode == 0 then
    -- Original values
    config.residential = 1.0
    config.commercial  = 1.0
    config.industrial  = 1.0
  else
    -- Tame version
    config.residential = 0.6
    config.commercial  = 0.6
    config.industrial  = 0.6
  end

  api.setGrowthConfig(config)
end

return runFn
