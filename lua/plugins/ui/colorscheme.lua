return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    --tokyonight
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    --eldritch
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
  {
    -- rose pine
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
    "datsfilipe/vesper.nvim",
    opts = {
      overrides = {
        RenderMarkdownCode = { bg = "#282828", fg = "#E4E4E4" },
        RenderMarkdownCodeInline = { bg = "#343434", fg = "#FEFEFE" },
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
