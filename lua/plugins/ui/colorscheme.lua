return {
  -- Aura Theme
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  {
    "daltonmenezes/aura-theme",
    lazy = false,
    priority = 1000,
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
    lazy = false,
    priority = 1000,
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
    lazy = false,
    priority = 1000,
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

  -- LazyVim colorscheme configuration
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme options: "aura-dark", "aura-dark-soft-text", "aura-soft-dark", "aura-soft-dark-soft-text", "eldritch", "rose-pine", "rose-pine-moon", "rose-pine-dawn", "tokyonight", "tokyonight-storm", "tokyonight-moon", "tokyonight-day"
      colorscheme = "eldritch",
    },
  },
}
