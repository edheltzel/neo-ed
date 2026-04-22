return {
  -- Eldritch Theme
  -- https://github.com/eldritch-theme/eldritch.nvim
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
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

  -- Aura Theme
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "daltonmenezes/aura-theme",
    lazy = true,
    init = function()
      -- Add the runtime path early, before colorscheme is loaded
      local plugin_path = vim.fn.stdpath("data") .. "/lazy/aura-theme"
      vim.opt.rtp:append(plugin_path .. "/packages/neovim")
    end,
  },

  -- Rose Pine Theme
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
    },
  },

  -- Tokyo Night Theme
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night", -- storm, moon, night, or day
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = { "qf", "help", "terminal" },
      dim_inactive = true,
    },
  },
  -- This is the ONLY place to set your active colorscheme
  -- LazyVim colorscheme configuration
  {
    "LazyVim/LazyVim",
    opts = {
      -- Available options:
      --   Eldritch: "eldritch"
      --   Aura: "aura-dark", "aura-dark-soft-text", "aura-soft-dark", "aura-soft-dark-soft-text"
      --   Rose Pine: "rose-pine", "rose-pine-moon", "rose-pine-dawn"
      --   Tokyo Night: "tokyonight", "tokyonight-storm", "tokyonight-moon", "tokyonight-day"
      colorscheme = "eldritch",
    },
  },
}
