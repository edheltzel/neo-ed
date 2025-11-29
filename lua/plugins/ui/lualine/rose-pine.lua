---- Rose Pine lualine theme
-- https://rosepinetheme.com/

local M = {}

-- Rose Pine color palettes
M.palettes = {
  ["rose-pine"] = {
    base = "#191724",
    surface = "#1f1d2e",
    overlay = "#26233a",
    muted = "#6e6a86",
    subtle = "#908caa",
    text = "#e0def4",
    love = "#eb6f92",
    gold = "#f6c177",
    rose = "#ebbcba",
    pine = "#31748f",
    foam = "#9ccfd8",
    iris = "#c4a7e7",
  },
  ["rose-pine-moon"] = {
    base = "#232136",
    surface = "#2a273f",
    overlay = "#393552",
    muted = "#6e6a86",
    subtle = "#908caa",
    text = "#e0def4",
    love = "#eb6f92",
    gold = "#f6c177",
    rose = "#ea9a97",
    pine = "#3e8fb0",
    foam = "#9ccfd8",
    iris = "#c4a7e7",
  },
  ["rose-pine-dawn"] = {
    base = "#faf4ed",
    surface = "#fffaf3",
    overlay = "#f2e9e1",
    muted = "#9893a5",
    subtle = "#797593",
    text = "#575279",
    love = "#b4637a",
    gold = "#ea9d34",
    rose = "#d7827e",
    pine = "#286983",
    foam = "#56949f",
    iris = "#907aa9",
  },
}

function M.get_theme(variant)
  variant = variant or "rose-pine"
  local colors = M.palettes[variant] or M.palettes["rose-pine"]

  local theme = {}

  theme.normal = {
    a = { bg = colors.surface, fg = colors.muted },
    b = { bg = colors.muted, fg = colors.muted },
    c = { bg = colors.surface, fg = colors.muted },
  }

  theme.insert = {
    a = { bg = colors.love, fg = colors.base },
    b = { bg = colors.muted, fg = colors.base },
  }

  theme.command = {
    a = { bg = colors.foam, fg = colors.base },
    b = { bg = colors.muted, fg = colors.base },
  }

  theme.visual = {
    a = { bg = colors.iris, fg = colors.base },
    b = { bg = colors.muted, fg = colors.base },
  }

  theme.replace = {
    a = { bg = colors.surface, fg = colors.love },
    b = { bg = colors.muted, fg = colors.base },
  }

  theme.terminal = {
    a = { bg = colors.gold, fg = colors.base },
    b = { bg = colors.muted, fg = colors.base },
  }

  theme.inactive = {
    a = { bg = colors.base, fg = colors.muted },
    b = { bg = colors.base, fg = colors.muted, gui = "bold" },
    c = { bg = colors.base, fg = colors.muted },
  }

  -- Add color properties for easy access
  theme.fg = colors.muted
  theme.gray = colors.subtle
  theme.dark = colors.base

  return theme
end

return M
