---- Aura color palettes for NEO.ED theme
-- https://github.com/daltonmenezes/aura-theme

local M = {}

M.palettes = {
  ["aura-dark"] = {
    colors = {
      darker = "#110f18",
      bg = "#15141b",
      darkGray = "#1c1b22",
      fg = "#6d6d6d",
      gray = "#a277ff",
      green = "#61ffca",
      blue = "#82e2ff",
      purple = "#a277ff",
      red = "#ff6767",
      magenta = "#f694ff",
      midPurple = "#3d375e7f",
      darkPurple = "#29263c",
      orange = "#ffca85",
      white = "#edecee",
    },
    -- Override function receives colors table, return overrides
    -- Example: Make insert mode use bg text on magenta background
    get_overrides = function(colors)
      return {
        insert = {
          a = { fg = colors.darker, bg = colors.red },
        },
      }
    end,
  },
  ["aura-soft"] = {
    colors = {
      darker = "#1c1b27",
      bg = "#21202e",
      darkGray = "#2a2939",
      fg = "#6d6d6d",
      gray = "#a277ff",
      green = "#61ffca",
      blue = "#82e2ff",
      purple = "#a277ff",
      red = "#ff6767",
      magenta = "#f694ff",
    },
    -- get_overrides = function(colors)
    --   return {}
    -- end,
  },
}

function M.get_colors(variant)
  variant = variant or "aura-dark"
  local palette = M.palettes[variant] or M.palettes["aura-dark"]
  -- Call get_overrides function if it exists, passing colors
  local overrides = palette.get_overrides and palette.get_overrides(palette.colors) or nil
  return palette.colors, overrides
end

return M
