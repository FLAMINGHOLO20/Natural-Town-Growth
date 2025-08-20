local M = {}
local config = {}

function M.setGrowthConfig(c)
  config = c
end

function M.getGrowthConfig()
  return config
end

-- Allow other mods to register new needs
M.extraNeeds = {}

function M.registerNeed(name, weight)
  table.insert(M.extraNeeds, { name = name, weight = weight })
end

return M
