---- Base16 Atelier Lakeside palette for NEO.ED theme
-- https://github.com/wincent/base16-nvim (colors/atelier-lakeside.lua)

local M = {}

M.palettes = {
  ["atelier-lakeside"] = {
    colors = {
      darker = "#161b1d",   -- gui00
      bg = "#1f292e",       -- gui01
      darkGray = "#516d7b", -- gui02
      fg = "#5a7b8c",       -- gui03 (Comment)
      gray = "#7195a8",     -- gui04
      green = "#568c3b",    -- gui0B
      blue = "#257fad",     -- gui0D
      purple = "#6b6bb8",   -- gui0E
      red = "#d22d72",      -- gui08
      magenta = "#b72dd2",  -- gui0F
    },
  },
}

function M.get_colors(variant)
  variant = variant or "atelier-lakeside"
  local palette = M.palettes[variant] or M.palettes["atelier-lakeside"]
  local overrides = palette.get_overrides and palette.get_overrides(palette.colors) or nil
  return palette.colors, overrides
end

return M
