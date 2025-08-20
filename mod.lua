function data()
return {
  info = {
    name = _("Natural Town Growth – Mod.io Edition"),
    description = _("Enhanced town growth with customizable parameters and modding API."),
    minorVersion = 1,
    severityAdd = "NONE",
    severityRemove = "WARNING",
    runFn = "res/scripts/ntg_core.lua",
    authors = {
      {
        name = "Shimanto + ChatGPT",
        role = "CREATOR",
      },
    },
    tags = { "Gameplay", "Town Growth", "Economy" },
    params = {
      {
        key = "growth_mode",
        name = _("Growth Mode"),
        values = { _("Original"), _("Tame") },
        defaultIndex = 0,
      },
    },
  }
}
end
