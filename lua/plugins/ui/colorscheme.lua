return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  -- eldritch
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 11000,
    opts = {
      transparent = false,
      dim_inactive = true,
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = {
        "qf",
        "help",
        "terminal",
      },
      on_colors = function(colors)
        colors.bg = "#171928"
      end,
      on_highlights = function(highlights, colors)
        highlights.SnacksDashboardHeader = { fg = colors.fg_gutter }
        highlights.SnacksDashboardDesc = { fg = colors.fg_dark }
        highlights.SnacksDashboardIcon = { fg = colors.fg_gutter }
        highlights.SnacksDashboardFooter = { fg = colors.fg_gutter }
        highlights.SnacksPickerTree = { fg = colors.dark5 }
        highlights.WhichKeyBorder = { fg = colors.comment }
        highlights.FloatBorder = { fg = colors.comment }
      end,
    },
  },

  -- Rose Pine Theme rose-pine, rose-pine-moon, rose-pine-dawn
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
    opts = {
      variant = "main", -- auto, main, moon, or dawn
      dark_variant = "main",
      dim_inactive_windows = false,
      extend_background_behind_borders = true,
      styles = {
        bold = true,
        italic = true,
        transparency = false,
      },
      highlight_groups = {
        CursorColumn = { bg = "#F4E9E0" },
        ColorColumn = { bg = "#F4E9E0" },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "datsfilipe/vesper.nvim",
    -- Vesper ships no code-block highlight, so markdown code inherits Normal
    -- and reads as low-contrast. `overrides` is merged last over every group
    -- at theme-load (no autocmd needed), so scope the fix to vesper here.
    opts = {
      overrides = {
        -- render-markdown.nvim virtual backgrounds (rendered view).
        -- fg is set too: plain (no-language) code blocks have no syntax to
        -- color the text, so without an explicit fg it stays dim/low-contrast.
        RenderMarkdownCode = { bg = "#282828", fg = "#E4E4E4" }, -- fenced block panel (bgFloat)
        RenderMarkdownCodeInline = { bg = "#343434", fg = "#FEFEFE" }, -- inline `code` (bgOption)
        -- raw treesitter captures (focused/edit line + when render is off)
        ["@markup.raw.block.markdown"] = { bg = "#282828", fg = "#E4E4E4" },
        ["@markup.raw.markdown_inline"] = { bg = "#343434", fg = "#FEFEFE" },
      },
    },
  },
  -- LazyVim colorscheme configuration
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vesper",
    },
  },
}
