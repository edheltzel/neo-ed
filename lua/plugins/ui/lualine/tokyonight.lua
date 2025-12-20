---- Tokyo Night color palettes for NEO.ED theme
-- https://github.com/folke/tokyonight.nvim

local M = {}

M.palettes = {
  ["tokyonight"] = { -- night variant (default)
    colors = {
      darker = "#16161e",
      bg = "#1a1b26",
      darkGray = "#292e42",
      fg = "#565f89",
      gray = "#a9b1d6",
      green = "#9ece6a",
      blue = "#7dcfff",
      purple = "#9d7cd8",
      red = "#f7768e",
      magenta = "#bb9af7",
      pink = "#ff4499",
    },
    -- Override function receives colors table, return overrides
    -- Example: Custom red for replace mode
    get_overrides = function(colors)
      return {
        insert = {
          a = { bg = colors.pink },
        },
      }
    end,
  },
  ["tokyonight-storm"] = {
    colors = {
      darker = "#1f2335",
      bg = "#24283b",
      darkGray = "#292e42",
      fg = "#565f89",
      gray = "#a9b1d6",
      green = "#9ece6a",
      blue = "#7dcfff",
      purple = "#9d7cd8",
      red = "#f7768e",
      magenta = "#bb9af7",
    },
  },
  ["tokyonight-moon"] = {
    colors = {
      darker = "#1e2030",
      bg = "#222436",
      darkGray = "#2f334d",
      fg = "#636da6",
      gray = "#828bb8",
      green = "#c3e88d",
      blue = "#86e1fc",
      purple = "#fca7ea",
      red = "#ff757f",
      magenta = "#c099ff",
    },
  },
  ["tokyonight-day"] = {
    colors = {
      darker = "#d0d5e3",
      bg = "#e1e2e7",
      darkGray = "#c4c8da",
      fg = "#848cb5",
      gray = "#6172b0",
      green = "#587539",
      blue = "#007197",
      purple = "#7847bd",
      red = "#f52a65",
      magenta = "#9854f1",
    },
  },
}

function M.get_colors(variant)
  variant = variant or "tokyonight"
  local palette = M.palettes[variant] or M.palettes["tokyonight"]
  local overrides = palette.get_overrides and palette.get_overrides(palette.colors) or nil
  return palette.colors, overrides
end

return M
